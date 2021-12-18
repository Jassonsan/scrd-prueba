import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { IInventario } from '../model/model';

@Injectable({
  providedIn: 'root'
})
export class InventarioService {
  private url = environment.api + '';
  constructor(private http: HttpClient) { }

  public getOrganizations(): Observable<any> {
    return this.http.get(this.url + "empresa" );
  }
  public getPeople(id: string): Observable<any> {
    return this.http.get(this.url + "persona/empresa?id="+id );
  }
  public getAreas(id: string): Observable<any> {
    return this.http.get(this.url + "area/empresa?id="+id );
  }
  public getInventory(id: string): Observable<any> {
    return this.http.get(this.url + "inventario/empresa?id="+id );
  }
  public deleteInventory(id: string): Observable<any> {
    return this.http.delete(this.url + "inventario/"+id );
  }
  public createInventory(dto: IInventario): Observable<any> {
    return this.http.post(this.url + "inventario", dto );
  }  
  public updateInventory(dto: IInventario): Observable<any> {
    return this.http.put(this.url + "inventario/"+dto.id, dto );
  } 
}
