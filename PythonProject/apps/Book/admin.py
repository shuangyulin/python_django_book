from django.contrib import admin
from apps.Book.models import Book

# Register your models here.

admin.site.register(Book,admin.ModelAdmin)