//
//  DataController.m
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 03/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import "DataController.h"

@implementation DataController

-(void)initDataBase{
   // Create a string containing the full path to the sqlite.db inside the documents folder
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    databasePath = [documentsDirectory stringByAppendingPathComponent:@"touristGuide.db"];
    
    // Check to see if the database file already exists
    bool databaseAlreadyExists = [[NSFileManager defaultManager] fileExistsAtPath:databasePath];
    NSLog(@"DataBasePath: %@", databasePath);
    
    // Create the database if it doesn't yet exists in the file system
    if (!databaseAlreadyExists)
    {
        // Open the database and store the handle as a data member
        if (sqlite3_open([databasePath UTF8String], &databaseHandle) == SQLITE_OK)
        {
            // Create all tables
            
            const char *sql = "DROP TABLE IF EXISTS 'city';CREATE TABLE 'city' ('id' INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , 'name' TEXT, 'idCountry' INTEGER);INSERT INTO 'city' VALUES(1,'Yucatan',1);INSERT INTO 'city' VALUES(2,'Rome',2);INSERT INTO 'city' VALUES(3,'Rio de Janeiro',3);INSERT INTO 'city' VALUES(4,'East of China',4);INSERT INTO 'city' VALUES(5,'Cusco Region',5);INSERT INTO 'city' VALUES(6,'Ma''an Governorate',6);INSERT INTO 'city' VALUES(7,'Agra, Uttar Pradesh',7);INSERT INTO 'city' VALUES(8,'Giza',8);INSERT INTO 'city' VALUES(9,'Mexico City',1);INSERT INTO 'city' VALUES(10,'Chihuahua',1);INSERT INTO 'city' VALUES(11,'Acapulco',1);INSERT INTO 'city' VALUES(12,'Guanajuato City',1);INSERT INTO 'city' VALUES(13,'Tuscany',2);INSERT INTO 'city' VALUES(14,'Cinque Terre',2);INSERT INTO 'city' VALUES(15,'Siena',2);INSERT INTO 'city' VALUES(16,'Venice',2);INSERT INTO 'city' VALUES(17,'Border betwen Argentina and Brazil',3);INSERT INTO 'city' VALUES(18,'Rio de Janeiro',3);INSERT INTO 'city' VALUES(19,'Northeastern Coast',3);INSERT INTO 'city' VALUES(20,'Lhasa Valley',4);INSERT INTO 'city' VALUES(21,'Guangxi Province',4);INSERT INTO 'city' VALUES(22,'Sichuan',4);INSERT INTO 'city' VALUES(23,'Ica',5);INSERT INTO 'city' VALUES(24,'Arequipa',5);INSERT INTO 'city' VALUES(25,'Uros',5);INSERT INTO 'city' VALUES(26,'Trujillo',5);INSERT INTO 'city' VALUES(27,'Jerash',6);INSERT INTO 'city' VALUES(28,'Aman',6);INSERT INTO 'city' VALUES(29,'Udaipur',7);INSERT INTO 'city' VALUES(30,'Hampi',7);INSERT INTO 'city' VALUES(31,'Madhya Pradesh',7);INSERT INTO 'city' VALUES(32,'Goa',7);INSERT INTO 'city' VALUES(33,'Kerala',7);INSERT INTO 'city' VALUES(34,'Luxor',8);INSERT INTO 'city' VALUES(35,'Sinai Peninsula',8);INSERT INTO 'city' VALUES(36,'San Carlos',9);INSERT INTO 'city' VALUES(37,'Buenos Aires',9);INSERT INTO 'city' VALUES(38,'Puerto Iguazu',9);INSERT INTO 'city' VALUES(39,'Santa Cruz',9);DROP TABLE IF EXISTS 'countries';CREATE TABLE 'countries' ('id' INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , 'name' TEXT);INSERT INTO 'countries' VALUES(1,'MEXICO');INSERT INTO 'countries' VALUES(2,'ITALY');INSERT INTO 'countries' VALUES(3,'BRAZIL');INSERT INTO 'countries' VALUES(4,'CHINA');INSERT INTO 'countries' VALUES(5,'PERU');INSERT INTO 'countries' VALUES(6,'JORDAN');INSERT INTO 'countries' VALUES(7,'INDIA');INSERT INTO 'countries' VALUES(8,'EGYPT');INSERT INTO 'countries' VALUES(9,'ARGENTINA');DROP TABLE IF EXISTS 'hotels';CREATE TABLE 'hotels' ('id' INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , 'name' TEXT, 'idCountry' INTEGER, 'url' TEXT);INSERT INTO 'hotels' VALUES(1,'Lonely Planet',1,'http://www.lonelyplanet.com/mexico/hotels');INSERT INTO 'hotels' VALUES(2,'Tripadvisor',1,'http://www.tripadvisor.com.mx/Hotels');INSERT INTO 'hotels' VALUES(3,'Fiesta Inn',1,'http://www.fiestainn.com/es/home');INSERT INTO 'hotels' VALUES(4,'Hostelworld',1,'http://www.spanish.hostelworld.com/Albergues/Mexico?source=googleadwordscountrieses&kid=15036588&aid=2&sub_keyword=hostel%20mexico&sub_ad=p&sub_publisher=ADW');INSERT INTO 'hotels' VALUES(5,'Lonely Planet',2,'http://www.lonelyplanet.com/italy/hotels');INSERT INTO 'hotels' VALUES(6,'Tripadvisor',2,'http://www.tripadvisor.it/Hotels');INSERT INTO 'hotels' VALUES(7,'Holiday Inn',2,'http://www.holidayinn.com/hotels/us/es/reservation/hotelsearchresult?qAdlt=1&qBrs=6c.hi.ex.rs.ic.cp.in.sb.cw.cv&qChld=0&qDest=ROME%2CItaly&qFRA=1&qGRM=0&qIta=99612715&qPSt=0&qRRSrt=rt&qRms=1&qRpn=1&qRpp=10&qSHp=1&qSmP=3&qSrt=sBR&qWch=0&srb_u=1&icdv=99612715&sicreative=22357505603&sicontent=0&siclientid=1927&sitrackingid=496777150&dp=true');INSERT INTO 'hotels' VALUES(8,'Hostelworld',2,'http://www.spanish.hostelworld.com/alojamiento/Italia');INSERT INTO 'hotels' VALUES(9,'Lonely Planet',3,'http://www.lonelyplanet.com/brazil/hotels');INSERT INTO 'hotels' VALUES(10,'Tripadvisor',3,'http://www.tripadvisor.com.br/Hotels');INSERT INTO 'hotels' VALUES(11,'Holiday Inn',3,'http://www.holidayinn.com/hotels/us/es/reservation/hotelsearchresult?qAdlt=1&qBrs=6c.hi.ex.rs.ic.cp.in.sb.cw.cv&qChld=0&qDest=brasil&qFRA=1&qGRM=0&qIta=99612715&qLat=0&qLng=0&qPSt=0&qRRSrt=rt&qRms=1&qRpn=1&qRpp=10&qRtP=6CBARC&qSHp=1&qSmP=3&qSrt=sBR&qWch=0&srb_u=1');INSERT INTO 'hotels' VALUES(12,'Hostelworld',3,'http://www.spanish.hostelworld.com/Albergues/Brasil');INSERT INTO 'hotels' VALUES(13,'Lonely Planet',4,'http://www.lonelyplanet.com/china/hotels');INSERT INTO 'hotels' VALUES(14,'Tripadvisor',4,'http://www.daodao.com/Hotels');INSERT INTO 'hotels' VALUES(15,'Holiday Inn',4,'http://www.holidayinn.com/hotels/us/es/reservation/hotelsearchresult?qAdlt=1&qBrs=6c.hi.ex.rs.ic.cp.in.sb.cw.cv&qChld=0&qDest=China&qFRA=1&qGRM=0&qIta=99612715&qLat=39.9041&qLng=116.4075&qPSt=0&qRRSrt=rt&qRms=1&qRpn=1&qRpp=10&qRtP=6CBARC&qSHp=1&qSmP=3&qSrt=sBR&qWch=0&srb_u=1');INSERT INTO 'hotels' VALUES(16,'Hostelworld',4,'http://www.spanish.hostelworld.com/Albergues/Brasil');INSERT INTO 'hotels' VALUES(17,'Lonely Planet',5,'http://www.lonelyplanet.com/peru/hotels');INSERT INTO 'hotels' VALUES(18,'Tripadvisor',5,'http://www.tripadvisor.com.pe/Hotels');INSERT INTO 'hotels' VALUES(19,'Holiday Inn',5,'http://www.holidayinn.com/hotels/us/es/reservation/hotelsearchresult?qAdlt=1&qBrs=6c.hi.ex.rs.ic.cp.in.sb.cw.cv&qChld=0&qDest=Peru&qFRA=1&qGRM=0&qIta=99612715&qLat=0&qLng=0&qPSt=0&qRRSrt=rt&qRms=1&qRpn=1&qRpp=10&qRtP=6CBARC&qSHp=1&qSmP=3&qSrt=sBR&qWch=0&srb_u=1');INSERT INTO 'hotels' VALUES(20,'Hostelworld',5,'http://www.spanish.hostelworld.com/alojamiento/Peru');INSERT INTO 'hotels' VALUES(21,'Lonely Planet',6,'http://www.lonelyplanet.com/jordan/hotels');INSERT INTO 'hotels' VALUES(22,'Tripadvisor',6,'http://www.tripadvisor.in/Hotels-g293985-Jordan-Hotels.html');INSERT INTO 'hotels' VALUES(23,'Holiday Inn',6,'http://www.ihg.com/holidayinn/hotels/us/es/reservation/hotelsearchresult?qAdlt=1&qBrs=ic.cp.in.hi.ex.rs.cv.sb.cw.6c&qChld=0&qDest=Jordania&qFRA=1&qGRM=0&qIta=99612715&qLat=31.9566&qLng=35.9457&qPSt=0&qRRSrt=rt&qRmP=3&qRms=1&qRpn=1&qRpp=10&qRtP=6CBARC&qSHp=1&qSmP=3&qSrt=sBR&qWch=0&srb_u=1');INSERT INTO 'hotels' VALUES(24,'Hostelworld',6,'http://www.hostelworld.com/accommodation/Jordan');INSERT INTO 'hotels' VALUES(25,'Lonely Planet',7,'http://www.lonelyplanet.com/india/hotels');INSERT INTO 'hotels' VALUES(26,'Tripadvisor',7,'http://www.tripadvisor.in/hotels');INSERT INTO 'hotels' VALUES(27,'Holiday Inn',7,'http://www.holidayinn.com/hotels/us/es/reservation/hotelsearchresult?qAdlt=1&qBrs=6c.hi.ex.rs.ic.cp.in.sb.cw.cv&qChld=0&qDest=India&qFRA=1&qGRM=0&qIta=99612715&qLat=28.6354&qLng=77.225&qPSt=0&qRRSrt=rt&qRms=1&qRpn=1&qRpp=10&qRtP=6CBARC&qSHp=1&qSmP=3&qSrt=sDD&qWch=0&srb_u=1');INSERT INTO 'hotels' VALUES(28,'Hostelworld',7,'http://www.spanish.hostelworld.com/alojamiento/India');INSERT INTO 'hotels' VALUES(29,'Lonely Planet',8,'http://www.lonelyplanet.com/egypt/hotels');INSERT INTO 'hotels' VALUES(30,'Tripadvisor',8,'http://www.tripadvisor.com.eg/Hotels');INSERT INTO 'hotels' VALUES(31,'Holiday Inn',8,'http://www.ihg.com/holidayinn/hotels/us/es/reservation/hotelsearchresult?qAdlt=1&qBrs=ic.cp.in.hi.ex.rs.cv.sb.cw.6c&qChld=0&qDest=Egipto&qFRA=1&qGRM=0&qIta=99612715&qLat=0&qLng=0&qPSt=0&qRRSrt=rt&qRmP=3&qRms=1&qRpn=1&qRpp=10&qRtP=6CBARC&qSHp=1&qSmP=3&qSrt=sBR&qWch=0&srb_u=1');INSERT INTO 'hotels' VALUES(32,'Hostelworld',8,'http://www.spanish.hostelworld.com/alojamiento/Egipto');INSERT INTO 'hotels' VALUES(33,'Lonely Planet',9,'http://www.lonelyplanet.com/argentina/hotels');INSERT INTO 'hotels' VALUES(34,'Tripadvisor',9,'http://www.tripadvisor.com.mx/Hotels-g294266-Argentina-Hotels.html');INSERT INTO 'hotels' VALUES(35,'Hostelworld',9,'http://www.spanish.hostelworld.com/Albergues/Argentina?source=googleadwordsesbroad&kid=15020787&aid=2&sub_keyword=%2Bhostals%20%2Bargentina&sub_ad=b&sub_publisher=ADW');INSERT INTO 'hotels' VALUES(36,'Hosteling International',9,'http://www.hostels.org.ar/');DROP TABLE IF EXISTS 'places';CREATE TABLE 'places' ('id' INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , 'name' TEXT, 'idCity' INTEGER, 'description' TEXT, 'wonder' BOOL, 'longitude' DOUBLE, 'latitude' DOUBLE);INSERT INTO 'places' VALUES(1,'Chichen Itza',1,'Chichen Itza is located in southern Mexico on the Yucatan Peninsula, just 2 km from the town of Piste, 40 km from Valladolid, and 120 km from Merida. Its name derives from the Mayan words Chi, mouth, Che en, well, Itz, magician, and a, water, that together, form the most likely definition, wellhead of the water magicians.Chichen Itza is considered among the most important archaeological sites in Mexico, so much so that in 1988 it was added to the UNESCO World Heritage list. In 2007 it was recognized as one of the new seven wonders of the modern world, an initiative launched by the private sector.',1,-88.568736,20.683597);INSERT INTO 'places' VALUES(2,'Roman Colosseum',2,'The Roman Colosseum or Coliseum, originally known as the Flavian Amphitheatre, was commisioned in AD 72 by Emperor Vespasian. It was completed by his son, Titus, in 80, with later improvements by Domitian. The Colosseum is located just east of the Roman Forum and was built to a practical design, with its 80 arched entrances allowing easy access to 55,000 spectators, who were seated according to rank. The Coliseum is huge, an ellipse 188m long and 156 wide. Originally 240 masts were attached to stone corbels on the 4th level.',1,12.49222,41.89);INSERT INTO 'places' VALUES(3,'Christ the Redeemer',3,'Christ the Redeemer is a statue of Jesus Christ in Rio de Janeiro, Brazil, considered the largest Art Deco statue in the world. It is 30 metres (98 ft) tall, not including its 8 metres (26 ft) pedestal, and its arms stretch 28 metres (92 ft) wide. It weighs 635 tonnes (625 long, 700 short tons), and is located at the peak of the 700-metre (2,300 ft) Corcovado mountain in the Tijuca Forest National Park overlooking the city. A symbol of Brazilian Christianity, the statue has become an icon for Rio de Janeiro and Brazil. It is made of reinforced concrete and soapstone, and was constructed between 1922 and 1931.',1,-43.210278,-22.95);INSERT INTO 'places' VALUES(4,'Great Wall of China',4,'he Great Wall of China is a series of fortifications made of stone, brick, tamped earth, wood, and other materials, generally built along an east-to-west line across the historical northern borders of China in part to protect the Chinese Empire or its prototypical states against intrusions by various nomadic groups or military incursions by various warlike peoples or forces. Several walls were being built as early as the 7th century BC;[3] these, later joined together and made bigger and stronger, are now collectively referred to as the Great Wall.[4] Especially famous is the wall built between 220–206 BC by the first Emperor of China, Qin Shi Huang. Little of that wall remains. Since then, the Great Wall has on and off been rebuilt, maintained, and enhanced; the majority of the existing wall are from the Ming Dynasty',1,117.23193,40.67693);INSERT INTO 'places' VALUES(5,'Machu Picchu',5,'Machu Picchu (Quechua machu old, old person, pikchu peak; mountain or prominence with a broad base which ends in sharp peaks, old peak) is a 15th-century Inca site located 2,430 metres (7,970 ft) above sea level. It is located in the Cusco Region, Urubamba Province, Machupicchu District in Peru. It is situated on a mountain ridge above the Sacred Valley which is 80 kilometres (50 mi) northwest of Cusco and through which the Urubamba River flows. Most archaeologists believe that Machu Picchu was built as an estate for the Inca emperor Pachacuti (1438–1472). Often mistakenly referred to as the Lost City of the Incas, it is perhaps the most familiar icon of Inca civilization.',1,-72.546111,-13.16333);INSERT INTO 'places' VALUES(6,'Petra',6,'Petra is a historical and archaeological city in the southern Jordanian governorate of Ma''an that is famous for its rock-cut architecture and water conduit system. Another name for Petra is the Rose City due to the color of the stone out of which it is carved.Established possibly as early as 312 BCE as the capital city of the Nabataeans, it is a symbol of Jordan, as well as Jordan''s most-visited tourist attraction. It lies on the slope of Jebel al-Madhbah (identified by some as the biblical Mount Hor) in a basin among the mountains which form the eastern flank of Arabah (Wadi Araba), the large valley running from the Dead Sea to the Gulf of Aqaba. Petra has been a UNESCO World Heritage Site since 1985.',1,35.44333,30.33056);INSERT INTO 'places' VALUES(7,'Taj Mahal',7,'The Taj Mahal is a white marble mausoleum located in Agra, Uttar Pradesh, India. It was built by Mughal emperor Shah Jahan in memory of his third wife, Mumtaz Mahal. The Taj Mahal is widely recognized as the jewel of Muslim art in India and one of the universally admired masterpieces of the world''s heritage.Taj Mahal is regarded by many as the finest example of Mughal architecture, a style that combines elements from Islamic, Persian, Ottoman Turkish and Indian architectural styles.',1,78.042222,27.174167);INSERT INTO 'places' VALUES(8,'The Great Pyramid of Giza',8,'The Great Pyramid of Giza (also known as the Pyramid of Khufu or the Pyramid of Cheops) is the oldest and largest of the three pyramids in the Giza Necropolis bordering what is now El Giza, Egypt. It is the oldest of the Seven Wonders of the Ancient World, and the only one to remain largely intact.',0,31.134167,29.979167);INSERT INTO 'places' VALUES(9,'Teotihuacan',9,'In the 2nd century BC a new civilization arose in the valley of Mexico. This civilization built the flourishing metropolis of Teotihuacán and it’s huge pyramids. The Pyramid of the Sun was built around 100 AD and is the largest pyramid in Teotihuacán and all of Mexico. The construction of the smaller Pyramid of the Moon started a century later and was finished in 450 AD. Seven centuries after the demise of the Teotihuacán empire the pyramids were honored and utilized by the Aztecs and became a place of pilgrimage. Mesoamerica’s greatest city is just 31 miles (50km) northeast of Mexico City and can be reached by bus or taxi. ',0,-98.843179,19.693425);INSERT INTO 'places' VALUES(10,'Copper Canyon',10,'The Copper Canyon is in fact a network of canyons which together are several times larger than the Grand Canyon. The most popular way to explore the Copper Canyon is on the “Chihuahua al Pacifico” Railway. The track passes over 37 bridges and through 86 tunnels, rising as high as 2,400 meter (7,900 feet) above sea level featuring spectacular views of the canyons below.',0,-107.912937,27.216474);INSERT INTO 'places' VALUES(11,'Acapulco',11,'Acapulco is the original Mexican resort town which came into prominence by the 1950s as a getaway for Hollywood stars and millionaires. Still, Acapulco remains a popular tourist destination especially among Mexicans and as a spring break destination among US college students. No visit to Acapulco is complete without watching the cliff divers perform their impressive jumps into ocean. They have been doing it since the 1930s, although today the divers are professionals. ',0,-99.881614,16.863794);INSERT INTO 'places' VALUES(12,'Guanajuato',12,'Nestled in the mountains of the Sierra de Guanajuato lies the beautiful colonial city of Guanajuato. The city was founded in 1554 next to one of the richest silver mining areas of Mexico. The 16th-century mining boom led to the construction of beautiful haciendas and fine colonial buildings. Guanajuato streets and many colorful alleyways spread out in every direction while most of its traffic is served by a network of underground tunnels making it an excellent city for pedestrians. ',0,-101.25832,21.018111);INSERT INTO 'places' VALUES(13,'San Gimignano',13,'Nicknamed the medieval Manhatten, San Gimignano is a village in Tuscany famous for its 14 stone towers. At the height of San Gimignano’s wealth and power, more than 70 towers were built to defend the town against enemy attacks. After the plague devastated the city in 1348, San Gimignano’s power faded, which kept enemies away and preserved many of the city’s medieval towers.',0,11.043491,43.467632);INSERT INTO 'places' VALUES(14,'Manarola',14,'Mestled in the Italian Riviera, Manarola is one of the oldest towns in Cinque Terre. The “Five Lands” comprises of five villages noted for their beauty. Part of Cinque Terre charm is the lack of visible modern development. Paths, trains and boats connect the villages, and cars cannot reach it from the outside. The towns sprout out of the mountainside to provide a breathtaking view of the Mediterranean sea. ',0,9.728093,44.106509);INSERT INTO 'places' VALUES(15,'Piazza del Campo',15,'One of Europe’s greatest medieval squares, the Piazza del Campo is the principal public space of the historic center of Siena, Tuscany. It is renowned worldwide for its beauty and architectural integrity. The Palazzo Pubblico and its famous tower, as well as various palazzi signorili belonging to the wealthiest of Siena families surround the shell-shaped piazza. The twice-per-year horse-race, Palio di Siena, involves circling the Piazza del Campo, on which a thick layer of dirt has been laid, three times and usually lasts no more than 90 seconds. ',0,11.331754,43.318465);INSERT INTO 'places' VALUES(16,'Canals of Venice',16,'Referred to as “The City of Water”, Venice is the crown jewel of water cities. Romantic gondolas, and Italian architecture along the Grand Canal helped earn this status. Stitched together with over 150 canals that have become central to its character, Venice has decayed since its heyday and has more tourists than residents, but with its romantic charm it remains one of the top tourist attractions in Italy.',0,12.315515,45.440847);INSERT INTO 'places' VALUES(17,'Iguazu Falls',17,'One of the great natural wonders of the world, Iguaçu Falls is situated on the border between Brazil and Argentina. The waterfall system consists of 275 falls along the Iguazu River. The most impressive of them all is the Devil’s Throat a U-shaped with a height of 82 meter (269 ft). The falls can be reached from the cities Foz do Iguaçu in Brazil and Puerto Iguazú in Argentina, as well as from Ciudad del Este in Paraguay. On the Brazilian side there is a long walkway along the canyon with an extension to the lower base of the Devil’s Throat.',0,-54.436667,-25.695278);INSERT INTO 'places' VALUES(18,'Rio Carnival',18,'There are carnival celebrations in virtually every corner of Brazil, the best-known ones taking place in Recife together with the neighboring Olinda and Salvador. But the biggest and most famous carnival is undoubtedly the Carnival in Rio de Janeiro. The Rio Carnival attracts two million people per day on the streets and almost half a million foreigners during its 4 day celebration. The Carnival is all over the place, in the streets and squares, bars, clubs and all other venues in Rio, concluding in the spectacular Rio Samba Parade at the Sambadrome.',0,-43.20071,-22.913395);INSERT INTO 'places' VALUES(19,'Fernando de Noronha',19,'Fernando de Noronha is a beautiful archipelago with pristine beaches, landscapes and wildlife, situated 354 km (220 miles) off the northeastern coast in Brazil. The archipelago was discovered by Amerigo Vespucci in 1503 and temporarily occupied by the Dutch and French before Portugal established dominion in 1737. Today only the largest of the 21 islands is inhabited with a population of about 3,500. The islands are a Mecca for divers and snorkelers with warm waters year-round and very good visibility even at depths of 50 meters.',0,-32.411121,-3.84066);INSERT INTO 'places' VALUES(20,'Potala Palace',20,'Situated 130 meters above the Lhasa valley, the Potala Palace rises a further 170 meters and is the greatest monumental structure in all of Tibet. The construction of the present palace began in 1645 during the reign of the 5th Dalai Lama and by 1648 the Potrang Karpo, or White Palace, was completed. The Potrang Marpo, or Red Palace, was added between 1690 and 1694. The Potala Palace remained the residence of the Dalai Lama until the 14th Dalai Lama fled to India, after the Chinese invasion in 1959.',0,91.118618,29.655192);INSERT INTO 'places' VALUES(21,'Li River Cruise',21,'A Li River cruise from Guilin to Yangshuo is the highlight of any trip to northeastern Guangxi Province. The landscape is decorated with amazing hills, steep cliffs, incredible caves and farming villages, and is lined with bamboo groves. With its breathtaking scenery and taste of a life far removed from the concrete metropolis, the scenery along the Li River is one of the top tourist attractions in China.',0,111.071777,24.886436);INSERT INTO 'places' VALUES(22,'Leshan Giant Buddha',22,'The Giant Buddha of Leshan is a gigantic Buddha statue carved out of a cliff face in Sichuan, western China. Begun in the year 713 during the Tang Dynasty, the statue was not completed until the year 803, and was the effort of thousands of sculptors and workers. The Leshan Giant Buddha stands about 71 meters (233 feet) high and has three meter (11 feet) long fingers on each of its enormous resting hands.',0,105.029297,29.916852);INSERT INTO 'places' VALUES(23,'Huacachina',23,'Located near Ica, Huacachina is a tiny oasis town surrounding a small natural lake and itself surrounded by towering sand dunes. Once a playground for the Peruvian elite, these days Huacachina mostly attracts international tourists. The big draw here is the opportunity to sand board and taking dune buggy rides on the sand dunes.',0,-75.763333,-14.0875);INSERT INTO 'places' VALUES(24,'Santa Catalina Monastery',24,'Founded on October 2, 1580, the Santa Catalina Monastery in Arequipa covers a walled area of 20,000 square meters with walls, streets, walkways, stairways and small squares. The monastery is predominantly of the Mudéjar style, and is characterized by the vividly painted walls. It is one of the most important monasteries of colonial Peru and Latin America.',0,-71.536791,-16.395283);INSERT INTO 'places' VALUES(25,'Uros Islands',25,'Made of dried totora reeds, the artificial islands of the Uros are Lake Titicaca’s top tourist attraction. The lives of the Uros, a pre-Incan people, are interwoven with these reeds, which is a primary source of food and are also used to make their homes, their boats and even a reed flower tea. Reeds are added to the top of the islands constantly, about every three months, as they rot from the bottom, so the ground is always soft and springy. ',0,-69.968992,-15.818668);INSERT INTO 'places' VALUES(26,'Trujillo',26,'Trujillo is a moderately large city in Northwestern Peru, near the Pacific Coast. The city was founded in 1534 among 4 Chimu settlements to enable the Spanish to ally with them against the Incas. Trujillo is close to the pre-Columbian site of Chan Chan, the largest adobe city in the ancient world and the beach resort of Huanchaco. ',0,-79.021534,-8.109052);INSERT INTO 'places' VALUES(27,'Jerash',27,'Jerash is the second most popular cities visited by the tourists after Petra. According to historical records Jerash has been inhabited since 3200 BC to 1600 AD Jerash city is divided into two, old city and new city. Old city or old city is a city which is the ancient Roman heritage building. While the new cityatau new town is where the population now lives Jordan.	City of Jerash has another attraction. Here can be found in various places such as the Oval Plaza meeting. Large field oval, surrounded by towering masts. This ancient city also has a magnificent theater, called the South Theater. Its uniqueness, has a natural acoustic system as a loudspeaker, a typical theater building thousands of centuries ago. Each Jerash Festival was held in July featuring a variety of local and international dance.',0,35.90555,32.276902);INSERT INTO 'places' VALUES(28,'Amman City And Citadel',28,'Citadel, located on a hilltop not far from the traditional markets of Al Balad. A relic that reminds us of the Roman Empire, and the early rise of Islam Bizantinum. Remains of buildings with masts towering above the city of Amman, people said this is a relic of Hercules. The building is crumbling and in ruins. occupied by the Romans (162-166 AD), much larger than the one in Rome.',0,35.945695,31.956578);INSERT INTO 'places' VALUES(29,'Wadi Rum',28,'Wadi Rum, which is located about 320 km south of Amman is a place that can help you to imagine life on the moon or on Mars. A maze of monolithic rock as if rising from the desert floor, towering as high as 1,750 meters creating a natural challenge for serious mountaineers. Hikers can enjoy the peace of the empty spaces with no boundaries, exploring the canyons and water holes to find the image on the old stone wall 4000 yearsand many other spectacular treasures this vast wilderness. Wadi Rum is also known as the Valley of the Moon, a pink desert and jagged peaks in the south of Jordan.',0,35.426273,29.584579);INSERT INTO 'places' VALUES(30,'Lake Palace',29,'The Lake Palace in Lake Pichola in the city of Udaipur was built as a royal summer palace in the 18th century. Today it is a luxury 5 Star hotel, operating under the “Taj Hotels Resorts and Palaces”. The Lake Palace hotel operates a boat which transports guests to the hotel from a jetty at the City Palace on the east bank of Lake Pichola. The palace became famous in 1983 when it was featured in the James Bond film Octopussy, as the home of titular character.',0,73.680013,24.575414);INSERT INTO 'places' VALUES(31,'Virupaksha Temple',30,'The Virupaksha Temple in the city of Hampi started out as a small shrine and grew into a large complex under the Vijayanagara rulers. It is believed that this temple has been functioning uninterruptedly ever since the small shrine was built in the 7th century AD which makes it one of the oldest functioning Hindu temples in India.',0,76.46006,15.335036);INSERT INTO 'places' VALUES(32,'Kanha National Park',31,'Kanha National Park is among the most beautiful wildlife reserves in Asia and one of best places to catch a glimpse of a tiger in India. The lush sal and bamboo forests, grassy meadows and ravines of Kanha provided inspiration to Rudyard Kipling for his famous novel “Jungle Book” and make this one of the top attractions in India.',0,80.588279,22.298274);INSERT INTO 'places' VALUES(33,'Palolem',32,'Palolem is the most southerly of Goa’s developed beaches and also one of the most beautiful. It is a natural bay surrounded by lofty headlands on either sides, resulting in a calm, idyllic sea with a gently sloping bed. For those who believe a beach cannot be paradise without a decent selection of cheap restaurants and good hotels, a dose of nightlife and plenty of like-minded people Palolem is the place to be.',0,74.123996,15.299326);INSERT INTO 'places' VALUES(34,'Kerala backwaters',33,'The Kerala backwaters are a chain of lagoons and lakes lying parallel to the Arabian Sea coast in the Kerala state. The Kerala backwaters are home to many unique species of aquatic life including crabs, frogs and mudskippers, water birds and animals such as otters and turtles. Today, houseboat tourism is the most popular tourist activity in the backwaters, with several large Kettuvallams (traditional rice boats, now converted into floating hotels)ply the waterways.',0,77.075623,8.319156);INSERT INTO 'places' VALUES(35,'Karnak',34,'Although badly ruined, few sites in Egypt are more impressive than Karnak. It is the largest ancient religious site ever built, and represents the combined achievement of many generations of Egyptian builders. The Temple of Karnak actually consists of three main temples, smaller enclosed temples, and several outer temples located about 2.5 kilometers north of Luxor. One of most famous structures of Karnak is the Hypostyle Hall, a hall area of 5,000 m2 (50,000 sq ft) with 134 massive columns arranged in 16 rows.',0,32.65727,25.718835);INSERT INTO 'places' VALUES(36,'Red Sea Reef',35,'The Red Sea, off the coast of Egypt, is one of the most beautiful places in the world to go diving. The waters of the Red Sea are renowned for their spectacular visibility and features some of the most exotic seascapes. With its wide expanse of coral formation on the reefs, it is home to thousands of different sea creatures. Red Sea beach resorts are located on both sides of the sea, on the east side and part of the Sinai peninsula is the long established Sharm el Sheikh and its neo-hippy counterpart, Dahab. On the west coast of the Red Sea lies relatively old and touristy Hurghada and a cluster of new resort towns.',0,34.513634,28.509135);INSERT INTO 'places' VALUES(37,'River Nile Cruise',34,'Cruising the Nile is a popular way of visiting upper Egypt. The Nile River has been Egypt’s lifeline since ancient times and there is no better way to trace the passage of Egypt’s history than to follow the course of the Nile. Almost all Egyptian cruise ships travel the Luxor-Aswan route which is safe, scenic and terminates at two of Egypt’s most important towns. Taking a Felucca down the Nile is an adventurous option. Feluccas are sail boats that have been used on the Nile since antiquity. A Felucca is not quite as comfortable as a luxury cruise ship but nothing can beat sailing in a quiet rig that was designed thousands of years ago.',0,32.636089,25.699159);INSERT INTO 'places' VALUES(38,'Bariloche',36,'With its chocolate shops, Swiss-style architecture and picturesque setting of pristine lakes and snow-capped mountains, San Carlos de Bariloche appears more like a village in Switzerland. Instead, it is an enchanting city in the Río Negro Province of Argentina. Commonly referred to as simply Bariloche, San Carlos also serves as a gateway to spectacular landscapes and outdoor adventures.',0,-71.310278,-41.133472);INSERT INTO 'places' VALUES(39,'Buenos Aires',37,'Pulsating with vitality and seductive charm from colorful European architecture to animated neighborhoods, sensational shopping, gourmet cuisine and sizzling nightlife, it is no wonder that Buenos Aires gave birth to the captivating tango dance. Located off the southeastern coast of South America, Buenos Aires is the capital city of Argentina and one of Latin America’s largest cities.',0,-58.381593,-34.603723);INSERT INTO 'places' VALUES(40,'Iguazu Falls',38,'One of the world’s most stunning natural wonders, Iguazu Falls is a series of magnificent waterfalls located on the Iguazu River, straddling the border between Brazil and Argentina. The town on the Argentine side is called Puerto Iguazu and is small and pretty. It also it offers some of the best hostels, top-end hotels and spas in Argentina.',0,-54.436667,-25.695278);INSERT INTO 'places' VALUES(41,'Los Glaciares',39,'Los Glaciares or Glaciers National Park is home to some of the world’s most awe-inspiring natural wonders. Located in the Santa Cruz Province of the vast Patagonia region, the national park features the largest ice cap outside of Greenland and Antarctica. While the glaciers are located in the southern section of the park, the northern section features majestic mountains such as Mount Fitz Roy, offering hiking and mountain climbing.',0,-73.010674,-49.268253);";
            
            char *error;
            if (sqlite3_exec(databaseHandle, sql, NULL, NULL, &error) == SQLITE_OK)
            {
                NSLog(@"Exitoso! :D");
            }
            else
            {
                NSLog(@"Cant insert Error: %s", error);
            }
            
        }
    }
}
-(void)insert{
    
}
-(void)drop{
    
}
-(NSMutableArray *)exQuery:(NSString *)query columToReturn:(int)colum typeOfData:(int)type{
    NSMutableArray *elements = [[NSMutableArray alloc]init];
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    const char *errMsg;
    
    if (sqlite3_open(dbpath, &databaseHandle) == SQLITE_OK){
        
        const char *insert_stmt = [query UTF8String];
        
        if (sqlite3_prepare_v2(databaseHandle, insert_stmt, -1, &statement,&errMsg) == SQLITE_OK)
        {
            NSLog(@"Successful: %@",query);
            NSString *data= [[NSString alloc] init];
            int dataInt;
            double dataDouble;
            while (sqlite3_step(statement) == SQLITE_ROW){
                //TEXT,INT,BOOL,DOUBLE
                switch (type) {
                    case 0:
                        data=[data initWithUTF8String:(const char *) sqlite3_column_text(statement, colum)];
                        NSLog(@"DATA: \"%@\"", data);
                        [elements addObject:data];
                        break;
                    case 1:
                        dataInt= sqlite3_column_int(statement, colum);
                        NSLog(@"DATA: \"%i\"", dataInt);
                        [elements addObject:[NSString stringWithFormat:@"%i",dataInt]];
                        break;
                    case 2:
                        dataDouble = sqlite3_column_double(statement, colum);
                        NSLog(@"DATA: \"%f\"", dataDouble);
                        [elements addObject:[NSString stringWithFormat:@"%f",dataDouble]];
                        break;
                    default:
                        break;
                }
            }
        } else {
            NSLog(@"Failed: \"%s\"",errMsg);
        }
        sqlite3_finalize(statement);
        sqlite3_close(databaseHandle);
    }
    
    return elements;
}

//Otro

//-(NSMutableArray *)exQuery2:(NSString *)query
//{
//    NSMutableArray *elements = [[NSMutableArray alloc]init];
//    sqlite3_stmt *statement;
//    const char *dbpath = [databasePath UTF8String];
//    const char *errMsg;
//    
//    if (sqlite3_open(dbpath, &databaseHandle) == SQLITE_OK){
//        
//        const char *insert_stmt = [query UTF8String];
//        
//        if (sqlite3_prepare_v2(databaseHandle, insert_stmt, -1, &statement,&errMsg) == SQLITE_OK)
//        {
//            NSLog(@"Successful: %@",query);
//            NSString *data= [[NSString alloc] init];
//            while (sqlite3_step(statement) == SQLITE_ROW)
//            {
//                NSMutableArray * element = [[NSMutableArray alloc] init];
//                [element addObject:[data initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
//                [element addObject:[data initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
//                [element addObject:[data initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)]];
//                [element addObject:[data initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)]];
//                [elements addObject:element];
//            }
//        } else {
//            NSLog(@"Failed: \"%s\"",errMsg);
//        }
//        sqlite3_finalize(statement);
//        sqlite3_close(databaseHandle);
//    }
//    
//    return elements;
//    
//}
@end
