from django.views.generic import View
from apps.BaseView import BaseView
from django.shortcuts import render
from django.core.paginator import Paginator
from apps.Book.models import Book
from apps.BookType.models import BookType
from django.http import JsonResponse
from django.http import FileResponse
from apps.BaseView import ImageFormatException
from django.conf import settings
import pandas as pd
import os


class FrontAddView(BaseView):  # 前台图书添加
    def primaryKeyExist(self, barcode):  # 判断主键是否存在
        try:
            Book.objects.get(barcode=barcode)
            return True
        except Book.DoesNotExist:
            return False

    def get(self,request):
        bookTypes = BookType.objects.all()  # 获取所有图书类型
        context = {
            'bookTypes': bookTypes,
        }
        # 使用模板
        return render(request, 'Book/book_frontAdd.html', context)

    def post(self,request):
        barcode = request.POST.get('book.barcode') # 判断图书条形码是否存在
        if self.primaryKeyExist(barcode):
            return JsonResponse({'success': False, 'message': '图书条形码已经存在'})

        book = Book() # 新建一个图书对象然后获取参数
        book.barcode = barcode
        book.bookName = request.POST.get('book.bookName')
        book.bookTypeObj = BookType.objects.get(bookTypeId=int(request.POST.get('book.bookTypeObj.bookTypeId')))
        book.price = float(request.POST.get('book.price'))
        book.count = int(request.POST.get('book.count'))
        book.publishDate = request.POST.get('book.publishDate')
        book.publish = request.POST.get('book.publish')
        try:
            book.bookPhoto = self.uploadImageFile(request,'book.bookPhoto')
        except ImageFormatException as ife:
            return JsonResponse({'success': False, 'message': ife.error})
        book.bookDesc = request.POST.get('book.bookDesc')
        book.bookFile = self.uploadCommonFile(request,'book.bookFile')
        book.save() # 保存图书信息到数据库
        return JsonResponse({'success': True, 'message': '保存成功'})


class FrontModifyView(BaseView):  # 前台修改图书
    def get(self, request, barcode):
        context = {"barcode": barcode}
        return render(request, 'Book/book_frontModify.html', context)


class FrontListView(BaseView):  # 前台图书查询列表
    def get(self, request):
        return self.handle(request)

    def post(self, request):
        return self.handle(request)

    def handle(self,request):
        self.getCurrentPage(request)  # 获取当前要显示第几页
        # 下面获取查询参数
        barcode = self.getStrParam(request, 'barcode')
        bookName = self.getStrParam(request, 'bookName')
        publishDate = self.getStrParam(request, 'publishDate')
        bookTypeObj_bookTypeId = self.getIntParam(request, 'bookTypeObj.bookTypeId')
        # 然后条件组合查询过滤
        book = Book.objects.all()
        if barcode != '':
            book = book.filter(barcode__contains=barcode)
        if bookName != '':
            book = book.filter(bookName__contains=bookName)
        if publishDate != '':
            book = book.filter(publishDate__contains=publishDate)
        if bookTypeObj_bookTypeId != '0':
            book = book.filter(bookTypeObj=bookTypeObj_bookTypeId)
        # 对查询结果利用Paginator进行分页
        self.paginator = Paginator(book, self.pageSize)
        # 计算总的页码数，要显示的页码列表，总记录等
        self.calculatePages()
        # 获取第page页的Page实例对象
        books_page = self.paginator.page(self.currentPage)

        # 获取所有图书类型
        bookTypes = BookType.objects.all()
        # 构造模板需要的参数
        context = {
            'bookTypes': bookTypes,
            'books_page': books_page,
            'barcode': barcode,
            'bookName': bookName,
            'publishDate': publishDate,
            'bookTypeObj_bookTypeId': int(bookTypeObj_bookTypeId),
            'currentPage': self.currentPage,
            'totalPage': self.totalPage,
            'recordNumber': self.recordNumber,
            'startIndex': self.startIndex,
            'pageList': self.pageList,
        }
        # 渲染模板界面
        return render(request, 'Book/book_frontquery_result.html', context)


class FrontShowView(View):  # 前台显示图片详情页
    def get(self, request, barcode):
        bookTypes = BookType.objects.all()
        # 查询需要显示的图书对象
        book = Book.objects.get(barcode=barcode)
        context = {
            'bookTypes': bookTypes,
            'book': book
        }
        # 渲染模板显示
        return render(request, 'Book/book_frontshow.html', context)


class UpdateView(BaseView):  # Ajax方式图书更新
    def get(self, request, barcode):
        # GET方式请求查询图书对象并返回图书json格式
        book = Book.objects.get(barcode=barcode)
        return JsonResponse(book.getJsonObj())

    def post(self, request, barcode):
        # POST方式提交图书修改信息更新到数据库
        book = Book.objects.get(barcode=barcode)
        book.bookName = request.POST.get('book.bookName')
        book.bookTypeObj = BookType.objects.get(bookTypeId=int(request.POST.get('book.bookTypeObj.bookTypeId')))
        book.price = float(request.POST.get('book.price'))
        book.count = int(request.POST.get('book.count'))
        book.publishDate = request.POST.get('book.publishDate')
        book.publish = request.POST.get('book.publish')
        try:
            bookPhotoName = self.uploadImageFile(request, 'book.bookPhoto')
        except ImageFormatException as ife:
            return JsonResponse({'success': False, 'message': ife.error})
        if bookPhotoName != 'img/NoImage.jpg':
            book.bookPhoto = bookPhotoName

        book.bookDesc = request.POST.get('book.bookDesc')
        bookFileName = self.uploadCommonFile(request, 'book.bookFile')
        if bookFileName != 'file/NoFile.jpg':
            book.bookFile = bookFileName

        book.save()
        return JsonResponse({'success': True, 'message': '保存成功'})


class AddView(BaseView):  # 后台添加图书
    def primaryKeyExist(self, barcode):  # 判断主键是否存在
        try:
            Book.objects.get(barcode=barcode)
            return True
        except Book.DoesNotExist:
            return False

    def get(self, request):
        # 获取所有图书类型
        bookTypes = BookType.objects.all()
        context = {
            'bookTypes': bookTypes,
        }
        # 渲染显示模板界面
        return render(request, 'Book/book_add.html', context)

    def post(self, request):
        # POST方式处理图书添加业务
        barcode = request.POST.get('book.barcode')
        if self.primaryKeyExist(barcode):
            return JsonResponse({'success': False, 'message': '图书条形码已经存在'})
        # 新建一个图书对象然后收集图书参数
        book = Book()
        book.barcode = barcode
        book.bookName = request.POST.get('book.bookName')
        book.bookTypeObj = BookType.objects.get(bookTypeId=int(request.POST.get('book.bookTypeObj.bookTypeId')))
        book.price = float(request.POST.get('book.price'))
        book.count = int(request.POST.get('book.count'))
        book.publishDate = request.POST.get('book.publishDate')
        book.publish = request.POST.get('book.publish')
        try:
            book.bookPhoto = self.uploadImageFile(request, 'book.bookPhoto')
        except ImageFormatException as ife:
            return JsonResponse({'success': False, 'message': ife.error})
        book.bookDesc = request.POST.get('book.bookDesc')
        book.bookFile = self.uploadCommonFile(request, 'book.bookFile')
        book.save()  # 这里提交更新到数据库
        return JsonResponse({'success': True, 'message': '保存成功'})


class BackModifyView(BaseView):  # 后台更新图书
    def get(self, request, barcode):
        context = {"barcode": barcode}
        return render(request, 'Book/book_modify.html', context)


class ListView(BaseView):  # 后台图书列表
    def get(self, request):
        # 使用模板
        return render(request, 'Book/book_query_result.html')

    def post(self,request):
        # 获取当前要显示第几页和每页几条数据
        self.getPageAndSize(request)
        # 收集查询参数
        barcode = self.getStrParam(request, 'barcode')
        bookName = self.getStrParam(request, 'bookName')
        publishDate = self.getStrParam(request, 'publishDate')
        bookTypeObj_bookTypeId = self.getIntParam(request, 'bookTypeObj.bookTypeId')
        # 然后条件组合查询过滤
        books = Book.objects.all()
        if barcode != '':
            books = books.filter(barcode__contains=barcode)
        if bookName != '':
            books = books.filter(bookName__contains=bookName)
        if publishDate != '':
            books = books.filter(publishDate__contains=publishDate)
        if bookTypeObj_bookTypeId != '0':
            books = books.filter(bookTypeObj=bookTypeObj_bookTypeId)
        # 利用Paginator对查询结果集分页
        self.paginator = Paginator(books, self.pageSize)
        # 计算总的页码数，要显示的页码列表，总记录等
        self.calculatePages()
        # 获取第page页的Page实例对象
        books_page = self.paginator.page(self.currentPage)
        # 查询的结果集转换为列表
        bookList = []
        for book in books_page:
            book = book.getJsonObj()
            bookList.append(book)
        # 构造模板页面需要的参数
        book_res = {
            'rows': bookList,
            'total': self.recordNumber,
        }
        # 渲染模板页面显示
        return JsonResponse(book_res, json_dumps_params={'ensure_ascii':False})


class DeletesView(BaseView):  # 删除图书信息
    def get(self, request):
        return self.handle(request)

    def post(self, request):
        return self.handle(request)

    def handle(self, request):
        barcodes = self.getStrParam(request, 'barcodes')
        barcodes = barcodes.split(',')
        count = 0
        try:
            for barcode in barcodes:
                Book.objects.get(barcode=barcode).delete()
                count = count + 1
            message = '%s条记录删除成功！' % count
            success = True
        except Exception as e:
            message = '数据库删除发生错误！'
            success = False
        return JsonResponse({"success": success, "message": message})


class OutToExcelView(BaseView):  # 导出图书信息到excel并下载
    def get(self,request):
        # 收集查询参数
        barcode = self.getStrParam(request, 'barcode')
        bookName = self.getStrParam(request, 'bookName')
        publishDate = self.getStrParam(request, 'publishDate')
        bookTypeObj_bookTypeId = self.getIntParam(request, 'bookTypeObj.bookTypeId')
        # 然后条件组合查询过滤
        books = Book.objects.all()
        if barcode != '':
            books = books.filter(barcode__contains=barcode)
        if bookName != '':
            books = books.filter(bookName__contains=bookName)
        if publishDate != '':
            books = books.filter(publishDate__contains=publishDate)
        if bookTypeObj_bookTypeId != '0':
            books = books.filter(bookTypeObj=bookTypeObj_bookTypeId)
        #将查询结果集转换成列表
        bookList = []
        for book in books:
            book = book.getJsonObj()
            bookList.append(book)
        # 利用pandas实现数据的导出功能
        pf = pd.DataFrame(bookList)
        # 设置要导入到excel的列
        columns_map = {
            'barcode': '图书条形码',
            'bookName': '图书名称',
            'bookTypeObj': '图书类别',
            'price': '图书价格',
            'count': '图书数量',
            'publishDate': '出版日期',
            'publish': '出版社',
        }
        pf = pf[columns_map.keys()]
        pf.rename(columns=columns_map, inplace=True)
        # 将空的单元格替换为空字符
        pf.fillna('', inplace=True)
        #设定文件名和导出路径
        filename = 'books.xlsx'
        # 这个路径可以在settings中设置也可以直接手动输入
        root_path = settings.MEDIA_ROOT + '/output/'
        file_path = os.path.join(root_path, filename)
        pf.to_excel(file_path, encoding='utf-8', index=False)
        # 将生成的excel文件输出到网页下载
        file = open(file_path, 'rb')
        response = FileResponse(file)
        response['Content-Type'] = 'application/octet-stream'
        response['Content-Disposition'] = 'attachment;filename="books.xlsx"'
        return response





