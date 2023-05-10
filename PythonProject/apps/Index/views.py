from django.shortcuts import render
from django.views.generic import View
from apps.Index.models import Admin
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import redirect
from django.urls import reverse
from json import dumps


class IndexView(View):
    def get(self, request):
        # 显示首页,使用模板
        return render(request, 'index.html')


class FrontLoginView(View):
    # 前台登录
    def post(self,request):
        # 登录校验接收数据
        username = request.POST.get('userName')
        password = request.POST.get('password')
        try:
            admin = Admin.objects.get(username=username, password=password)
            request.session['user_name'] = username
            data = {'msg': '登录成功', 'success': True}
        except Admin.DoesNotExist:
            # 用户名密码错误
            data = {'msg': '登录失败', 'success': False}
        # ensure_ascii=False用于处理中文
        return HttpResponse(dumps(data, ensure_ascii=False))


class FrontLoginOutView(View):
    def get(self,request):
        del request.session['user_name']  # 删除指定数据
        request.session.clear()  # 清空的是值
        request.session.flush()  # 键和值一起清空
        return HttpResponseRedirect(reverse("Index:index"))


class LoginView(View):
    # 后台登录页面
    def get(self,request):
        return render(request, 'login.html')

    def post(self,request):
        # 登录校验接收数据
        username = request.POST.get('username')
        password = request.POST.get('password')
        try:
            admin = Admin.objects.get(username=username, password=password)
            request.session['username'] = username
            data = {'msg': '登录成功', 'success': True}
        except Admin.DoesNotExist:
            # 用户名密码错误
            data = {'msg': '登录失败', 'success': False}
        # ensure_ascii=False用于处理中文
        return HttpResponse(dumps(data, ensure_ascii=False))


class LoginOutView(View):
    def get(self, request):
        # del request.session['username']  # 删除指定数据
        request.session.clear()  # 清空的是值
        request.session.flush()  # 键和值一起清空
        return redirect(reverse("Index:login"))


class MainView(View):
    # 后台主界面
    def get(self,request):
        return render(request, 'main.html')

class ChangePasswordView(View):
    def get(self, request):
        return render(request, 'password_modify.html')

    def post(self, request):
        oldPassword = request.POST.get('oldPassword')
        newPassword = request.POST.get('newPassword')
        newPassword2 = request.POST.get('newPassword2')


        if oldPassword == '':
            return render(request, 'message.html', {'message': '旧密码不正确！'})
        if newPassword == '':
            return render(request, 'message.html', {'message': '请输入新密码!'})
        if newPassword != newPassword2:
            return render(request, 'message.html', {'message': '两次新密码不一样！'})

        username = request.session['username']
        admin = Admin.objects.get(username=username)
        if oldPassword != admin.password:
            return render(request, 'message.html', {'message': '旧密码不正确！'})
        admin.password = newPassword
        admin.save()
        return render(request, 'message.html', {'message': '密码修改成功！'})