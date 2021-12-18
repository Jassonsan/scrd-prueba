CREATE USER usrinventarios with encrypted password 'usrinventarios';
CREATE DATABASE dbinventarios;
GRANT ALL PRIVILEGES ON DATABASE dbinventarios TO usrinventarios;
\c dbinventarios;
CREATE TABLE IF NOT EXISTS  public.empresa
(
    id uuid NOT NULL,
    nombre character(250) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.empresa
    OWNER to usrinventarios;

CREATE TABLE IF NOT EXISTS  public.area
(
    id uuid NOT NULL,
    nombre character(250) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.area
    OWNER to usrinventarios;

CREATE TABLE IF NOT EXISTS  public.persona
(
    id uuid NOT NULL,
    nombre character(250) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.persona
    OWNER to usrinventarios;

CREATE TABLE public.area_empresa
(
    id uuid NOT NULL,
    id_area uuid NOT NULL,
    id_empresa uuid NOT NULL,
    PRIMARY KEY (id_area),
    CONSTRAINT area_empresa_fk_1 FOREIGN KEY (id_area)
        REFERENCES public.area (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT area_empresa_fk_2 FOREIGN KEY (id_empresa)
        REFERENCES public.empresa (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.area_empresa
    OWNER to usrinventarios;

CREATE TABLE public.persona_empresa
(
    id uuid NOT NULL,
    id_persona uuid NOT NULL,
    id_empresa uuid NOT NULL,
    PRIMARY KEY (id_persona),
    CONSTRAINT persona_empresa_fk_1 FOREIGN KEY (id_persona)
        REFERENCES public.persona (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT persona_empresa_fk_2 FOREIGN KEY (id_empresa)
        REFERENCES public.empresa (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.persona_empresa
    OWNER to usrinventarios;

CREATE TABLE public.inventario
(
    id uuid NOT NULL,
    nombre character(250) NOT NULL,
    descripcion character(250),
    tipo character(250),
    serial character(250),
    valor_compra numeric,
    fecha_compra date,
    estado character(250),
    id_area uuid,
    id_persona uuid,
    id_empresa uuid NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT inventario_fk_1 FOREIGN KEY (id_empresa)
        REFERENCES public.empresa (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT inventario_fk_2 FOREIGN KEY (id_area)
        REFERENCES public.area (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT inventario_fk_3 FOREIGN KEY (id_persona)
        REFERENCES public.persona (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.inventario
    OWNER to usrinventarios;


insert into empresa values ('c919b68e-5e18-11ec-bf63-0242ac130002','Empresa 1');
insert into empresa values ('e01912d0-5e18-11ec-bf63-0242ac130002','Empresa 2');
insert into empresa values ('e01917a8-5e18-11ec-bf63-0242ac130002','Empresa 3');

insert into persona values ('045811a0-5e19-11ec-bf63-0242ac130002','Empleado 1 empresa 1');
insert into persona values ('045813d0-5e19-11ec-bf63-0242ac130002','Empleado 2 empresa 1');
insert into persona values ('045814fc-5e19-11ec-bf63-0242ac130002','Empleado 3 empresa 1');
insert into persona values ('045815f6-5e19-11ec-bf63-0242ac130002','Empleado 1 empresa 2');
insert into persona values ('045816e6-5e19-11ec-bf63-0242ac130002','Empleado 2 empresa 2');
insert into persona values ('04581a4c-5e19-11ec-bf63-0242ac130002','Empleado 3 empresa 2');
insert into persona values ('04581b78-5e19-11ec-bf63-0242ac130002','Empleado 1 empresa 3');
insert into persona values ('04581c5e-5e19-11ec-bf63-0242ac130002','Empleado 2 empresa 3');
insert into persona values ('04581d30-5e19-11ec-bf63-0242ac130002','Empleado 3 empresa 3');

insert into persona_empresa values ('68864c50-5e19-11ec-bf63-0242ac130002','045811a0-5e19-11ec-bf63-0242ac130002','c919b68e-5e18-11ec-bf63-0242ac130002');
insert into persona_empresa values ('68864e80-5e19-11ec-bf63-0242ac130002','045813d0-5e19-11ec-bf63-0242ac130002','c919b68e-5e18-11ec-bf63-0242ac130002');
insert into persona_empresa values ('688652d6-5e19-11ec-bf63-0242ac130002','045814fc-5e19-11ec-bf63-0242ac130002','c919b68e-5e18-11ec-bf63-0242ac130002');

insert into persona_empresa values ('68865416-5e19-11ec-bf63-0242ac130002','045815f6-5e19-11ec-bf63-0242ac130002','e01912d0-5e18-11ec-bf63-0242ac130002');
insert into persona_empresa values ('688654fc-5e19-11ec-bf63-0242ac130002','045816e6-5e19-11ec-bf63-0242ac130002','e01912d0-5e18-11ec-bf63-0242ac130002');
insert into persona_empresa values ('688655e2-5e19-11ec-bf63-0242ac130002','04581a4c-5e19-11ec-bf63-0242ac130002','e01912d0-5e18-11ec-bf63-0242ac130002');

insert into persona_empresa values ('688656b4-5e19-11ec-bf63-0242ac130002','04581b78-5e19-11ec-bf63-0242ac130002','e01917a8-5e18-11ec-bf63-0242ac130002');
insert into persona_empresa values ('68865786-5e19-11ec-bf63-0242ac130002','04581c5e-5e19-11ec-bf63-0242ac130002','e01917a8-5e18-11ec-bf63-0242ac130002');
insert into persona_empresa values ('68865858-5e19-11ec-bf63-0242ac130002','04581d30-5e19-11ec-bf63-0242ac130002','e01917a8-5e18-11ec-bf63-0242ac130002');

insert into area values ('045811a0-5e19-11ec-bf63-0242ac130002','Area 1 empresa 1');
insert into area values ('045813d0-5e19-11ec-bf63-0242ac130002','Area 2 empresa 1');
insert into area values ('045814fc-5e19-11ec-bf63-0242ac130002','Area 3 empresa 1');
insert into area values ('045815f6-5e19-11ec-bf63-0242ac130002','Area 1 empresa 2');
insert into area values ('045816e6-5e19-11ec-bf63-0242ac130002','Area 2 empresa 2');
insert into area values ('04581a4c-5e19-11ec-bf63-0242ac130002','Area 3 empresa 2');
insert into area values ('04581b78-5e19-11ec-bf63-0242ac130002','Area 1 empresa 3');
insert into area values ('04581c5e-5e19-11ec-bf63-0242ac130002','Area 2 empresa 3');
insert into area values ('04581d30-5e19-11ec-bf63-0242ac130002','Area 3 empresa 3');

insert into area_empresa values ('68864c50-5e19-11ec-bf63-0242ac130002','045811a0-5e19-11ec-bf63-0242ac130002','c919b68e-5e18-11ec-bf63-0242ac130002');
insert into area_empresa values ('68864e80-5e19-11ec-bf63-0242ac130002','045813d0-5e19-11ec-bf63-0242ac130002','c919b68e-5e18-11ec-bf63-0242ac130002');
insert into area_empresa values ('688652d6-5e19-11ec-bf63-0242ac130002','045814fc-5e19-11ec-bf63-0242ac130002','c919b68e-5e18-11ec-bf63-0242ac130002');

insert into area_empresa values ('68865416-5e19-11ec-bf63-0242ac130002','045815f6-5e19-11ec-bf63-0242ac130002','e01912d0-5e18-11ec-bf63-0242ac130002');
insert into area_empresa values ('688654fc-5e19-11ec-bf63-0242ac130002','045816e6-5e19-11ec-bf63-0242ac130002','e01912d0-5e18-11ec-bf63-0242ac130002');
insert into area_empresa values ('688655e2-5e19-11ec-bf63-0242ac130002','04581a4c-5e19-11ec-bf63-0242ac130002','e01912d0-5e18-11ec-bf63-0242ac130002');

insert into area_empresa values ('688656b4-5e19-11ec-bf63-0242ac130002','04581b78-5e19-11ec-bf63-0242ac130002','e01917a8-5e18-11ec-bf63-0242ac130002');
insert into area_empresa values ('68865786-5e19-11ec-bf63-0242ac130002','04581c5e-5e19-11ec-bf63-0242ac130002','e01917a8-5e18-11ec-bf63-0242ac130002');
insert into area_empresa values ('68865858-5e19-11ec-bf63-0242ac130002','04581d30-5e19-11ec-bf63-0242ac130002','e01917a8-5e18-11ec-bf63-0242ac130002');