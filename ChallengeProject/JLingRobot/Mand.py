# -*- coding: utf-8 -*-
import sys
import socket
import aiml
import logging
import os
import Log
from Log import Logger
from Speak import OutputVoice, MyTTS

log = Logger('./log/mand.log', level='debug')

# 判断是否形成大脑文件--指令
mybotMand = aiml.Kernel()
# 自定义对话指令库
if os.path.isfile("./AIML/base.brn"):
    mybotMand.bootstrap(brainFile="./AIML/base.brn")
else:
    mybotMand.bootstrap(learnFiles="./AIML/base.xml", commands="load aiml b")
    mybotMand.saveBrain("./AIML/base.brn")

# 信息配置
host = "127.0.0.1"
jling_port = 9987
agora_port = 9988
command_port = 9989
bufSize = 1024

jlingHost = (host, jling_port)
agoraHost = (host, agora_port)
commandHost = (host, command_port)


# 数据的写入
def writeTxT(path):
    file = open("%s.txt" % path, "r")
    msg = file.read()
    # 转化为字典
    return eval(msg)


# 数据的发送
def sendTxT(path):
    file = open("%s.txt" % path, "r")
    msg = file.read()
    return msg


# 打开视频监控
def openMonitor():
    os.system("")


def JLing_command():
    client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    client.bind(commandHost)
    while True:
        data, addr = client.recvfrom(bufSize)
        log.logger.info("MSG:" + str(data) + "Addr:" + str(addr))
        message = str(data)
        # 播放指令
        if message.find('01') >= 0:
            MyTTS(message[4:])
            OutputVoice()
        # 打开视频监控
        if message.find('02') >= 0:
            os.system("")
        # 消息的反馈
        if message.find('03') >= 0:
            msg = sendTxT("JLing_date")
            client.sendto(msg.encode(encoding="utf-8"), agoraHost)
            log.logger.info("Mand send to agora :" + msg)


JLing_command()
