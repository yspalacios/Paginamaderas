# Generated by Django 5.1.7 on 2025-04-01 13:46

import django.core.validators
import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('auth', '0012_alter_user_first_name_max_length'),
    ]

    operations = [
        migrations.CreateModel(
            name='Folder',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('status', models.CharField(default='No definido', max_length=50)),
                ('fecha_inicio', models.CharField(blank=True, max_length=100, null=True)),
                ('puesto_designado', models.CharField(blank=True, max_length=255, null=True)),
                ('salario_actual', models.CharField(blank=True, max_length=100, null=True)),
                ('horas_trabajo', models.CharField(blank=True, max_length=50, null=True)),
                ('tiempo_contrato', models.CharField(blank=True, max_length=100, null=True)),
                ('numero_identidad', models.CharField(blank=True, max_length=100, null=True)),
                ('numero_seguro_social', models.CharField(blank=True, max_length=100, null=True)),
                ('eps', models.CharField(blank=True, max_length=100, null=True)),
                ('fondo_pensiones', models.CharField(blank=True, max_length=100, null=True)),
                ('arl', models.CharField(blank=True, max_length=100, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Producto',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('tipo_madera', models.CharField(max_length=200)),
                ('nombre_producto', models.CharField(max_length=200)),
                ('descripcion', models.TextField()),
                ('imagen', models.ImageField(blank=True, null=True, upload_to='productos/')),
                ('publicado', models.BooleanField(default=False)),
            ],
        ),
        migrations.CreateModel(
            name='datos',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('password', models.CharField(max_length=128, verbose_name='password')),
                ('last_login', models.DateTimeField(blank=True, null=True, verbose_name='last login')),
                ('is_superuser', models.BooleanField(default=False, help_text='Designates that this user has all permissions without explicitly assigning them.', verbose_name='superuser status')),
                ('email', models.EmailField(max_length=254, unique=True)),
                ('nombres', models.CharField(default='', max_length=100)),
                ('apellidos', models.CharField(default='', max_length=100)),
                ('phone', models.CharField(blank=True, max_length=10, null=True, validators=[django.core.validators.RegexValidator(message='El teléfono debe contener 10 dígitos numéricos.', regex='^\\d{10}$')])),
                ('security_question', models.CharField(blank=True, max_length=255, null=True)),
                ('security_answer', models.CharField(blank=True, max_length=255, null=True)),
                ('recovery_email', models.EmailField(blank=True, max_length=254, null=True)),
                ('status', models.CharField(default='No Activo', max_length=20)),
                ('is_active', models.BooleanField(default=True)),
                ('is_staff', models.BooleanField(default=False)),
                ('groups', models.ManyToManyField(blank=True, help_text='The groups this user belongs to. A user will get all permissions granted to each of their groups.', related_name='user_set', related_query_name='user', to='auth.group', verbose_name='groups')),
                ('user_permissions', models.ManyToManyField(blank=True, help_text='Specific permissions for this user.', related_name='user_set', related_query_name='user', to='auth.permission', verbose_name='user permissions')),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='Document',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('file', models.FileField(blank=True, null=True, upload_to='documents/')),
                ('uploaded_at', models.DateTimeField(auto_now_add=True)),
                ('folder', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='documents', to='maderas.folder')),
            ],
        ),
    ]
