from django.db import models
import uuid

# Create your models here.
class Area(models.Model):

    id = models.UUIDField(primary_key=True)
    nombre = models.CharField(max_length=250)

    def __str__(self):
        return self.id, self.name

    class Meta:
        db_table = 'area'

class Persona(models.Model):

    id = models.UUIDField(primary_key=True)
    nombre = models.CharField(max_length=250)

    def __str__(self):
        return self.id, self.name

    class Meta:
        db_table = 'persona'

class Empresa(models.Model):

    id = models.UUIDField(primary_key=True)
    nombre = models.CharField(max_length=250)

    def __str__(self):
        return self.id, self.name

    class Meta:
        db_table = 'empresa'

class AreaEmpresa(models.Model):

    id = models.UUIDField(primary_key=True)
    id_area = models.ForeignKey(Area, on_delete=models.CASCADE, db_column='id_area', related_name='area_empresa_fk_1')
    id_empresa = models.ForeignKey(Empresa, on_delete=models.CASCADE, db_column='id_empresa', related_name="area_empresa_fk_2")

    def __str__(self):
        return self.id

    class Meta:
        db_table = 'area_empresa'

class PersonaEmpresa(models.Model):

    id = models.UUIDField(primary_key=True)
    id_persona = models.ForeignKey(Persona, on_delete=models.CASCADE, db_column='id_persona')
    id_empresa = models.ForeignKey(Empresa, on_delete=models.CASCADE, db_column='id_empresa')

    def __str__(self):
        return self.id

    class Meta:
        db_table = 'persona_empresa'

class Inventario(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4)
    nombre = models.CharField(max_length=250)
    descripcion = models.CharField(max_length=250)
    tipo = models.CharField(max_length=250)
    serial = models.CharField(max_length=250)
    valor_compra = models.FloatField()
    fecha_compra = models.DateField(null=True)
    estado = models.CharField(max_length=250)
    id_area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True, db_column='id_area')
    id_persona = models.ForeignKey(Persona, on_delete=models.CASCADE, null=True, db_column='id_persona')
    id_empresa = models.ForeignKey(Empresa, on_delete=models.CASCADE, null=False, db_column='id_empresa')

    def __str__(self):
        return self.id

    class Meta:
        db_table = 'inventario'