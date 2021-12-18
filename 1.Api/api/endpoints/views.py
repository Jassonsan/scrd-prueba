from django.db.models.expressions import Subquery
from django.db.models.query import QuerySet
from django.shortcuts import render
from .models import Area, Persona, Empresa, AreaEmpresa, PersonaEmpresa, Inventario
from rest_framework import generics
from .serializers import AreaSerializer, EmpresaSerializer, InventarioSerializer, PersonaSerializer, AreaEmpresaSerializer
# Create your views here.

class AreaList(generics.ListAPIView):
    ##queryset = Area.objects.all()
    serializer_class = AreaSerializer
    
    def get_queryset(self):
        id = self.request.query_params.get('id')
        if id:
            organization_area = AreaEmpresa.objects.filter(id_empresa=id)
            return Area.objects.filter(id__in=Subquery(organization_area.values('id_area')))
        

class PersonaList(generics.ListAPIView):
    #queryset = Persona.objects.all()
    serializer_class = PersonaSerializer

    def get_queryset(self):
        id = self.request.query_params.get('id')
        if id:
            organization_people = PersonaEmpresa.objects.filter(id_empresa=id)
            return Persona.objects.filter(id__in=Subquery(organization_people.values('id_persona')))


class EmpresaList(generics.ListAPIView):
    queryset = Empresa.objects.all()
    serializer_class = EmpresaSerializer


class InventarioList(generics.ListAPIView):
    serializer_class =  InventarioSerializer

    def get_queryset(self):
        id = self.request.query_params.get('id')
        if id:
            return Inventario.objects.filter(id_empresa=id)

class InventarioCreate(generics.CreateAPIView):
    queryset = Inventario.objects.all()
    serializer_class =  InventarioSerializer

class InventarioDeleteUpdate(generics.RetrieveUpdateAPIView, generics.RetrieveDestroyAPIView):
    queryset = Inventario.objects.all()
    serializer_class =  InventarioSerializer
    lookup_field = 'id'
