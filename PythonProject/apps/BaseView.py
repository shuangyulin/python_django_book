from django.views.generic import View
from django.conf import settings

class ImageFormatException(Exception):
    def __init__(self, code, error, data):
        self.code = code
        self.error = error
        self.data = data


class BaseView(View):
    def __init__(self):
        self.currentPage = 1
        self.totalPage = 0
        self.pageSize = 8
        self.recordNumber = 0
        self.startIndex = 0
        self.startPage = 1
        self.endPage = 1
        self.pageList = []
        self.paginator = None

    def getCurrentPage(self,request): #前台要显示第几页的参数获取
        if request.method == 'GET':
            self.currentPage = request.GET.get('currentPage', 1)
            self.currentPage = int(self.currentPage)
        elif request.method == 'POST':
            self.currentPage = request.POST.get('currentPage', 1)
            self.currentPage = int(self.currentPage)

    def getPageAndSize(self,request): #后台要显示第几页和每页多少条数据的参数获取
        if request.method == 'GET':
            self.currentPage = request.GET.get('page', 1)
            self.currentPage = int(self.currentPage)
            self.pageSize = request.GET.get('rows', 5)
            self.pageSize = int(self.pageSize)
        elif request.method == 'POST':
            self.currentPage = request.POST.get('page', 1)
            self.currentPage = int(self.currentPage)
            self.pageSize = request.GET.get('rows', 5)
            self.pageSize = int(self.pageSize)

    def getStrParam(self,request,paramName):
        if request.method == 'GET':
            value = request.GET.get(paramName)
            if value is None:
                value = ''
            return value
        elif request.method == 'POST':
            value = request.POST.get(paramName)
            if value is None:
                value = ''
            return value

    def getIntParam(self,request, paramName):
        if request.method == 'GET':
            value = request.GET.get(paramName)
            if value is None or value == '':
                value = '0'
            return value
        elif request.method == 'POST':
            value = request.POST.get(paramName)
            if value is None or value == '':
                value = '0'
            return value

    def calculatePages(self):
        self.totalPage = self.paginator.num_pages
        self.recordNumber = self.paginator.count
        if self.currentPage > self.totalPage:
            self.currentPage = self.totalPage
        self.startIndex = (self.currentPage - 1) * self.pageSize  # 计算起始序号
        self.startPage = self.currentPage - 5
        self.endPage = self.currentPage + 5
        if self.startPage < 1:
            self.startPage = 1
        if self.endPage > self.totalPage:
            self.endPage = self.totalPage;
        self.pageList = list(range(self.startPage, self.endPage + 1))


    def uploadImageFile(self,request,param):
        try:
            imageFile = request.FILES[param]
            if imageFile.size > 0:
                contentTypes = ['image/jpeg', 'image/png', 'image/gif']
                if imageFile.content_type not in contentTypes:
                    raise ImageFormatException(1001, '图书格式错误', '请上传图片格式')
                save_path = '%s/img/%s' % (settings.MEDIA_ROOT, imageFile.name)
                with open(save_path, 'wb') as f:
                    for content in imageFile.chunks():
                        f.write(content)
                fileName = 'img/%s' % imageFile.name
        except KeyError as e:  #如果不传文件就这个异常
            fileName = 'img/NoImage.jpg'
        return fileName

    def uploadCommonFile(self,request,param):
        try:
            commonFile = request.FILES[param]
            if commonFile.size > 0:
                save_path = '%s/file/%s' % (settings.MEDIA_ROOT, commonFile.name)
                with open(save_path, 'wb') as f:
                    for content in commonFile.chunks():
                        f.write(content)
                fileName = 'file/%s' % commonFile.name
        except Exception as e:
            fileName = 'file/NoFile.jpg'
        return fileName


