from django.test import TestCase
from django.shortcuts import render, HttpResponse, redirect
from JLing import models


# Create your views here.
def testpush(request):
    return render(request, "Test/TestPushVideo.html")


def testrecv(request):
    return render(request, "Test/TestRecvVideo.html")


def testmsg(request):
    return render(request, "Test/testMSG.html")
