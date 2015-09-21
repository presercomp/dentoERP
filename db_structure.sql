-- DROP DATABASE "DentoERP";

CREATE DATABASE "DentoERP"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Spanish_Spain.1252'
       LC_CTYPE = 'Spanish_Spain.1252'
       CONNECTION LIMIT = -1;
       
create table comunas (
   comunas_codigo       numeric(6)           not null,
   provincias_codigo    numeric(4)           null,
   comunas_nombre       varchar(30)          null,
   constraint pk_comunas primary key (comunas_codigo)
);

create table doctores (
   doctores_codigo      serial not null,
   personas_run         numeric(9)           null,
   doctores_direccion   varchar(300)         null,
   doctores_telefono    numeric              null,
   doctores_movil       numeric              null,
   doctores_correoelectronico varchar(500)         null,
   doctores_actualizado time with time zone  not null,
   doctores_vigente     bool                 not null,
   constraint pk_doctores primary key (doctores_codigo)
);

create table empleados (
   empleados_codigo     serial not null,
   personas_run         numeric(9)           null,
   sucursales_codigo    int4                 null,
   empleados_actualizado time with time zone  not null,
   empleados_vigente    bool                 not null,
   constraint pk_empleados primary key (empleados_codigo)
);

create table empresas (
   empresas_codigo      serial not null,
   personas_run         numeric(9)           null,
   empresas_giro        text                 null,
   empresas_actualizado time with time zone  null,
   empresas_vigente     bool                 null,
   constraint pk_empresas primary key (empresas_codigo)
);

create table pacientes (
   pacientes_codigo     serial not null,
   personas_run         numeric(9)           null,
   pacientes_direccion  varchar(300)         null,
   pacientes_telefono   numeric              null,
   pacientes_movil      numeric              null,
   pacientes_correoelectronico varchar(500)         null,
   pacientes_fechaingreso date                 not null,
   pacientes_titular    bool                 not null,
   pac_pacientes_codigo int4                 null,
   comunas_codigo       numeric(6)           null,
   pacientes_actualizado time with time zone  not null,
   pacientes_vigente    bool                 not null,
   constraint pk_pacientes primary key (pacientes_codigo)
);

create table perfiles (
   perfiles_codigo      serial not null,
   perfiles_nombre      varchar(100)         not null,
   perfiles_actualizado time with time zone  not null,
   perfiles_vigente     bool                 not null,
   constraint pk_perfiles primary key (perfiles_codigo)
);

create table personas (
   personas_run         numeric(9)           not null,
   personas_natural     bool                 not null,
   personas_paterno     varchar(50)          null,
   personas_materno     varchar(50)          null,
   personas_nombres     varchar(150)         not null,
   personas_fechanacimiento date                 null,
   personas_actualizado time with time zone  not null,
   personas_vigente     bool                 not null,
   constraint pk_personas primary key (personas_run)
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
   regiones_iso_3166_2_cl varchar(6)           null,
   constraint pk_regiones primary key (regiones_codigo)
);

create table sucursales (
   sucursales_codigo    serial not null,
   sucursales_direccion varchar(300)         null,
   empresas_codigo      int4                 null,
   comunas_codigo       numeric(6)           null,
   sucursales_telefono  numeric              null,
   sucursales_correoelectronico varchar(500)         null,
   sucursales_esmatriz  bool                 null,
   sucursales_actualizado time with time zone  null,
   sucursales_vigente   bool                 null,
   constraint pk_sucursales primary key (sucursales_codigo)
);

create table usuarios (
   usuarios_codigo      serial not null,
   perfiles_codigo      int4                 null,
   personas_run         numeric(9)           null,
   usuarios_apodo       varchar(25)          not null,
   usuarios_clave       text                 not null,
   usuarios_actualizado time with time zone  not null,
   usuarios_vigente     bool                 not null,
   constraint pk_usuarios primary key (usuarios_codigo)
);

alter table comunas
   add constraint fk_comunas_fk_comuna_provinci foreign key (provincias_codigo)
      references provincias (provincias_codigo)
      on delete cascade on update cascade;

alter table doctores
   add constraint fk_doctores_fk_doctor_personas foreign key (personas_run)
      references personas (personas_run)
      on delete cascade on update cascade;

alter table empleados
   add constraint fk_empleado_fk_emplea_personas foreign key (personas_run)
      references personas (personas_run)
      on delete restrict on update restrict;

alter table empleados
   add constraint fk_empleado_fk_emplea_sucursal foreign key (sucursales_codigo)
      references sucursales (sucursales_codigo)
      on delete restrict on update restrict;

alter table empresas
   add constraint fk_empresas_fk_empres_personas foreign key (personas_run)
      references personas (personas_run)
      on delete cascade on update cascade;

alter table pacientes
   add constraint fk_paciente_fk_pacien_comunas foreign key (comunas_codigo)
      references comunas (comunas_codigo)
      on delete restrict on update restrict;

alter table pacientes
   add constraint fk_paciente_fk_pacien_personas foreign key (personas_run)
      references personas (personas_run)
      on delete cascade on update cascade;

alter table pacientes
   add constraint fk_paciente_fk_pactit_paciente foreign key (pac_pacientes_codigo)
      references pacientes (pacientes_codigo)
      on delete set null on update set null;

alter table provincias
   add constraint fk_provinci_fk_provin_regiones foreign key (regiones_codigo)
      references regiones (regiones_codigo)
      on delete cascade on update cascade;

alter table sucursales
   add constraint fk_sucursal_fk_sucurs_comunas foreign key (comunas_codigo)
      references comunas (comunas_codigo)
      on delete restrict on update restrict;

alter table sucursales
   add constraint fk_sucursal_fk_sucurs_empresas foreign key (empresas_codigo)
      references empresas (empresas_codigo)
      on delete cascade on update cascade;

alter table usuarios
   add constraint fk_usuarios_fk_usuari_perfiles foreign key (perfiles_codigo)
      references perfiles (perfiles_codigo)
      on delete restrict on update restrict;

alter table usuarios
   add constraint fk_usuarios_fk_usuari_personas foreign key (personas_run)
      references personas (personas_run)
      on delete restrict on update restrict;
