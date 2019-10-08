import aiml
import sys
import os 

kernel1 = aiml.Kernel() 
if os.path.isfile("chat.brn"): 
	kernel1.bootstrap(brainFile = "chat.brn")
else: 
	kernel1.bootstrap(learnFiles = "chat.xml", commands = "load aiml b")
	kernel1.saveBrain("chat.brn") 

kernel2 = aiml.Kernel() 
if os.path.isfile("base.brn"): 
	kernel2.bootstrap(brainFile = "base.brn")
else: 
	kernel2.bootstrap(learnFiles = "base.xml", commands = "load aiml b")
	kernel2.saveBrain("base.brn") 

# kernel now ready for use 

while True: 
	print(kernel1.respond(input("Enter your message >> ")))
