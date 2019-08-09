from django.db import models


# Create your models here.
# 创建用户表
class UserTable(models.Model):
    Email = models.CharField(max_length=255, default='')
    Password = models.CharField(max_length=255, default='')
    MessageID = models.CharField(max_length=255, default='')
    VideoID = models.CharField(max_length=255, default='')

    # 打印字符串
    def __str__(self):
        return self.Email + self.Password + self.MessageID + self.VideoID
