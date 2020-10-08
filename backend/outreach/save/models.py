import uuid
from datetime import datetime

from django.db import models

# Create your models here.
class Save(models.Model):
    id = models.UUIDField('id',primary_key = True,default = uuid.uuid4,editable = False)
    parent = models.CharField('parent',max_length=120,null=False,default='feed')
    feed = models.ForeignKey('feed.Feed',null=True,on_delete=models.CASCADE)
    saver = models.ForeignKey('user.Profile',null=False,blank=False,on_delete=models.CASCADE)
    timestamp = models.DateTimeField('timestamp',null=False,default=datetime.utcnow)

    def __str__(self):
        return f"Save({self.feed,self.saver})"