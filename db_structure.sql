-- DROP DATABASE "DentoERP";

CREATE DATABASE "DentoERP"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Spanish_Spain.1252'
       LC_CTYPE = 'Spanish_Spain.1252'
       CONNECTION LIMIT = -1;
       
drop table ciudades;

drop table comunas;

drop table empresas;

drop table provincias;

drop table regiones;

drop table sucursales;

create table ciudades (
   ciudades_codigo      numeric(10)          not null,
   comunas_codigo       numeric(6)           null,
   ciudades_nombre      varchar(30)          null,
   constraint pk_ciudades primary key (ciudades_codigo)
);

create table comunas (
   comunas_codigo       numeric(6)           not null,
   provincias_codigo    numeric(4)           null,
   comunas_nombre       varchar(30)          null,
   constraint pk_comunas primary key (comunas_codigo)
);

create table empresas (
   empresas_rut         numeric(9)           not null,
   empresas_razonsocial text                 null,
   empresas_giro        text                 null,
   empresas_vigente     bool                 null,
   constraint pk_empresas primary key (empresas_rut)
);

create table provincias (
   provincias_codigo    numeric(4)           not null,
   regiones_codigo      numeric(2)           null,
   provincias_nombre    varchar(30)          null,
   constraint pk_provincias primary key (provincias_codigo)
);

create table regiones (
   regiones_codigo      numeric(2)           not null,
   regiones_nombre      varchar(100)         null,
   constraint pk_regiones primary key (regiones_codigo)
);

create table sucursales (
   sucursales_codigo    numeric              not null,
   empresas_rut         numeric(9)           null,
   sucursales_direccion varchar(300)         null,
   ciudades_codigo      numeric(10)          null,
   sucursales_telefono  numeric              null,
   sucursales_esmatriz  bool                 null,
   sucursales_vigente   bool                 null,
   constraint pk_sucursales primary key (sucursales_codigo)
);

alter table ciudades
   add constraint fk_ciudades_ref_ciuda_comunas foreign key (comunas_codigo)
      references comunas (comunas_codigo)
      on delete cascade on update cascade;

alter table comunas
   add constraint fk_comunas_ref_comun_provinci foreign key (provincias_codigo)
      references provincias (provincias_codigo)
      on delete cascade on update cascade;

alter table provincias
   add constraint fk_provinci_ref_provi_regiones foreign key (regiones_codigo)
      references regiones (regiones_codigo)
      on delete cascade on update cascade;

alter table sucursales
   add constraint fk_sucursal_ref_sucur_ciudades foreign key (ciudades_codigo)
      references ciudades (ciudades_codigo)
      on delete cascade on update cascade;

alter table sucursales
   add constraint fk_sucursal_ref_sucur_empresas foreign key (empresas_rut)
      references empresas (empresas_rut)
      on delete cascade on update cascade;


