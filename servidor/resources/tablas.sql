DROP DATABASE IF EXISTS TN;
CREATE DATABASE IF NOT EXISTS TN;
/*CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON TN.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;*/

USE TN;

DROP TABLE IF EXISTS historialCompras;
DROP TABLE IF EXISTS categoriasAnuncios;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS anuncios;
DROP TABLE IF EXISTS vendedores;
DROP TABLE IF EXISTS usuarios;

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(20) UNIQUE NOT NULL,
    password VARCHAR(500) NOT NULL,
    email VARCHAR(50) NOT NULL,
    tipo CHAR(1) NOT NULL,
    foto VARCHAR(100) DEFAULT 'default_user.png',
    descripcion VARCHAR(200),
    fecha_creacion TIMESTAMP NOT NULL DEFAULT NOW(),
    habilitado TINYINT(1) DEFAULT 1,
    CONSTRAINT usu_hab_ck CHECK(habilitado BETWEEN 0 AND 1),
    CONSTRAINT usu_name_unique UNIQUE(username),
    CONSTRAINT usu_email_unique UNIQUE(email),
    CONSTRAINT usu_email_ck CHECK(email LIKE '%@%.%'),
    CONSTRAINT usu_tipo_ck CHECK(tipo IN ("A","V","C"))
);

CREATE TABLE vendedores (
    id INT PRIMARY KEY,
    direccion VARCHAR(200) NOT NULL,
    telefono VARCHAR(15) NOT NULL UNIQUE,
    CONSTRAINT ven_usu_id_fk FOREIGN KEY(id) REFERENCES usuarios(id) ON DELETE CASCADE
);

CREATE TABLE anuncios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha_publicacion TIMESTAMP NOT NULL DEFAULT NOW(),
    fecha_caducidad TIMESTAMP DEFAULT NOW(),
    nombre VARCHAR(100) UNIQUE NOT NULL,
    descripcion VARCHAR(2000) NOT NULL,
    foto VARCHAR(100) DEFAULT NULL,
    precio DOUBLE NOT NULL,
    vendido TINYINT(1) DEFAULT 0,
	num_visitas INT DEFAULT 0,
    id_vendedor INT,
    CONSTRAINT anu_ven_fk FOREIGN KEY(id_vendedor) REFERENCES vendedores(id) ON DELETE CASCADE 
);

CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(25) UNIQUE NOT NULL
);

CREATE TABLE categoriasAnuncios (
    id_anuncio INT,
    id_categoria INT, 
    CONSTRAINT rel_anu_cat FOREIGN KEY(id_anuncio) REFERENCES anuncios(id) ON DELETE CASCADE,
    CONSTRAINT rel_cat_anu FOREIGN KEY(id_categoria) REFERENCES categorias(id) ON DELETE CASCADE,
    CONSTRAINT cat_anu_pk PRIMARY KEY (id_categoria,id_anuncio)
);

CREATE TABLE historialCompras (
    id_anuncio INT,
    id_comprador INT,
	id_vendedor INT,
    fecha_compra TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT hist_comp_pk PRIMARY KEY (id_anuncio, id_comprador, id_vendedor),
    CONSTRAINT rel_histcomp_anu FOREIGN KEY(id_anuncio) REFERENCES anuncios(id) ON DELETE CASCADE,
    CONSTRAINT rel_histcomp_comp FOREIGN KEY(id_comprador) REFERENCES usuarios(id) ON DELETE CASCADE,
	CONSTRAINT rel_histvent_comp FOREIGN KEY(id_vendedor) REFERENCES vendedores(id) ON DELETE CASCADE
);

/*
-------------------------- USUARIOS --------------------------
*/
-- Contraseñas: 1234 (hasheadas y salteadas)
INSERT INTO usuarios(username,password,email,tipo) VALUES('Alaitz','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','alaitz.candela@ikasle.egibide.org','A');
INSERT INTO usuarios(username,password,email,tipo) VALUES('Raul','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','raul.melgosa@ikasle.egibide.org','A');
INSERT INTO usuarios(username,password,email,tipo) VALUES('Dani','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','daniel.tamargo@ikasle.egibide.org','A');
INSERT INTO usuarios(username,password,email,tipo) VALUES('bershka','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','bershka@gmail.com','V');
INSERT INTO usuarios(username,password,email,tipo) VALUES('Zara','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','zara@gmail.com','V');
INSERT INTO usuarios(username,password,email,tipo) VALUES('Game','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','game@gmail.com','V');
INSERT INTO usuarios(username,password,email,tipo) VALUES('Don limpio','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','donlimpio@gmail.com','V');
INSERT INTO usuarios(username,password,email,tipo) VALUES('Ikea','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','ikea@gmail.com','V');
INSERT INTO usuarios(username,password,email,tipo) VALUES('Eroski','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','eroski@gmail.com','V');
INSERT INTO usuarios(username,password,email,tipo) VALUES('La casa del libro','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','laCasaDelLibro@gmail.com','V');
INSERT INTO usuarios(username,password,email,tipo) VALUES('PC Componentes','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','PcCom@gmail.com','V');
INSERT INTO usuarios(username,password,email,tipo) VALUES('Wetaca','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','wetaca@ikasle.egibide.org','V');
INSERT INTO usuarios(username,password,email,tipo) VALUES('Primark','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','primark@gmail.com','V');


/*
-------------------------- VENDEDORES --------------------------
*/

INSERT INTO vendedores VALUES((SELECT id FROM usuarios WHERE(UPPER(username)='BERSHKA')),'Barcelona','923277146');
INSERT INTO vendedores VALUES((SELECT id FROM usuarios WHERE(UPPER(username)='ZARA')),'La Coruña','968455918');
INSERT INTO vendedores VALUES((SELECT id FROM usuarios WHERE(UPPER(username)='GAME')),'Texas','972713100');
INSERT INTO vendedores VALUES((SELECT id FROM usuarios WHERE(UPPER(username)='DON LIMPIO')),'Ohio','980081113');
INSERT INTO vendedores VALUES((SELECT id FROM usuarios WHERE(UPPER(username)='IKEA')),'Kronoberg','978827424');
INSERT INTO vendedores VALUES((SELECT id FROM usuarios WHERE(UPPER(username)='EROSKI')),'País Vasco','956042238');
INSERT INTO vendedores VALUES((SELECT id FROM usuarios WHERE(UPPER(username)='LA CASA DEL LIBRO')),'Albacete','988197660');
INSERT INTO vendedores VALUES((SELECT id FROM usuarios WHERE(UPPER(username)='PC COMPONENTES')),'Murcia','964563035');
INSERT INTO vendedores VALUES((SELECT id FROM usuarios WHERE(UPPER(username)='WETACA')),'Madrid','931904577');
INSERT INTO vendedores VALUES((SELECT id FROM usuarios WHERE(UPPER(username)='PRIMARK')),'Dublín','926778196');


/*
-------------------------- ANUNCIOS REALES --------------------------
*/

/*BERSHKA*/

INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'BERSHKA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Camiseta de rayas','camiseta de talla M con rayas azules',12.99);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'BERSHKA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Pantalones vaqueros negros','Pantalones de talla 38 negros y rotos',9.99);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'BERSHKA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Sudadera gris','Sudadera talla S grande y ancho',15.99);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'BERSHKA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Nike Air Jordan 1 Smoke Grey','Zapatillas Nike Air Jordan 1 color Smoke Grey talla 36',74.99);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'BERSHKA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Calcetines','Calcetines con estampado de gatitos empresarios de talla 38-42',9.99);

/*ZARA*/

INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'ZARA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Vestido rojo ','Vestido rojo con lentejuelas perfecto para salir de noche',20.95);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'ZARA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Abrigo lana oversize','Abrigo negro de talla 40',80);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'ZARA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Camisa blanca','Camisa estructura de color blanco,manga larga y de algodón',29.95);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'ZARA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Gorro cashmere','Gorro de cashmere negro ',40);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'ZARA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Camiseta UCLA','Camiseta de niño color blanco de la universidad de UCLA',10.95);

/*GAME*/

INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'GAME'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Teclado Asus Rog Claymore II','Teclado mecánico RGB antighosting switches cherry MX Blue',230);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'GAME'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Ratón Logitech G Pro','Ratón inalámbrico RGB 16000 DPI ergonómico y sensor HERO 16K',80.99);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'GAME'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Portatil MSI Katana','Ordenador portatil I7-11800H 16GB RAM 1TB SSD RTX 3060 Pantalla 15.6" 144Hz',1500);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'GAME'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Los Sims 4','Juego Los Sims 4 edición especial vida ecológica no contiene disco sino código de descarga',39.95);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'GAME'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Fifa 22','Juego EA Sports Fifa 22 simulador de futbol para PlayStation 5',60);

/*DON LIMPIO*/

INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'DON LIMPIO'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Fregasuelos olor lavanda','Fregasuelos con olor a lavanda para un acabado eficaz',3.99);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'DON LIMPIO'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Don Limpio baño','Producto de limpieza para baños que deja un brillo más duradero',2.65);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'DON LIMPIO'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Limpia Cristales','Limpia cristales de Don Limpio limpieza absoluta',3);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'DON LIMPIO'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Bayetas','5 bayetas reutilizables',4);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'DON LIMPIO'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Limpiador multiusos','Limpiador para cualquier zona de la casa',3.50);

/*IKEA*/

INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'IKEA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Estantería Kallax','Estantería modular de 42 x 147 cm, acabado en patrón de madera',39);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'IKEA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Armario Syvde','Armario de recibidor abierto de 80 x 123 cm acabado en color blanco',80);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'IKEA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Mueble TV Brimnes','Mueble de televisor con dos cajones de 120 x 41 x 53 cm acabado en blanco y gris',79);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'IKEA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Mueble de almacenaje Hemnes','Mueble de almacenaje de salón de 326 x 197 cm',647);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'IKEA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Escritorio Malm','Escritorio para el hogar de 140 x 65 cm',149);

/*EROSKI*/

INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'EROSKI'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Cuaderno Oxford','Cuaderno de espiral, tapa dura, 100 páginas A4',5.60);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'EROSKI'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Bolígrafo bic','Bolígrafo tinta azul punta de 1mm construido en cristal',0.40);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'EROSKI'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Bolígrafo pilot','Bolígrafo tinta de gel azul construido en plástico', 0.85);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'EROSKI'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Recambio de papel','Recambio de 200 hojas A4 de papel cuadriculado para archivadores',3.60);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'EROSKI'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Lapicero Staedtler','Lapicero de grafito negro dureza HB',0.20);

/*LA CASA DEL LIBRO*/

INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'LA CASA DEL LIBRO'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Los Juegos del Hambre','La nación de Panem obliga a cada uno de sus doce distritos a enviar a un chico y a una chica, adolescentes, para competir en Los juegos del hambre. En parte es un entretenimiento rebuscado y en parte es una táctica de intimidación por parte del gobierno. Los juegos del hambre es un evento televisado nacionalmente en el cual los "Tributos" tienen que luchar entre ellos hasta quedar solamente un superviviente. Enfrentada con los bien entrenados "Tributos" quienes llevan toda la vida preparándose para estos juegos, Katniss se ve obligada a recurrir a sus agudos instintos, así como a la tutoría de Haymitch Abernathy, antiguo campeón, y ahora estropeado y  borrachín. Si quiere volver a casa en el Distrito 12, Katniss tendrá que tomar unas decisiones imposibles en La Arena que sopesan la supervivencia frente a la humanidad y la vida frente al amor.',17);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'LA CASA DEL LIBRO'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Harry Potter y el cáliz de fuego','Tras otro abominable verano con los Dursley, Harry se dispone a iniciar el cuarto curso en Hogwarts, la famosa escuela de magia y hechicería. A sus catorce años, a Harry le gustaría ser un joven mago como los demás y dedicarse a aprender nuevos sortilegios, encontrarse con sus amigos Ron y Hermione y asistir con ellos a los Mundiales de quidditch. Sin embargo, al llegar al colegio le espera una gran sorpresa que lo obligará a enfrentarse a los desafíos más temibles de toda su vida. SI logra superarlos, habrá demostrado que ya no es un niño y que está preparado para vivir las nuevas y emocionantes experiencias que el futuro le depara.',15);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'LA CASA DEL LIBRO'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Harry Potter y el príncipe mestizo','Con dieciséis años cumplidos, Harry inicia el sexto curso en Hogwarts en medio de terribles acontecimientos que asolan Inglaterra. Elegido capitán del equipo de quidditch, los ensayos, los exámenes y las chicas ocupan todo su tiempo, pero la tranquilidad dura poco. A pesar de los férreos controles de seguridad que protegen la escuela, dos alumnos son brutalmente atacados. Dumbledore sabe que se acerca el momento, anunciado por la Profecía, en que Harry y Voldemort se enfrentarían a muerte: «El único con poder para vencer al Señor Tenebroso se acerca... Uno de los dos debe morir a manos del otro, pues ninguno de los dos podrá vivir mientras siga el otro con vida» El anciano director solicitará la ayuda de Harry y juntos emprenderán peligrosos viajes para intentar debilitar al enemigo, para lo cual el joven mago contará con un viejo libro de pociones perteneciente a un misterioso personaje, alguien que se hace llamar Príncipe Mestizo.',15);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'LA CASA DEL LIBRO'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Nacidos de la bruma: el imperio final','Durante mil años han caído las cenizas y nada florece. Durante mil años los skaa han sido esclavizados y viven sumidos en un miedo inevitable. Durante mil años el Lord Legislador reina con un poder absoluto gracias al terror, a sus poderes e inmortalidad. Le ayudan «obligadores» e «inquisidores», junto a la poderosa magia de la «alomancia». Pero los nobles a menudo han tenido trato sexual con jóvenes skaa y, aunque la ley lo prohíbe, algunos de sus bastardos han sobrevivido y heredado los poderes alománticos: son los «nacidos de la bruma» (mistborns). Ahora, Kelsier, el «superviviente», el único que ha logrado huir de los Pozos de Hathsin, ha encontrado a Vin, una pobre chica skaa con mucha suerte... Tal vez los dos, unidos a la rebelión que los skaa intentan desde hace mil años, logren cambiar el mundo y la atroz dominación del Lord Legislador.',20);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'LA CASA DEL LIBRO'), DATE_ADD(NOW(), INTERVAL 30 DAY),'El bestiario de Axlin','El mundo de Axlin está plagado de monstruos. Algunos atacan a los viajeros en los caminos, otros asedian las aldeas hasta que logran arrasarlas por completo y otros entran en las casas por las noches para llevarse a los niños mientras duermen. Axlin es la escriba de su aldea, la única que sabe leer y escribir. Y se ha propuesto investigar todo lo que pueda sobre los monstruos y plasmar sus descubrimientos en un libro que pueda servir de guía y protección a otras personas. Por eso decide partir con los buhoneros para reunir la sabiduría ancestral de las aldeas en su precaria lucha contra los monstruos. No obstante, a lo largo de su viaje descubrirá cosas que jamás habría imaginado cuando partió.',15);

/*PC COMPONENTES*/

INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'PC COMPONENTES'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Tempest M6 Rez 2.0 Gaming Speakers','Altavoces de tamaño medio intensidad de sonido de hasta 65db y respuesta de frecuencia de 100Hz',11.99);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'PC COMPONENTES'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Lenovo C24-25','Monitor de 23.8" con tasa de refresco de 75Hz',128.90);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'PC COMPONENTES'), DATE_ADD(NOW(), INTERVAL 30 DAY),'HyperX Alloy elite 2','Teclado mecánico Gaming RGB conector USB 2.0 cable de 1.8m',159.99);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'PC COMPONENTES'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Razer Viper mini','Ratón Gaming RGB 8500 DPI',50);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'PC COMPONENTES'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Logitech G432','Auriculares gaming compatibles con todas las plataformas con micrófono integrado',79.99);

/*WETACA*/

INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'WETACA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Pollo con salsa thai','Para la base de este plato sofreímos lentamente cebolla junto con ajo y setas. Incorporamos salsa de soja, jengibre y leche de coco, incorporamos un poco de cayena en polvo para darle alegría. Cocinamos las verduras al vapor. En este caso empleamos noodles de boniato que tienen una textura única',5.95);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'WETACA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Verdura salteada cin humus de piquillo y arroz imperial','Para este hummus tan particular trituramos garbanzos cocidos junto con piquillos , ajo confitado y zumo de lima. Hacemos un mix de verduras que cocinamos al vapor y aderezamos con un poco de aceite de sésamo. Para completar este equilibrado plato incorporamos arroz integral negro apenas aliñado.',6.05);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'WETACA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Arroz con leche','Cocinado al estilo tradicional asturiano, a fuego muy bajo, removiendo constantemente y añadiendo poco a poco la leche, como si fuera un risotto. Terminamos con mantequilla, azúcar de caña y un toque de canela.',2.45);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'WETACA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Solomillo con salsa de queso','Cocinamos el lomo a baja temperatura para que quede jugoso. A partir de una mezcla 6 quesos hacemos una salsa a la que le incorporamos caldo de verduras para hacerlo más ligero. Incorporamos un poco de estragón que encaja perfectamente con el cerdo y el queso.',5.95);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'WETACA'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Merluza con salsa vizcaína','Cocinamos la merluza a baja temperatura para asegurarnos que quede en su punto. Para la salsa sofreímos cebolla, ajo puerro y zanahorias. incorporamos tomate y pimiento choricero. Mojamos con vino blanco reducido y caldo de pescado. Incorporamos un poquito de cayena en polvo para que tenga un poco de "alegría".',6.60);

/*PRIMARK*/

INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'PRIMARK'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Pack 8 anillos plateados','8 anillos plateados con cuerpos celestes',4);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'PRIMARK'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Bolso Chicago Bulls','Bolso shopper de lona color marfil extragrande de los Chicago Bulls de la NBA',6);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'PRIMARK'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Cinta para la cabeza','Cinta para la cabeza negra de forro polar de Thinsulate',3);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'PRIMARK'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Collar doble','Collar de dos filas semiprecioso bañado en oro',10);
INSERT INTO anuncios(id_vendedor, fecha_caducidad, nombre, descripcion, precio) VALUES((SELECT vendedores.id FROM vendedores, usuarios WHERE vendedores.id = usuarios.id AND UPPER(usuarios.username) = 'PRIMARK'), DATE_ADD(NOW(), INTERVAL 30 DAY),'Pendientes de aro','Pendientes de aro mini pleateados triples con detalle de diamante',2);

/*
-------------------------- CATEGORÍAS --------------------------
*/

INSERT INTO categorias(nombre) VALUES('Informática');
INSERT INTO categorias(nombre) VALUES('Ropa');
INSERT INTO categorias(nombre) VALUES('Accesorios');
INSERT INTO categorias(nombre) VALUES('Comida');
INSERT INTO categorias(nombre) VALUES('Cocina');
INSERT INTO categorias(nombre) VALUES('Libros');
INSERT INTO categorias(nombre) VALUES('Droguería');
INSERT INTO categorias(nombre) VALUES('Material escolar');
INSERT INTO categorias(nombre) VALUES('Limpieza');
INSERT INTO categorias(nombre) VALUES('Hogar');
INSERT INTO categorias(nombre) VALUES('Gaming');
INSERT INTO categorias(nombre) VALUES('Otros');

/*
-------------------------- CATEGORÍAS-ANUNCIOS --------------------------
*/

INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(1,2);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(2,2);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(3,2);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(4,2);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(5,2);

INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(6,2);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(7,2);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(8,2);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(9,2);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(10,2);

INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(11,1);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(12,1);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(13,1);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(14,11);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(15,11);

INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(16,9);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(17,9);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(18,9);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(19,9);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(20,9);

INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(21,10);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(22,10);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(23,10);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(24,10);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(25,10);

INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(26,8);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(27,8);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(28,8);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(29,8);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(30,8);

INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(31,6);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(32,6);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(33,6);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(34,6);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(35,6);

INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(36,11);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(37,11);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(38,11);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(39,11);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(40,11);

INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(41,4);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(42,4);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(43,4);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(44,4);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(45,4);

INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(46,3);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(47,3);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(48,3);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(49,3);
INSERT INTO categoriasAnuncios (id_anuncio,id_categoria) VALUES(50,3);


/*
-------------------------- FOTOS ANUNCIOS --------------------------
*/
UPDATE anuncios SET foto = "4-camisetaRayas.png" WHERE id = 1;
UPDATE anuncios SET foto = "4-packCalcetines.png" WHERE id = 5;
UPDATE anuncios SET foto = "4-pantalonesVaquerosNegros.png" WHERE id = 2;
UPDATE anuncios SET foto = "4-smokeGrey.png" WHERE id = 4;
UPDATE anuncios SET foto = "4-sudaderaGris.png" WHERE id = 3;
UPDATE anuncios SET foto = "5-abrigoLanaOverzie.png" WHERE id = 7;
UPDATE anuncios SET foto = "5-camisaBlanca.png" WHERE id = 8;
UPDATE anuncios SET foto = "5-gorroCashmereNegro.png" WHERE id = 9;
UPDATE anuncios SET foto = "5-vestidoRojo.png" WHERE id = 6;
UPDATE anuncios SET foto = "5-camisetaUCLA.jpg" WHERE id = 10;

UPDATE anuncios SET foto = "6-tecladoAsus.png" WHERE id = 11;
UPDATE anuncios SET foto = "6-ratonPro.png" WHERE id = 12;
UPDATE anuncios SET foto = "6-portatil.png" WHERE id = 13;
UPDATE anuncios SET foto = "6-sims.jfif" WHERE id = 14;
UPDATE anuncios SET foto = "6-fifa.jpg" WHERE id = 15;
UPDATE anuncios SET foto = "7-fregasuelosLavanda.png" WHERE id = 16;
UPDATE anuncios SET foto = "7-bano.png" WHERE id = 17;
UPDATE anuncios SET foto = "7-limpiaCristales.png" WHERE id = 18;
UPDATE anuncios SET foto = "7-bayetas.png" WHERE id = 19;
UPDATE anuncios SET foto = "7-multiusos.png" WHERE id = 20;

UPDATE anuncios SET foto = "8-estanteria.png" WHERE id = 21;
UPDATE anuncios SET foto = "8-armario.png" WHERE id = 22;
UPDATE anuncios SET foto = "8-muebleBlanco.png" WHERE id = 23;
UPDATE anuncios SET foto = "8-muebleHemnes.png" WHERE id = 24;
UPDATE anuncios SET foto = "8-escritorio.png" WHERE id = 25;
UPDATE anuncios SET foto = "9-cuaderno.png" WHERE id = 26;
UPDATE anuncios SET foto = "9-boliBic.png" WHERE id = 27;
UPDATE anuncios SET foto = "9-boliPilot.png" WHERE id = 28;
UPDATE anuncios SET foto = "9-recambio.png" WHERE id = 29;
UPDATE anuncios SET foto = "9-lapiz.png" WHERE id = 30;

UPDATE anuncios SET foto = "10-ljdh.jpg" WHERE id = 31;
UPDATE anuncios SET foto = "10-hp4.jfif" WHERE id = 32;
UPDATE anuncios SET foto = "10-hp6.jpg" WHERE id = 33;
UPDATE anuncios SET foto = "10-nacidosDeLaBruma.jpg" WHERE id = 34;
UPDATE anuncios SET foto = "10-elBestiarioDeAxlin.jpg" WHERE id = 35;
UPDATE anuncios SET foto = "11-altavoz.png" WHERE id = 36;
UPDATE anuncios SET foto = "11-lenovo.png" WHERE id = 37;
UPDATE anuncios SET foto = "11-elite2.png" WHERE id = 38;
UPDATE anuncios SET foto = "11-ratonMini.png" WHERE id = 39;
UPDATE anuncios SET foto = "11-auriculares.png" WHERE id = 40;

UPDATE anuncios SET foto = "12-pollo.jfif" WHERE id = 41;
UPDATE anuncios SET foto = "12-verdura.jpg" WHERE id = 42;
UPDATE anuncios SET foto = "12-arrozConLeche.jpg" WHERE id = 43;
UPDATE anuncios SET foto = "12-solomillo.jpg" WHERE id = 44;
UPDATE anuncios SET foto = "12-merluza.jpg" WHERE id = 45;
UPDATE anuncios SET foto = "13-anillos.png" WHERE id = 46;
UPDATE anuncios SET foto = "13-bolso.png" WHERE id = 47;
UPDATE anuncios SET foto = "13-cinta.png" WHERE id = 48;
UPDATE anuncios SET foto = "13-collarDoble.png" WHERE id = 49;
UPDATE anuncios SET foto = "13-pendientes.png" WHERE id = 50;

/*
-------------------------- FOTOS USUARIOS --------------------------
*/
UPDATE usuarios SET foto = "3-dani.jpg" WHERE id = 3; -- Dani

/*
-------------------------- ANUNCIOS BULTO --------------------------
*/

/*ANUNCIOS PARA ESTADÍSTICAS (NO NECESITAN NI CATEGORÍA, SOLO ESTAR VINCULADOS*/
/*
-------------------------- VENTAS ANUNCIOS --------------------------
*/

-- Enero
INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-01-01'), TIMESTAMP('2021-01-08'),'Pantalones Hip Hop Top', 'Tasty Life Pantalones Hip Hop callejeros deportivos', 9.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-01-01'), TIMESTAMP('2021-01-08'),'Camiseta Hip Hop Hombre', 'Tasty Life Camiseta Hip Hop hombre callejera', 7.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-01-01'), TIMESTAMP('2021-01-08'),'Camiseta Hip Hop Mujer', 'Tasty Life Camiseta Hip Hop mujer callejera', 7.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-01-01'), TIMESTAMP('2021-01-08'),'Zapatillas Hip Hop', 'Tasty Life Zapatillas Hip Hop callejeras deportivas', 24.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-01-01'), TIMESTAMP('2021-01-08'),'Gorra Hip Hop', 'Tasty Life Gorra Hip Hop hombre callejera', 15.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-01-01'), TIMESTAMP('2021-01-08'),'Manga Compresora', 'Tasty Life Manga compresora (1 ud)', 3.25, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-01-01'), TIMESTAMP('2021-01-08'),'Manga Compresora Negro', 'Tasty Life Manga compresora color negro (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-01-01'), TIMESTAMP('2021-01-08'),'Manga Compresora Azul', 'Tasty Life Manga compresora color azul (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-01-01'), TIMESTAMP('2021-01-08'),'Manga Compresora Verde', 'Tasty Life Manga compresora color verde (1 ud)', 3.50, 0);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-01-01'), TIMESTAMP('2021-01-08'),'Manga Compresora Morado', 'Tasty Life Manga compresora color morado (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-01-01'), TIMESTAMP('2021-01-08'),'Manga Compresora Amarillo', 'Tasty Life Manga compresora color Amarillo (1 ud)', 3.50, 0);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-01-01'), TIMESTAMP('2021-01-08'),'Manga Compresora Cyan', 'Tasty Life Manga compresora color Cyan (1 ud)', 3.50, 0);

-- Febrero
INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-02-01'), TIMESTAMP('2021-02-08'),'Pantalones Hip Hop Top February Edition', 'Tasty Life Pantalones Hip Hop callejeros deportivos', 9.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-02-01'), TIMESTAMP('2021-02-08'),'Camiseta Hip Hop Hombre February Edition', 'Tasty Life Camiseta Hip Hop hombre callejera', 7.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-02-01'), TIMESTAMP('2021-02-08'),'Camiseta Hip Hop Mujer February Edition', 'Tasty Life Camiseta Hip Hop mujer callejera', 7.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-02-01'), TIMESTAMP('2021-02-08'),'Zapatillas Hip Hop February Edition', 'Tasty Life Zapatillas Hip Hop callejeras deportivas', 24.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-02-01'), TIMESTAMP('2021-02-08'),'Gorra Hip Hop February Edition', 'Tasty Life Gorra Hip Hop hombre callejera', 15.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-02-01'), TIMESTAMP('2021-02-08'),'Manga Compresora February Edition', 'Tasty Life Manga compresora (1 ud)', 3.25, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-02-01'), TIMESTAMP('2021-02-08'),'Manga Compresora Negro February Edition', 'Tasty Life Manga compresora color negro (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-02-01'), TIMESTAMP('2021-02-08'),'Manga Compresora Azul February Edition', 'Tasty Life Manga compresora color azul (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-02-01'), TIMESTAMP('2021-02-08'),'Manga Compresora Verde February Edition', 'Tasty Life Manga compresora color verde (1 ud)', 3.50, 0);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-02-01'), TIMESTAMP('2021-02-08'),'Manga Compresora Morado February Edition', 'Tasty Life Manga compresora color morado (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-02-01'), TIMESTAMP('2021-02-08'),'Manga Compresora Amarillo February Edition', 'Tasty Life Manga compresora color Amarillo (1 ud)', 3.50, 0);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-02-01'), TIMESTAMP('2021-02-08'),'Manga Compresora Cyan February Edition', 'Tasty Life Manga compresora color Cyan (1 ud)', 3.50, 0);

-- Marzo
INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-03-01'), TIMESTAMP('2021-03-08'),'Pantalones Hip Hop Top March Edition', 'Tasty Life Pantalones Hip Hop callejeros deportivos', 9.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-03-01'), TIMESTAMP('2021-03-08'),'Manga Compresora Negro March Edition', 'Tasty Life Manga compresora color negro (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-03-01'), TIMESTAMP('2021-03-08'),'Manga Compresora Azul March Edition', 'Tasty Life Manga compresora color azul (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-03-01'), TIMESTAMP('2021-03-08'),'Manga Compresora Verde March Edition', 'Tasty Life Manga compresora color verde (1 ud)', 3.50, 0);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-03-01'), TIMESTAMP('2021-03-08'),'Manga Compresora Amarillo March Edition', 'Tasty Life Manga compresora color Amarillo (1 ud)', 3.50, 0);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-03-01'), TIMESTAMP('2021-03-08'),'Manga Compresora Cyan March Edition', 'Tasty Life Manga compresora color Cyan (1 ud)', 3.50, 0);

-- Abril
INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-04-01'), TIMESTAMP('2021-04-08'),'Pantalones Hip Hop Top April Edition', 'Tasty Life Pantalones Hip Hop callejeros deportivos', 9.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-04-01'), TIMESTAMP('2021-04-08'),'Camiseta Hip Hop Hombre April Edition', 'Tasty Life Camiseta Hip Hop hombre callejera', 7.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-04-01'), TIMESTAMP('2021-04-08'),'Camiseta Hip Hop Mujer April Edition', 'Tasty Life Camiseta Hip Hop mujer callejera', 7.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-04-01'), TIMESTAMP('2021-04-08'),'Zapatillas Hip Hop April Edition', 'Tasty Life Zapatillas Hip Hop callejeras deportivas', 24.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-04-01'), TIMESTAMP('2021-04-08'),'Gorra Hip Hop April Edition', 'Tasty Life Gorra Hip Hop hombre callejera', 15.95, 1);


-- Mayo
INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-05-01'), TIMESTAMP('2021-05-08'),'Manga Compresora May Edition', 'Tasty Life Manga compresora (1 ud)', 3.25, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-05-01'), TIMESTAMP('2021-05-08'),'Manga Compresora Negro May Edition', 'Tasty Life Manga compresora color negro (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-05-01'), TIMESTAMP('2021-05-08'),'Manga Compresora Azul May Edition', 'Tasty Life Manga compresora color azul (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-05-01'), TIMESTAMP('2021-05-08'),'Manga Compresora Verde May Edition', 'Tasty Life Manga compresora color verde (1 ud)', 3.50, 0);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-05-01'), TIMESTAMP('2021-05-08'),'Manga Compresora Morado May Edition', 'Tasty Life Manga compresora color morado (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-05-01'), TIMESTAMP('2021-05-08'),'Manga Compresora Amarillo May Edition', 'Tasty Life Manga compresora color Amarillo (1 ud)', 3.50, 0);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-05-01'), TIMESTAMP('2021-05-08'),'Manga Compresora Cyan May Edition', 'Tasty Life Manga compresora color Cyan (1 ud)', 3.50, 0);

-- Junio
INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-06-01'), TIMESTAMP('2021-06-08'),'Manga Compresora Azul June Edition', 'Tasty Life Manga compresora color azul (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-06-01'), TIMESTAMP('2021-06-08'),'Manga Compresora Verde June Edition', 'Tasty Life Manga compresora color verde (1 ud)', 3.50, 0);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-06-01'), TIMESTAMP('2021-06-08'),'Manga Compresora Morado June Edition', 'Tasty Life Manga compresora color morado (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-06-01'), TIMESTAMP('2021-06-08'),'Manga Compresora Amarillo June Edition', 'Tasty Life Manga compresora color Amarillo (1 ud)', 3.50, 0);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-06-01'), TIMESTAMP('2021-06-08'),'Manga Compresora Cyan June Edition', 'Tasty Life Manga compresora color Cyan (1 ud)', 3.50, 0);

-- Julio
INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-07-01'), TIMESTAMP('2021-07-08'),'Pantalones Hip Hop Top July Edition', 'Tasty Life Pantalones Hip Hop callejeros deportivos', 9.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-07-01'), TIMESTAMP('2021-07-08'),'Camiseta Hip Hop Hombre July Edition', 'Tasty Life Camiseta Hip Hop hombre callejera', 7.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-07-01'), TIMESTAMP('2021-07-08'),'Camiseta Hip Hop Mujer July Edition', 'Tasty Life Camiseta Hip Hop mujer callejera', 7.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-07-01'), TIMESTAMP('2021-07-08'),'Zapatillas Hip Hop July Edition', 'Tasty Life Zapatillas Hip Hop callejeras deportivas', 24.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-07-01'), TIMESTAMP('2021-07-08'),'Gorra Hip Hop July Edition', 'Tasty Life Gorra Hip Hop hombre callejera', 15.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-07-01'), TIMESTAMP('2021-07-08'),'Manga Compresora July Edition', 'Tasty Life Manga compresora (1 ud)', 3.25, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-07-01'), TIMESTAMP('2021-07-08'),'Manga Compresora Negro July Edition', 'Tasty Life Manga compresora color negro (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-07-01'), TIMESTAMP('2021-07-08'),'Manga Compresora Azul July Edition', 'Tasty Life Manga compresora color azul (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-07-01'), TIMESTAMP('2021-07-08'),'Manga Compresora Verde July Edition', 'Tasty Life Manga compresora color verde (1 ud)', 3.50, 0);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-07-01'), TIMESTAMP('2021-07-08'),'Manga Compresora Morado July Edition', 'Tasty Life Manga compresora color morado (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-07-01'), TIMESTAMP('2021-07-08'),'Manga Compresora Amarillo July Edition', 'Tasty Life Manga compresora color Amarillo (1 ud)', 3.50, 0);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-07-01'), TIMESTAMP('2021-07-08'),'Manga Compresora Cyan July Edition', 'Tasty Life Manga compresora color Cyan (1 ud)', 3.50, 0);


-- Agosto
INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-08-01'), TIMESTAMP('2021-08-08'),'Pantalones Hip Hop Top August Edition', 'Tasty Life Pantalones Hip Hop callejeros deportivos', 9.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-08-01'), TIMESTAMP('2021-08-08'),'Camiseta Hip Hop Hombre August Edition', 'Tasty Life Camiseta Hip Hop hombre callejera', 7.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-08-01'), TIMESTAMP('2021-08-08'),'Camiseta Hip Hop Mujer August Edition', 'Tasty Life Camiseta Hip Hop mujer callejera', 7.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-08-01'), TIMESTAMP('2021-08-08'),'Zapatillas Hip Hop August Edition', 'Tasty Life Zapatillas Hip Hop callejeras deportivas', 24.50, 1);

-- Septiembre
INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-09-01'), TIMESTAMP('2021-09-08'),'Pantalones Hip Hop Top September Edition', 'Tasty Life Pantalones Hip Hop callejeros deportivos', 9.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-09-01'), TIMESTAMP('2021-09-08'),'Camiseta Hip Hop Hombre September Edition', 'Tasty Life Camiseta Hip Hop hombre callejera', 7.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-09-01'), TIMESTAMP('2021-09-08'),'Camiseta Hip Hop Mujer September Edition', 'Tasty Life Camiseta Hip Hop mujer callejera', 7.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-09-01'), TIMESTAMP('2021-09-08'),'Zapatillas Hip Hop September Edition', 'Tasty Life Zapatillas Hip Hop callejeras deportivas', 24.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-09-01'), TIMESTAMP('2021-09-08'),'Gorra Hip Hop September Edition', 'Tasty Life Gorra Hip Hop hombre callejera', 15.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-09-01'), TIMESTAMP('2021-09-08'),'Manga Compresora September Edition', 'Tasty Life Manga compresora (1 ud)', 3.25, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-09-01'), TIMESTAMP('2021-09-08'),'Manga Compresora Negro September Edition', 'Tasty Life Manga compresora color negro (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-09-01'), TIMESTAMP('2021-09-08'),'Manga Compresora Azul September Edition', 'Tasty Life Manga compresora color azul (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-09-01'), TIMESTAMP('2021-09-08'),'Manga Compresora Verde September Edition', 'Tasty Life Manga compresora color verde (1 ud)', 3.50, 0);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-09-01'), TIMESTAMP('2021-09-08'),'Manga Compresora Morado September Edition', 'Tasty Life Manga compresora color morado (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-09-01'), TIMESTAMP('2021-09-08'),'Manga Compresora Amarillo September Edition', 'Tasty Life Manga compresora color Amarillo (1 ud)', 3.50, 0);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-09-01'), TIMESTAMP('2021-09-08'),'Manga Compresora Cyan September Edition', 'Tasty Life Manga compresora color Cyan (1 ud)', 3.50, 0);

-- Octubre
INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-10-01'), TIMESTAMP('2021-10-08'),'Pantalones Hip Hop Top October Edition', 'Tasty Life Pantalones Hip Hop callejeros deportivos', 9.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-10-01'), TIMESTAMP('2021-10-08'),'Camiseta Hip Hop Hombre October Edition', 'Tasty Life Camiseta Hip Hop hombre callejera', 7.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-10-01'), TIMESTAMP('2021-10-08'),'Camiseta Hip Hop Mujer October Edition', 'Tasty Life Camiseta Hip Hop mujer callejera', 7.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-10-01'), TIMESTAMP('2021-10-08'),'Zapatillas Hip Hop October Edition', 'Tasty Life Zapatillas Hip Hop callejeras deportivas', 24.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-10-01'), TIMESTAMP('2021-10-08'),'Gorra Hip Hop October Edition', 'Tasty Life Gorra Hip Hop hombre callejera', 15.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-10-01'), TIMESTAMP('2021-10-08'),'Manga Compresora October Edition', 'Tasty Life Manga compresora (1 ud)', 3.25, 1);

-- Noviembre
INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-11-01'), TIMESTAMP('2021-11-08'),'Pantalones Hip Hop Top November Edition', 'Tasty Life Pantalones Hip Hop callejeros deportivos', 9.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-11-01'), TIMESTAMP('2021-11-08'),'Camiseta Hip Hop Hombre November Edition', 'Tasty Life Camiseta Hip Hop hombre callejera', 7.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-11-01'), TIMESTAMP('2021-11-08'),'Camiseta Hip Hop Mujer November Edition', 'Tasty Life Camiseta Hip Hop mujer callejera', 7.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-11-01'), TIMESTAMP('2021-11-08'),'Zapatillas Hip Hop November Edition', 'Tasty Life Zapatillas Hip Hop callejeras deportivas', 24.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-11-01'), TIMESTAMP('2021-11-08'),'Gorra Hip Hop November Edition', 'Tasty Life Gorra Hip Hop hombre callejera', 15.95, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-11-01'), TIMESTAMP('2021-11-08'),'Manga Compresora November Edition', 'Tasty Life Manga compresora (1 ud)', 3.25, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-11-01'), TIMESTAMP('2021-11-08'),'Manga Compresora Negro November Edition', 'Tasty Life Manga compresora color negro (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-11-01'), TIMESTAMP('2021-11-08'),'Manga Compresora Azul November Edition', 'Tasty Life Manga compresora color azul (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-11-01'), TIMESTAMP('2021-11-08'),'Manga Compresora Verde November Edition', 'Tasty Life Manga compresora color verde (1 ud)', 3.50, 0);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-11-01'), TIMESTAMP('2021-11-08'),'Manga Compresora Morado November Edition', 'Tasty Life Manga compresora color morado (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-11-01'), TIMESTAMP('2021-11-08'),'Manga Compresora Amarillo November Edition', 'Tasty Life Manga compresora color Amarillo (1 ud)', 3.50, 0);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-11-01'), TIMESTAMP('2021-11-08'),'Manga Compresora Red Bull November Edition', 'Tasty Life Manga compresora edición especial Red Bull (1 ud)', 3.50, 0);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-11-01'), TIMESTAMP('2021-11-08'),'Manga Compresora Palace November Edition', 'Tasty Life Manga compresora palace edition (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-11-01'), TIMESTAMP('2021-12-09'),'Manga Compresora Blanco November Edition', 'Tasty Life Manga compresora color Blanco (1 ud)', 3.50, 1);

INSERT INTO anuncios(id_vendedor, fecha_publicacion, fecha_caducidad, nombre, descripcion, precio, vendido) 
VALUES(4, TIMESTAMP('2021-11-01'), TIMESTAMP('2021-12-03'),'Manga Compresora Cyan November Edition', 'Tasty Life Manga compresora color Cyan (1 ud)', 3.50, 1);

/* foto genérica para estos anuncios de bulto */
UPDATE anuncios SET foto = "generic_img.png" WHERE id > 50;

/* vincular las ventas a unos pocos clientes */
INSERT INTO usuarios(username, password, email, tipo, foto, descripcion) VALUES ('compulsivo', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'compradorcompulsivo@gmail.com', 'C', 'compradorcompulsivo.jpg', 'ME ENCANTA COMPRAR, ES MI PASIÓN, QUIERO COMPRAR MÁS, MÁS, MÁÁÁÁÁÁÁS!! SI ME ESTÁS LEYENDO POR FAVOR PUBLICA ALGO, ¡¡¡¡YO TE LO COMPRO!!!!');
INSERT INTO historialCompras(id_anuncio, id_vendedor, id_comprador) VALUES 
(51, 4, 14), (52, 4, 14), (53, 4, 14), (54, 4, 14), (55, 4, 14), (56, 4, 14),
(57, 4, 14), (58, 4, 14), (60, 4, 14), (61, 4, 14), (62, 4, 14),
(63, 4, 14), (64, 4, 14), (65, 4, 14), (66, 4, 14), (67, 4, 14), 
(77, 4, 14), (81, 4, 14), (82, 4, 14), (83, 4, 14), (84, 4, 14), (85, 4, 14), 
(86, 4, 14), (87, 4, 14), (88, 4, 14), (90, 4, 14), (93, 4, 14), (95, 4, 14), 
(98, 4, 14), (99, 4, 14), (100, 4, 14), (101, 4, 14), (102, 4, 14), (103, 4, 14), 
(104, 4, 14), (105, 4, 14), (107, 4, 14), (110, 4, 14), (111, 4, 14), (112, 4, 14), 
(113, 4, 14), (114, 4, 14), (115, 4, 14), (116, 4, 14), (117, 4, 14), (118, 4, 14), 
(119, 4, 14), (120, 4, 14), (121, 4, 14), (123, 4, 14), (126, 4, 14), (127, 4, 14), 
(128, 4, 14), (129, 4, 14), (130, 4, 14), (131, 4, 14), (132, 4, 14), (134, 4, 14), 
(135, 4, 14), (136, 4, 14), (137, 4, 14), (138, 4, 14), (139, 4, 14), (141, 4, 14), 
(144, 4, 14), (145, 4, 14), (146, 4, 14);


/* USUARIOS CLIENTES EXTRA PARA PAGINACIÓN (no tendrán compras) */
/* Contraseñas: 1234 */
INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('xbraun', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'xbraun@wiegand.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('sabryna', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'sabryna.block@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('alyce29', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'alyce29@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('amir', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'amir.upton@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('okon', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'okon.hattie@gmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('bergstrom', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'bergstrom.zelma@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('ibernier', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'ibernier@parker.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('domingo08', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'domingo08@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('dashawn', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'dashawn.christiansen@gmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('orn', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'orn.sid@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('smueller', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'smueller@gmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('goldner', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'goldner.meagan@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('myrtie', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'myrtie.ledner@cremin.biz', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('carleton', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'carleton.lubowitz@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('vonrueden', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'vonrueden.granville@oconner.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('dleuschke', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'dleuschke@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('leslie97', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'leslie97@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('vdamore', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'vdamore@conroy.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('hermann63', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'hermann63@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('zwiegand', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'zwiegand@gmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('jconnelly', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'jconnelly@kihn.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('olangworth', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'olangworth@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('josue22', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'josue22@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('santa', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'santa.marvin@bergnaum.biz', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('qpadberg', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'qpadberg@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('rjohnson', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'rjohnson@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('janessa86', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'janessa86@gmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('ettie18', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'ettie18@kemmer.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('ebogisich', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'ebogisich@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('ahauck', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'ahauck@bernier.info', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('javon', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'javon.collier@beer.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('nikita', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'nikita.ritchie@bosco.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('wilfredo72', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'wilfredo72@fay.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('ykihn', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'ykihn@gmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('fgerhold', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'fgerhold@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('hegmann', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'hegmann.trevion@gmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('bridie28', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'bridie28@cummerata.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('eschmidt', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'eschmidt@jakubowski.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('yblick', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'yblick@kuphal.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('lesly', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'lesly.fritsch@schaefer.org', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('karina', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'karina.gislason@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('pkub', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'pkub@pagac.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('elfrieda', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'elfrieda.ullrich@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('darius24', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'darius24@harber.info', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('kankunding', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'kankunding@weissnat.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('rfunk', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'rfunk@gmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('stone', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'stone.schmitt@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('providenci64', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'providenci64@hane.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('myra05', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'myra05@lindgren.biz', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('rutherford', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'rutherford.alexa@beier.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('morgan88', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'morgan88@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('gerald53', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'gerald53@okeefe.org', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('fritz94', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'fritz94@gmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('bessie', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'bessie.kuhlman@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('rogahn', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'rogahn.kiel@waelchi.net', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('tbechtelar', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'tbechtelar@gmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('jones', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'jones.dayana@dach.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('kcrooks', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'kcrooks@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('danial', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'danial.mcdermott@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('prosacco', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'prosacco.jennings@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('jadon60', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'jadon60@douglas.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('joanne', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'joanne.crist@gmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('windler', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'windler.athena@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('monique', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'monique.lind@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('padberg', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'padberg.colin@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('daphney81', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'daphney81@brekke.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('sofia', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'sofia.hessel@bartell.biz', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('edmund80', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'edmund80@padberg.biz', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('xcollins', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'xcollins@gmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('runolfsson', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'runolfsson.elroy@sawayn.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('denesik', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'denesik.saul@herman.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('fsawayn', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'fsawayn@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('eduardo', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'eduardo.hills@king.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('ressie', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'ressie.kling@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('nolan', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'nolan.collier@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('misty', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'misty.mayert@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('kenya', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'kenya.cummings@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('alf', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'alf.christiansen@mitchell.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('prudence51', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'prudence51@jaskolski.info', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('nadia', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'nadia.purdy@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('annalise70', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'annalise70@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('white', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'white.estrella@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('macejkovic', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'macejkovic.jasmin@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('larkin', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'larkin.patrick@gmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('hollis70', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'hollis70@labadie.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('aliyah46', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'aliyah46@fay.biz', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('osatterfield', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'osatterfield@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('grant', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'grant.kutch@kuhic.org', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('icie12', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'icie12@gmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('cecile73', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'cecile73@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('juwan56', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'juwan56@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('ebuckridge', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'ebuckridge@mclaughlin.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('swaniawski', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'swaniawski.miracle@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('terry', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'terry.jensen@kassulke.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('krippin', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'krippin@beatty.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('agoodwin', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'agoodwin@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('jairo', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'jairo.huels@gmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('delpha', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'delpha.olson@marvin.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('keeling', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'keeling.jeanne@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('pouros', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'pouros.keven@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('effertz', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'effertz.martine@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('loren', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'loren.medhurst@koelpin.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('tillman', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'tillman.emmalee@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('marietta05', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'marietta05@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('edwina', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'edwina.lebsack@toy.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('hlemke', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'hlemke@gleichner.org', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('weber', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'weber.evie@bernhard.net', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('wilber19', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'wilber19@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('qmurphy', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'qmurphy@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('myrtice56', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'myrtice56@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('haley', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'haley.joan@hotmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('yundt', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'yundt.winona@runte.org', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('jerry', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'jerry.blanda@gusikowski.biz', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('cschiller', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'cschiller@yahoo.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('lon20', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'lon20@considine.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('una80', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'una80@gmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('edmond', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'edmond.parker@tromp.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('farrell', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'farrell.mozell@gulgowski.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('bart', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'bart.torphy@gmail.com', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

INSERT INTO usuarios(username, password, email, tipo, descripcion) 
VALUES('sparisian', '$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m', 'sparisian@hirthe.net', 'C', 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis vehicula ante. Donec dignissim sem non feugiat imperdiet. Mauris eget.');

