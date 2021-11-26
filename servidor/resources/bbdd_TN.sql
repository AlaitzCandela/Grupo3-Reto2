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
  `num_visitas` int(11) DEFAULT '0',
  `id_vendedor` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `anu_ven_fk` (`id_vendedor`),
  CONSTRAINT `anu_ven_fk` FOREIGN KEY (`id_vendedor`) REFERENCES `vendedores` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anuncios`
--

LOCK TABLES `anuncios` WRITE;
/*!40000 ALTER TABLE `anuncios` DISABLE KEYS */;
INSERT INTO `anuncios` VALUES (1,'2021-11-26 00:05:17','2021-12-26 00:05:17','Camiseta de rayas','camiseta de talla M con rayas azules','4-camisetaRayas.png',12.99,0,0,4),(2,'2021-11-26 00:05:17','2021-12-26 00:05:17','Pantalones vaqueros negros','Pantalones de talla 38 negros y rotos','4-pantalonesVaquerosNegros.png',9.99,0,0,4),(3,'2021-11-26 00:05:17','2021-12-26 00:05:17','Sudadera gris','Sudadera talla S grande y ancho','4-sudaderaGris.png',15.99,0,0,4),(4,'2021-11-26 00:05:17','2021-12-26 00:05:17','Nike Air Jordan 1 Smoke Grey','Zapatillas Nike Air Jordan 1 color Smoke Grey talla 36','4-smokeGrey.png',74.99,0,0,4),(5,'2021-11-26 00:05:17','2021-12-26 00:05:17','Calcetines','Calcetines con estampado de gatitos empresarios de talla 38-42','4-packCalcetines.png',9.99,0,0,4),(6,'2021-11-26 00:05:17','2021-12-26 00:05:17','Vestido rojo ','Vestido rojo con lentejuelas perfecto para salir de noche','5-vestidoRojo.png',20.95,0,0,5),(7,'2021-11-26 00:05:17','2021-12-26 00:05:17','Abrigo lana oversize','Abrigo negro de talla 40','5-abrigoLanaOverzie.png',80,0,0,5),(8,'2021-11-26 00:05:17','2021-12-26 00:05:17','Camisa blanca','Camisa estructura de color blanco,manga larga y de algodón','5-camisaBlanca.png',29.95,0,0,5),(9,'2021-11-26 00:05:17','2021-12-26 00:05:17','Gorro cashmere','Gorro de cashmere negro ','5-gorroCashmereNegro.png',40,0,0,5),(10,'2021-11-26 00:05:17','2021-12-26 00:05:17','Camiseta UCLA','Camiseta de niño color blanco de la universidad de UCLA','5-camisetaUCLA.jpg',10.95,0,0,5),(11,'2021-11-26 00:05:17','2021-12-26 00:05:17','Teclado Asus Rog Claymore II','Teclado mecánico RGB antighosting switches cherry MX Blue','6-tecladoAsus.png',230,0,0,6),(12,'2021-11-26 00:05:17','2021-12-26 00:05:17','Ratón Logitech G Pro','Ratón inalámbrico RGB 16000 DPI ergonómico y sensor HERO 16K','6-ratonPro.png',80.99,0,0,6),(13,'2021-11-26 00:05:17','2021-12-26 00:05:17','Portatil MSI Katana','Ordenador portatil I7-11800H 16GB RAM 1TB SSD RTX 3060 Pantalla 15.6\" 144Hz','6-portatil.png',1500,0,0,6),(14,'2021-11-26 00:05:17','2021-12-26 00:05:17','Los Sims 4','Juego Los Sims 4 edición especial vida ecológica no contiene disco sino código de descarga','6-sims.jfif',39.95,0,0,6),(15,'2021-11-26 00:05:17','2021-12-26 00:05:17','Fifa 22','Juego EA Sports Fifa 22 simulador de futbol para PlayStation 5','6-fifa.jpg',60,0,0,6),(16,'2021-11-26 00:05:17','2021-12-26 00:05:17','Fregasuelos olor lavanda','Fregasuelos con olor a lavanda para un acabado eficaz','7-fregasuelosLavanda.png',3.99,0,0,7),(17,'2021-11-26 00:05:17','2021-12-26 00:05:17','Don Limpio baño','Producto de limpieza para baños que deja un brillo más duradero','7-bano.png',2.65,0,0,7),(18,'2021-11-26 00:05:17','2021-12-26 00:05:17','Limpia Cristales','Limpia cristales de Don Limpio limpieza absoluta','7-limpiaCristales.png',3,0,0,7),(19,'2021-11-26 00:05:17','2021-12-26 00:05:17','Bayetas','5 bayetas reutilizables','7-bayetas.png',4,0,0,7),(20,'2021-11-26 00:05:17','2021-12-26 00:05:17','Limpiador multiusos','Limpiador para cualquier zona de la casa','7-multiusos.png',3.5,0,0,7),(21,'2021-11-26 00:05:17','2021-12-26 00:05:17','Estantería Kallax','Estantería modular de 42 x 147 cm, acabado en patrón de madera','8-estanteria.png',39,0,0,8),(22,'2021-11-26 00:05:17','2021-12-26 00:05:17','Armario Syvde','Armario de recibidor abierto de 80 x 123 cm acabado en color blanco','8-armario.png',80,0,0,8),(23,'2021-11-26 00:05:17','2021-12-26 00:05:17','Mueble TV Brimnes','Mueble de televisor con dos cajones de 120 x 41 x 53 cm acabado en blanco y gris','8-muebleBlanco.png',79,0,0,8),(24,'2021-11-26 00:05:17','2021-12-26 00:05:17','Mueble de almacenaje Hemnes','Mueble de almacenaje de salón de 326 x 197 cm','8-muebleHemnes.png',647,0,0,8),(25,'2021-11-26 00:05:17','2021-12-26 00:05:17','Escritorio Malm','Escritorio para el hogar de 140 x 65 cm','8-escritorio.png',149,0,0,8),(26,'2021-11-26 00:05:17','2021-12-26 00:05:17','Cuaderno Oxford','Cuaderno de espiral, tapa dura, 100 páginas A4','9-cuaderno.png',5.6,0,0,9),(27,'2021-11-26 00:05:17','2021-12-26 00:05:17','Bolígrafo bic','Bolígrafo tinta azul punta de 1mm construido en cristal','9-boliBic.png',0.4,0,0,9),(28,'2021-11-26 00:05:17','2021-12-26 00:05:17','Bolígrafo pilot','Bolígrafo tinta de gel azul construido en plástico','9-boliPilot.png',0.85,0,0,9),(29,'2021-11-26 00:05:17','2021-12-26 00:05:17','Recambio de papel','Recambio de 200 hojas A4 de papel cuadriculado para archivadores','9-recambio.png',3.6,0,0,9),(30,'2021-11-26 00:05:17','2021-12-26 00:05:17','Lapicero Staedtler','Lapicero de grafito negro dureza HB','9-lapiz.png',0.2,0,0,9),(31,'2021-11-26 00:05:17','2021-12-26 00:05:17','Los Juegos del Hambre','La nación de Panem obliga a cada uno de sus doce distritos a enviar a un chico y a una chica, adolescentes, para competir en Los juegos del hambre. En parte es un entretenimiento rebuscado y en parte es una táctica de intimidación por parte del gobierno. Los juegos del hambre es un evento televisado nacionalmente en el cual los \"Tributos\" tienen que luchar entre ellos hasta quedar solamente un superviviente. Enfrentada con los bien entrenados \"Tributos\" quienes llevan toda la vida preparándose para estos juegos, Katniss se ve obligada a recurrir a sus agudos instintos, así como a la tutoría de Haymitch Abernathy, antiguo campeón, y ahora estropeado y  borrachín. Si quiere volver a casa en el Distrito 12, Katniss tendrá que tomar unas decisiones imposibles en La Arena que sopesan la supervivencia frente a la humanidad y la vida frente al amor.','10-ljdh.jpg',17,0,0,10),(32,'2021-11-26 00:05:17','2021-12-26 00:05:17','Harry Potter y el cáliz de fuego','Tras otro abominable verano con los Dursley, Harry se dispone a iniciar el cuarto curso en Hogwarts, la famosa escuela de magia y hechicería. A sus catorce años, a Harry le gustaría ser un joven mago como los demás y dedicarse a aprender nuevos sortilegios, encontrarse con sus amigos Ron y Hermione y asistir con ellos a los Mundiales de quidditch. Sin embargo, al llegar al colegio le espera una gran sorpresa que lo obligará a enfrentarse a los desafíos más temibles de toda su vida. SI logra superarlos, habrá demostrado que ya no es un niño y que está preparado para vivir las nuevas y emocionantes experiencias que el futuro le depara.','10-hp4.jfif',15,0,0,10),(33,'2021-11-26 00:05:17','2021-12-26 00:05:17','Harry Potter y el príncipe mestizo','Con dieciséis años cumplidos, Harry inicia el sexto curso en Hogwarts en medio de terribles acontecimientos que asolan Inglaterra. Elegido capitán del equipo de quidditch, los ensayos, los exámenes y las chicas ocupan todo su tiempo, pero la tranquilidad dura poco. A pesar de los férreos controles de seguridad que protegen la escuela, dos alumnos son brutalmente atacados. Dumbledore sabe que se acerca el momento, anunciado por la Profecía, en que Harry y Voldemort se enfrentarían a muerte: «El único con poder para vencer al Señor Tenebroso se acerca... Uno de los dos debe morir a manos del otro, pues ninguno de los dos podrá vivir mientras siga el otro con vida» El anciano director solicitará la ayuda de Harry y juntos emprenderán peligrosos viajes para intentar debilitar al enemigo, para lo cual el joven mago contará con un viejo libro de pociones perteneciente a un misterioso personaje, alguien que se hace llamar Príncipe Mestizo.','10-hp6.jpg',15,0,0,10),(34,'2021-11-26 00:05:17','2021-12-26 00:05:17','Nacidos de la bruma: el imperio final','Durante mil años han caído las cenizas y nada florece. Durante mil años los skaa han sido esclavizados y viven sumidos en un miedo inevitable. Durante mil años el Lord Legislador reina con un poder absoluto gracias al terror, a sus poderes e inmortalidad. Le ayudan «obligadores» e «inquisidores», junto a la poderosa magia de la «alomancia». Pero los nobles a menudo han tenido trato sexual con jóvenes skaa y, aunque la ley lo prohíbe, algunos de sus bastardos han sobrevivido y heredado los poderes alománticos: son los «nacidos de la bruma» (mistborns). Ahora, Kelsier, el «superviviente», el único que ha logrado huir de los Pozos de Hathsin, ha encontrado a Vin, una pobre chica skaa con mucha suerte... Tal vez los dos, unidos a la rebelión que los skaa intentan desde hace mil años, logren cambiar el mundo y la atroz dominación del Lord Legislador.','10-nacidosDeLaBruma.jpg',20,0,0,10),(35,'2021-11-26 00:05:17','2021-12-26 00:05:17','El bestiario de Axlin','El mundo de Axlin está plagado de monstruos. Algunos atacan a los viajeros en los caminos, otros asedian las aldeas hasta que logran arrasarlas por completo y otros entran en las casas por las noches para llevarse a los niños mientras duermen. Axlin es la escriba de su aldea, la única que sabe leer y escribir. Y se ha propuesto investigar todo lo que pueda sobre los monstruos y plasmar sus descubrimientos en un libro que pueda servir de guía y protección a otras personas. Por eso decide partir con los buhoneros para reunir la sabiduría ancestral de las aldeas en su precaria lucha contra los monstruos. No obstante, a lo largo de su viaje descubrirá cosas que jamás habría imaginado cuando partió.','10-elBestiarioDeAxlin.jpg',15,0,0,10),(36,'2021-11-26 00:05:17','2021-12-26 00:05:17','Tempest M6 Rez 2.0 Gaming Speakers','Altavoces de tamaño medio intensidad de sonido de hasta 65db y respuesta de frecuencia de 100Hz','11-altavoz.png',11.99,0,0,11),(37,'2021-11-26 00:05:17','2021-12-26 00:05:17','Lenovo C24-25','Monitor de 23.8\" con tasa de refresco de 75Hz','11-lenovo.png',128.9,0,0,11),(38,'2021-11-26 00:05:17','2021-12-26 00:05:17','HyperX Alloy elite 2','Teclado mecánico Gaming RGB conector USB 2.0 cable de 1.8m','11-elite2.png',159.99,0,0,11),(39,'2021-11-26 00:05:17','2021-12-26 00:05:17','Razer Viper mini','Ratón Gaming RGB 8500 DPI','11-ratonMini.png',50,0,0,11),(40,'2021-11-26 00:05:17','2021-12-26 00:05:17','Logitech G432','Auriculares gaming compatibles con todas las plataformas con micrófono integrado','11-auriculares.png',79.99,0,0,11),(41,'2021-11-26 00:05:17','2021-12-26 00:05:17','Pollo con salsa thai','Para la base de este plato sofreímos lentamente cebolla junto con ajo y setas. Incorporamos salsa de soja, jengibre y leche de coco, incorporamos un poco de cayena en polvo para darle alegría. Cocinamos las verduras al vapor. En este caso empleamos noodles de boniato que tienen una textura única','12-pollo.jfif',5.95,0,0,12),(42,'2021-11-26 00:05:17','2021-12-26 00:05:17','Verdura salteada cin humus de piquillo y arroz imperial','Para este hummus tan particular trituramos garbanzos cocidos junto con piquillos , ajo confitado y zumo de lima. Hacemos un mix de verduras que cocinamos al vapor y aderezamos con un poco de aceite de sésamo. Para completar este equilibrado plato incorporamos arroz integral negro apenas aliñado.','12-verdura.jpg',6.05,0,0,12),(43,'2021-11-26 00:05:17','2021-12-26 00:05:17','Arroz con leche','Cocinado al estilo tradicional asturiano, a fuego muy bajo, removiendo constantemente y añadiendo poco a poco la leche, como si fuera un risotto. Terminamos con mantequilla, azúcar de caña y un toque de canela.','12-arrozConLeche.jpg',2.45,0,0,12),(44,'2021-11-26 00:05:17','2021-12-26 00:05:17','Solomillo con salsa de queso','Cocinamos el lomo a baja temperatura para que quede jugoso. A partir de una mezcla 6 quesos hacemos una salsa a la que le incorporamos caldo de verduras para hacerlo más ligero. Incorporamos un poco de estragón que encaja perfectamente con el cerdo y el queso.','12-solomillo.jpg',5.95,0,0,12),(45,'2021-11-26 00:05:17','2021-12-26 00:05:17','Merluza con salsa vizcaína','Cocinamos la merluza a baja temperatura para asegurarnos que quede en su punto. Para la salsa sofreímos cebolla, ajo puerro y zanahorias. incorporamos tomate y pimiento choricero. Mojamos con vino blanco reducido y caldo de pescado. Incorporamos un poquito de cayena en polvo para que tenga un poco de \"alegría\".','12-merluza.jpg',6.6,0,0,12),(46,'2021-11-26 00:05:17','2021-12-26 00:05:17','Pack 8 anillos plateados','8 anillos plateados con cuerpos celestes','13-anillos.png',4,0,0,13),(47,'2021-11-26 00:05:17','2021-12-26 00:05:17','Bolso Chicago Bulls','Bolso shopper de lona color marfil extragrande de los Chicago Bulls de la NBA','13-bolso.png',6,0,0,13),(48,'2021-11-26 00:05:17','2021-12-26 00:05:17','Cinta para la cabeza','Cinta para la cabeza negra de forro polar de Thinsulate','13-cinta.png',3,0,0,13),(49,'2021-11-26 00:05:17','2021-12-26 00:05:17','Collar doble','Collar de dos filas semiprecioso bañado en oro','13-collarDoble.png',10,0,0,13),(50,'2021-11-26 00:05:17','2021-12-26 00:05:17','Pendientes de aro','Pendientes de aro mini pleateados triples con detalle de diamante','13-pendientes.png',2,0,0,13),(51,'2021-01-01 00:00:00','2021-01-08 00:00:00','Pantalones Hip Hop Top','Tasty Life Pantalones Hip Hop callejeros deportivos','generic_img.png',9.95,1,0,4),(52,'2021-01-01 00:00:00','2021-01-08 00:00:00','Camiseta Hip Hop Hombre','Tasty Life Camiseta Hip Hop hombre callejera','generic_img.png',7.95,1,0,4),(53,'2021-01-01 00:00:00','2021-01-08 00:00:00','Camiseta Hip Hop Mujer','Tasty Life Camiseta Hip Hop mujer callejera','generic_img.png',7.95,1,0,4),(54,'2021-01-01 00:00:00','2021-01-08 00:00:00','Zapatillas Hip Hop','Tasty Life Zapatillas Hip Hop callejeras deportivas','generic_img.png',24.5,1,0,4),(55,'2021-01-01 00:00:00','2021-01-08 00:00:00','Gorra Hip Hop','Tasty Life Gorra Hip Hop hombre callejera','generic_img.png',15.95,1,0,4),(56,'2021-01-01 00:00:00','2021-01-08 00:00:00','Manga Compresora','Tasty Life Manga compresora (1 ud)','generic_img.png',3.25,1,0,4),(57,'2021-01-01 00:00:00','2021-01-08 00:00:00','Manga Compresora Negro','Tasty Life Manga compresora color negro (1 ud)','generic_img.png',3.5,1,0,4),(58,'2021-01-01 00:00:00','2021-01-08 00:00:00','Manga Compresora Azul','Tasty Life Manga compresora color azul (1 ud)','generic_img.png',3.5,1,0,4),(59,'2021-01-01 00:00:00','2021-01-08 00:00:00','Manga Compresora Verde','Tasty Life Manga compresora color verde (1 ud)','generic_img.png',3.5,0,0,4),(60,'2021-01-01 00:00:00','2021-01-08 00:00:00','Manga Compresora Morado','Tasty Life Manga compresora color morado (1 ud)','generic_img.png',3.5,1,0,4),(61,'2021-01-01 00:00:00','2021-01-08 00:00:00','Manga Compresora Amarillo','Tasty Life Manga compresora color Amarillo (1 ud)','generic_img.png',3.5,0,0,4),(62,'2021-01-01 00:00:00','2021-01-08 00:00:00','Manga Compresora Cyan','Tasty Life Manga compresora color Cyan (1 ud)','generic_img.png',3.5,0,0,4),(63,'2021-02-01 00:00:00','2021-02-08 00:00:00','Pantalones Hip Hop Top February Edition','Tasty Life Pantalones Hip Hop callejeros deportivos','generic_img.png',9.95,1,0,4),(64,'2021-02-01 00:00:00','2021-02-08 00:00:00','Camiseta Hip Hop Hombre February Edition','Tasty Life Camiseta Hip Hop hombre callejera','generic_img.png',7.95,1,0,4),(65,'2021-02-01 00:00:00','2021-02-08 00:00:00','Camiseta Hip Hop Mujer February Edition','Tasty Life Camiseta Hip Hop mujer callejera','generic_img.png',7.95,1,0,4),(66,'2021-02-01 00:00:00','2021-02-08 00:00:00','Zapatillas Hip Hop February Edition','Tasty Life Zapatillas Hip Hop callejeras deportivas','generic_img.png',24.5,1,0,4),(67,'2021-02-01 00:00:00','2021-02-08 00:00:00','Gorra Hip Hop February Edition','Tasty Life Gorra Hip Hop hombre callejera','generic_img.png',15.95,1,0,4),(68,'2021-02-01 00:00:00','2021-02-08 00:00:00','Manga Compresora February Edition','Tasty Life Manga compresora (1 ud)','generic_img.png',3.25,1,0,4),(69,'2021-02-01 00:00:00','2021-02-08 00:00:00','Manga Compresora Negro February Edition','Tasty Life Manga compresora color negro (1 ud)','generic_img.png',3.5,1,0,4),(70,'2021-02-01 00:00:00','2021-02-08 00:00:00','Manga Compresora Azul February Edition','Tasty Life Manga compresora color azul (1 ud)','generic_img.png',3.5,1,0,4),(71,'2021-02-01 00:00:00','2021-02-08 00:00:00','Manga Compresora Verde February Edition','Tasty Life Manga compresora color verde (1 ud)','generic_img.png',3.5,0,0,4),(72,'2021-02-01 00:00:00','2021-02-08 00:00:00','Manga Compresora Morado February Edition','Tasty Life Manga compresora color morado (1 ud)','generic_img.png',3.5,1,0,4),(73,'2021-02-01 00:00:00','2021-02-08 00:00:00','Manga Compresora Amarillo February Edition','Tasty Life Manga compresora color Amarillo (1 ud)','generic_img.png',3.5,0,0,4),(74,'2021-02-01 00:00:00','2021-02-08 00:00:00','Manga Compresora Cyan February Edition','Tasty Life Manga compresora color Cyan (1 ud)','generic_img.png',3.5,0,0,4),(75,'2021-03-01 00:00:00','2021-03-08 00:00:00','Pantalones Hip Hop Top March Edition','Tasty Life Pantalones Hip Hop callejeros deportivos','generic_img.png',9.95,1,0,4),(76,'2021-03-01 00:00:00','2021-03-08 00:00:00','Manga Compresora Negro March Edition','Tasty Life Manga compresora color negro (1 ud)','generic_img.png',3.5,1,0,4),(77,'2021-03-01 00:00:00','2021-03-08 00:00:00','Manga Compresora Azul March Edition','Tasty Life Manga compresora color azul (1 ud)','generic_img.png',3.5,1,0,4),(78,'2021-03-01 00:00:00','2021-03-08 00:00:00','Manga Compresora Verde March Edition','Tasty Life Manga compresora color verde (1 ud)','generic_img.png',3.5,0,0,4),(79,'2021-03-01 00:00:00','2021-03-08 00:00:00','Manga Compresora Amarillo March Edition','Tasty Life Manga compresora color Amarillo (1 ud)','generic_img.png',3.5,0,0,4),(80,'2021-03-01 00:00:00','2021-03-08 00:00:00','Manga Compresora Cyan March Edition','Tasty Life Manga compresora color Cyan (1 ud)','generic_img.png',3.5,0,0,4),(81,'2021-04-01 00:00:00','2021-04-08 00:00:00','Pantalones Hip Hop Top April Edition','Tasty Life Pantalones Hip Hop callejeros deportivos','generic_img.png',9.95,1,0,4),(82,'2021-04-01 00:00:00','2021-04-08 00:00:00','Camiseta Hip Hop Hombre April Edition','Tasty Life Camiseta Hip Hop hombre callejera','generic_img.png',7.95,1,0,4),(83,'2021-04-01 00:00:00','2021-04-08 00:00:00','Camiseta Hip Hop Mujer April Edition','Tasty Life Camiseta Hip Hop mujer callejera','generic_img.png',7.95,1,0,4),(84,'2021-04-01 00:00:00','2021-04-08 00:00:00','Zapatillas Hip Hop April Edition','Tasty Life Zapatillas Hip Hop callejeras deportivas','generic_img.png',24.5,1,0,4),(85,'2021-04-01 00:00:00','2021-04-08 00:00:00','Gorra Hip Hop April Edition','Tasty Life Gorra Hip Hop hombre callejera','generic_img.png',15.95,1,0,4),(86,'2021-05-01 00:00:00','2021-05-08 00:00:00','Manga Compresora May Edition','Tasty Life Manga compresora (1 ud)','generic_img.png',3.25,1,0,4),(87,'2021-05-01 00:00:00','2021-05-08 00:00:00','Manga Compresora Negro May Edition','Tasty Life Manga compresora color negro (1 ud)','generic_img.png',3.5,1,0,4),(88,'2021-05-01 00:00:00','2021-05-08 00:00:00','Manga Compresora Azul May Edition','Tasty Life Manga compresora color azul (1 ud)','generic_img.png',3.5,1,0,4),(89,'2021-05-01 00:00:00','2021-05-08 00:00:00','Manga Compresora Verde May Edition','Tasty Life Manga compresora color verde (1 ud)','generic_img.png',3.5,0,0,4),(90,'2021-05-01 00:00:00','2021-05-08 00:00:00','Manga Compresora Morado May Edition','Tasty Life Manga compresora color morado (1 ud)','generic_img.png',3.5,1,0,4),(91,'2021-05-01 00:00:00','2021-05-08 00:00:00','Manga Compresora Amarillo May Edition','Tasty Life Manga compresora color Amarillo (1 ud)','generic_img.png',3.5,0,0,4),(92,'2021-05-01 00:00:00','2021-05-08 00:00:00','Manga Compresora Cyan May Edition','Tasty Life Manga compresora color Cyan (1 ud)','generic_img.png',3.5,0,0,4),(93,'2021-06-01 00:00:00','2021-06-08 00:00:00','Manga Compresora Azul June Edition','Tasty Life Manga compresora color azul (1 ud)','generic_img.png',3.5,1,0,4),(94,'2021-06-01 00:00:00','2021-06-08 00:00:00','Manga Compresora Verde June Edition','Tasty Life Manga compresora color verde (1 ud)','generic_img.png',3.5,0,0,4),(95,'2021-06-01 00:00:00','2021-06-08 00:00:00','Manga Compresora Morado June Edition','Tasty Life Manga compresora color morado (1 ud)','generic_img.png',3.5,1,0,4),(96,'2021-06-01 00:00:00','2021-06-08 00:00:00','Manga Compresora Amarillo June Edition','Tasty Life Manga compresora color Amarillo (1 ud)','generic_img.png',3.5,0,0,4),(97,'2021-06-01 00:00:00','2021-06-08 00:00:00','Manga Compresora Cyan June Edition','Tasty Life Manga compresora color Cyan (1 ud)','generic_img.png',3.5,0,0,4),(98,'2021-07-01 00:00:00','2021-07-08 00:00:00','Pantalones Hip Hop Top July Edition','Tasty Life Pantalones Hip Hop callejeros deportivos','generic_img.png',9.95,1,0,4),(99,'2021-07-01 00:00:00','2021-07-08 00:00:00','Camiseta Hip Hop Hombre July Edition','Tasty Life Camiseta Hip Hop hombre callejera','generic_img.png',7.95,1,0,4),(100,'2021-07-01 00:00:00','2021-07-08 00:00:00','Camiseta Hip Hop Mujer July Edition','Tasty Life Camiseta Hip Hop mujer callejera','generic_img.png',7.95,1,0,4),(101,'2021-07-01 00:00:00','2021-07-08 00:00:00','Zapatillas Hip Hop July Edition','Tasty Life Zapatillas Hip Hop callejeras deportivas','generic_img.png',24.5,1,0,4),(102,'2021-07-01 00:00:00','2021-07-08 00:00:00','Gorra Hip Hop July Edition','Tasty Life Gorra Hip Hop hombre callejera','generic_img.png',15.95,1,0,4),(103,'2021-07-01 00:00:00','2021-07-08 00:00:00','Manga Compresora July Edition','Tasty Life Manga compresora (1 ud)','generic_img.png',3.25,1,0,4),(104,'2021-07-01 00:00:00','2021-07-08 00:00:00','Manga Compresora Negro July Edition','Tasty Life Manga compresora color negro (1 ud)','generic_img.png',3.5,1,0,4),(105,'2021-07-01 00:00:00','2021-07-08 00:00:00','Manga Compresora Azul July Edition','Tasty Life Manga compresora color azul (1 ud)','generic_img.png',3.5,1,0,4),(106,'2021-07-01 00:00:00','2021-07-08 00:00:00','Manga Compresora Verde July Edition','Tasty Life Manga compresora color verde (1 ud)','generic_img.png',3.5,0,0,4),(107,'2021-07-01 00:00:00','2021-07-08 00:00:00','Manga Compresora Morado July Edition','Tasty Life Manga compresora color morado (1 ud)','generic_img.png',3.5,1,0,4),(108,'2021-07-01 00:00:00','2021-07-08 00:00:00','Manga Compresora Amarillo July Edition','Tasty Life Manga compresora color Amarillo (1 ud)','generic_img.png',3.5,0,0,4),(109,'2021-07-01 00:00:00','2021-07-08 00:00:00','Manga Compresora Cyan July Edition','Tasty Life Manga compresora color Cyan (1 ud)','generic_img.png',3.5,0,0,4),(110,'2021-08-01 00:00:00','2021-08-08 00:00:00','Pantalones Hip Hop Top August Edition','Tasty Life Pantalones Hip Hop callejeros deportivos','generic_img.png',9.95,1,0,4),(111,'2021-08-01 00:00:00','2021-08-08 00:00:00','Camiseta Hip Hop Hombre August Edition','Tasty Life Camiseta Hip Hop hombre callejera','generic_img.png',7.95,1,0,4),(112,'2021-08-01 00:00:00','2021-08-08 00:00:00','Camiseta Hip Hop Mujer August Edition','Tasty Life Camiseta Hip Hop mujer callejera','generic_img.png',7.95,1,0,4),(113,'2021-08-01 00:00:00','2021-08-08 00:00:00','Zapatillas Hip Hop August Edition','Tasty Life Zapatillas Hip Hop callejeras deportivas','generic_img.png',24.5,1,0,4),(114,'2021-09-01 00:00:00','2021-09-08 00:00:00','Pantalones Hip Hop Top September Edition','Tasty Life Pantalones Hip Hop callejeros deportivos','generic_img.png',9.95,1,0,4),(115,'2021-09-01 00:00:00','2021-09-08 00:00:00','Camiseta Hip Hop Hombre September Edition','Tasty Life Camiseta Hip Hop hombre callejera','generic_img.png',7.95,1,0,4),(116,'2021-09-01 00:00:00','2021-09-08 00:00:00','Camiseta Hip Hop Mujer September Edition','Tasty Life Camiseta Hip Hop mujer callejera','generic_img.png',7.95,1,0,4),(117,'2021-09-01 00:00:00','2021-09-08 00:00:00','Zapatillas Hip Hop September Edition','Tasty Life Zapatillas Hip Hop callejeras deportivas','generic_img.png',24.5,1,0,4),(118,'2021-09-01 00:00:00','2021-09-08 00:00:00','Gorra Hip Hop September Edition','Tasty Life Gorra Hip Hop hombre callejera','generic_img.png',15.95,1,0,4),(119,'2021-09-01 00:00:00','2021-09-08 00:00:00','Manga Compresora September Edition','Tasty Life Manga compresora (1 ud)','generic_img.png',3.25,1,0,4),(120,'2021-09-01 00:00:00','2021-09-08 00:00:00','Manga Compresora Negro September Edition','Tasty Life Manga compresora color negro (1 ud)','generic_img.png',3.5,1,0,4),(121,'2021-09-01 00:00:00','2021-09-08 00:00:00','Manga Compresora Azul September Edition','Tasty Life Manga compresora color azul (1 ud)','generic_img.png',3.5,1,0,4),(122,'2021-09-01 00:00:00','2021-09-08 00:00:00','Manga Compresora Verde September Edition','Tasty Life Manga compresora color verde (1 ud)','generic_img.png',3.5,0,0,4),(123,'2021-09-01 00:00:00','2021-09-08 00:00:00','Manga Compresora Morado September Edition','Tasty Life Manga compresora color morado (1 ud)','generic_img.png',3.5,1,0,4),(124,'2021-09-01 00:00:00','2021-09-08 00:00:00','Manga Compresora Amarillo September Edition','Tasty Life Manga compresora color Amarillo (1 ud)','generic_img.png',3.5,0,0,4),(125,'2021-09-01 00:00:00','2021-09-08 00:00:00','Manga Compresora Cyan September Edition','Tasty Life Manga compresora color Cyan (1 ud)','generic_img.png',3.5,0,0,4),(126,'2021-10-01 00:00:00','2021-10-08 00:00:00','Pantalones Hip Hop Top October Edition','Tasty Life Pantalones Hip Hop callejeros deportivos','generic_img.png',9.95,1,0,4),(127,'2021-10-01 00:00:00','2021-10-08 00:00:00','Camiseta Hip Hop Hombre October Edition','Tasty Life Camiseta Hip Hop hombre callejera','generic_img.png',7.95,1,0,4),(128,'2021-10-01 00:00:00','2021-10-08 00:00:00','Camiseta Hip Hop Mujer October Edition','Tasty Life Camiseta Hip Hop mujer callejera','generic_img.png',7.95,1,0,4),(129,'2021-10-01 00:00:00','2021-10-08 00:00:00','Zapatillas Hip Hop October Edition','Tasty Life Zapatillas Hip Hop callejeras deportivas','generic_img.png',24.5,1,0,4),(130,'2021-10-01 00:00:00','2021-10-08 00:00:00','Gorra Hip Hop October Edition','Tasty Life Gorra Hip Hop hombre callejera','generic_img.png',15.95,1,0,4),(131,'2021-10-01 00:00:00','2021-10-08 00:00:00','Manga Compresora October Edition','Tasty Life Manga compresora (1 ud)','generic_img.png',3.25,1,0,4),(132,'2021-11-01 00:00:00','2021-11-08 00:00:00','Pantalones Hip Hop Top November Edition','Tasty Life Pantalones Hip Hop callejeros deportivos','generic_img.png',9.95,1,0,4),(133,'2021-11-01 00:00:00','2021-11-08 00:00:00','Camiseta Hip Hop Hombre November Edition','Tasty Life Camiseta Hip Hop hombre callejera','generic_img.png',7.95,1,0,4),(134,'2021-11-01 00:00:00','2021-11-08 00:00:00','Camiseta Hip Hop Mujer November Edition','Tasty Life Camiseta Hip Hop mujer callejera','generic_img.png',7.95,1,0,4),(135,'2021-11-01 00:00:00','2021-11-08 00:00:00','Zapatillas Hip Hop November Edition','Tasty Life Zapatillas Hip Hop callejeras deportivas','generic_img.png',24.5,1,0,4),(136,'2021-11-01 00:00:00','2021-11-08 00:00:00','Gorra Hip Hop November Edition','Tasty Life Gorra Hip Hop hombre callejera','generic_img.png',15.95,1,0,4),(137,'2021-11-01 00:00:00','2021-11-08 00:00:00','Manga Compresora November Edition','Tasty Life Manga compresora (1 ud)','generic_img.png',3.25,1,0,4),(138,'2021-11-01 00:00:00','2021-11-08 00:00:00','Manga Compresora Negro November Edition','Tasty Life Manga compresora color negro (1 ud)','generic_img.png',3.5,1,0,4),(139,'2021-11-01 00:00:00','2021-11-08 00:00:00','Manga Compresora Azul November Edition','Tasty Life Manga compresora color azul (1 ud)','generic_img.png',3.5,1,0,4),(140,'2021-11-01 00:00:00','2021-11-08 00:00:00','Manga Compresora Verde November Edition','Tasty Life Manga compresora color verde (1 ud)','generic_img.png',3.5,0,0,4),(141,'2021-11-01 00:00:00','2021-11-08 00:00:00','Manga Compresora Morado November Edition','Tasty Life Manga compresora color morado (1 ud)','generic_img.png',3.5,1,0,4),(142,'2021-11-01 00:00:00','2021-11-08 00:00:00','Manga Compresora Amarillo November Edition','Tasty Life Manga compresora color Amarillo (1 ud)','generic_img.png',3.5,0,0,4),(143,'2021-11-01 00:00:00','2021-11-08 00:00:00','Manga Compresora Red Bull November Edition','Tasty Life Manga compresora edición especial Red Bull (1 ud)','generic_img.png',3.5,0,0,4),(144,'2021-11-01 00:00:00','2021-11-08 00:00:00','Manga Compresora Palace November Edition','Tasty Life Manga compresora palace edition (1 ud)','generic_img.png',3.5,1,0,4),(145,'2021-11-01 00:00:00','2021-12-09 00:00:00','Manga Compresora Blanco November Edition','Tasty Life Manga compresora color Blanco (1 ud)','generic_img.png',3.5,1,0,4),(146,'2021-11-01 00:00:00','2021-12-03 00:00:00','Manga Compresora Cyan November Edition','Tasty Life Manga compresora color Cyan (1 ud)','generic_img.png',3.5,1,0,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (3,'Accesorios'),(5,'Cocina'),(4,'Comida'),(7,'Droguería'),(11,'Gaming'),(10,'Hogar'),(1,'Informática'),(6,'Libros'),(9,'Limpieza'),(8,'Material escolar'),(12,'Otros'),(2,'Ropa');
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
  `id_vendedor` int(11) NOT NULL,
  `fecha_compra` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_anuncio`,`id_comprador`,`id_vendedor`),
  KEY `rel_histcomp_comp` (`id_comprador`),
  KEY `rel_histvent_comp` (`id_vendedor`),
  CONSTRAINT `rel_histcomp_anu` FOREIGN KEY (`id_anuncio`) REFERENCES `anuncios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rel_histcomp_comp` FOREIGN KEY (`id_comprador`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rel_histvent_comp` FOREIGN KEY (`id_vendedor`) REFERENCES `vendedores` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historialCompras`
--

LOCK TABLES `historialCompras` WRITE;
/*!40000 ALTER TABLE `historialCompras` DISABLE KEYS */;
INSERT INTO `historialCompras` VALUES (51,14,4,'2021-11-26 00:05:19'),(52,14,4,'2021-11-26 00:05:19'),(53,14,4,'2021-11-26 00:05:19'),(54,14,4,'2021-11-26 00:05:19'),(55,14,4,'2021-11-26 00:05:19'),(56,14,4,'2021-11-26 00:05:19'),(57,14,4,'2021-11-26 00:05:19'),(58,14,4,'2021-11-26 00:05:19'),(60,14,4,'2021-11-26 00:05:19'),(61,14,4,'2021-11-26 00:05:19'),(62,14,4,'2021-11-26 00:05:19'),(63,14,4,'2021-11-26 00:05:19'),(64,14,4,'2021-11-26 00:05:19'),(65,14,4,'2021-11-26 00:05:19'),(66,14,4,'2021-11-26 00:05:19'),(67,14,4,'2021-11-26 00:05:19'),(77,14,4,'2021-11-26 00:05:19'),(81,14,4,'2021-11-26 00:05:19'),(82,14,4,'2021-11-26 00:05:19'),(83,14,4,'2021-11-26 00:05:19'),(84,14,4,'2021-11-26 00:05:19'),(85,14,4,'2021-11-26 00:05:19'),(86,14,4,'2021-11-26 00:05:19'),(87,14,4,'2021-11-26 00:05:19'),(88,14,4,'2021-11-26 00:05:19'),(90,14,4,'2021-11-26 00:05:19'),(93,14,4,'2021-11-26 00:05:19'),(95,14,4,'2021-11-26 00:05:19'),(98,14,4,'2021-11-26 00:05:19'),(99,14,4,'2021-11-26 00:05:19'),(100,14,4,'2021-11-26 00:05:19'),(101,14,4,'2021-11-26 00:05:19'),(102,14,4,'2021-11-26 00:05:19'),(103,14,4,'2021-11-26 00:05:19'),(104,14,4,'2021-11-26 00:05:19'),(105,14,4,'2021-11-26 00:05:19'),(107,14,4,'2021-11-26 00:05:19'),(110,14,4,'2021-11-26 00:05:19'),(111,14,4,'2021-11-26 00:05:19'),(112,14,4,'2021-11-26 00:05:19'),(113,14,4,'2021-11-26 00:05:19'),(114,14,4,'2021-11-26 00:05:19'),(115,14,4,'2021-11-26 00:05:19'),(116,14,4,'2021-11-26 00:05:19'),(117,14,4,'2021-11-26 00:05:19'),(118,14,4,'2021-11-26 00:05:19'),(119,14,4,'2021-11-26 00:05:19'),(120,14,4,'2021-11-26 00:05:19'),(121,14,4,'2021-11-26 00:05:19'),(123,14,4,'2021-11-26 00:05:19'),(126,14,4,'2021-11-26 00:05:19'),(127,14,4,'2021-11-26 00:05:19'),(128,14,4,'2021-11-26 00:05:19'),(129,14,4,'2021-11-26 00:05:19'),(130,14,4,'2021-11-26 00:05:19'),(131,14,4,'2021-11-26 00:05:19'),(132,14,4,'2021-11-26 00:05:19'),(134,14,4,'2021-11-26 00:05:19'),(135,14,4,'2021-11-26 00:05:19'),(136,14,4,'2021-11-26 00:05:19'),(137,14,4,'2021-11-26 00:05:19'),(138,14,4,'2021-11-26 00:05:19'),(139,14,4,'2021-11-26 00:05:19'),(141,14,4,'2021-11-26 00:05:19'),(144,14,4,'2021-11-26 00:05:19'),(145,14,4,'2021-11-26 00:05:19'),(146,14,4,'2021-11-26 00:05:19');
/*!40000 ALTER TABLE `historialCompras` ENABLE KEYS */;
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
  `foto` varchar(100) DEFAULT 'default_user.png',
  `descripcion` varchar(200) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `habilitado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `usu_name_unique` (`username`),
  UNIQUE KEY `usu_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Alaitz','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','alaitz.candela@ikasle.egibide.org','A','default_user.png',NULL,'2021-11-26 00:05:17',1),(2,'Raul','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','raul.melgosa@ikasle.egibide.org','A','default_user.png',NULL,'2021-11-26 00:05:17',1),(3,'Dani','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','daniel.tamargo@ikasle.egibide.org','A','3-dani.jpg',NULL,'2021-11-26 00:05:17',1),(4,'bershka','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','bershka@gmail.com','V','default_user.png',NULL,'2021-11-26 00:05:17',1),(5,'Zara','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','zara@gmail.com','V','default_user.png',NULL,'2021-11-26 00:05:17',1),(6,'Game','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','game@gmail.com','V','default_user.png',NULL,'2021-11-26 00:05:17',1),(7,'Don limpio','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','donlimpio@gmail.com','V','default_user.png',NULL,'2021-11-26 00:05:17',1),(8,'Ikea','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','ikea@gmail.com','V','default_user.png',NULL,'2021-11-26 00:05:17',1),(9,'Eroski','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','eroski@gmail.com','V','default_user.png',NULL,'2021-11-26 00:05:17',1),(10,'La casa del libro','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','laCasaDelLibro@gmail.com','V','default_user.png',NULL,'2021-11-26 00:05:17',1),(11,'PC Componentes','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','PcCom@gmail.com','V','default_user.png',NULL,'2021-11-26 00:05:17',1),(12,'Wetaca','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','wetaca@ikasle.egibide.org','V','default_user.png',NULL,'2021-11-26 00:05:17',1),(13,'Primark','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','primark@gmail.com','V','default_user.png',NULL,'2021-11-26 00:05:17',1),(14,'compulsivo','$2y$08$0lzt6WoAemujRpyGxWJJ7.pFesin2bqQIOm9X3kdDd5xpPSxPLh3m','compradorcompulsivo@gmail.com','C','compradorcompulsivo.jpg','ME ENCANTA COMPRAR, ES MI PASIÓN, QUIERO COMPRAR MÁS, MÁS, MÁÁÁÁÁÁÁS!! SI ME ESTÁS LEYENDO POR FAVOR PUBLICA ALGO, ¡¡¡¡YO TE LO COMPRO!!!!','2021-11-26 00:05:19',1);
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
  `telefono` varchar(15) NOT NULL,
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
INSERT INTO `vendedores` VALUES (4,'Barcelona','923277146'),(5,'La Coruña','968455918'),(6,'Texas','972713100'),(7,'Ohio','980081113'),(8,'Kronoberg','978827424'),(9,'País Vasco','956042238'),(10,'Albacete','988197660'),(11,'Murcia','964563035'),(12,'Madrid','931904577'),(13,'Dublín','926778196');
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

-- Dump completed on 2021-11-26  0:06:42
