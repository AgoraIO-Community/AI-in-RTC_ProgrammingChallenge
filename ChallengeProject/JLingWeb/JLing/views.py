from django.shortcuts import render, HttpResponse, redirect
from JLing import models


# Create your views here.
def index(request):
    return render(request, "login.html")


def register(request):
    return render(request, "register.html")


def sign_In(request):
    try:
        print("start sign_in")
        email = request.POST['email']
        password = request.POST['password']
        user = models.UserTable.objects.filter(Email__exact=email, Password__exact=password)
    except:
        print("failed")
        return render(request, 'login.html')
    if user:
        print("signIn success")
        # 登录成功
        # 将信息保存在数据库的session表（在数据库存中一个表名是session的表）中对应的value
        request.session['email'] = email
        request.session['password'] = password
        # 说明：如果需要在页面上显示出来的用户信息太多（有时还有积分，姓名，年龄等信息），所以我们可以只用session保存user_id
        return render(request, 'test.html')
        # 如果是GET请求，就说明是用户刚开始登录，使用URL直接进入登录页面的
    else:
        return render(request, 'login.html')


def sign_Up(request):
    try:
        print("start sign_up")
        email = request.POST['email']
        messageId = request.POST['messageId']
        videoId = request.POST['videoId']
        password = request.POST['password']
        user = models.UserTable.objects.create(Email=email, Password=password, MessageID=messageId, VideoID=videoId)
    except:
        print("failed")
        return render(request, 'register.html')
    if user:
        print("signUp success")
        return render(request, 'login.html')
        # 如果是GET请求，就说明是用户刚开始登录，使用URL直接进入登录页面的
    else:
        return render(request, 'register.html')
