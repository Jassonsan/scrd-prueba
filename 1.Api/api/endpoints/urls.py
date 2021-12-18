from django.urls import path
from .views import AreaList, InventarioCreate,  InventarioDeleteUpdate, InventarioList,  PersonaList, EmpresaList

urlpatterns = [
    path('area/empresa', AreaList.as_view()),
    path('persona/empresa', PersonaList.as_view()),
    path('empresa', EmpresaList.as_view()),
    path('inventario/empresa', InventarioList.as_view()),
    path('inventario', InventarioCreate.as_view()),
    path('inventario/<str:id>', InventarioDeleteUpdate.as_view()),
]