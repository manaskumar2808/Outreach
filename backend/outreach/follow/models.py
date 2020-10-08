import uuid
from datetime import datetime

from django.db import models

# Create your models here.
class Follow(models.Model):
    id = models.UUIDField('id',primary_key = True,default = uuid.uuid4,editable = False)
    follower = models.ForeignKey('user.Profile',related_name='follower',null=False,blank=False,on_delete=models.CASCADE)
    followed = models.ForeignKey('user.Profile',related_name='followed',null=False,blank=False,on_delete=models.CASCADE)
    timestamp = models.DateTimeField('timestamp',null=False,default=datetime.utcnow)

    def __str__(self):
        return f"Follow({self.follower,self.followed})"

