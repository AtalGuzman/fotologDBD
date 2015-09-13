
use usachLog_development;
drop table if exists auditoria;

create table auditoria
(
	ID_auditoria int not null auto_increment,
	DESCRIPCION	varchar(255),
	FECHA			datetime,
	primary key(ID_auditoria) 
);

/*===================================================*/
/* 							Triggers									*/
/*===================================================*/

/* Para usuario*/
drop trigger if exists insertar_usuario;
drop trigger if exists borrar_usuario;
drop trigger if exists actualizar_usuario;

/*NOMBRE_PHOTOLOG
NOMBRE_US
APELLIDO_US
CORREO_US*/


create trigger insertar_usuario after insert on usuarios
for each row
insert into auditoria(DESCRIPCION,FECHA) values ( concat('Se inserta el usuario de nombre ',new.NOMBRE_US,' con correo ', new.email,' a la tabla usuarios'),now());

create trigger borrar_usuario after delete on usuarios
for each row
insert into auditoria(DESCRIPCION,FECHA) values ( concat('Se elimina el usuario de nombre ',old.NOMBRE_US,' con correo ', old.email,' de la tabla usuarios'),now());

create trigger actualizar_usuario after update on usuarios
for each row
insert into auditoria(DESCRIPCION,FECHA) values (concat('Se logeó el usuario de ', new.NOMBRE_US, 'o se actualizaron sus datos personales.'),now());


/* Para foto*/
drop trigger if exists insertar_foto;
drop trigger if exists borrar_foto;
drop trigger if exists actualizar_foto;

/* ID_fotos              int not null,
   ID_usuario           int not null,
   DESCRIPCION          text,
   FECHA                date,
   TITULO               varchar(100
*/
create trigger insertar_foto after insert on fotos
for each row
insert into auditoria(DESCRIPCION,FECHA) values ( concat('Se inserta la foto de id ',new.Id,' y con descripción: "', new.DESCRIPCION,'" a la tabla fotos'),now());

create trigger borrar_foto after delete on fotos
for each row
insert into auditoria(DESCRIPCION,FECHA) values (concat('Se borra la foto de id ',old.Id,' y con descripción: "', old.DESCRIPCION,'" a la tabla fotos'),now());

create trigger actualizar_foto after update on fotos
for each row
insert into auditoria(DESCRIPCION,FECHA) values (concat('Se cambia la descripción de la foto ',old.Id,' desde ',old.DESCRIPCION,' a ',new.DESCRIPCION),now());

/* Para comentario*/
drop trigger if exists insertar_comentario;
drop trigger if exists borrar_comentario;
drop trigger if exists actualizar_comentario;

/*
   ID_comentarios        int not null,
   ID_usuario           int,
   ID_fotos              int not null,
   TEXTO                text,
   FECHA                datetime,*/
create trigger insertar_comentario after insert on comentarios
for each row
insert into auditoria(DESCRIPCION,FECHA) values (concat('Se inserta el comentario con texto ',new.TEXTO,' con id ', new.Id),now());

create trigger borrar_comentario after delete on comentarios
for each row
insert into auditoria(DESCRIPCION,FECHA) values (concat('Se elimina el comentario de id ',old.Id,' y de texto ',old.TEXTO),now());

create trigger actualizar_comentario after update on comentarios
for each row
insert into auditoria(DESCRIPCION,FECHA) values (concat('Se cambia el texto del comentario de id ',old.Id,' y de ',old.TEXTO,' a ',new.TEXTO),now());

/* Para administrador*/
drop trigger if exists insertar_administrador;
drop trigger if exists borrar_administrador;
drop trigger if exists actualizar_administrador;

/*ID_ADMIN             int not null,
   CONTRASENA_AD        char(255),
   CORREO_AD            varchar(150),
   NOMBRE_AD            varchar(50),
   APELLIDO_AD          varchar(50),
*/
create trigger insertar_administrador after insert on admin_users
for each row
insert into auditoria(DESCRIPCION,FECHA) values (concat('Se inserta el administrador con correo ',new.email,'.'),now());

create trigger borrar_administrador after delete on admin_users
for each row
insert into auditoria(DESCRIPCION,FECHA) values (concat('Se elimina el administrador con correo ',old.email,'.'),now());

create trigger actualizar_administrador after update on admin_users
for each row
insert into auditoria(DESCRIPCION,FECHA) values (concat('Se actualizan los datos  del administrador con id  ',old.Id,' y correo ',old.email, ' a correo ', new.email),now());

/*Para calificación*/

/*ID_calificacions      int not null,
   ID_fotos              int not null,
   ID_usuario           int not null,
   VALOR_calificacions   int*/
drop trigger if exists insertar_calificacion;
drop trigger if exists borrar_calificacion;
drop trigger if exists actualizar_calificacion;

create trigger insertar_calificacion after insert on calificacions
for each row
insert into auditoria(DESCRIPCION,FECHA) values (concat('Se inserta la calificación  ',new.nota,' a la foto ',new.foto_id),now());

create trigger borrar_calificacion after delete on calificacions
for each row
insert into auditoria(DESCRIPCION,FECHA) values (concat('Se elimina la calificación  de id ',old.Id, ' con valor ',old.nota),now());

create trigger actualizar_calificacion after update on calificacions
for each row
insert into auditoria(DESCRIPCION,FECHA) values (concat('Se cambia el valor de la calificación  de id ',old.Id, ' con valor ',old.nota,' al valor ', new.nota),now());

/*Para amigos*/
drop trigger if exists insertar_amigo;
drop trigger if exists borrar_amigo;
drop trigger if exists actualizar_amigo;

/*
  ID_AMISTAD           int not null,
   ID_usuario           int not null,
   ID_amigo_usuario       int not null,
   FECHA_AMISTAD 	date*/
create trigger insertar_amigo after insert on amigos
for each row
insert into auditoria(DESCRIPCION,FECHA) values (concat('Se inserta la amistad entre ',new.amigo_id,' y ',new.usuario_id),now());

create trigger borrar_amigo after delete on amigos
for each row
insert into  auditoria(DESCRIPCION,FECHA) values (concat('Se elimina la amistad entre ',old.amigo_id,' y ',old.usuario_id),now());
/*delete from amigos where ID_usuario=old.ID_usuario and ID_amigo_usuario = old.ID_usuario;/*Este caso es diferente, ya que en caso de que no encuentre la condición no borrará nada*/

/*no creo que sea necesario poner un trigger de actualización para esta, debido
a que basta con agregar una nueva relación en vez de cambiar una que existe
/*create trigger actualizar_amigo after update on amigos
for each row
insert into auditoria(TABLA,CAMBIO,FECHA) values ('amigos','actualizar',now());*/

