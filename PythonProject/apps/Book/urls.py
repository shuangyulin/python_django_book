from apps.Book.views import FrontAddView, FrontListView, UpdateView, DeletesView, FrontShowView, AddView, \
    ListView, OutToExcelView, BackModifyView, FrontModifyView
from django.conf.urls import url

# 正在部署的应用的名称
app_name = 'Book'

urlpatterns = [
    url(r'^frontAdd$', FrontAddView.as_view(), name='frontAdd'),  # 前台图书添加
    url(r'^frontModify/(?P<barcode>.+)$', FrontModifyView.as_view(), name='frontModify'),  # 前台更新图书
    url(r'^frontList$', FrontListView.as_view(), name='frontList'),  # 前台图书查询列表
    url(r'^frontShow/(?P<barcode>.+)$', FrontShowView.as_view(), name='frontShow'),  # 前台显示图片详情页

    url(r'^update/(?P<barcode>.+)$', UpdateView.as_view(), name='update'),  # Ajax方式图书更新

    url(r'^add$', AddView.as_view(), name='add'),  # 后台添加图书
    url(r'^backModify/(?P<barcode>.+)$', BackModifyView.as_view(), name="backModify"),  # 后台更新图书
    url(r'^list$', ListView.as_view(), name='list'),  # 后台图书列表
    url(r'^deletes$', DeletesView.as_view(), name="deletes"),  # 删除图书信息
    url(r'^OutToExcel$', OutToExcelView.as_view(), name='OutToExcel')  # 导出图书信息到excel并下载
]
