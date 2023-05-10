from django.conf.urls import url
from apps.Index.views import IndexView,FrontLoginView,FrontLoginOutView,LoginView,LoginOutView,MainView,ChangePasswordView

# 正在部署的应用的名称
app_name = 'Index'

urlpatterns = [
    url(r'^$', IndexView.as_view(), name='index'),  # 首页
    url(r'^frontLogin$', FrontLoginView.as_view(), name='frontLogin'),  # 前台登录
    url(r'^frontLoginout$', FrontLoginOutView.as_view(), name='frontLoginout'),  # 前台退出
    url(r'^login$', LoginView.as_view(), name="login"),  # 后台登录
    url(r'^loginout$', LoginOutView.as_view(), name="loginout"),  # 后台退出
    url(r'^changePassword$', ChangePasswordView.as_view(), name='changePassword'),  # 管理员修改密码
    url(r'^main$', MainView.as_view(), name='main')
]
