-- MySQL dump 10.13  Distrib 5.7.36, for Linux (x86_64)
--
-- Host: localhost    Database: TN
-- ------------------------------------------------------
-- Server version	5.7.36-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `anuncios`
--

DROP TABLE IF EXISTS `anuncios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `anuncios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_publicacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_caducidad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(2000) NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `precio` double NOT NULL,
  `vendido` tinyint(1) DEFAULT '0',
  `id_vendedor` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `anu_ven_fk` (`id_vendedor`),
  CONSTRAINT `anu_ven_fk` FOREIGN KEY (`id_vendedor`) REFERENCES `vendedores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anuncios`
--

LOCK TABLES `anuncios` WRITE;
/*!40000 ALTER TABLE `anuncios` DISABLE KEYS */;
INSERT INTO `anuncios` VALUES (1,'2021-11-16 08:54:24','2021-12-16 08:54:24','Camiseta de rayas','camiseta de talla M con rayas azules',NULL,12.99,0,4),(2,'2021-11-16 08:54:24','2021-12-16 08:54:24','Pantalones vaqueros negros','Pantalones de talla 38 negros y rotos',NULL,9.99,0,4),(3,'2021-11-16 08:54:24','2021-12-16 08:54:24','Sudadera gris','Sudadera talla S grande y ancho',NULL,15.99,0,4),(4,'2021-11-16 08:54:24','2021-12-16 08:54:24','Nike Air Jordan 1 Smoke Grey','Zapatillas Nike Air Jordan 1 color Smoke Grey talla 36',NULL,74.99,0,4),(5,'2021-11-16 08:54:24','2021-12-16 08:54:24','Calcetines','Calcetines con estampado de gatitos empresarios de talla 38-42',NULL,9.99,0,4),(6,'2021-11-16 08:54:24','2021-12-16 08:54:24','Vestido rojo ','Vestido rojo con lentejuelas perfecto para salir de noche',NULL,20.95,0,5),(7,'2021-11-16 08:54:24','2021-12-16 08:54:24','Abrigo lana oversize','Abrigo negro de talla 40',NULL,80,0,5),(8,'2021-11-16 08:54:24','2021-12-16 08:54:24','Camisa blanca','Camisa estructura de color blanco,manga larga y de algodón',NULL,29.95,0,5),(9,'2021-11-16 08:54:24','2021-12-16 08:54:24','Gorro cashmere','Gorro de cashmere negro ',NULL,40,0,5),(10,'2021-11-16 08:54:24','2021-12-16 08:54:24','Camiseta UCLA','Camiseta de niño color blanco de la universidad de UCLA',NULL,10.95,0,5),(11,'2021-11-16 08:54:24','2021-12-16 08:54:24','Teclado Asus Rog Claymore II','Teclado mecánico RGB antighosting switches cherry MX Blue',NULL,230,0,6),(12,'2021-11-16 08:54:24','2021-12-16 08:54:24','Ratón Logitech G Pro','Ratón inalámbrico RGB 16000 DPI ergonómico y sensor HERO 16K',NULL,80.99,0,6),(13,'2021-11-16 08:54:24','2021-12-16 08:54:24','Portatil MSI Katana','Ordenador portatil I7-11800H 16GB RAM 1TB SSD RTX 3060 Pantalla 15.6\" 144Hz',NULL,1500,0,6),(14,'2021-11-16 08:54:24','2021-12-16 08:54:24','Los Sims 4','Juego Los Sims 4 edición especial vida ecológica no contiene disco sino código de descarga',NULL,39.95,0,6),(15,'2021-11-16 08:54:24','2021-12-16 08:54:24','Fifa 22','Juego EA Sports Fifa 22 simulador de futbol para PlayStation 5',NULL,60,0,6),(16,'2021-11-16 08:54:24','2021-12-16 08:54:24','Fregasuelos olor lavanda','Fregasuelos con olor a lavanda para un acabado eficaz',NULL,3.99,0,7),(17,'2021-11-16 08:54:24','2021-12-16 08:54:24','Don Limpio baño','Producto de limpieza para baños que deja un brillo más duradero',NULL,2.65,0,7),(18,'2021-11-16 08:54:24','2021-12-16 08:54:24','Limpia Cristales','Limpia cristales de Don Limpio limpieza absoluta',NULL,3,0,7),(19,'2021-11-16 08:54:24','2021-12-16 08:54:24','Bayetas','5 bayetas reutilizables',NULL,4,0,7),(20,'2021-11-16 08:54:24','2021-12-16 08:54:24','Limpiador multiusos','Limpiador para cualquier zona de la casa',NULL,3.5,0,7),(21,'2021-11-16 08:54:24','2021-12-16 08:54:24','Estantería Kallax','Estantería modular de 42 x 147 cm, acabado en patrón de madera',NULL,39,0,8),(22,'2021-11-16 08:54:24','2021-12-16 08:54:24','Armario Syvde','Armario de recibidor abierto de 80 x 123 cm acabado en color blanco',NULL,80,0,8),(23,'2021-11-16 08:54:24','2021-12-16 08:54:24','Mueble TV Brimnes','Mueble de televisor con dos cajones de 120 x 41 x 53 cm acabado en blanco y gris',NULL,79,0,8),(24,'2021-11-16 08:54:24','2021-12-16 08:54:24','Mueble de almacenaje Hemnes','Mueble de almacenaje de salón de 326 x 197 cm',NULL,647,0,8),(25,'2021-11-16 08:54:24','2021-12-16 08:54:24','Escritorio Malm','Escritorio para el hogar de 140 x 65 cm',NULL,149,0,8),(26,'2021-11-16 08:54:24','2021-12-16 08:54:24','Cuaderno Oxford','Cuaderno de espiral, tapa dura, 100 páginas A4',NULL,5.6,0,9),(27,'2021-11-16 08:54:24','2021-12-16 08:54:24','Bolígrafo bic','Bolígrafo tinta azul punta de 1mm construido en cristal',NULL,0.4,0,9),(28,'2021-11-16 08:54:24','2021-12-16 08:54:24','Bolígrafo pilot','Bolígrafo tinta de gel azul construido en plástico',NULL,0.85,0,9),(29,'2021-11-16 08:54:24','2021-12-16 08:54:24','Recambio de papel','Recambio de 200 hojas A4 de papel cuadriculado para archivadores',NULL,3.6,0,9),(30,'2021-11-16 08:54:24','2021-12-16 08:54:24','Lapicero Staedtler','Lapicero de grafito negro dureza HB',NULL,0.2,0,9),(31,'2021-11-16 08:54:24','2021-12-16 08:54:24','Los Juegos del Hambre','La nación de Panem obliga a cada uno de sus doce distritos a enviar a un chico y a una chica, adolescentes, para competir en Los juegos del hambre. En parte es un entretenimiento rebuscado y en parte es una táctica de intimidación por parte del gobierno. Los juegos del hambre es un evento televisado nacionalmente en el cual los \"Tributos\" tienen que luchar entre ellos hasta quedar solamente un superviviente. Enfrentada con los bien entrenados \"Tributos\" quienes llevan toda la vida preparándose para estos juegos, Katniss se ve obligada a recurrir a sus agudos instintos, así como a la tutoría de Haymitch Abernathy, antiguo campeón, y ahora estropeado y  borrachín. Si quiere volver a casa en el Distrito 12, Katniss tendrá que tomar unas decisiones imposibles en La Arena que sopesan la supervivencia frente a la humanidad y la vida frente al amor.',NULL,17,0,10),(32,'2021-11-16 08:54:24','2021-12-16 08:54:24','Harry Potter y el cáliz de fuego','Tras otro abominable verano con los Dursley, Harry se dispone a iniciar el cuarto curso en Hogwarts, la famosa escuela de magia y hechicería. A sus catorce años, a Harry le gustaría ser un joven mago como los demás y dedicarse a aprender nuevos sortilegios, encontrarse con sus amigos Ron y Hermione y asistir con ellos a los Mundiales de quidditch. Sin embargo, al llegar al colegio le espera una gran sorpresa que lo obligará a enfrentarse a los desafíos más temibles de toda su vida. SI logra superarlos, habrá demostrado que ya no es un niño y que está preparado para vivir las nuevas y emocionantes experiencias que el futuro le depara.',NULL,15,0,10),(33,'2021-11-16 08:54:24','2021-12-16 08:54:24','Harry Potter y el príncipe mestizo','Con dieciséis años cumplidos, Harry inicia el sexto curso en Hogwarts en medio de terribles acontecimientos que asolan Inglaterra. Elegido capitán del equipo de quidditch, los ensayos, los exámenes y las chicas ocupan todo su tiempo, pero la tranquilidad dura poco. A pesar de los férreos controles de seguridad que protegen la escuela, dos alumnos son brutalmente atacados. Dumbledore sabe que se acerca el momento, anunciado por la Profecía, en que Harry y Voldemort se enfrentarían a muerte: «El único con poder para vencer al Señor Tenebroso se acerca... Uno de los dos debe morir a manos del otro, pues ninguno de los dos podrá vivir mientras siga el otro con vida» El anciano director solicitará la ayuda de Harry y juntos emprenderán peligrosos viajes para intentar debilitar al enemigo, para lo cual el joven mago contará con un viejo libro de pociones perteneciente a un misterioso personaje, alguien que se hace llamar Príncipe Mestizo.',NULL,15,0,10),(34,'2021-11-16 08:54:24','2021-12-16 08:54:24','Nacidos de la bruma: el imperio final','Durante mil años han caído las cenizas y nada florece. Durante mil años los skaa han sido esclavizados y viven sumidos en un miedo inevitable. Durante mil años el Lord Legislador reina con un poder absoluto gracias al terror, a sus poderes e inmortalidad. Le ayudan «obligadores» e «inquisidores», junto a la poderosa magia de la «alomancia». Pero los nobles a menudo han tenido trato sexual con jóvenes skaa y, aunque la ley lo prohíbe, algunos de sus bastardos han sobrevivido y heredado los poderes alománticos: son los «nacidos de la bruma» (mistborns). Ahora, Kelsier, el «superviviente», el único que ha logrado huir de los Pozos de Hathsin, ha encontrado a Vin, una pobre chica skaa con mucha suerte... Tal vez los dos, unidos a la rebelión que los skaa intentan desde hace mil años, logren cambiar el mundo y la atroz dominación del Lord Legislador.',NULL,20,0,10),(35,'2021-11-16 08:54:24','2021-12-16 08:54:24','El bestiario de Axlin','El mundo de Axlin está plagado de monstruos. Algunos atacan a los viajeros en los caminos, otros asedian las aldeas hasta que logran arrasarlas por completo y otros entran en las casas por las noches para llevarse a los niños mientras duermen. Axlin es la escriba de su aldea, la única que sabe leer y escribir. Y se ha propuesto investigar todo lo que pueda sobre los monstruos y plasmar sus descubrimientos en un libro que pueda servir de guía y protección a otras personas. Por eso decide partir con los buhoneros para reunir la sabiduría ancestral de las aldeas en su precaria lucha contra los monstruos. No obstante, a lo largo de su viaje descubrirá cosas que jamás habría imaginado cuando partió.',NULL,15,0,10),(36,'2021-11-16 08:54:24','2021-12-16 08:54:24','Tempest M6 Rez 2.0 Gaming Speakers','Altavoces de tamaño medio intensidad de sonido de hasta 65db y respuesta de frecuencia de 100Hz',NULL,11.99,0,11),(37,'2021-11-16 08:54:24','2021-12-16 08:54:24','Lenovo C24-25','Monitor de 23.8\" con tasa de refresco de 75Hz',NULL,128.9,0,11),(38,'2021-11-16 08:54:24','2021-12-16 08:54:24','HyperX Alloy elite 2','Teclado mecánico Gaming RGB conector USB 2.0 cable de 1.8m',NULL,159.99,0,11),(39,'2021-11-16 08:54:24','2021-12-16 08:54:24','Razer Viper mini','Ratón Gaming RGB 8500 DPI',NULL,50,0,11),(40,'2021-11-16 08:54:24','2021-12-16 08:54:24','Logitech G432','Auriculares gaming compatibles con todas las plataformas con micrófono integrado',NULL,79.99,0,11),(41,'2021-11-16 08:54:24','2021-12-16 08:54:24','Pollo con salsa thai','Para la base de este plato sofreímos lentamente cebolla junto con ajo y setas. Incorporamos salsa de soja, jengibre y leche de coco, incorporamos un poco de cayena en polvo para darle alegría. Cocinamos las verduras al vapor. En este caso empleamos noodles de boniato que tienen una textura única',NULL,5.95,0,12),(42,'2021-11-16 08:54:24','2021-12-16 08:54:24','Verdura salteada cin humus de piquillo y arroz imperial','Para este hummus tan particular trituramos garbanzos cocidos junto con piquillos , ajo confitado y zumo de lima. Hacemos un mix de verduras que cocinamos al vapor y aderezamos con un poco de aceite de sésamo. Para completar este equilibrado plato incorporamos arroz integral negro apenas aliñado.',NULL,6.05,0,12),(43,'2021-11-16 08:54:24','2021-12-16 08:54:24','Arroz con leche','Cocinado al estilo tradicional asturiano, a fuego muy bajo, removiendo constantemente y añadiendo poco a poco la leche, como si fuera un risotto. Terminamos con mantequilla, azúcar de caña y un toque de canela.',NULL,2.45,0,12),(44,'2021-11-16 08:54:24','2021-12-16 08:54:24','Solomillo con salsa de queso','Cocinamos el lomo a baja temperatura para que quede jugoso. A partir de una mezcla 6 quesos hacemos una salsa a la que le incorporamos caldo de verduras para hacerlo más ligero. Incorporamos un poco de estragón que encaja perfectamente con el cerdo y el queso.',NULL,5.95,0,12),(45,'2021-11-16 08:54:24','2021-12-16 08:54:24','Merluza con salsa vizcaína','Cocinamos la merluza a baja temperatura para asegurarnos que quede en su punto. Para la salsa sofreímos cebolla, ajo puerro y zanahorias. incorporamos tomate y pimiento choricero. Mojamos con vino blanco reducido y caldo de pescado. Incorporamos un poquito de cayena en polvo para que tenga un poco de \"alegría\".',NULL,6.6,0,12),(46,'2021-11-16 08:54:24','2021-12-16 08:54:24','Pack 8 anillos plateados','8 anillos plateados con cuerpos celestes',NULL,4,0,13),(47,'2021-11-16 08:54:24','2021-12-16 08:54:24','Bolso Chicago Bulls','Bolso shopper de lona color marfil extragrande de los Chicago Bulls de la NBA',NULL,6,0,13),(48,'2021-11-16 08:54:24','2021-12-16 08:54:24','Cinta para la cabeza','Cinta para la cabeza negra de forro polar de Thinsulate',NULL,3,0,13),(49,'2021-11-16 08:54:24','2021-12-16 08:54:24','Collar doble','Collar de dos filas semiprecioso bañado en oro',NULL,10,0,13),(50,'2021-11-16 08:54:24','2021-12-16 08:54:24','Pendientes de aro','Pendientes de aro mini pleateados triples con detalle de diamante',NULL,2,0,13);
/*!40000 ALTER TABLE `anuncios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (3,'Accesorios'),(5,'Cocina'),(4,'Comida'),(7,'Droguería'),(11,'Gaming'),(10,'Hogar'),(1,'Informática'),(6,'Libros'),(9,'Limpieza'),(8,'Material escolar'),(2,'Ropa');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoriasAnuncios`
--

DROP TABLE IF EXISTS `categoriasAnuncios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoriasAnuncios` (
  `id_anuncio` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  PRIMARY KEY (`id_categoria`,`id_anuncio`),
  KEY `rel_anu_cat` (`id_anuncio`),
  CONSTRAINT `rel_anu_cat` FOREIGN KEY (`id_anuncio`) REFERENCES `anuncios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rel_cat_anu` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoriasAnuncios`
--

LOCK TABLES `categoriasAnuncios` WRITE;
/*!40000 ALTER TABLE `categoriasAnuncios` DISABLE KEYS */;
INSERT INTO `categoriasAnuncios` VALUES (1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(8,2),(9,2),(10,2),(11,1),(12,1),(13,1),(14,11),(15,11),(16,9),(17,9),(18,9),(19,9),(20,9),(21,10),(22,10),(23,10),(24,10),(25,10),(26,8),(27,8),(28,8),(29,8),(30,8),(31,6),(32,6),(33,6),(34,6),(35,6),(36,11),(37,11),(38,11),(39,11),(40,11),(41,4),(42,4),(43,4),(44,4),(45,4),(46,3),(47,3),(48,3),(49,3),(50,3);
/*!40000 ALTER TABLE `categoriasAnuncios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historialCompras`
--

DROP TABLE IF EXISTS `historialCompras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historialCompras` (
  `id_anuncio` int(11) NOT NULL,
  `id_comprador` int(11) NOT NULL,
  `fecha_compra` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_anuncio`,`id_comprador`),
  KEY `rel_histcomp_comp` (`id_comprador`),
  CONSTRAINT `rel_histcomp_anu` FOREIGN KEY (`id_anuncio`) REFERENCES `anuncios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rel_histcomp_comp` FOREIGN KEY (`id_comprador`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historialCompras`
--

LOCK TABLES `historialCompras` WRITE;
/*!40000 ALTER TABLE `historialCompras` DISABLE KEYS */;
/*!40000 ALTER TABLE `historialCompras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historialVentas`
--

DROP TABLE IF EXISTS `historialVentas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historialVentas` (
  `id_anuncio` int(11) NOT NULL,
  `id_vendedor` int(11) NOT NULL,
  `fecha_venta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_anuncio`,`id_vendedor`),
  KEY `rel_histvent_comp` (`id_vendedor`),
  CONSTRAINT `rel_histvent_anu` FOREIGN KEY (`id_anuncio`) REFERENCES `anuncios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rel_histvent_comp` FOREIGN KEY (`id_vendedor`) REFERENCES `vendedores` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historialVentas`
--

LOCK TABLES `historialVentas` WRITE;
/*!40000 ALTER TABLE `historialVentas` DISABLE KEYS */;
/*!40000 ALTER TABLE `historialVentas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pruebaimg`
--

DROP TABLE IF EXISTS `pruebaimg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pruebaimg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img` longblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pruebaimg`
--

LOCK TABLES `pruebaimg` WRITE;
/*!40000 ALTER TABLE `pruebaimg` DISABLE KEYS */;
/*!40000 ALTER TABLE `pruebaimg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(500) NOT NULL,
  `email` varchar(50) NOT NULL,
  `tipo` char(1) NOT NULL,
  `foto` longblob,
  `descripcion` varchar(200) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `habilitado` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `usu_name_unique` (`username`),
  UNIQUE KEY `usu_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Alaitz','1234','alaitz.candela@ikasle.egibide.org','A',NULL,NULL,'2021-11-16 08:54:23',0),(2,'Raul','1234','raul.melgosa@ikasle.egibide.org','A',NULL,NULL,'2021-11-16 08:54:23',0),(3,'Dani','1234','daniel.tamargo@ikasle.egibide.org','A',NULL,NULL,'2021-11-16 08:54:23',0),(4,'bershka','3drvEKk9','bershka@gmail.com','V',NULL,NULL,'2021-11-16 08:54:23',0),(5,'Zara','gkQqjOtq','zara@gmail.com','V',NULL,NULL,'2021-11-16 08:54:23',0),(6,'Game','tLicxim1','game@gmail.com','V',NULL,NULL,'2021-11-16 08:54:23',0),(7,'Don limpio','cFn7qOdU','donlimpio@gmail.com','V',NULL,NULL,'2021-11-16 08:54:23',0),(8,'Ikea','WI1fNLi4','ikea@gmail.com','V',NULL,NULL,'2021-11-16 08:54:24',0),(9,'Eroski','dnsC9NCy','eroski@gmail.com','V',NULL,NULL,'2021-11-16 08:54:24',0),(10,'La casa del libro','gQFULBT9','laCasaDelLibro@gmail.com','V',NULL,NULL,'2021-11-16 08:54:24',0),(11,'PC Componentes','XWwgQvBM','PcCom@gmail.com','V',NULL,NULL,'2021-11-16 08:54:24',0),(12,'Wetaca','rBrEyaw3','wetaca@ikasle.egibide.org','V',NULL,NULL,'2021-11-16 08:54:24',0),(13,'Primark','sv6hVsGs','primark@gmail.com','V',NULL,NULL,'2021-11-16 08:54:24',0);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendedores`
--

DROP TABLE IF EXISTS `vendedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendedores` (
  `id` int(11) NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `telefono` int(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `telefono` (`telefono`),
  CONSTRAINT `ven_usu_id_fk` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendedores`
--

LOCK TABLES `vendedores` WRITE;
/*!40000 ALTER TABLE `vendedores` DISABLE KEYS */;
INSERT INTO `vendedores` VALUES (4,'Barcelona',923277146),(5,'La Coruña',968455918),(6,'Texas',972713100),(7,'Ohio',980081113),(8,'Kronoberg',978827424),(9,'País Vasco',956042238),(10,'Albacete',988197660),(11,'Murcia',964563035),(12,'Madrid',931904577),(13,'Dublín',926778196);
/*!40000 ALTER TABLE `vendedores` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-16  8:58:34
