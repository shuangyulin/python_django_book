from apps.BookType.views import FrontAddView, FrontListView, ListAllView
from django.conf.urls import url

# 正在部署的应用的名称
app_name = 'BookType'

urlpatterns = [
    url(r'^frontAdd$', FrontAddView.as_view(), name='frontAdd'), #前台添加
    url(r'^frontList', FrontListView.as_view(), name='frontList'), # 前台查询列表
    url(r'^listAll', ListAllView.as_view(), name='listAll'),  #前台查询所有图书类型
]
