from __future__ import absolute_import, division, print_function

import os
import sys
import glob
import argparse
import numpy as np
import PIL.Image as pil
import matplotlib as mpl
import matplotlib.cm as cm

import torch
from torchvision import transforms, datasets

import networks
from layers import disp_to_depth
from utils import download_model_if_doesnt_exist

model_name = "mono+stereo_1024x320"

if torch.cuda.is_available():
    device = torch.device("cuda")
else:
    device = torch.device("cpu")

download_model_if_doesnt_exist(model_name)
model_path = os.path.join("models", model_name)
print("-> Loading model from ", model_path)
encoder_path = os.path.join(model_path, "encoder.pth")
depth_decoder_path = os.path.join(model_path, "depth.pth")

# LOADING PRETRAINED MODEL
print("   Loading pretrained encoder")
encoder = networks.ResnetEncoder(18, False)
loaded_dict_enc = torch.load(encoder_path, map_location=device)

# extract the height and width of image that this model was trained with
feed_height = loaded_dict_enc['height']
feed_width = loaded_dict_enc['width']
filtered_dict_enc = {k: v for k, v in loaded_dict_enc.items() if k in encoder.state_dict()}
encoder.load_state_dict(filtered_dict_enc)
encoder.to(device)
encoder.eval()

print("   Loading pretrained decoder")
depth_decoder = networks.DepthDecoder(
    num_ch_enc=encoder.num_ch_enc, scales=range(4))

loaded_dict = torch.load(depth_decoder_path, map_location=device)
depth_decoder.load_state_dict(loaded_dict)

depth_decoder.to(device)
depth_decoder.eval()

output_directory = os.path.dirname('assets')

print("-> Predicting on {:d} test images".format(-1))

def predict_depth(img, crop=True, buffer=False):
    # PREDICTING ON EACH IMAGE IN TURN
    with torch.no_grad():

        image_path = "target"

        # Load image and preprocess
        input_image = img.convert('RGB')
        original_width, original_height = input_image.size

        if original_width < original_height:
            original_height, original_width = input_image.size
            input_image = input_image.transpose(Image.ROTATE_90)

        if crop:
            temp_height = original_width / feed_width * feed_height
            delta_height = (original_height - temp_height) / 2
            input_image = input_image.crop((0, delta_height, original_width, original_height - delta_height))
            original_height = int(temp_height)
        input_image = input_image.resize((feed_width, feed_height), pil.LANCZOS)

        input_image = transforms.ToTensor()(input_image).unsqueeze(0)

        # PREDICTION
        input_image = input_image.to(device)
        features = encoder(input_image)
        outputs = depth_decoder(features)

        disp = outputs[("disp", 0)]
        disp_resized = torch.nn.functional.interpolate(
            disp, (original_height, original_width), mode="bilinear", align_corners=False)

        # Saving numpy file
        output_name = os.path.splitext(os.path.basename(image_path))[0]
        name_dest_npy = os.path.join(output_directory, "{}_disp.npy".format(output_name))
        scaled_disp, _ = disp_to_depth(disp, 0.1, 100)
        # np.save(name_dest_npy, scaled_disp.cpu().numpy())

        # Saving colormapped depth image
        disp_resized_np = disp_resized.squeeze().cpu().numpy()
        vmax = np.percentile(disp_resized_np, 95)
        normalizer = mpl.colors.Normalize(vmin=disp_resized_np.min(), vmax=vmax)
        mapper = cm.ScalarMappable(norm=normalizer, cmap='magma')
        colormapped_im = (mapper.to_rgba(disp_resized_np)[:, :, :3] * 255).astype(np.uint8)
        im = pil.fromarray(colormapped_im)

        if buffer:
            with BytesIO() as output:
                im.save(output, format="jpeg")
                return output.getvalue()
        else:
            name_dest_im = os.path.join(output_directory, "{}_{}_{}.jpg".format(output_name, model_name, 'cropped' if crop else 'uncropped'))
            im.save(name_dest_im)

            print("   Processed {:d} of {:d} images - saved prediction to {}".format(
                1, 1, name_dest_im))

#print('-> Done!')

import asyncio
from pyppeteer import launch

from PIL import Image
import base64
from io import BytesIO

def parse_img(url):
    url = url.split(',')[1]
    data = base64.decodebytes(url.encode())
    return Image.open(BytesIO(data))


from sanic import Sanic
from sanic.response import json
from sanic_cors import CORS, cross_origin

app = Sanic()
CORS(app)

@app.route("/")
async def test(request):
    return json({"hello": "world"})

@app.route("/json", methods=['POST', 'OPTIONS'])
def post_json(request):
    ret = None
    try:
        img = parse_img(request.json['answer']).transpose(Image.ROTATE_90)
        img.save('target_network.bmp')
    except:
        return json({ "received": True, "message": request.json })

    ret = predict_depth(img, True, True)
    ret = base64.encodebytes(ret)
    return json({ "received": True, "message": 'data:image/jpg;base64,' + ret.decode()})
    #predict_depth(img, False)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)