# Generated by Django 5.1.6 on 2025-05-05 18:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('maderas', '0002_datos_profile_image'),
    ]

    operations = [
        migrations.AddField(
            model_name='producto',
            name='precio',
            field=models.DecimalField(decimal_places=2, default=0.0, max_digits=10),
        ),
    ]
