import uuid
from datetime import datetime

from django.db import models

# Create your models here.
class Like(models.Model):
    id = models.UUIDField('id',primary_key = True,default = uuid.uuid4,editable = False)
    parent = models.CharField('parent',max_length=120,null=False,default='feed')
    feed = models.ForeignKey('feed.Feed',null=True,on_delete=models.CASCADE)
    comment = models.ForeignKey('comment.Comment',null=True,on_delete=models.CASCADE)
    liker = models.ForeignKey('user.Profile',null=False,blank=False,on_delete=models.CASCADE)
    timestamp = models.DateTimeField('timestamp',null=False,default=datetime.utcnow)

    def __str__(self):
        if(self.feed is None):
            if(self.comment is None):
                return f"Like()"
            else:
                return f"Like({self.comment},{self.liker})"
        return f"Like({self.feed,self.liker})"