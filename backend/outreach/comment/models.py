import uuid 

from datetime import datetime

from django.db import models

# Create your models here.
class Comment(models.Model):
    id = models.UUIDField('id',primary_key = True,default = uuid.uuid4,editable = False)
    text = models.TextField('text',null=False,blank=False)
    commentor = models.ForeignKey('user.Profile',null=False,blank=False,on_delete=models.CASCADE)
    feed = models.ForeignKey('feed.Feed',null=True,blank=True,on_delete=models.CASCADE)
    status = models.CharField('status',max_length=120,null=False,default='direct')
    timestamp = models.DateTimeField('timestamp',null=False,default=datetime.utcnow)

    def __str__(self):
        return f"Comment({self.text})"


class Reply(models.Model):
    id = models.UUIDField('id',primary_key = True, default = uuid.uuid4, editable = False)
    text = models.TextField('text',null=False,blank=False)
    replier = models.ForeignKey('user.Profile',null=False,blank=False,on_delete=models.CASCADE)
    comment = models.ForeignKey('Comment', related_name='comment', null=False, blank=False,on_delete=models.CASCADE)
    timestamp = models.DateTimeField('timestamp',null=False,default=datetime.utcnow)

    def __str__(self):
        return f"Reply({self.text})"
