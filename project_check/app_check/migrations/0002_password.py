# Generated by Django 4.0.2 on 2022-03-16 01:48

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app_check', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Password',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('xiangmu', models.CharField(blank=True, max_length=200, null=True)),
                ('content', models.CharField(blank=True, max_length=200, null=True)),
                ('result', models.CharField(blank=True, max_length=200, null=True)),
            ],
            options={
                'db_table': 'password',
                'managed': False,
            },
        ),
    ]
