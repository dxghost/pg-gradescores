# Generated by Django 3.1.5 on 2021-01-26 14:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('main', '0004_auto_20210126_1430'),
    ]

    operations = [
        migrations.AlterField(
            model_name='examquestion',
            name='points',
            field=models.IntegerField(null=True),
        ),
    ]