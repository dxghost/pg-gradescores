# Generated by Django 3.1.5 on 2021-01-26 14:30

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('main', '0003_auto_20210126_1429'),
    ]

    operations = [
        migrations.RenameField(
            model_name='examquestion',
            old_name='question_id',
            new_name='question',
        ),
        migrations.AlterUniqueTogether(
            name='examquestion',
            unique_together={('exam', 'question')},
        ),
    ]