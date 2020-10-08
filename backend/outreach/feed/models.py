from datetime import datetime

from django.db import models

# Create your models here.

class Feed(models.Model):
    title = models.CharField('title',max_length=240,null=False,blank=False)
    content = models.TextField('content',null=True,blank=True)
    imageUrl = models.TextField('imageUrl',null=True,blank=True)
    videoUrl = models.TextField('videoUrl',null=True,blank=True)
    timestamp = models.DateTimeField('timestamp',null=False,default=datetime.utcnow)
    creator = models.ForeignKey('user.Profile',related_name='creator',on_delete=models.CASCADE,null=True,blank=True)

    def __str__(self):
        return f"Feed({self.title})"



