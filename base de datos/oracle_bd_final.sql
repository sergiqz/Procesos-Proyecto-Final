CREATE TABLESPACE TIENDA_FINAL1 DATAFILE
'C:\tienda\TIENDITA.dbf' SIZE 100M EXTENT
MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;

-- crear usuario
CREATE USER TIENDA_FINAL
IDENTIFIED BY admin
DEFAULT TABLESPACE TIENDA_FINAL1
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON TIENDA_FINAL1;
--------------------------------------------------------
GRANT CREATE SESSION, RESOURCE, CREATE VIEW, CREATE MATERIALIZED VIEW, CREATE SYNONYM
TO TIENDA_FINAL;
grant create procedure to TIENDA_FINAL;


CREATE TABLE CLIENTE(
   Id_cliente NUMBER(10,0) not null,
   Nombre VARCHAR2(100) not null,
   Apellido VARCHAR2(100) not null,
   Telefono NUMBER(15,0) not null,
   Email VARCHAR2(100) not null,
   Contrasena VARCHAR2(100) not null,
   CONSTRAINT pk_Id_cliente PRIMARY KEY (Id_cliente)
);

CREATE TABLE DIRECCION_COMPRA(
   Id_direccion NUMBER(10,0) not null,
   Id_cliente NUMBER(10,0) not null,
   Tipo_direccion VARCHAR2(300) not null,
   Direccion VARCHAR2(300) not null,
   Nro_lote NUMBER(10,0),
   Depto VARCHAR2(10),
   Urbanizacion VARCHAR2(300),
   Referencia VARCHAR2(300),
   Departamento VARCHAR2(300),
   Provincia VARCHAR2(300),
   Distrito VARCHAR2(300),
   Pais VARCHAR2(100),
   Codigo_postal number(6,0),
   CONSTRAINT dir_fk_cli FOREIGN KEY (Id_cliente) REFERENCES CLIENTE (Id_cliente),
   CONSTRAINT pk_direccion PRIMARY KEY (ID_DIRECCION)
);


CREATE TABLE TARJETAS(
   Id_tarjeta NUMBER(10,0),
   Id_cliente NUMBER(10,0),
   Nombre_titular VARCHAR2(100),
   Apellido_titular VARCHAR2(100),
   Numero_tarjeta NUMBER(16,0),
   Mes_expi NUMBER(2,0),
   Anho_expi NUMBER(2,0),
   CONSTRAINT tarje_fk_cli FOREIGN KEY (Id_cliente) REFERENCES CLIENTE (Id_cliente),
   CONSTRAINT pk_tarjetas PRIMARY KEY (Id_tarjeta)
);

CREATE TABLE Direcciones_facturacion(
   Id_Factura NUMBER(10,0),
   Id_cliente NUMBER(10,0),
   Razon_social VARCHAR2(300),
   RUC VARCHAR2(11),
   Direccion_del_dominio_fiscal VARCHAR2(300),
   CONSTRAINT factu_fk_cli FOREIGN KEY (Id_cliente) REFERENCES CLIENTE (Id_cliente),
   CONSTRAINT pk_factura PRIMARY KEY (Id_Factura)
);

CREATE TABLE Impuesto(
   Id_impuesto NUMBER(10,0),
   Pais VARCHAR2(100),
   Porcentaje_impuesto number(6,3),
   Fecha DATE,
   CONSTRAINT pk_Id_impuesto PRIMARY KEY (Id_impuesto)
);

CREATE TABLE Courrier(
   Id_courrier NUMBER(10,0),
   Nombre VARCHAR2(300),
   Direccion VARCHAR2(300),
   CONSTRAINT pk_Id_courrier PRIMARY KEY (Id_courrier)
);

CREATE TABLE Carrito(
   Id_carrito NUMBER(10,0),
   Id_direccion NUMBER(10,0),
   Id_courrier NUMBER(10,0),
   Id_impuesto NUMBER(10,0),
   Id_Factura NUMBER(10,0),
   Id_tarjeta NUMBER(10,0),
   Fecha_Compra DATE,
   Fecha_Inicio DATE,
   Confirmado VARCHAR2(1),
   Porcentaje_impuesto NUMBER(6,3),
   
   CONSTRAINT car_dir_fk FOREIGN KEY (Id_direccion) REFERENCES DIRECCION_COMPRA (Id_direccion),
   CONSTRAINT car_courri_fk FOREIGN KEY (Id_courrier) REFERENCES Courrier (Id_courrier),
   CONSTRAINT car_impues_fk FOREIGN KEY (Id_impuesto) REFERENCES Impuesto (Id_impuesto),
   CONSTRAINT car_factu_fk FOREIGN KEY (Id_Factura) REFERENCES Direcciones_facturacion (Id_Factura),
   CONSTRAINT car_tarjeta_fk FOREIGN KEY (Id_tarjeta) REFERENCES TARJETAS (Id_tarjeta),
   CONSTRAINT pk_carrito PRIMARY KEY (Id_carrito)
);

CREATE TABLE FACTURAS(
   Id_facturas NUMBER(10,0),
   Id_carrito NUMBER(10,0),
   Fecha DATE,
   CONSTRAINT pk_facturas PRIMARY KEY (Id_facturas),
   CONSTRAINT factu_dir_carri FOREIGN KEY (Id_carrito) REFERENCES Carrito (Id_carrito)
);






CREATE TABLE PROVEEDOR(
   Id_proveedor NUMBER(10,0),
   Nombre_Prove VARCHAR2(300),
   Nombre_Contac VARCHAR2(300),
   Pais VARCHAR2(100),
   Telefono NUMBER(15,0),
   CONSTRAINT pk_proveedor PRIMARY KEY (Id_proveedor)
);
CREATE TABLE CATEGORIA(
   Id_categoria NUMBER(10,0),
   Nombre_Cate VARCHAR2(300),
   Descripcion_Conta VARCHAR2(400),
   CONSTRAINT pk_categoria PRIMARY KEY (Id_categoria)
);



CREATE TABLE PRODUCTOS(
   ID_PRODUCTO NUMBER(10,0),
   ID_CATEGORIA NUMBER(10,0),
   ID_PROVEEDOR NUMBER(10,0),
   Nombre VARCHAR2(200),
   Precio_Unidad NUMBER(8,2),
   Peso VARCHAR2(100),
   Dimensiones VARCHAR2(100),
   Descripcion VARCHAR2(300),
   Descuento NUMBER(8,2),
   CONSTRAINT pro_cat_fk FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIA (ID_CATEGORIA),
   CONSTRAINT pro_prov_fk FOREIGN KEY (ID_PROVEEDOR) REFERENCES PROVEEDOR (ID_PROVEEDOR),
   CONSTRAINT pk_producto PRIMARY KEY (ID_PRODUCTO)
);

CREATE TABLE HISTORIAL(
   ID_HISTORIAL NUMBER(10,0),
   ID_PRODUCTO NUMBER(10,0),
   Precio NUMBER(8,2),
   Fecha DATE,
   CONSTRAINT hist_fk_pro FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTOS (ID_PRODUCTO),
   CONSTRAINT pk_historial PRIMARY KEY (ID_HISTORIAL)
);
CREATE TABLE ALMACENES(
   ID_ALMACEN NUMBER(10,0),
   Nombre VARCHAR2(100),
   DIRECCION VARCHAR2(300),
   CONSTRAINT pk_almacen PRIMARY KEY (ID_ALMACEN)
);

CREATE TABLE ALMACENES_PRODUCTO(
   ID_ALMACEN_PRODUCTO NUMBER(10,0),
   ID_PRODUCTO NUMBER(8,2),
   ID_ALMACEN NUMBER(10,0),
   Stock NUMBER(20,0),
     
   CONSTRAINT alamcen_pro_pro_fk FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTOS (ID_PRODUCTO),
   CONSTRAINT alamcen_pro_alma_fk FOREIGN KEY (ID_ALMACEN) REFERENCES ALMACENES (ID_ALMACEN),
   CONSTRAINT pk_almacen_producto PRIMARY KEY (ID_ALMACEN_PRODUCTO)
);


CREATE TABLE COMPRA_PROD(
   ID_COMPRA NUMBER(10,0),
   ID_PRODUCTO NUMBER(10,0),
   Id_carrito NUMBER(10,0),
   Cantidad NUMBER(20,0),
   Precio NUMBER(8,2),
   Descuento NUMBER(3,2),
     
   CONSTRAINT compra_pro_fk FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTOS (ID_PRODUCTO),
   CONSTRAINT compra_carri_fk FOREIGN KEY (Id_carrito) REFERENCES Carrito (Id_carrito),
   CONSTRAINT pk_compra PRIMARY KEY (ID_COMPRA)
);

CREATE TABLE USUARIO(
   ID_USUARIO NUMBER(10,0),
   Nombre VARCHAR2(200),
   Apellido VARCHAR2(200),
   Telefono NUMBER(15,0),
   Email VARCHAR2(100),
   Contrasena VARCHAR2(100),
   
   CONSTRAINT pk_usuario PRIMARY KEY (ID_USUARIO)
);



CREATE TABLE ROLESS(
   ID_ROL NUMBER(10,0),
   Nombre VARCHAR2(100),
   Descripcion VARCHAR2(300),
   
   CONSTRAINT pk_rol PRIMARY KEY (ID_ROL)
);


CREATE TABLE Usuario_rol(
   ID_USUARIO_ROL NUMBER(10,0),
   ID_ROL NUMBER(10,0),
   ID_USUARIO NUMBER(10,0),
   
   CONSTRAINT usuario_rol_fk_rol FOREIGN KEY (ID_ROL) REFERENCES ROLESS (ID_ROL),
   CONSTRAINT usuario_rol_fk_usuario FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO (ID_USUARIO),
   CONSTRAINT pk_usuario_rol PRIMARY KEY (ID_USUARIO_ROL)
);

CREATE TABLE TIPO_CAMBIO(
   ID_TIPO_CAMBIO NUMBER(10,0),
   valor_soles NUMBER(5,2),
   NOMBRE VARCHAR2(300),

   CONSTRAINT pk_tipo_cambio PRIMARY KEY (ID_TIPO_CAMBIO)
);





select * from cliente;

INSERT INTO cliente VALUES (73221243, 'Sergio', 'Duenas',91345691,'sergiqz@gmail.com','asdfdfsdf');

INSERT INTO cliente VALUES (43199016, 'Jesus', 'Ventura',91345191,'jesusv@gmail.com','asdfwgserg');

INSERT INTO cliente VALUES (93186116, 'Walker','Manrique20',91151916,'walkerm1@gmail.com','asdfgwerg');

INSERT INTO cliente VALUES (93186999, 'Pepe','Manrique19',91151316,'walkerm2@gmail.com','werger84g');

INSERT INTO cliente VALUES (93186111, 'Pedro','Manrique18',91165916,'walkerm3@gmail.com','rth4re8t4');

INSERT INTO cliente VALUES (93186112, 'Walker','Manrique17',93551916,'walkerm4@gmail.com','rg1tr1g8');

INSERT INTO cliente VALUES (93186113, 'Pedro','Manrique16',92559016,'walkerm5@gmail.com','345234rgserfg');

INSERT INTO cliente VALUES (93186114, 'Juan','Manrique15',9223191,'walkerm6@gmail.com','sgdfserg4');

INSERT INTO cliente VALUES (93186115, 'Sara','Manrique14',9100916,'walkerm7@gmail.com','w3e4tt5tgw4');

INSERT INTO cliente VALUES (93186166, 'Pedro1','Manrique1',9101086,'walkerm8@gmail.com','erffr84541');

INSERT INTO cliente VALUES (93186117, 'Pedro2','Manrique2',9121116,'walkerm9@gmail.com','erg48r8g4');

INSERT INTO cliente VALUES (93186118, 'Pedro3','Manrique3',90551916,'walkerm10@gmail.com','we8rg48rg');

INSERT INTO cliente VALUES (93186119, 'Pedro4','Manrique4',9115016,'walkerm11@gmail.com','w651rg81tr');

INSERT INTO cliente VALUES (93186110, 'Pedro5','Manrique5',91150011,'walkerm12@gmail.com','61u768171j81');

INSERT INTO cliente VALUES (96186111, 'Pedro6','Manrique6',91151919,'walkerm13@gmail.com','gert+g48t4');

INSERT INTO cliente VALUES (97186112, 'Pedro7','Manrique7',91139196,'walkerm14@gmail.com','erg4rt4g8er');

INSERT INTO cliente VALUES (98186113, 'Pedro8','Manrique8',91147116,'walkerm15@gmail.com','ertg4trg');

INSERT INTO cliente VALUES (99186114, 'Pedro9','Manrique9',91112916,'walkerm16@gmail.com','rgt848tr8g');

INSERT INTO cliente VALUES (90086115, 'Pedro10','Manrique10',91551216,'walkerm17@gmail.com','eg84r8t4g4er');

INSERT INTO cliente VALUES (90011666, 'Pedro11','Manrique11',91551296,'walkerm18@gmail.com','er7tge7tr');


select * from direccion_compra;

INSERT INTO DIRECCION_COMPRA VALUES (1,73221243, 'Casa','Calle_horacio_Patino 114',NULL,NULL,'Guardia_Civil','Atras_de_la_sunat', 'Arequipa','Arequipa','Paucarpata','Peru','518685');

INSERT INTO DIRECCION_COMPRA VALUES (2,73221243, 'Departamento','Calle_Patino 1314',NULL,1,NULL,'Atras_de_la_sunat1', 'Cuzco','Cuzco','Paucarpata','Peru','181818');

INSERT INTO DIRECCION_COMPRA VALUES (3,43199016, 'Condominio','Calle_Gustavo 358',NULL,NULL,NULL,'Atras_de_la_sunat2', 'Andahuaylas','Apurimac','Paucarpata','Peru','181951');

INSERT INTO DIRECCION_COMPRA VALUES (4,93186116, 'Residencial','Avenida_Tesoro 114',NULL,NULL,'Guardia_Civil2','Atras_de_la_sunat3','Paucarpata','Puno','Paucarpata','Peru','181819');

INSERT INTO DIRECCION_COMPRA VALUES (5,93186999, 'Otro','Avenida_Enrrique 244',100,NULL,NULL,'Atras_de_la_sunat4','Paucarpata','Tacna','Paucarpata','Peru','181851');

INSERT INTO DIRECCION_COMPRA VALUES (6,93186111, 'Local','Avenida_Enrrique 132',NULL,NULL,'Guardia_Civi4','Atras_de_la_sunat5','Tacna','Paucarpata','Peru','181614');

INSERT INTO DIRECCION_COMPRA VALUES (7,93186112, 'Casa','Avenida_Enrrique 313',NULL,NULL,'Guardia_Civi6','Atras_de_la_sunat6', 'Tacna','Tacna','Paucarpata','Peru','181842');

INSERT INTO DIRECCION_COMPRA VALUES (8,93186113, 'Oficina','Avenida_Enrrique 579',NULL,NULL,'Guardia_Civi7','Atras_de_la_sunat7', 'Lima','Lima','Paucarpata','Peru','191151');

INSERT INTO DIRECCION_COMPRA VALUES (9,93186114, 'Departamento','Avenida_Gustavo1 116',NULL,1,'Guardia_Civi8','Atras_de_la_sunat8', 'Lima','Lima','Paucarpata','Peru','616812');

INSERT INTO DIRECCION_COMPRA VALUES (10,93186115, 'Departamento','Avenida_Gustavo1 115',NULL,2,'Guardia_Civil9','Atras_de_la_sunat9', 'Puno','Puno','Paucarpata','Peru','711612');

INSERT INTO DIRECCION_COMPRA VALUES (11,93186166, 'Departamento','Avenida_Gustavo1 114',NULL,3,'Guardia_Civil10','Atras_de_la_sunat10', 'Cuzco','Cuzco','Paucarpata','Peru','716121');

INSERT INTO DIRECCION_COMPRA VALUES (12,93186166, 'Departamento','Avenida_Gustavo1 113',NULL,4,'Guardia_Civil11','Atras_de_la_sunat11', 'Piura','Piura','Paucarpata','Peru','915191');

INSERT INTO DIRECCION_COMPRA VALUES (13,93186118, 'Residencial','Avenida_Gustavo1 112',NULL,NULL,'Guardia_Civil12','Atras_de_la_sunat12', 'Piura','Piura','Paucarpata','Peru','118161');


INSERT INTO DIRECCION_COMPRA VALUES (15,93186110, 'Condominio','Avenida_Gustavo1 110',NULL,NULL,'Guardia_Civil14','Atras_de_la_sunat14', 'Ica','Ica','Paucarpata','Peru','231219');

INSERT INTO DIRECCION_COMPRA VALUES (16,96186111, 'Condominio','Avenida_Gustavo1 109',NULL,NULL,'Guardia_Civil15','Atras_de_la_sunat15', 'Ica','Ica','Paucarpata','Peru','711115');

INSERT INTO DIRECCION_COMPRA VALUES (17,97186112, 'Casa','Avenida_Gustavo1 108',NULL,NULL,'Guardia_Civil16','Atras_de_la_sunat16', 'Lima','Lima','Paucarpata','Peru','211611');

INSERT INTO DIRECCION_COMPRA VALUES (14,93186119, 'Residencial','Avenida_Gustavo1 111',NULL,NULL,'Guardia_Civil13','Atras_de_la_sunat13', 'Ica','Ica','Paucarpata','Peru','211181');

INSERT INTO DIRECCION_COMPRA VALUES (18,98186113, 'Otro','Avenida_Gustavo1 107',100,NULL,'Guardia_Civil17','Atras_de_la_sunat17', 'Lima','Lima','Paucarpata','Peru','117511');

INSERT INTO DIRECCION_COMPRA VALUES (19,99186114, 'Otro','Avenida_Gustavo1 106',23,NULL,'Guardia_Civil18','Atras_de_la_sunat18', 'Lima','Lima','Paucarpata','Peru','915818');

INSERT INTO DIRECCION_COMPRA VALUES (20,90086115, 'Oficina','Avenida_Gustavo1 105',NULL,NULL,'Guardia_Civil19','Atras_de_la_sunat19', 'Arequipa','Arequipa','Paucarpata','Peru','411561');

INSERT INTO DIRECCION_COMPRA VALUES (21,90011666, 'Oficina','Avenida_Gustavo1 104',NULL,NULL,'Guardia_Civil20','Atras_de_la_sunat20', 'Arequipa','Arequipa','Paucarpata','Peru','161651');

INSERT INTO DIRECCION_COMPRA VALUES (22,93186111, 'Casa','Avenida_Gustavo1 103',NULL,NULL,'Guardia_Civil21','Atras_de_la_sunat21', 'Arequipa','Arequipa','Paucarpata','Peru','165116');

INSERT INTO DIRECCION_COMPRA VALUES (23,90086115, 'Casa','Avenida_Gustavo1 102',NULL,NULL,'Guardia_Civil22','Atras_de_la_sunat22', 'Arequipa','Arequipa','Paucarpata','Peru','151556');

INSERT INTO DIRECCION_COMPRA VALUES (24,90011666, 'Casa','Avenida_Gustavo1 101',NULL,NULL,'Guardia_Civil23','Atras_de_la_sunat23', 'Arequipa','Arequipa','Paucarpata','Peru','114115');

INSERT INTO DIRECCION_COMPRA VALUES (25,73221243, 'Casa','Avenida_Gustavo1 100',NULL,NULL,'Guardia_Civil24','Atras_de_la_sunat24', 'Arequipa','Arequipa','Paucarpata','Peru','159515');

INSERT INTO DIRECCION_COMPRA VALUES (26,94251251, 'Casa','Avenida_Gustavo1 100',NULL,NULL,'Guardia_Civil24','Atras_de_la_sunat24', 'Bogota','Bogota','Chincheri','Colombia','159515');

select * from categoria;

INSERT INTO categoria VALUES (1,'CELULARES Y TABLETS','Celulares y Smartphones TABLETS');

INSERT INTO categoria VALUES (2,'TV, AUDIO, FOTO','');

INSERT INTO categoria VALUES (3,'CONSOLA Y VIDEJUEGOS' ,'');

INSERT INTO categoria VALUES (4,'COMPUTACION','');

INSERT INTO categoria VALUES (5,'HOGAR','');

INSERT INTO categoria VALUES (6,'ELECTROHOGAR','');

INSERT INTO categoria VALUES (7,'MODA','');

INSERT INTO categoria VALUES (8,'RELOJES Y ACCESORIOS','');

INSERT INTO categoria VALUES (9,'BELLEZA Y CUIDADO PERSONAL','');

select * from proveedor;

INSERT INTO Proveedor VALUES (1,'Adidas pro' ,'Juan', 'EEUU','11155611');

INSERT INTO Proveedor VALUES (2,'Huawei pro' ,'WA', 'CHINA','11616615');

INSERT INTO Proveedor VALUES (3,'Dell pro' ,'Pedro', 'EEUU','116161688');

INSERT INTO Proveedor VALUES (4,'Lenovo pro' ,'Carlos', 'EEUU','91191151');

INSERT INTO Proveedor VALUES (5,'LG pro' ,'Juan', 'EEUU','1819815');

INSERT INTO Proveedor VALUES (6,'XBOX pro' ,'Pedro', 'EEUU','98498115');

INSERT INTO Proveedor VALUES (7,'CAMILO pro' ,'Carlos', 'Espana','481111544');

INSERT INTO Proveedor VALUES (8,'CRITAL pro' ,'Carlos', 'Brasil','71161719');

INSERT INTO Proveedor VALUES (9,'EXIS pro' ,'Juan', 'Alemania','4179116');


select * from productos;


INSERT INTO productos VALUES (1,7,1,'Zapatillas Hombre B22703 3MC',219.00,'2kg','talla 48','zapatillas hombre negras talla 49',0);

INSERT INTO productos VALUES (2,7,1,'C C.S NEGRO-10.0',139.00,'8kg','10cm x 20cm','',0);

INSERT INTO productos VALUES (3,1,2,'P30 Lite 128GB 4GB Ram - Negro',999.00,'1kg','2cm x 5cm','P30 Lite 128GB 4GB Ram',0);

INSERT INTO productos VALUES (4,1,2,'Y5 2018',355.00,'1kg','2cm x 5cm','Y5 2018 1 ram',0);

INSERT INTO productos VALUES (5,2,3,'Audífonos Inalámbricos ',79.00,'0.1kg','2cm x 40cm','Audífonos Inalámbricos',0);

INSERT INTO productos VALUES (6,2,5,'Televisor LED Smart TV UHD 4K',159.00,'11kg','40 pulgadas','Televisor LED Smart TV UHD 4K',0);

INSERT INTO productos VALUES (7,3,7,'Nintendo Switch Neón',1299.00,'2kg','2cm x 5cm','Nintendo Switch Neón',0);

INSERT INTO productos VALUES (8,3,6,'Xbox One S 1TB Forza ',1295.00,'2kg','5cm x 10cm','Xbox One S 1TB Forza',0);

INSERT INTO productos VALUES (9,4,3,'Laptop Dell Gaming G3 15" ',3999.00,'2kg','30cm x 40cm','Laptop Dell Gaming G3 15',0);

INSERT INTO productos VALUES (10,4,4,'Disco Duro Externo 2TB',279.40,'0.2kg','10cm x 6cm','Disco Duro Externo 2TB',0);

INSERT INTO productos VALUES (11,5 ,9,'Tetera De Vidrio Pyrex, 2600 ',44.40,'1kg','30cm','Tetera De Vidrio Pyrex, 2600 ',0);

INSERT INTO productos VALUES (12,5 ,8,'Zapatera Armable de 5 Niveles ',49.00,'20kg','100cm x 150cm','Zapatera Armable de 5 Niveles',0);

INSERT INTO productos VALUES (13,6 ,7,'Maquina para Cremoladas ',80.00,'5kg','50cm x 100cm','Maquina para Cremoladas',0);

INSERT INTO productos VALUES (14,6 ,7,'Mini Enfriador de Aire ',44.90,'10kg','100cm x 50cm','Mini Enfriador de Aire',0);

INSERT INTO productos VALUES (17,8 ,7,'Reloj Fossil FS5379 ',473,'0.5kg','.','Reloj Fossil FS5379',0);

INSERT INTO productos VALUES (18,8 ,8,'Reloj Casio Edifice ',299,'0.3kg','.','Reloj Casio Edifice',0);

INSERT INTO productos VALUES (19,9 ,9,'PHILIPS ALISADORA ',119,'2kg','5cm','PHILIPS ALISADORA',0);

INSERT INTO productos VALUES (20,9 ,8,'Alisador Siegen 3530 ',169,'2kg','5cm','Alisador Siegen 3530',0);

select * from DIRECCIONES_FACTURACION;

INSERT INTO DIRECCIONES_FACTURACION VALUES (1,73221243, 'Sergio EMP',7484845468,'Calle Horacio Patino 114 Arequipa');

INSERT INTO DIRECCIONES_FACTURACION VALUES (2,93186116, 'Walker EMP',3486514568,'Calle Gustavo 154 Cusco');

INSERT INTO DIRECCIONES_FACTURACION VALUES (3,93186999, 'Pepe EMP',9988845458,'Calle Horacio 1024 Arequipa');

INSERT INTO DIRECCIONES_FACTURACION VALUES (4,93186110, 'Pedro EMP',0484845468,'Av Tildo 224 Lima');

INSERT INTO DIRECCIONES_FACTURACION VALUES (5,90086115, 'Juanito EMP',1486545468,'AV Guardio Patino 994 Lima');

select * from tarjetas;

INSERT INTO tarjetas VALUES (1,73221243,'Sergio','Duenas',9415126548711284,1,21);

INSERT INTO tarjetas VALUES (2,43199016, 'Jesus', 'Ventura',9134519165792642,3,31);

INSERT INTO tarjetas VALUES (3,93186116, 'Walker','Manrique20',9115519164861267,1,22);

INSERT INTO tarjetas VALUES (4,93186999, 'Pepe','Manrique19',9115123168671894,3,19);

INSERT INTO tarjetas VALUES (5,93186111, 'Pedro','Manrique18',9115659169482176,6,22);

INSERT INTO tarjetas VALUES (6,93186116, 'Walker','Manrique17',9235519169712643,7,21);

INSERT INTO tarjetas VALUES (7,93186113, 'Pedro','Manrique16',9825590161794582,8,23);

INSERT INTO tarjetas VALUES (8,93186114, 'Juan','Manrique15',912231911794568,9,22);

INSERT INTO tarjetas VALUES (9,93186115, 'Sara','Manrique14',910009165791635,10,22);

INSERT INTO tarjetas VALUES (10,93186166, 'Pedro1','Manrique1',911010869826475,4,25);

INSERT INTO tarjetas VALUES (11,93186117, 'Pedro2','Manrique2',911211168617456,3,21);

INSERT INTO tarjetas VALUES (12,93186118, 'Pedro3','Manrique3',9005519169314682,2,21);

INSERT INTO tarjetas VALUES (13,93186119, 'Pedro4','Manrique4',9115500161234765,3,20);

INSERT INTO tarjetas VALUES (14,93186110, 'Pedro5','Manrique5',9115500112226479,5,18);

INSERT INTO tarjetas VALUES (15,96186111, 'Pedro6','Manrique6',9115191919758163,6,19);

INSERT INTO tarjetas VALUES (16,97186112, 'Pedro7','Manrique7',9113919168164792,1,20);

INSERT INTO tarjetas VALUES (17,98186113, 'Pedro8','Manrique8',9114719167123486,5,20);

INSERT INTO tarjetas VALUES (18,99186114, 'Pedro9','Manrique9',9111219168542222,11,21);

INSERT INTO tarjetas VALUES (19,90086115, 'Pedro10','Manrique10',9115512167111195,11,20);

INSERT INTO tarjetas VALUES (20,90011666, 'Pedro11','Manrique11',9115512296816791,12,24);

select * from impuesto;

INSERT INTO impuesto VALUES (1,'Peru',2,TO_DATE('2019/09/11', 'yyyy/mm/dd'));

INSERT INTO impuesto VALUES (2,'Colombia',5,TO_DATE('2019/11/20', 'yyyy/mm/dd'));

INSERT INTO impuesto VALUES (3,'Espana',10,TO_DATE('2019/03/30', 'yyyy/mm/dd'));

INSERT INTO impuesto VALUES (4,'Chile',6,TO_DATE('2019/05/11', 'yyyy/mm/dd'));

INSERT INTO impuesto VALUES (5,'Mexico',7,TO_DATE('2019/07/01', 'yyyy/mm/dd'));

INSERT INTO impuesto VALUES (6,'EEUU',8,TO_DATE('2019/08/20', 'yyyy/mm/dd'));

SELECT * FROM COURRIER;

INSERT INTO COURRIER VALUES (1,'POLLITO', 'calle san cristobal 115');

INSERT INTO COURRIER VALUES (2,'CHASQUI', 'calle pizarroo 515');

INSERT INTO COURRIER VALUES (3,'LLAMITA', 'calle san lorenzo 516');

INSERT INTO COURRIER VALUES (4,'TRAVEL', 'avenida walker 5161');

INSERT INTO COURRIER VALUES (5,'SPEED', 'calle gustavo 1818');

INSERT INTO COURRIER VALUES (6,'FAST', 'calle nicolas 1515');


 select * from almacenes;
 
 INSERT INTO almacenes VALUES (1,'sergio_alma_0','avenida hugarte 115');
 
 INSERT INTO almacenes VALUES (2,'sergio_alma_1','calle civil 200');
 
 INSERT INTO almacenes VALUES (3,'sergio_alma_2','avenida hugarte 720');
 
 INSERT INTO almacenes VALUES (4,'sergio_alma_3','avenida cruce 145');
 
 INSERT INTO almacenes VALUES (5,'sergio_alma_4','avenida pierola 715');
 
 INSERT INTO almacenes VALUES (6,'sergio_alma_5','avenida pizarro 1123');
 
 INSERT INTO almacenes VALUES (7,'sergio_alma_6','avenida colon 165');

  select * from ALMACENES_PRODUCTO;
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (1,1,1,20);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (2,2,2,10);
   
  INSERT INTO ALMACENES_PRODUCTO VALUES (3,3,3,30);

  INSERT INTO ALMACENES_PRODUCTO VALUES (4,4,4,15);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (5,5,5,13);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (6,6,6,21);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (7,7,7,19);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (8,8,1,18);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (9,9,2,14);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (10,10,3,14);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (11,11,4,31);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (12,12,5,25);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (13,13,6,24);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (14,14,7,27);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (15,15,1,28);

  INSERT INTO ALMACENES_PRODUCTO VALUES (16,16,2,29);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (17,17,3,30);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (18,18,4,11);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (19,19,5,9);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (20,20,6,5);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (21,1,7,8);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (22,3,1,9);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (23,10,2,20);
 
  INSERT INTO ALMACENES_PRODUCTO VALUES (24,15,3,14);

  select * from USUARIO;
 
INSERT INTO USUARIO VALUES (73221285, 'Pedro', 'Duenas',91345691,'pedritox','asdfdfsdf');

INSERT INTO USUARIO VALUES (43199091, 'Gustavo', 'Ventura',91345191,'gustavox','asdfwgserg');

INSERT INTO USUARIO VALUES (93186145, 'Walter','Manrique20',91151916,'walterx','asdfgwerg');

INSERT INTO USUARIO VALUES (93186951, 'Erick','Manrique19',91151316,'ericksenx','werger84g');

INSERT INTO USUARIO VALUES (93186123, 'Andre','Manrique18',91165916,'andrexito','rth4re8t4');

INSERT INTO USUARIO VALUES (93184845, 'Tito','Manrique17',93551916,'titox','rg1tr1g8');


select * from roless;

INSERT INTO roless VALUES (1, 'SELECT','Ability to perform SELECT statements on the table.');

INSERT INTO roless VALUES (2, 'INSERT','Ability to perform INSERT statements on the table.');

INSERT INTO roless VALUES (3, 'UPDATE','Ability to perform UPDATE statements on the table.');

INSERT INTO roless VALUES (4, 'DELETE','Ability to perform DELETE statements on the table.');

INSERT INTO roless VALUES (5, 'REFERENCE','Ability to create a constraint that refers to the table.');

INSERT INTO roless VALUES (6, 'ALTER','Ability to perform ALTER TABLE statements to change the table definition.');

select * from USUARIO_ROL;

INSERT INTO USUARIO_ROL VALUES (1,1,73221285);

INSERT INTO USUARIO_ROL VALUES (2,2,43199091);

INSERT INTO USUARIO_ROL VALUES (3,3,93186145);

INSERT INTO USUARIO_ROL VALUES (4,4,93186951);

INSERT INTO USUARIO_ROL VALUES (5,5,93186123);

INSERT INTO USUARIO_ROL VALUES (6,6,93184845);

select * from tipo_cambio;

INSERT INTO tipo_cambio VALUES (1,3.2,'Dolares');

select * from historial;

INSERT INTO historial VALUES (1,1,219,TO_DATE('2019/10/24', 'yyyy/mm/dd'));

INSERT INTO historial VALUES (2,2,139,TO_DATE('2019/10/30', 'yyyy/mm/dd'));

INSERT INTO historial VALUES (3,3,999,TO_DATE('2019/10/23', 'yyyy/mm/dd'));

INSERT INTO historial VALUES (4,4,355,TO_DATE('2019/10/20', 'yyyy/mm/dd'));

INSERT INTO historial VALUES (5,5,79,TO_DATE('2019/11/20', 'yyyy/mm/dd'));

INSERT INTO historial VALUES (6,6,159,TO_DATE('2019/11/08', 'yyyy/mm/dd'));

INSERT INTO historial VALUES (7,7,1299,TO_DATE('2019/11/11', 'yyyy/mm/dd'));

INSERT INTO historial VALUES (8,8,1295,TO_DATE('2019/11/10', 'yyyy/mm/dd'));

INSERT INTO historial VALUES (9,9,3999,TO_DATE('2019/11/29', 'yyyy/mm/dd'));

INSERT INTO historial VALUES (10,10,279,TO_DATE('2019/11/26', 'yyyy/mm/dd'));

INSERT INTO historial VALUES (11,11,44,TO_DATE('2019/11/04', 'yyyy/mm/dd'));

INSERT INTO historial VALUES (12,12,49,TO_DATE('2019/10/28', 'yyyy/mm/dd'));

INSERT INTO historial VALUES (13,13,80,TO_DATE('2019/11/28', 'yyyy/mm/dd'));

INSERT INTO historial VALUES (14,14,45,TO_DATE('2019/11/27', 'yyyy/mm/dd'));

INSERT INTO historial VALUES (17,17,119,TO_DATE('2019/11/09', 'yyyy/mm/dd'));

INSERT INTO historial VALUES (18,18,169,TO_DATE('2019/11/03', 'yyyy/mm/dd'));

select * from carrito;
select * from courrier;
select * from impuesto;
select * from direccion_compra;


INSERT INTO carrito VALUES (1,1,1,1,null,1,TO_DATE('2019/10/06', 'yyyy/mm/dd'),TO_DATE('2019/10/03', 'yyyy/mm/dd'),'T',4);

INSERT INTO carrito VALUES (2,2,1,1,null,2,TO_DATE('2019/10/12', 'yyyy/mm/dd'),TO_DATE('2019/10/11', 'yyyy/mm/dd'),'T',10);

INSERT INTO carrito VALUES (3,3,1,1,null,3,TO_DATE('2019/09/28', 'yyyy/mm/dd'),TO_DATE('2019/09/25', 'yyyy/mm/dd'),'T',3);

INSERT INTO carrito VALUES (4,4,2,1,null,4,TO_DATE('2019/09/18', 'yyyy/mm/dd'),TO_DATE('2019/09/15', 'yyyy/mm/dd'),'T',1);

INSERT INTO carrito VALUES (5,5,2,2,null,5,TO_DATE('2019/09/10', 'yyyy/mm/dd'),TO_DATE('2019/09/04', 'yyyy/mm/dd'),'T',1);

INSERT INTO carrito VALUES (6,6,2,2,null,6,TO_DATE('2019/10/13', 'yyyy/mm/dd'),TO_DATE('2019/10/11', 'yyyy/mm/dd'),'T',2);

INSERT INTO carrito VALUES (7,7,3,2,null,7,TO_DATE('2019/10/12', 'yyyy/mm/dd'),TO_DATE('2019/10/10', 'yyyy/mm/dd'),'T',2);

INSERT INTO carrito VALUES (8,8,3,3,null,8,null,TO_DATE('2019/10/25', 'yyyy/mm/dd'),'F',6);

INSERT INTO carrito VALUES (9,9,3,1,null,9,null,TO_DATE('2019/09/12', 'yyyy/mm/dd'),'F',4);

INSERT INTO carrito VALUES (10,10,3,1,null,10,TO_DATE('2019/10/04', 'yyyy/mm/dd'),TO_DATE('2019/10/03', 'yyyy/mm/dd'),'T',3);

INSERT INTO carrito VALUES (11,11,3,1,null,11,TO_DATE('2019/10/03', 'yyyy/mm/dd'),TO_DATE('2019/10/03', 'yyyy/mm/dd'),'T',5);

INSERT INTO carrito VALUES (12,12,4,1,null,12,TO_DATE('2019/11/05', 'yyyy/mm/dd'),TO_DATE('2019/11/04', 'yyyy/mm/dd'),'F',9);

INSERT INTO carrito VALUES (13,13,5,1,null,13,TO_DATE('2019/10/05', 'yyyy/mm/dd'),TO_DATE('2019/10/05', 'yyyy/mm/dd'),'T',10);

INSERT INTO carrito VALUES (14,14,5,5,null,14,null,TO_DATE('2019/09/07', 'yyyy/mm/dd'),'F',6);

INSERT INTO carrito VALUES (15,15,5,4,null,15,TO_DATE('2019/09/07', 'yyyy/mm/dd'),TO_DATE('2019/09/07', 'yyyy/mm/dd'),'T',2);

INSERT INTO carrito VALUES (16,16,6,3,null,16,TO_DATE('2019/10/15', 'yyyy/mm/dd'),TO_DATE('2019/10/14', 'yyyy/mm/dd'),'T',0);

INSERT INTO carrito VALUES (17,17,6,6,null,17,null,TO_DATE('2019/11/15', 'yyyy/mm/dd'),'F',0);

INSERT INTO carrito VALUES (18,18,6,5,null,18,TO_DATE('2019/11/21', 'yyyy/mm/dd'),TO_DATE('2019/11/20', 'yyyy/mm/dd'),'T',3);

INSERT INTO carrito VALUES (19,19,6,4,1,19,TO_DATE('2019/11/23', 'yyyy/mm/dd'),TO_DATE('2019/11/22', 'yyyy/mm/dd'),'T',7);

INSERT INTO carrito VALUES (20,20,3,3,null,20,null,TO_DATE('2019/10/22', 'yyyy/mm/dd'),'F',4);

INSERT INTO carrito VALUES (21,21,4,2,1,1,TO_DATE('2019/10/02', 'yyyy/mm/dd'),TO_DATE('2019/09/10', 'yyyy/mm/dd'),'T',6);

INSERT INTO carrito VALUES (22,22,5,1,null,2,TO_DATE('2019/10/03', 'yyyy/mm/dd'),TO_DATE('2019/10/02', 'yyyy/mm/dd'),'T',8);

INSERT INTO carrito VALUES (23,23,4,1,2,1,TO_DATE('2019/11/05', 'yyyy/mm/dd'),TO_DATE('2019/11/03', 'yyyy/mm/dd'),'T',8);

INSERT INTO carrito VALUES (24,24,5,1,null,3,null,TO_DATE('2019/11/15', 'yyyy/mm/dd'),'F',6);

INSERT INTO carrito VALUES (25,25,1,1,3,1,null,TO_DATE('2019/11/30', 'yyyy/mm/dd'),'F',9);

INSERT INTO carrito VALUES (26,1,2,1,null,5,null,TO_DATE('2019/11/29', 'yyyy/mm/dd'),'F',10);


select * from FACTURAS;

INSERT INTO FACTURAS VALUES (1,19,TO_DATE('2019/11/23', 'yyyy/mm/dd'));

INSERT INTO FACTURAS VALUES (2,21,TO_DATE('2019/10/02', 'yyyy/mm/dd'));

INSERT INTO FACTURAS VALUES (3,23,TO_DATE('2019/11/05', 'yyyy/mm/dd'));

INSERT INTO FACTURAS VALUES (4,25,TO_DATE('2019/11/30', 'yyyy/mm/dd'));


select * from compra_prod;
select * from productos;



INSERT INTO compra_prod VALUES (1,1,1,2,395,10);

INSERT INTO compra_prod VALUES (2,2,2,1,111,20);

INSERT INTO compra_prod VALUES (3,3,3,1,900,10);

INSERT INTO compra_prod VALUES (4,4,4,1,320,10);

INSERT INTO compra_prod VALUES (5,5,5,2,79,0);

INSERT INTO compra_prod VALUES (6,6,6,1,159,0);

INSERT INTO compra_prod VALUES (7,7,7,2,1299,0);

INSERT INTO compra_prod VALUES (8,8,1,1,1295,0);

INSERT INTO compra_prod VALUES (9,9,10,1,3999,0);

INSERT INTO compra_prod VALUES (10,10,11,2,558,0);

INSERT INTO compra_prod VALUES (11,11,12,1,44,0);

INSERT INTO compra_prod VALUES (12,12,13,1,49,0);

INSERT INTO compra_prod VALUES (13,13,15,1,80,0);

INSERT INTO compra_prod VALUES (14,14,16,2,45,0);

INSERT INTO compra_prod VALUES (15,17,18,1,473,0);

INSERT INTO compra_prod VALUES (16,18,19,1,299,0);

INSERT INTO compra_prod VALUES (17,19,21,2,238,0);

INSERT INTO compra_prod VALUES (18,20,22,3,507,0);

INSERT INTO compra_prod VALUES (19,1,23,1,219,0);

INSERT INTO compra_prod VALUES (20,2,1,1,534,0);

INSERT INTO compra_prod VALUES (21,3,2,1,1110,0);

INSERT INTO compra_prod VALUES (22,4,3,1,1255,0);

INSERT INTO compra_prod VALUES (23,11,4,3,364,0);



select * from SYS.DBA_EDITIONING_VIEW_COLS;

SELECT table_name FROM SYS.ALL_TABLES WHERE OWNER='TIENDA_FINAL';

select * from CLIENTE;
select * from DIRECCION_COMPRA;
select * from TARJETAS;
select * from DIRECCIONES_FACTURACION;
select * from COURRIER;
select * from CARRITO;
select * from FACTURAS;
select * from PROVEEDOR;
select * from CATEGORIA;
select * from PRODUCTOS;
select * from HISTORIAL;
select * from ALMACENES;
select * from ALMACENES_PRODUCTO;
select * from COMPRA_PROD;
select * from USUARIO;
select * from ROLESS;
select * from USUARIO_ROL;
select * from IMPUESTO;
select * from TIPO_CAMBIO;









CREATE SEQUENCE prod_prodid_seq
		  INCREMENT BY 1
                START WITH 21
		   MINVALUE 0
                MAXVALUE 10000
                NOCACHE
                NOCYCLE;


CREATE SEQUENCE carr_carrid_seq
		  INCREMENT BY 1
                START WITH 27
		   MINVALUE 0
                MAXVALUE 10000
                NOCACHE
                NOCYCLE;
                
                
                
                
create or replace function CALCULO_IMPUESTO (PRECIO_TOTAL number,IMPUESTO NUMBER)
  return number
 is
 begin 
   return PRECIO_TOTAL-(PRECIO_TOTAL*(IMPUESTO/100));
 end;
 
 create or replace function CALCULO_CAMBIO (PRECIO_TOTAL number,CAMBIO NUMBER)
  return number
 is
 begin 
   return PRECIO_TOTAL*CAMBIO;
 end;

Create or replace procedure insert_cliente
(DNI in NUMBER,NOMBRE in VARCHAR2, APELLIDO in VARCHAR2, TELEFONO in NUMBER, CORREO in VARCHAR2,CONTRASEÑA in VARCHAR2)
as 
begin
INSERT INTO cliente VALUES (DNI, NOMBRE, APELLIDO,TELEFONO,CORREO,CONTRASEÑA);
DBMS_OUTPUT.PUT_LINE('El usuario fue insertado correctamente');    
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE ('Elemento duplicado');
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE ('Elemento invalido');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE (SQLCODE||' '||SQLERRM);
END;
SET SERVEROUTPUT ON
execute insert_cliente(90011666, 'Pedro11','Manrique11',91551296,'walkerm18@gmail.com','er7tge7tr');

Create or replace procedure insert_categoria
(ID in NUMBER,NOMBRE_CATEGORIA in VARCHAR2, DESCRI_CONTAC in VARCHAR2)
as 
begin
INSERT INTO categoria VALUES (ID,NOMBRE_CATEGORIA , DESCRI_CONTAC );
DBMS_OUTPUT.PUT_LINE('El usuario fue insertado correctamente');    
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE ('Elemento duplicado');
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE ('Elemento invalido');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE (SQLCODE||' '||SQLERRM);
END;
SET SERVEROUTPUT ON
execute insert_categoria(1,'CELULARES Y TABLETS','Celulares y Smartphones TABLETS');

Create or replace procedure insert_dire_compra
(ID in NUMBER,Id_cliente NUMBER,TIPO in VARCHAR2, DIRECCION in VARCHAR2, NRO_LOTE in NUMBER, DEPARTAMENTO in VARCHAR2, URBANIZACION in VARCHAR2, REFERENCIA in VARCHAR2,Departamento1 VARCHAR2, PROVINCIA in VARCHAR2, DISTRITO in VARCHAR2, pais in varchar2,Codigo_postal VARCHAR2)
as 
begin
INSERT INTO DIRECCION_COMPRA VALUES (ID,Id_cliente,TIPO, DIRECCION , NRO_LOTE , DEPARTAMENTO, URBANIZACION , REFERENCIA,Departamento1, PROVINCIA , DISTRITO , pais,Codigo_postal);
DBMS_OUTPUT.PUT_LINE('El usuario fue insertado correctamente');    
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE ('Elemento duplicado');
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE ('Elemento invalido');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE (SQLCODE||' '||SQLERRM);
END;
SET SERVEROUTPUT ON
execute insert_dire_compra(26,94251251, 'Casa','Avenida_Gustavo1 100',NULL,NULL,'Guardia_Civil24','Atras_de_la_sunat24', 'Bogota','Bogota','Chincheri','Colombia','1591515');

Create or replace procedure insert_proveedor
(ID in NUMBER,NOMBRE_PROVE in VARCHAR2, NOMBRE_CONTAC in VARCHAR2, PAIS in VARCHAR2,TELEFONO in NUMBER)
as 
begin
INSERT INTO Proveedor VALUES (ID,NOMBRE_PROVE, NOMBRE_CONTAC, PAIS ,TELEFONO);
DBMS_OUTPUT.PUT_LINE('El usuario fue insertado correctamente');    
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE ('Elemento duplicado');
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE ('Elemento invalido');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE (SQLCODE||' '||SQLERRM);
END;
SET SERVEROUTPUT ON
execute insert_proveedor(9,'EXIS pro' ,'Juan', 'Alemania','4179116');

Create or replace procedure insert_productos
(id_categoria in NUMBER,ID_PROVEEDOR NUMBER, NOMBRE in VARCHAR2,precio_unidad in NUMBER,Peso VARCHAR2,Dimensiones VARCHAR2,Descripcion VARCHAR2,Descuento NUMBER)
as 
begin
INSERT INTO productos VALUES (prod_prodid_seq.NEXTVAL,id_categoria, id_proveedor,nombre,precio_unidad,Peso,Dimensiones,Descripcion,Descuento);
DBMS_OUTPUT.PUT_LINE('El usuario fue insertado correctamente');    
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE ('Elemento duplicado');
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE ('Elemento invalido');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE (SQLCODE||' '||SQLERRM);
END;
SET SERVEROUTPUT ON
execute insert_productos(7,1,'Zapatillas Hombre B22703 3MC',219.00,'2kg','talla 48','zapatillas hombre negras talla 49',0);

Create or replace procedure insert_DIRECCIONES_FACTURACION
(ID in NUMBER,Id_cliente NUMBER,razon_Social in VARCHAR2, ruc in NUMBER,direccion in VARCHAR2)
as 
begin
INSERT INTO DIRECCIONES_FACTURACION VALUES (ID ,Id_cliente,razon_Social,ruc,direccion);
DBMS_OUTPUT.PUT_LINE('El usuario fue insertado correctamente');    
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE ('Elemento duplicado');
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE ('Elemento invalido');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE (SQLCODE||' '||SQLERRM);
END;
SET SERVEROUTPUT ON
execute insert_DIRECCIONES_FACTURACION(1,73221243, 'Sergio EMP',7484845468,'Calle Horacio Patino 114 Arequipa');

Create or replace procedure insert_tarjetas
(ID in NUMBER,id_cliente varchar2,NOMBRE_titular in VARCHAR2, apellido_titular in VARCHAR2,numero_tarjeta in NUMBER,mes_expi in NUMBER,ccv in date)
as 
begin
INSERT INTO tarjetas VALUES (ID,id_cliente,NOMBRE_titular, apellido_titular,numero_tarjeta,mes_expi,ccv);
DBMS_OUTPUT.PUT_LINE('El usuario fue insertado correctamente');    
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE ('Elemento duplicado');
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE ('Elemento invalido');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE (SQLCODE||' '||SQLERRM);
END;
SET SERVEROUTPUT ON
execute insert_tarjetas(1,73221243,'Sergio','Duenas',9415126548711284,1,2021);

Create or replace procedure insert_impuesto
(ID in NUMBER,pais in VARCHAR2, porcentaje_impuesto in VARCHAR2,fecha in date)
as 
begin
INSERT INTO impuesto VALUES (ID ,pais , porcentaje_impuesto,fecha);
DBMS_OUTPUT.PUT_LINE('El usuario fue insertado correctamente');    
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE ('Elemento duplicado');
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE ('Elemento invalido');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE (SQLCODE||' '||SQLERRM);
END;
SET SERVEROUTPUT ON
execute insert_impuesto(1,'Peru','2%',TO_DATE('2019/09/11', 'yyyy/mm/dd'));

Create or replace procedure insert_COURRIER
(ID in NUMBER,nombre in VARCHAR2, direccion in VARCHAR2)
as 
begin
INSERT INTO COURRIER VALUES (ID ,nombre,direccion);
DBMS_OUTPUT.PUT_LINE('El usuario fue insertado correctamente');    
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE ('Elemento duplicado');
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE ('Elemento invalido');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE (SQLCODE||' '||SQLERRM);
END;
SET SERVEROUTPUT ON
execute insert_COURRIER(1,'POLLITO', 'calle san cristobal 115');

Create or replace procedure insert_almacenes
(ID in NUMBER,nombre in VARCHAR2, direccion in VARCHAR2)
as 
begin
INSERT INTO almacenes VALUES (ID ,nombre,direccion);
DBMS_OUTPUT.PUT_LINE('El usuario fue insertado correctamente');    
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE ('Elemento duplicado');
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE ('Elemento invalido');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE (SQLCODE||' '||SQLERRM);
END;
SET SERVEROUTPUT ON
execute insert_almacenes(1,'sergio_alma_0','avenida hugarte 115');

Create or replace procedure insert_almacenes_producto
(ID in NUMBER,id_almacen in number, id_producto in number,stock in number)
as 
begin
INSERT INTO ALMACENES_PRODUCTO VALUES (ID ,id_almacen,id_producto,stock);
DBMS_OUTPUT.PUT_LINE('El usuario fue insertado correctamente');    
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE ('Elemento duplicado');
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE ('Elemento invalido');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE (SQLCODE||' '||SQLERRM);
END;
SET SERVEROUTPUT ON
execute insert_almacenes_producto(1,1,1,20);

 Create or replace procedure insert_usuario
(ID in NUMBER,nombre in varchar2, apellido in varchar2,telefono in number,email in varchar2,contraseña in varchar2)
as 
begin
INSERT INTO usuario VALUES (ID,nombre, apellido,telefono,email,contraseña);
DBMS_OUTPUT.PUT_LINE('El usuario fue insertado correctamente');    
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE ('Elemento duplicado');
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE ('Elemento invalido');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE (SQLCODE||' '||SQLERRM);
END;
SET SERVEROUTPUT ON
execute insert_usuario(73221285, 'Pedro', 'Duenas',91345691,'pedro@gmail.com','asdfdfsdf');

Create or replace procedure insert_roless
(ID in NUMBER,NOMBRE in VARCHAR2, descripcion in VARCHAR2)
as 
begin
INSERT INTO roless VALUES (ID,NOMBRE, descripcion);
DBMS_OUTPUT.PUT_LINE('El usuario fue insertado correctamente');    
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE ('Elemento duplicado');
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE ('Elemento invalido');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE (SQLCODE||' '||SQLERRM);
END;
SET SERVEROUTPUT ON
execute insert_roless(1, 'Modificar productos','modifica los productos');

Create or replace procedure insert_usuario_rol
(ID in NUMBER,id_usuario in number, id_rol in number)
as 
begin
INSERT INTO usuario_rol VALUES (ID ,id_usuario,id_rol);
DBMS_OUTPUT.PUT_LINE('El usuario fue insertado correctamente');    
EXCEPTION
WHEN DUP_VAL_ON_INDX THEN
DBMS_OUTPUT.PUT_LINE ('Elemento duplicado');
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE ('Elemento invalido');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE (SQLCODE||' '||SQLERRM);
END;
SET SERVEROUTPUT ON
execute insert_usuario_rol(1,1,73221285);

Create or replace procedure insert_tipo_cambio
(ID in NUMBER,valor in number, nombre in varchar)
as 
begin
INSERT INTO tipo_cambio VALUES (ID ,id_usuario,id_rol);
DBMS_OUTPUT.PUT_LINE('El usuario fue insertado correctamente');    
EXCEPTION
WHEN DUP_VAL_ON_INDX THEN
DBMS_OUTPUT.PUT_LINE ('Elemento duplicado');
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE ('Elemento invalido');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE (SQLCODE||' '||SQLERRM);
END;
SET SERVEROUTPUT ON
execute insert_tipo_cambio(1,3.2,'Dolares');

Create or replace procedure insert_carrito
(ID_direccion in NUMBER ,ID_courrier in NUMBER,ID_impuesto in NUMBER,ID_factura in NUMBER, ID_tarjeta in NUMBER, compra IN DATE, inicio IN DATE,confirmado IN VARCHAR2, porcentaje_impuesto IN NUMBER)
as 
begin
INSERT INTO carrito VALUES (carr_carrid_seq.NEXTVAL,ID_direccion ,ID_courrier,ID_impuesto,ID_factura, ID_tarjeta, compra, inicio,confirmado, porcentaje_impuesto);
DBMS_OUTPUT.PUT_LINE('El usuario fue insertado correctamente');    
EXCEPTION
WHEN DUP_VAL_ON_INDX THEN
DBMS_OUTPUT.PUT_LINE ('Elemento duplicado');
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE ('Elemento invalido');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE (SQLCODE||' '||SQLERRM);
END;
SET SERVEROUTPUT ON
execute insert_carrito(1,1,1,null,1,TO_DATE('2019/10/06', 'yyyy/mm/dd'),TO_DATE('2019/10/03', 'yyyy/mm/dd'),'T',4);




CREATE OR REPLACE PROCEDURE Lista_productos
as
begin
DECLARE
    CURSOR C5 IS     select pro.NOMBRE ,CATE.NOMBRE_CATE,prove.NOMBRE_PROVE ,alma.NOMBRE as nombre_alma from CATEGORIA CATE 
    inner join PRODUCTOS pro on CATE.ID_CATEGORIA=pro.id_categoria
    inner join PROVEEDOR prove on pro.ID_PROVEEDOR=prove.ID_PROVEEDOR
    inner join almacenes_producto  almapro on almapro.ID_PRODUCTO=pro.ID_PRODUCTO
    inner join almacenes alma on alma.ID_ALMACEN=almapro.ID_ALMACEN
    group by pro.id_producto,pro.NOMBRE,CATE.NOMBRE_CATE,prove.NOMBRE_PROVE,alma.NOMBRE
    order by CATE.NOMBRE_CATE;
    BEGIN
    FOR V_REG5 IN C5
    LOOP 
        dbms_output.put_line( 'CATEGORIA: '||V_REG5.NOMBRE_CATE||'    -------    '||'PRODUCTO: '||V_REG5.NOMBRE||'    -------    '||'NOMBRE PROVEEDOR: '||V_REG5.NOMBRE_PROVE||'    -------    '||'ALMACEN: '||V_REG5.nombre_alma);
    END LOOP;
    END;
END;

SET SERVEROUTPUT ON
execute Lista_productos;
    

CREATE OR REPLACE PROCEDURE Lista_precios
as
begin
DECLARE
    CURSOR C5 IS  select pro.NOMBRE ,CATE.NOMBRE_CATE,prove.NOMBRE_PROVE,pro.precio_unidad from CATEGORIA CATE 
    inner join PRODUCTOS pro on CATE.ID_CATEGORIA=pro.id_categoria
    inner join PROVEEDOR prove on pro.ID_PROVEEDOR=prove.ID_PROVEEDOR
    group by pro.id_producto,pro.NOMBRE,CATE.NOMBRE_CATE,prove.NOMBRE_PROVE,pro.precio_unidad
    order by CATE.NOMBRE_CATE;
    BEGIN
    FOR V_REG5 IN C5
    LOOP 
        dbms_output.put_line('CATEGORIA: '||V_REG5.NOMBRE_CATE||'    -------    '||'PRODUCTO: '||V_REG5.NOMBRE||'  '||'    -------    '||'NOMBRE PROVEEDOR'||V_REG5.NOMBRE_PROVE||'    -------    '||'PRECIO'||V_REG5.precio_unidad);
    END LOOP;
    END;
END;

SET SERVEROUTPUT ON
execute Lista_precios;





CREATE OR REPLACE PROCEDURE carrito_cliente_producto
as
begin
DECLARE
    CURSOR C5 IS      select CARR.ID_CARRITO,cli.NOMBRE,pro.NOMBRE as nombrepro from CARRITO CARR 
    inner join DIRECCION_COMPRA direcompra on CARR.ID_DIRECCION=direcompra.ID_DIRECCION
    inner join cliente cli on cli.ID_CLIENTE=direcompra.ID_CLIENTE
    inner join compra_prod compprd on compprd.ID_CARRITO=CARR.ID_CARRITO
    inner join productos pro on compprd.ID_producto=pro.ID_producto;
    BEGIN
    FOR V_REG5 IN C5
    LOOP 
        dbms_output.put_line('ID CARRITO: '||V_REG5.ID_CARRITO||'    -------    '||'CLIENTE: '||V_REG5.NOMBRE||' --------  '||'PRODUCTO:'||V_REG5.nombrepro);
    END LOOP;
    END;
END;

SET SERVEROUTPUT ON
execute carrito_cliente_producto;


CREATE USER PEDRITOX
IDENTIFIED BY asdfdfsdf
DEFAULT TABLESPACE TIENDA_FINAL
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON TIENDA_FINAL;
GRANT SELECT ON PRODUCTOS
TO PEDRITOX;

CREATE USER GUSTAVOX
IDENTIFIED BY asdfwgserg
DEFAULT TABLESPACE TIENDA_FINAL
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON TIENDA_FINAL;
GRANT INSERT ON PRODUCTOS
TO GUSTAVOX;

CREATE USER WALTERX
IDENTIFIED BY asdfgwerg
DEFAULT TABLESPACE TIENDA_FINAL
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON TIENDA_FINAL;
GRANT UPDATE ON PRODUCTOS
TO WALTERX;

CREATE USER ERICKSENX
IDENTIFIED BY werger84g
DEFAULT TABLESPACE TIENDA_FINAL
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON TIENDA_FINAL;
GRANT DELETE ON PRODUCTOS
TO ERICKSENX;

CREATE USER ANDREXITO
IDENTIFIED BY rth4re8t4
DEFAULT TABLESPACE TIENDA_FINAL
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON TIENDA_FINAL;
GRANT REFERENCE ON PRODUCTOS
TO ANDREXITO;

CREATE USER TITOX
IDENTIFIED BY rgltrlg8
DEFAULT TABLESPACE TIENDA_FINAL
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON TIENDA_FINAL;
GRANT ALTER ON PRODUCTOS
TO TITOX;

select * from cliente where NOMBRE ='Manuel';

select 



