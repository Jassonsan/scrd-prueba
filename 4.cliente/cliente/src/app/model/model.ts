export interface IArea{
    id: string;
    nombre: string;
}
export interface IEmpresa{
    id: string;
    nombre: string;
}
export interface IPersona{
    id: string;
    nombre: string;
}
export interface IInventario{
    id: string;
    nombre: string;
    descripcion: string;
    tipo: string;
    serial: string;
    valor_compra: number;
    fecha_compra: Date;
    estado: string;
    id_area?: string | null;
    id_persona?: string | null;
    id_empresa: string;
}
