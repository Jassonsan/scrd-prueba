import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { IArea, IEmpresa, IInventario, IPersona } from 'src/app/model/model';
import { InventarioService } from 'src/app/service/inventario.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  public selectedOrganization!: string;
  public areas: Array<IArea> = new Array<IArea>();
  public people: Array<IPersona> = new Array<IPersona>();
  public inventories: Array<IInventario> = new Array<IInventario>();
  public organizations: Array<IEmpresa> = new Array<IEmpresa>();
  public showModal = false;
  public inventoryForm: FormGroup;
  public editing = false;
  public selectedOption = 0;
  private selectedId!: string;
  constructor(private _inventario: InventarioService, private formBuilder: FormBuilder,) {
    this.inventoryForm = this.createInventoryForm();
    
  }

  ngOnInit(): void {
    this.inventoryForm.patchValue({area: false});
    this.selectedOption = 1;
    this.getOrganizations();
  }

  private getOrganizations() {
    this._inventario.getOrganizations().subscribe((res: Response) => {
      let response: any = res;
      this.organizations = response;
    });
  }
  private getPeople() {
    this._inventario.getPeople(this.selectedOrganization).subscribe((res: Response) => {
      let response: any = res;
      this.people = response;
    });
  }
  private getAreas() {
    this._inventario.getAreas(this.selectedOrganization).subscribe((res: Response) => {
      let response: any = res;
      this.areas = response;
    });
  }
  private getInventories() {
    this._inventario.getInventory(this.selectedOrganization).subscribe((res: Response) => {
      let response: any = res;
      this.inventories = response;       
      if(this.inventories){
        this.inventories.forEach((x: IInventario)=>{
          x.descripcion = x.descripcion ? x.descripcion.trim() : '';
          x.estado = x.estado ? x.estado.trim() : '';
          x.nombre = x.nombre ? x.nombre.trim() : '';
          x.serial = x.serial ? x.serial.trim() : '';
          x.tipo = x.tipo ? x.tipo.trim() : '';
        });
      }
           
    });
  }

  public changeOrganization() {

    if (this.selectedOrganization) {
      this.areas = new Array<IArea>();
      this.people = new Array<IPersona>();
      this.inventories = new Array<IInventario>();
      this.getPeople();
      this.getAreas();
      this.getInventories();
    }
  }

  public openModal() {
    this.showModal = true;
  }

  private createInventoryForm(): FormGroup {
    return this.formBuilder.group({
      nombre: ['', [Validators.required, Validators.maxLength(250)]],
      descripcion: ['', [Validators.required, Validators.maxLength(250)]],
      tipo: ['', [Validators.required, Validators.maxLength(250)]],
      serial: ['', [Validators.required, Validators.maxLength(250)]],
      valor_compra: ['', [Validators.required]],
      fecha_compra: ['', []],
      estado: ['', [Validators.required, Validators.maxLength(250)]],
      id_area: ['', []],
      id_persona: ['', []],
      id_empresa: ['', []],
      area: ['', []],
    });
  }

  private generateDTO(): IInventario {
    let dto: IInventario = {} as IInventario;
    dto.nombre = this.inventoryForm.value.nombre;
    dto.descripcion = this.inventoryForm.value.descripcion;
    dto.tipo = this.inventoryForm.value.tipo;
    dto.serial = this.inventoryForm.value.serial;
    dto.valor_compra = this.inventoryForm.value.valor_compra;
    dto.fecha_compra = this.inventoryForm.value.fecha_compra;
    dto.estado = this.inventoryForm.value.estado;
    if(this.selectedOption == 1){
      dto.id_area = this.inventoryForm.value.id_area;
      dto.id_persona = null;
    } else if(this.selectedOption == 2){
      dto.id_persona = this.inventoryForm.value.id_persona;
      dto.id_area = null;
    }
    if(this.editing){      
      dto.id = this.selectedId;
    }
    dto.id_empresa = this.selectedOrganization;
    return dto;
  }
  public save() {
    if(!this.editing){
      this._inventario.createInventory(this.generateDTO()).subscribe((res: Response)=>{
        this.getInventories();
        this.showModal = false;
        this.inventoryForm.reset();
      });
    } else{      
      this._inventario.updateInventory(this.generateDTO()).subscribe((res: Response)=>{
        this.getInventories();
        this.editing = false;
        this.showModal = false;
        this.inventoryForm.reset();
        this.selectedId ='';
      });
    }
  }
  public delete(id: string){
    this._inventario.deleteInventory(id).subscribe((res: Response)=>{
      this.getInventories();
      this.editing = false;
      this.inventoryForm.reset();
    });
  }

  public cancel() {
    this.showModal = false;
    this.inventoryForm.reset();
    this.editing = false;
    this.selectedId = '';
  }

  public changeOption() {    
    this.selectedOption = this.inventoryForm.value.area ? 1: 2;    
    if (this.selectedOption == 1) {
      this.inventoryForm.controls['id_persona'].clearValidators();
      this.inventoryForm.controls['id_area'].setValidators(Validators.required);
    } else if (this.selectedOption == 2) {
      this.inventoryForm.controls['id_area'].clearValidators();
      this.inventoryForm.controls['id_persona'].setValidators(Validators.required);
    }
  }
  public edit(dto: IInventario){
    this.selectedId = dto.id;
    this.inventoryForm.reset();
    this.inventoryForm.reset(dto);
    this.inventoryForm.patchValue({
      area: dto.id_area != null,
    });
    this.editing = true;
    this.showModal = true;    
    this.changeOption();
  }

}
