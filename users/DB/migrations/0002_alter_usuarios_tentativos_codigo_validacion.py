# Generated by Django 4.1.5 on 2023-05-12 04:31

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('DB', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='usuarios_tentativos',
            name='codigo_validacion',
            field=models.CharField(max_length=100),
        ),
    ]
