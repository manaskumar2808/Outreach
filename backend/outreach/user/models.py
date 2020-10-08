import uuid

from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class Profile(models.Model):
    user = models.ForeignKey(User, related_name='user', on_delete=models.CASCADE)
    userName = models.CharField('userName',max_length=240,null=False,blank=False)
    email = models.EmailField('email',null=False,blank=False)
    # profileImage = models.ImageField('profileImage',upload_to=None,null=True,blank=True)
    profileImageUrl = models.CharField('profileImageUrl',max_length=400,null=True,blank=True)
    firstName = models.CharField('firstName',max_length=240,null=True,blank=True)
    lastName = models.CharField('lastName',max_length=240,null=True,blank=True)
    phoneNo = models.CharField('phoneNo',max_length=10,null=True,blank=True)

    def __str__(self):
        return f"Profile({self.userName})"
