# Generated by Django 3.1.5 on 2021-01-26 06:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('main', '0001_initial'),
    ]

    operations = [
        migrations.AlterUniqueTogether(
            name='studentschool',
            unique_together=None,
        ),
        migrations.RemoveField(
            model_name='studentschool',
            name='school',
        ),
        migrations.RemoveField(
            model_name='studentschool',
            name='student',
        ),
        migrations.AlterUniqueTogether(
            name='teacherschool',
            unique_together=None,
        ),
        migrations.RemoveField(
            model_name='teacherschool',
            name='school',
        ),
        migrations.RemoveField(
            model_name='teacherschool',
            name='teacher',
        ),
        migrations.AddField(
            model_name='school',
            name='students',
            field=models.ManyToManyField(to='main.Student'),
        ),
        migrations.AddField(
            model_name='school',
            name='teachers',
            field=models.ManyToManyField(to='main.Teacher'),
        ),
        migrations.DeleteModel(
            name='StudentParent',
        ),
        migrations.DeleteModel(
            name='StudentSchool',
        ),
        migrations.DeleteModel(
            name='TeacherSchool',
        ),
    ]
