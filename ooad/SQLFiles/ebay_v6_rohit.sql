CREATE DATABASE  IF NOT EXISTS `ebay` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `ebay_v7`;
-- MySQL dump 10.13  Distrib 5.5.49, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: ebay
-- ------------------------------------------------------
-- Server version	5.5.49-0ubuntu0.14.04.1

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
-- Table structure for table `acknowledgement`
--

DROP TABLE IF EXISTS `acknowledgement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acknowledgement` (
  `ack_id` int(11) NOT NULL AUTO_INCREMENT,
  `ack` varchar(100) NOT NULL,
  `ack_topic` varchar(30) NOT NULL,
  PRIMARY KEY (`ack_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acknowledgement`
--

LOCK TABLES `acknowledgement` WRITE;
/*!40000 ALTER TABLE `acknowledgement` DISABLE KEYS */;
INSERT INTO `acknowledgement` VALUES (1,'RApS.in','RApS project'),(2,'Vijaya Porwal','Flow of project');
/*!40000 ALTER TABLE `acknowledgement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attributes`
--

DROP TABLE IF EXISTS `attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attributes` (
  `attributes_id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute_item_id` int(11) DEFAULT NULL,
  `attribute_key` varchar(45) DEFAULT NULL,
  `attribute_value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`attributes_id`),
  KEY `attriute_item_fk_idx` (`attribute_item_id`),
  CONSTRAINT `attriute_item_fk` FOREIGN KEY (`attribute_item_id`) REFERENCES `items` (`items_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attributes`
--

LOCK TABLES `attributes` WRITE;
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
INSERT INTO `attributes` VALUES (16,97,'screen size','15.6'),(17,97,'os','linux'),(18,103,'Screen Size',' 32'),(19,103,'Resolution','768p, 720p'),(20,104,'Type','Notebook'),(21,104,' 	Processor',' Intel Core i5 (5th Generation) 5200U'),(22,105,'Lens Type',' Telephoto'),(23,105,' 	Focal Length','300mm'),(24,106,'Length','8 feets'),(25,106,'Thickness','0.5 cm'),(26,106,'Material','Gold'),(39,111,'Test','Anubhav'),(49,96,'vvdh','dgvfsg'),(50,96,'bdfhdfk','fdjkdfk'),(51,96,'bddfi','udfiudfi'),(54,114,'RAM','3 GB'),(55,114,'',''),(56,117,'Author','Sanchit'),(63,95,'Skin Type','All'),(64,95,'Size','Value Size'),(65,95,'Gender','All'),(69,2,'width','15\"'),(70,2,'height','10\"'),(71,2,'length','15.2 cm'),(78,113,'RAM','3 GB'),(79,113,'','');
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buyers`
--

DROP TABLE IF EXISTS `buyers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buyers` (
  `buyers_id` int(11) NOT NULL AUTO_INCREMENT,
  `buyer_id` int(11) DEFAULT NULL,
  `buyer_address` varchar(45) DEFAULT NULL,
  `buyer_item_id` int(11) DEFAULT NULL,
  `buyer_dob` date DEFAULT NULL,
  `buyer_status` tinyint(4) DEFAULT NULL COMMENT '1 - Pending (In-Transit)\n2 - Dispatched\n3 - Delivered\n4 - Failed',
  `buyer_dod` date DEFAULT NULL,
  `buyer_money_paid` double DEFAULT NULL,
  `buyer_seller_id` int(11) DEFAULT NULL,
  `is_seller_rated` tinyint(4) DEFAULT NULL,
  `buyer_item_quantity` int(11) DEFAULT '1',
  PRIMARY KEY (`buyers_id`),
  KEY `buyer_id_fk_idx` (`buyer_id`),
  KEY `buyer_item_id_fk_idx` (`buyer_item_id`),
  KEY `buyer_seller_id_fk_idx` (`buyer_seller_id`),
  CONSTRAINT `buyer_id_fk` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`users_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `buyer_item_id_fk` FOREIGN KEY (`buyer_item_id`) REFERENCES `items` (`items_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyers`
--

LOCK TABLES `buyers` WRITE;
/*!40000 ALTER TABLE `buyers` DISABLE KEYS */;
INSERT INTO `buyers` VALUES (1,17,'MCR , IIITB',113,NULL,3,NULL,12000,27,1,2),(2,17,'MCR , IIITB',116,NULL,3,NULL,1700,27,1,1);
/*!40000 ALTER TABLE `buyers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carts` (
  `carts_id` int(11) NOT NULL AUTO_INCREMENT,
  `cart_user_id` int(11) DEFAULT NULL,
  `cart_item_id` int(11) DEFAULT NULL,
  `cart_quantity` int(11) DEFAULT NULL,
  `cart_price` float DEFAULT NULL,
  `cart_item_quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`carts_id`),
  KEY `cart_user_fk_idx` (`cart_user_id`),
  KEY `cart_item_fk_idx` (`cart_item_id`),
  CONSTRAINT `cart_item_fk` FOREIGN KEY (`cart_item_id`) REFERENCES `items` (`items_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cart_user_fk` FOREIGN KEY (`cart_user_id`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `cat_subcat`
--

DROP TABLE IF EXISTS `cat_subcat`;
/*!50001 DROP VIEW IF EXISTS `cat_subcat`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `cat_subcat` (
  `category_id` tinyint NOT NULL,
  `category_name` tinyint NOT NULL,
  `subcategory_id` tinyint NOT NULL,
  `subcategory_name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Audio , Home Entertainment'),(2,'Cameras , Optics'),(3,'Data Storage'),(4,'Fashion'),(5,'Home , Living'),(6,'Laptops , Computer Peripherals'),(7,'Mobile Phones , Accessories'),(8,'Fragrances , Beauty , Health'),(9,'Other'),(10,'Jewellery');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories_subcategories`
--

DROP TABLE IF EXISTS `categories_subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories_subcategories` (
  `cat_subcat_id` int(11) NOT NULL,
  `cat_id` int(11) DEFAULT NULL,
  `subcat_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`cat_subcat_id`),
  KEY `cat_fk_idx` (`cat_id`),
  KEY `subcat_fk_idx` (`subcat_id`),
  CONSTRAINT `cat_fk` FOREIGN KEY (`cat_id`) REFERENCES `categories` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `subcat_fk` FOREIGN KEY (`subcat_id`) REFERENCES `subcategories` (`subcategory_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories_subcategories`
--

LOCK TABLES `categories_subcategories` WRITE;
/*!40000 ALTER TABLE `categories_subcategories` DISABLE KEYS */;
INSERT INTO `categories_subcategories` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(6,2,6),(7,2,7),(8,3,8),(9,3,9),(10,3,10),(11,3,11),(12,4,12),(13,4,13),(14,4,14),(15,4,15),(16,5,16),(17,5,17),(18,5,18),(19,5,19),(20,6,20),(21,6,21),(22,6,22),(23,7,23),(24,7,24),(25,7,25),(26,7,26),(27,8,27),(28,8,28),(29,8,29),(30,8,30),(31,9,31),(32,9,32),(33,9,33),(34,9,34),(35,2,35),(36,6,36),(37,9,-1),(38,9,-1),(39,9,41),(40,10,-1),(41,10,42);
/*!40000 ALTER TABLE `categories_subcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deals`
--

DROP TABLE IF EXISTS `deals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deals` (
  `deal_id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_item_one` int(11) DEFAULT NULL,
  `deal_item_two` int(11) DEFAULT NULL,
  `deal_item_free` int(11) DEFAULT NULL,
  `deal_seller_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`deal_id`),
  KEY `deal_seller_id_fk_idx` (`deal_seller_id`),
  KEY `deal_item_one_fk_idx` (`deal_item_one`),
  KEY `deal_item_two_fk_idx` (`deal_item_two`),
  KEY `deal_item_free_fk_idx` (`deal_item_free`),
  CONSTRAINT `deal_item_free_fk` FOREIGN KEY (`deal_item_free`) REFERENCES `items` (`items_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `deal_item_one_fk` FOREIGN KEY (`deal_item_one`) REFERENCES `items` (`items_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `deal_item_two_fk` FOREIGN KEY (`deal_item_two`) REFERENCES `items` (`items_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `deal_seller_id` FOREIGN KEY (`deal_seller_id`) REFERENCES `sellers` (`seller_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deals`
--

LOCK TABLES `deals` WRITE;
/*!40000 ALTER TABLE `deals` DISABLE KEYS */;
INSERT INTO `deals` VALUES (11,2,3,95,1),(45,113,116,113,27);
/*!40000 ALTER TABLE `deals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `items_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` char(7) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `item_desc` varchar(500) DEFAULT NULL,
  `item_price` double DEFAULT NULL,
  `item_picture` varchar(100) DEFAULT NULL,
  `item_adv` tinyint(4) DEFAULT NULL,
  `item_cat_id` int(11) DEFAULT NULL,
  `item_subcat_id` int(11) DEFAULT NULL,
  `item_seller_id` int(11) DEFAULT NULL,
  `item_discount` double DEFAULT NULL,
  `item_quantity_available` int(11) DEFAULT NULL,
  `item_sold` int(11) DEFAULT NULL,
  `item_warranty_period` varchar(50) DEFAULT NULL,
  `item_color` varchar(45) DEFAULT NULL,
  `item_condition` varchar(45) DEFAULT NULL,
  `item_weight` double DEFAULT NULL,
  `item_brand` varchar(45) DEFAULT NULL,
  `item_expiry_date` date DEFAULT NULL,
  `item_advertisement_cost` float DEFAULT NULL,
  `item_advertisement_from` date DEFAULT NULL,
  `item_advertisement_to` date DEFAULT NULL,
  `is_deal_item` tinyint(4) DEFAULT '0',
  `item_deal_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`items_id`),
  UNIQUE KEY `item_id_UNIQUE` (`item_id`),
  KEY `item_category_fk_idx` (`item_cat_id`),
  KEY `item_subcategory_fk_idx` (`item_subcat_id`),
  KEY `item_seller_fk_idx` (`item_seller_id`),
  CONSTRAINT `item_category_fk` FOREIGN KEY (`item_cat_id`) REFERENCES `categories` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `item_seller_fk` FOREIGN KEY (`item_seller_id`) REFERENCES `users` (`users_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `item_subcategory_fk` FOREIGN KEY (`item_subcat_id`) REFERENCES `subcategories` (`subcategory_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (2,'I102','Sony Bravia KLV','BRAND NEW! SONY 22\" KLV-22P402C FULL HD LED TV With SONY INDIA Warranty',959,'eclipse10.png',1,1,1,1,20,10,2,'1 year','black','',183,'Sony','2016-04-06',0,NULL,NULL,1,NULL),(3,'I103','SONY 22\" KLV-22P402C','New LG 32\" LED HD 32LF515A TV USB Movie LG LED TV 1 Yr LG India Warranty',2000,'eclipse11.png',0,1,1,1,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(4,'I201','XBOX ONE 500GB','BRAND NEW SEALED XBOX ONE 500GB CONSOLE FIFA 16 BUNDLE OFFICIAL INDIAN STOCK',1250,'eclipse12.png',1,1,2,2,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(5,'I202','SONY PSP PlayStation','SONY PSP PlayStation Portable E1004 CB Black or white Gaming Console 1game free',1575,'eclipse26.png',1,1,2,2,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(6,'I301','Philips Volcano SPA7000B','Philips Volcano SPA7000B/94 USB/SD/FM/Bluetooth (5.1CH Speaker System)',420,'eclipse13.png',0,1,3,3,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(7,'I401','Portable Bluetooth MP3','New Portable Bluetooth MP3+FM+SD+Mini Stereo Rechargable Speaker Device - BE-13.',23,'eclipse14.png',0,1,4,3,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(8,'I501','Sony SLT-A58','Sony SLT-A58 18-135mm Lens',740,'eclipse15.png',0,2,0,4,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,'I601','Camera Video Tripod Stand','SIMPEX 222 CAMERA VIDEO TRIPOD STAND FOR SLR DSLR',15,'eclipse16.png',0,2,6,4,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(10,'I104','Micromax 20B2','Micromax 20B22HD 20\'\' LED Television',250,'eclipse23.png',1,1,1,2,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(11,'I1201','Men\'s Leather Jacker','MEN\'S LEATHER JACKET 100% PURE BLACK LEATHER JACKET #MJ06',110,'eclipse20.png',0,4,12,3,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(49,'145','Edjoe Men\'s Shirt','Edjoe Men\'s Mauve Stripes Slim Fit Casual/Party Wear shirt, BLEDMS0033\r\nSize Available: S, M, L, Easy Return/Exchange',20,'eclipse19.png',0,4,12,7,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(50,'101','Reebok Shoes','Light Weight',89,'eclipse21.png',1,4,14,7,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(51,'201','Puma Shoes','Running Shoes',79,'eclipse22.png',0,4,14,7,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(52,'146','BABY POOL BATH ','INFLATABLE BABY POOL BATH WATER TUB FOR KIDS\r\nGeniue quality Fast Shipping Also On COD Available\r\n',25,'eclipse27.png',1,9,34,7,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(53,'212',' Apple Watch 42mm ','Deal 08: New Imported Apple Watch 42mm Space Gray Case Black Sport Band MJ3T2\r\n6 months International Warranty',300,'eclipse31.png',1,4,13,7,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(55,'455','Blackberry Z3','Blackberry Z3 - 8 GB - Black - Smartphone',300,'eclipse32.png',0,7,23,7,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(56,'1056','Pen drive','sdbsdkbjkgjk',84655,'eclipse33.png',0,3,10,7,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(95,'505','Himalaya Neem Face Wash','50 ML PACK OF 3 pcs',201,'eclipse505.png',1,8,30,1,10,3,2,'1 year','','',50,'Himalaya',NULL,0,NULL,NULL,1,NULL),(96,'112','Dell Original Laptop Backpack Bag','By Targus !6 Lowest Price @ Rs 678 /Black\r\n100% imported Genuine With free shipping & warranty ',25000,'eclipse112.png',0,6,22,15,25,10,NULL,'6 months','Black','',500,'DELL',NULL,0,NULL,NULL,1,'31'),(97,'L653','Toshiba Laptop','4 GB RAM, 500 GB Hard Disk New',25000,'eclipseL653.png',1,6,36,16,10,5,NULL,'1 year','Red','New',0,'Toshiba',NULL,NULL,NULL,NULL,0,NULL),(103,'I101','LG 32\" LED HD 32LF550A TV USB Movie','New LG 32\" LED HD 32LF550A TV USB Movie LG LED TV 1 Yr LG India Warranty',21800,'eclipseI101.png',0,1,1,19,15,5,NULL,'Manufacturer Warranty','','New',0,'LG',NULL,NULL,NULL,NULL,0,NULL),(104,'I110','HP 240G4-328TX','POWERFUL, BEAUTIFUL LAPTOP, NViDiA Graphics 2GB',42000,'eclipseI110.png',0,6,36,19,30,1,NULL,'1 year','Black','New',0,'HP',NULL,NULL,NULL,NULL,0,NULL),(105,'I111','CANON EF MOUNT','CLEAN RMC Tokina 300mm f5.6',4600,'eclipseI111.png',1,2,35,19,10,1,NULL,'1 year','Black','New',0,'Canon',NULL,NULL,NULL,NULL,0,NULL),(106,'I112','Curtains','Best till dqte',50000,'eclipseI112.png',1,5,19,15,95,1,NULL,'Life Long','White','New',200,'Bombay Dying',NULL,NULL,NULL,NULL,0,'33'),(107,'1223','dfh','c xjj',123,'eclipse1223.png',0,3,11,15,0,1,NULL,'','','',0,'',NULL,0,'2016-04-01',NULL,0,NULL),(109,'798','dfh','kbgiubglb',98,'eclipse798.png',1,1,2,15,0,1,NULL,'7 months','','',0,'',NULL,0,'2016-04-18',NULL,1,NULL),(110,'45','vAS','sdDVSV',234,'eclipse45.png',1,2,6,15,12,12,NULL,'6 months','','',0,'',NULL,0,'2016-04-18','2016-04-25',0,'33'),(111,'12','Test','akCC',10000,'eclipse12.png',1,1,0,15,3,11,NULL,'6 months','','',0,'',NULL,1500,'2016-04-18','2016-04-21',0,'32'),(112,'13','HD','good',4500,'eclipse13.png',1,3,10,15,0,12,NULL,'6 months','','',0,'','2016-04-25',2475,'2016-04-19','2016-04-30',0,'33'),(113,'Note3','Xiaomi Redmi Note 3','Finger print Scanner',12000,'eclipseNote3.png',1,7,23,27,0,9,2,'1 Year','Gold','',147,'Xiaomi ','2016-05-01',0,NULL,NULL,1,'45'),(114,'Le1s','Le 1s','Latest Android Phone',11000,'eclipseLe1s.png',1,7,23,27,10,3,12,'1 Year','Silver ','New',167,'LeEco ',NULL,66000,'2016-04-18','2016-04-30',0,'43'),(115,'SonyPd','Sony 32 GB Pen Drive','Fast USB 3.0 Flash Pen Drive',645,'eclipseSonyPd.png',0,3,8,27,0,83,17,'6 months','Silver','New',0,'SONY',NULL,322.5,NULL,NULL,0,'44'),(116,'Fast','Fast Track Watch','Cool Blue coloured fast track watch',1700,'eclipseFast.png',1,4,13,27,0,9,1,'1 Year','Blue','',0,'Fasttrack',NULL,10200,'2016-04-18','2016-04-30',1,'45'),(117,'CrackI','Cracking The Coding Interview','Best book for programming.',800,'eclipseCrackI.png',1,9,32,27,5,20,NULL,'6 months','White','New',500,'',NULL,40,'2016-04-18','2016-04-30',0,'40'),(118,'D1','Dlink Wireless Router','Dlink wireless router des',1500,'eclipseD1.png',0,6,21,27,0,15,NULL,'','Black','New',0,'',NULL,750,NULL,NULL,0,'40'),(119,'122','Solitaire Diamond Ring','1.00 Ct Solitaire Ring Diamond Look Ring 14K Hallmark Gold Ring Diamond Rings',8100,'eclipse122.png',0,10,42,27,2,12,NULL,'1 Year','Gold','New',1,' Panache','2017-11-30',4050,NULL,NULL,0,NULL),(120,'23','White Gold Ring','\r\n    Certified-14k-Hallmarked-White-Gold-Ring-0-11-Carat-Natural-Real-Diamond-Ring',14196,'eclipse23.png',1,10,42,27,5,15,NULL,'1 Year','White','',2,'Forever Carat','2016-04-30',0,NULL,NULL,0,NULL),(121,'25','The Cleopatra Bracelet','40% discount on IGI certified diamond jewellery',52024,'eclipse25.png',1,10,42,27,12,17,NULL,'6 months','Gold','New',2,'Sarvada Jewels','2016-04-30',78036,'2016-04-27','2016-04-30',0,NULL),(122,'43','Nike Air Jordan','NEW DS NIKE AIR Jordan Retro 12 XII Black THE MASTER Sizes 4 -15',42510,'eclipse43.png',1,4,14,27,4,5,NULL,'1 Year','Black','',0,'',NULL,42510,'2016-04-27','2016-04-29',0,NULL);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `logs_id` int(11) NOT NULL AUTO_INCREMENT,
  `log_message` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`logs_id`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES (1,'Item with ID : I1204 is deleted'),(7,'Item with ID : I505 is deleted'),(8,'Item with ID : I205 is deleted'),(9,'Item with ID : I105 is deleted'),(10,'Item with ID : I105 is deleted'),(11,'Item with ID : 45 is deleted'),(12,'Item with ID : 89 is deleted'),(13,'Item with ID : 56 is added'),(14,'Item with ID : 58 is added'),(15,'Category with ID : 10 is deleted'),(16,'Category with ID : 10 is deleted'),(17,'Category with ID : 10 is deleted'),(18,'Item with ID : I10 is deleted'),(19,'Category with ID : 10 is deleted'),(20,'Category with ID : 10 is edited successfully'),(21,'Subcategory jsdbkbkdskjgwith ID40  is added successfully'),(22,'User with ID : S107 is registered'),(23,'User with ID : s109 is registered'),(24,'User with ID : s109 is registered'),(25,'User with ID : S111 is registered'),(26,'User with ID : S114 is registered'),(27,'User with ID : s1115 is registered'),(28,'User with ID : s115 is registered'),(29,'Item with ID : 59 is added'),(30,'Item with ID : 110 is deleted'),(31,'User with ID : s116 is registered'),(32,'Item with ID : 60 is added'),(33,'SubCategory with ID : 40 is Edited'),(34,'User with ID : s222 is registered'),(35,'Category with ID : 11 is Added'),(36,'Category with ID : 11 is Deleted'),(37,'Subcategory jwelwith ID : 41  is Added'),(38,'SubCategory with ID : 41 is Deleted'),(39,'Item with ID : 61 is added'),(40,'Category with ID : 11 is Added'),(41,'Category with ID : 12 is Added'),(42,'Category with ID : 13 is Added'),(43,'Category with ID : 10 is Added'),(44,'Subcategory Sharmawith ID : 41  is Added'),(45,'Category with ID : 10 is Deleted'),(46,'SubCategory with ID : 41 is Deleted'),(47,'Category with ID : 10 is Added'),(48,'Subcategory Bookswith ID : 41  is Added'),(49,'User with ID : slof is registered'),(50,'Item with ID : 62 is added'),(51,'Item with ID : 1012 is deleted'),(52,'User with ID : iihi is registered'),(53,'User with ID : 990 is registered'),(54,'Item with ID : 63 is added'),(55,'Item with ID : 67 is added'),(56,'Item with ID : 69 is added'),(57,'Item with ID : 70 is added'),(58,'Item with ID : 71 is added'),(59,'Item with ID : 80 is added'),(60,'Item with ID : 82 is added'),(61,'Item with ID : 83 is added'),(62,'User with ID : 23 is registered'),(63,'User with ID : adi is registered'),(64,'User with ID : adi is registered'),(65,'User with ID : s1012 is registered'),(66,'User with ID : s1012 is registered'),(67,'User with ID : 101 is registered'),(68,'User with ID : 123 is registered'),(69,'User with ID : 123 is registered'),(70,'User with ID : 123 is registered'),(71,'User with ID : sd is registered'),(72,'User with ID : a is registered'),(73,'Item with ID : 84 is added'),(74,'Item with ID : 0 is added'),(75,'Item with ID : 85 is added'),(76,'Item with ID : 86 is added'),(77,'Item with ID : 87 is added'),(78,'Item with ID : I5623 is deleted'),(79,'Category with ID : 10 is Deleted'),(80,'User with ID : NewSeller01 is registered'),(81,'Item with ID : 87 is added'),(82,'Item with ID : 88 is added'),(83,'Item with ID : 90 is added'),(84,'Item with ID : 95 is added'),(85,'Seller with ID : S10 is registered'),(86,'Seller with ID : rohit@gmail.com is registered'),(87,'Seller with ID : rahul@gmail.com is registered'),(88,'Item with ID : 96 is added'),(89,'Seller with ID : ramesh@gmail.com is registered'),(90,'Item with ID : 97 is added'),(91,'User with email : anubhav@gmail.com is registered'),(92,'Item with ID : 98 is added'),(93,'Item with ID : 101 is added'),(94,'Item with ID : 102 is added'),(95,'Seller with ID : aditya@gmail.com is registered'),(96,'Seller with ID : aditya@gmail.com is registered'),(97,'Item with ID : 103 is added'),(98,'Item with ID : 104 is added'),(99,'Item with ID : 105 is added'),(100,'User with email : dinesha@gmail.com is registered'),(101,'Item with ID : 106 is added'),(102,'User with email : pushp.ranjan@iiitb.org is registered'),(103,'Seller with ID : pushp.ranjan@iiitb.org is registered'),(104,'User with email : Aditya.Tiwari@iiitb.org is registered'),(105,'Seller with ID : Aditya.Tiwari@iiitb.org is registered'),(106,'User with email : dinesha@iiitb.ac.in is registered'),(107,'Seller with ID : Anubhav.022@iiitb.org is registered'),(108,'Seller with ID : Rahul.Kumar@iiitb.org is registered'),(109,'Seller with ID :  is registered'),(110,'Item with ID : 107 is added'),(111,'Item with ID : 109 is added'),(112,'Item with ID : 110 is added'),(113,'Item with ID : 111 is added'),(114,'Item with ID : 112 is added'),(115,'VAT value updated to 5.2 %'),(116,'Advertisement cost updated to 5 %'),(117,'Advertisement cost updated to 0.05 %'),(118,'Advertisement cost updated to 0.5 %'),(119,'Deal with IDs :  2, 3, 2  is Added'),(120,'Deal with Deal_Id :  6  is deleted'),(121,'Deal with Deal_Id :  7  is deleted'),(122,'Deal with Deal_Id :  8  is deleted'),(123,'Deal with IDs :  2, 3, 2  is Added'),(124,'Deal with IDs :  95, 95, 95  is Added'),(125,'Deal with Deal_Id :  10  is deleted'),(126,'Deal with Deal_Id :  9  is deleted'),(127,'Deal with IDs :  2, 3, 95  is Added'),(128,'Deal with IDs :  50, 51, 50  is Added'),(129,'Deal with IDs :  53, 55, 56  is Added'),(130,'Deal with IDs :  106, 107, 110  is Added'),(131,'Deal with Deal_Id :  15  is deleted'),(132,'Deal with Deal_Id :  16  is deleted'),(133,'Deal with IDs :  103, 104, 105  is Added'),(134,'Deal with Deal_Id :  22  is deleted'),(135,'Deal with IDs :  96, 109, 111  is Added'),(136,'Deal with IDs :  111, 111, 112  is Added'),(137,'Deal with Deal_Id :  21  is deleted'),(138,'Deal with Deal_Id :  32  is deleted'),(139,'Deal with IDs :  106, 110, 112  is Added'),(140,'Seller with ID : Sanchit.Pande@iiitb.org is registered'),(141,'Item with ID : 113 is added'),(142,'Item with ID : 114 is added'),(143,'Item with ID : 115 is added'),(144,'Item with ID : 116 is added'),(145,'Item with ID : 117 is added'),(146,'Item with ID : 118 is added'),(147,'Deal with IDs :  113, 116, 115  is Added'),(148,'Deal with IDs :  114, 118, 117  is Added'),(149,'User with email : sanchit.pande23@gmail.com is registered'),(150,'Deal with Deal_Id :  35  is deleted'),(151,'Deal with IDs :  114, 118, 117  is Added'),(152,'Deal with Deal_Id :  34  is deleted'),(153,'Deal with IDs :  113, 113, 113  is Added'),(154,'Deal with IDs :  115, 115, 116  is Added'),(155,'Deal with Deal_Id :  37  is deleted'),(156,'Deal with Deal_Id :  36  is deleted'),(157,'Deal with IDs :  113, 114, 113  is Added'),(158,'Deal with IDs :  117, 118, 118  is Added'),(159,'Deal with Deal_Id :  38  is deleted'),(160,'Deal with Deal_Id :  39  is deleted'),(161,'Deal with Deal_Id :  40  is deleted'),(162,'Deal with IDs :  113, 113, 113  is Added'),(163,'Deal with IDs :  114, 115, 115  is Added'),(164,'Deal with Deal_Id :  42  is deleted'),(165,'Deal with IDs :  114, 115, 114  is Added'),(166,'Deal with Deal_Id :  41  is deleted'),(167,'Deal with Deal_Id :  43  is deleted'),(168,'Deal with Deal_Id :  33  is deleted'),(169,'Deal with IDs :  113, 115, 113  is Added'),(170,'Deal with Deal_Id :  44  is deleted'),(171,'Deal with IDs :  113, 116, 113  is Added'),(172,'Category with ID : 10 is Added'),(173,'Subcategory Diamond Jewellerywith ID : 42  is Added'),(174,'Item with ID : 119 is added'),(175,'Item with ID : 120 is added'),(176,'Item with ID : 121 is added'),(177,'Item with ID : 122 is added');
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref`
--

DROP TABLE IF EXISTS `ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ref` (
  `ref_id` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(100) NOT NULL,
  `ref_topic` varchar(30) NOT NULL,
  PRIMARY KEY (`ref_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref`
--

LOCK TABLES `ref` WRITE;
/*!40000 ALTER TABLE `ref` DISABLE KEYS */;
INSERT INTO `ref` VALUES (1,'raps.in','ebay Project'),(2,'http://stackoverflow.com/questions/12674064/how-to-save-a-bufferedimage-as-a-file','Image Store & Retrieval'),(3,'http://www.java4s.com/ajax/ajax-onchange-fetch-the-data-from-the-database/','Dynamic fetch from database');
/*!40000 ALTER TABLE `ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `report`
--

DROP TABLE IF EXISTS `report`;
/*!50001 DROP VIEW IF EXISTS `report`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report` (
  `item_id` tinyint NOT NULL,
  `item_name` tinyint NOT NULL,
  `item_cat_id` tinyint NOT NULL,
  `item_subcat_id` tinyint NOT NULL,
  `seller_id` tinyint NOT NULL,
  `seller_name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sellers`
--

DROP TABLE IF EXISTS `sellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sellers` (
  `sellers_id` int(11) NOT NULL AUTO_INCREMENT,
  `seller_id` int(11) DEFAULT NULL,
  `seller_name` varchar(45) DEFAULT NULL,
  `seller_address` varchar(45) DEFAULT NULL,
  `seller_contact_no` varchar(45) DEFAULT NULL,
  `seller_email` varchar(45) DEFAULT NULL,
  `seller_nature_of_business` varchar(45) DEFAULT NULL,
  `seller_category_id` int(11) DEFAULT NULL,
  `seller_one_star` int(11) DEFAULT NULL,
  `seller_two_star` int(11) DEFAULT NULL,
  `seller_three_star` int(11) DEFAULT NULL,
  `seller_four_star` int(11) DEFAULT NULL,
  `seller_five_star` int(11) DEFAULT NULL,
  PRIMARY KEY (`sellers_id`),
  KEY `seller_id_fk_idx` (`seller_id`),
  CONSTRAINT `seller_id_fk` FOREIGN KEY (`seller_id`) REFERENCES `users` (`users_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sellers`
--

LOCK TABLES `sellers` WRITE;
/*!40000 ALTER TABLE `sellers` DISABLE KEYS */;
INSERT INTO `sellers` VALUES (1,1,'Jane Doe',NULL,'9856475891','jane.doe@gmail.com','Home Entertainment',1,5,2,3,5,11),(2,13,'John Doe','Electronics City','99999988','johndoe@gmail.com','1',7,1,5,3,2,1),(5,15,'Rahul Kumar','IIITB','999999999','rahul@gmail.com','1',3,1,2,5,2,4),(6,16,'Ramesh','West Bengal 6123','12341234','ramesh@gmail.com','1',7,2,5,1,1,3),(7,7,'Rohit Chouhan','IIITB','888888888','rohit@gmail.com','1',5,3,4,2,1,4),(8,19,'Aditya Tiwari','439, IIITB','999999999','aditya@gmail.com','1',7,3,1,4,6,2),(9,21,'Pushp Ranjan','506, IIITB','989898989','pushp.ranjan@iiitb.org','1',3,1,4,2,6,5),(10,22,'Aditya Tiwari','439, IIITB','999999999','Aditya.Tiwari@iiitb.org','1',7,NULL,NULL,NULL,NULL,NULL),(11,24,'John Abrahim','Mumbai','467476676','Anubhav.022@iiitb.org','1',4,NULL,NULL,NULL,NULL,NULL),(12,25,'Rahul Kumar','508, IIITB','9999999999','Rahul.Kumar@iiitb.org','1',1,NULL,NULL,NULL,NULL,NULL),(13,26,'','IIIT Bangalore','9999999999','','1',5,NULL,NULL,NULL,NULL,NULL),(14,27,'Sanchit Pande','IIIT Banglore 26/C ','940752339','Sanchit.Pande@iiitb.org','2',0,NULL,2,NULL,NULL,4);
/*!40000 ALTER TABLE `sellers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subcategories`
--

DROP TABLE IF EXISTS `subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subcategories` (
  `subcategory_id` int(11) NOT NULL,
  `subcategory_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`subcategory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subcategories`
--

LOCK TABLES `subcategories` WRITE;
/*!40000 ALTER TABLE `subcategories` DISABLE KEYS */;
INSERT INTO `subcategories` VALUES (-1,NULL),(0,'Extra'),(1,'LCD, LED & Televisions'),(2,'Gaming Consoles'),(3,'Home Theatre & Accessories'),(4,'Portable Audio & Video'),(6,'Camera, Camcorder Accessories'),(7,'Film Cameras, SLRs'),(8,'Pen Drives'),(9,'Memory Cards'),(10,'Hard Drives'),(11,'Internal Hard Drives'),(12,'Clothing & Accessories'),(13,'Watches'),(14,'Shoes'),(15,'Jewellery & Precious Stones'),(16,'Kitchen & Dining'),(17,'Furniture'),(18,'Home Appliances'),(19,'Home Decor'),(20,'iPads & Tablets'),(21,'Wireless Networking'),(22,'PC Tools & Laptop Accessories'),(23,'Mobile Phones'),(24,'Mobile Accessories'),(25,'Cases, Pouches'),(26,'Bluetooth Devices'),(27,'Bath and Spa'),(28,'Perfumes'),(29,'Make Up'),(30,'Body & Skin Care'),(31,'Auto Accessories & Parts'),(32,'Books & Magazines'),(33,'Fitness & Sports'),(34,'Toys, Games & Baby'),(35,'SLR Camera Lenses'),(36,'Laptops'),(39,'Othersss'),(40,'hello'),(41,'Books'),(42,'Diamond Jewellery');
/*!40000 ALTER TABLE `subcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `users_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(45) NOT NULL,
  `user_name` varchar(20) NOT NULL,
  `user_email` varchar(45) DEFAULT NULL,
  `user_password` varchar(45) DEFAULT NULL,
  `user_type` int(11) DEFAULT NULL COMMENT '0 - admin\n1 - buyer\n2 - buyer becomes seller',
  `user_balance` double DEFAULT '10000',
  PRIMARY KEY (`users_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'S101','Jane Doe','jane.doe@gmail.com','janedoe',2,286465.08),(2,'S102','Ezra Carral','ezra.carral@gmail.com','ezra',1,1500),(3,'S103','Tom Maines','tom.maines@gmail.com','tom',1,1500),(4,'S104','Eddie Bruton','eddie.bruton@gmail.com','eddie',1,1500),(7,'s105','Rohit Chouhan','rohit@gmail.com','rohit',2,541),(8,'NewSeller01','John T','johnt@gmail.com','john',1,1500),(13,'S10','John Doe','john.doe@gmail.com','john',2,696),(14,'5.2','0.5','admin','admin',0,193432.195),(15,'S106','Rahul','rahul@gmail.com','rahul',2,44073.845),(16,'L123','Ramesh','ramesh@gmail.com','l123',2,0),(17,'U123','Anubhav Sharma','anubhav@gmail.com','anubhav',1,915117.865),(19,'S100','Aditya Tiwari','aditya@gmail.com','aditya',2,0),(20,'u124','Dinesha KV','dinesha@gmail.com','password',1,5000),(21,'U111','Pushp Ranjan','pushp.ranjan@iiitb.org','sdssdsd',2,0),(22,'U112','Aditya Tiwari','Aditya.Tiwari@iiitb.org','aditya',2,0),(23,'Dinesha','Dinesha KV','dinesha@iiitb.ac.in','dinesha',1,0),(24,'S12','John Abrahim','Anubhav.022@iiitb.org','password',2,0),(25,'S122','Rahul Kumar','Rahul.Kumar@iiitb.org','rahul',2,0),(26,'','','','',2,0),(27,'Sanchit','Sanchit Pande','Sanchit.Pande@iiitb.org','sanchit',2,26324),(28,'sp','Sanchit  Pande','sanchit.pande23@gmail.com','sanchit',1,37376);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `cat_subcat`
--

/*!50001 DROP TABLE IF EXISTS `cat_subcat`*/;
/*!50001 DROP VIEW IF EXISTS `cat_subcat`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `cat_subcat` AS select `c`.`category_id` AS `category_id`,`c`.`category_name` AS `category_name`,`s`.`subcategory_id` AS `subcategory_id`,`s`.`subcategory_name` AS `subcategory_name` from ((`categories` `c` join `subcategories` `s`) join `categories_subcategories` `cs`) where ((`cs`.`cat_id` = `c`.`category_id`) and (`cs`.`subcat_id` = `s`.`subcategory_id`)) order by `c`.`category_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `report`
--

/*!50001 DROP TABLE IF EXISTS `report`*/;
/*!50001 DROP VIEW IF EXISTS `report`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `report` AS select `items`.`item_id` AS `item_id`,`items`.`item_name` AS `item_name`,`items`.`item_cat_id` AS `item_cat_id`,`items`.`item_subcat_id` AS `item_subcat_id`,`sellers`.`seller_id` AS `seller_id`,`sellers`.`seller_name` AS `seller_name` from (`items` join `sellers`) where (`items`.`item_seller_id` = `sellers`.`seller_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-27 23:09:49
