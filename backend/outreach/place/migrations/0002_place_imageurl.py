# Generated by Django 3.1.1 on 2020-09-28 15:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('place', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='place',
            name='imageUrl',
            field=models.CharField(blank=True, max_length=1000, null=True, verbose_name='imageUrl'),
        ),
    ]
