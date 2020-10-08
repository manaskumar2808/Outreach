import uuid
from datetime import datetime

from django.db import models

# Create your models here.
class Place(models.Model):
    id = models.UUIDField('id',primary_key = True,default = uuid.uuid4,editable = False)
    name = models.CharField('name',max_length=240, null = False, blank = False)
    location = models.CharField('location', max_length=480, null = False, blank = False)
    imageUrl = models.CharField('imageUrl', max_length=1000, null = True, blank = True)
    cost = models.DecimalField('cost', max_digits=10, decimal_places=2, null=True, blank=True)
    elevation = models.DecimalField('elevation', max_digits=10, decimal_places=2, null=True, blank=True)
    description = models.TextField('description',null=True, blank=True)
    placeType = models.CharField('type', max_length=240, null=True, blank=True)
    isUWHS = models.BooleanField('isUWHS', null=False, default=False)
    population = models.IntegerField('population', null=True, blank=True)
    timestamp = models.DateTimeField('timestamp',null=False,default=datetime.utcnow)

    def __str__(self):
        return f"Place({self.name})"

