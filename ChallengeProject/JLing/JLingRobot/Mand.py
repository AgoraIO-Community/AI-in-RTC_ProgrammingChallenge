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
host = ''
jling_port = 9987
agora_port = 9988
command_port = 9989
run = '192.168.43.237'
run_port = 9990
bufSize = 1024

jlingHost = (host, jling_port)
agoraHost = (host, agora_port)
commandHost = (host, command_port)
runHost = (run, run_port)


# 数据的写入
def writeTxT(path, msg):
    # 单引号转为双引号
    msg = msg.replace("\'", '\"')
    file = open("%s.txt" % path, "w")
    file.write(msg)


# 数据的读取
def readTxT(path):
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
        message = str(data, encoding='utf-8')
        log.logger.info("MSG:" + str(message) + "Addr:" + str(addr))
        # 播放指令
        if message.find('01') >= 0:
            msg = "小精灵已经把话说完了"
            MyTTS(message[4:])
            OutputVoice()
            client.sendto(msg.encode(encoding="utf-8"), agoraHost)
            log.logger.info("Mand send to agora :" + msg)
        # 打开视频监控
        if message.find('02') >= 0:
            msg = "已经打开了JLing的视频监控"
            os.system("./OpenVideoCall/run.sh")
            client.sendto(msg.encode(encoding="utf-8"), agoraHost)
            log.logger.info("Mand send to agora :" + msg)
        # 消息的反馈
        if message.find('03') >= 0:
            msg = readTxT("JLing_date")
            client.sendto(msg.encode(encoding="utf-8"), agoraHost)
            log.logger.info("Mand send to agora :" + msg)
        # 消息的更改
        if message.find('04') >= 0:
            msg = readTxT("JLing_date")
            dict = eval(msg)
            try:
                dict[message[4:6]] = message[7:]
                writeTxT("JLing_date", str(dict))
                msg = "数据输入成功"
                client.sendto(msg.encode(encoding="utf-8"), agoraHost)
                log.logger.info("Mand send to agora :" + msg)
            except:
                msg = "数据输入失败，请按以下格式输入：0004D1：关闭"
                client.sendto(msg.encode(encoding="utf-8"), agoraHost)
                log.logger.info("Mand send to agora :" + msg)
            # 消息的反馈
            msg = readTxT("JLing_date")
            client.sendto(msg.encode(encoding="utf-8"), agoraHost)
            log.logger.info("Mand send to agora :" + msg)
        if message.find('05') >= 0:
            msg = message[4:]
            log.logger.info("Mand send to RUN :" + msg)
            client.sendto(msg.encode(encoding="utf-8"), runHost)


JLing_command()
