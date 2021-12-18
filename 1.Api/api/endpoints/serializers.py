from django.db.models import fields
from django.db.models.base import Model
from rest_framework import serializers
from .models import Area, Persona, Empresa, AreaEmpresa, PersonaEmpresa, Inventario

class AreaSerializer(serializers.ModelSerializer):

    class Meta:
        model = Area
        fields = ['id','nombre']

class PersonaSerializer(serializers.ModelSerializer):

    class Meta:
        model = Persona
        fields = ['id','nombre']

class EmpresaSerializer(serializers.ModelSerializer):

    class Meta:
        model = Empresa
        fields = ['id','nombre']

class AreaEmpresaSerializer(serializers.ModelSerializer):

    class Meta:
        model = AreaEmpresa
        fields = '__all__'

class PersonaEmpresaSerializer(serializers.ModelSerializer):

    class Meta:
        model = PersonaEmpresa
        fields = '__all__'

class InventarioSerializer(serializers.ModelSerializer):

    class Meta:
        model = Inventario
        fields = '__all__'