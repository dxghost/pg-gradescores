# Generated by Django 3.1.5 on 2021-01-26 04:49

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('main', '0002_auto_20210126_0417'),
    ]

    operations = [
        migrations.AlterUniqueTogether(
            name='class',
            unique_together={('teacher', 'course', 'school')},
        ),
        migrations.CreateModel(
            name='ClassStudent',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('corresponding_class', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='main.class')),
                ('student', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='main.student')),
            ],
        ),
        migrations.RemoveField(
            model_name='class',
            name='student',
        ),
    ]
