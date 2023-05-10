from django.views.generic import View
from django.shortcuts import render
from apps.BookType.models import BookType
from django.core.paginator import Paginator
from django.http import JsonResponse


class FrontAddView(View):
    def get(self,request):
        pass

    def post(self,request):
        pass

class ListAllView(View):
    def get(self,request):
        bookTypes = BookType.objects.all()
        bookTypeList = []
        for bookType in bookTypes:
            bookTypeObj = {
                'bookTypeId': bookType.bookTypeId,
                'bookTypeName': bookType.bookTypeName,
            }
            bookTypeList.append(bookTypeObj)
        return JsonResponse(bookTypeList,safe=False)


class FrontListView(View):
    def get(self,request):
        pageSize = 5
        currentPage = request.GET.get("currentPage")
        bookTypes = BookType.objects.all()
        paginator = Paginator(bookTypes, pageSize)
        totalPage = paginator.num_pages
        recordNumber = paginator.count

        # 获取第page页的内容
        try:
            currentPage = int(currentPage)
        except Exception as e:
            currentPage = 1
        if currentPage > totalPage:
            currentPage = totalPage

        # 获取第page页的Page实例对象
        bookTypes_page = paginator.page(currentPage)

        startIndex = (currentPage - 1) * pageSize #计算起始序号


        startPage = currentPage - 5
        endPage = currentPage + 5
        if startPage < 1:
            startPage=1
        if endPage > totalPage:
            endPage = totalPage;

        pageList = list(range(startPage,endPage+1))

        context = {
            'bookTypes_page': bookTypes_page,
            'currentPage': currentPage,
            'totalPage': totalPage,
            'recordNumber': recordNumber,
            'startIndex': startIndex,
            'pageList': pageList,
        }

        print(pageList)

        # 使用模板
        return render(request, 'BookType/bookType_frontquery_result.html', context)


    def post(self,request):
        pass



