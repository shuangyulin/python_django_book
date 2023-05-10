from django.db import models


class BookType(models.Model):
    bookTypeId = models.AutoField(primary_key=True, verbose_name='图书类型id')
    bookTypeName = models.CharField(max_length=40, default='', verbose_name='图书类型名称')
    days = models.IntegerField(default=0, verbose_name='可借阅天数')

    class Meta:
        db_table = 't_BookType'
        verbose_name = '图书类别'
        verbose_name_plural = verbose_name
