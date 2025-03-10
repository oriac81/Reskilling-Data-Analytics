################################################################ Nivell 1 ################################################################
-- Descàrrega els arxius CSV, estudia'ls i dissenya una base de dades amb un esquema d'estrella que contingui, almenys 4 taules de les quals puguis realitzar les següents consultes:


-- Mostra la ruta on MySQL permet llegir/escriure arxius

SHOW VARIABLES LIKE 'secure_file_priv';

--  Donem permisos per a que SQLServer pugui accedir als arxius
SET GLOBAL local_infile = 1;

-- Verifiquem que Workbench té acces als arxius
SHOW VARIABLES LIKE 'local_infile';

-- Creem base de dades amb nom base_de_dades
CREATE DATABASE base_de_dades;

-- Indiquem a Workbench que utilitzi aquesta base de dades
USE base_de_dades;
-- Visualitzem algunes dades de users.csv per a veure com elaborar la taula i tenim en compte la llargada maxima dels registres

-- id	name	surname	phone	email	birth_date	country	city	postal_code	address
-- 1	Zeus	Gamble	1-282-581-0551	interdum.enim@protonmail.edu	Nov 17, 1985	United States	Lowell	73544	348-7818 Sagittis St.
-- column	id	name	surname	phone	email	birth_date	country	city	postal_code	address
-- MAX	3	9	11	15	40	12	14	24	8	36

-- Creació taula users
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    surname VARCHAR(100),
    phone VARCHAR(50),
    email VARCHAR(100),
    birth_date DATE,
    country VARCHAR(150),
    city VARCHAR(150),
    postal_code VARCHAR(100),
    address VARCHAR(255)
);

-- Visualitzem i verifiquem l'estructura de la taula users 
DESCRIBE users;

-- Importem les dades de l' arxiu  users_usa.csv a la taula users

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\users_usa.csv'
INTO TABLE users
FIELDS TERMINATED BY ','          -- Els valors estan separats per comes
ENCLOSED BY '"'                   -- Els valors que tenen espais o caràcters especials estan entre cometes dobles
LINES TERMINATED BY '\r\n'          -- Les línies estan separades per salts de línia
IGNORE 1 ROWS                     -- Ignorar la primera fila (capçalera)
(id, name, surname, phone, email, @birth_date,country, city, postal_code, address)
SET birth_date = STR_TO_DATE(@birth_date, '%b %d, %Y'); -- Convertim el valor de la variable @birth_date (en format text Mon DD, YYYY, ex: "Jan 15, 1990") a un format de data (DATE) utilitzant STR_TO_DATE().

-- Insertem les dades de users_usa.csv mitjançant un INSERT TO amb les dades de birth_date previament adaptades a DATE.

INSERT INTO users (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES
(1, 'Zeus', 'Gamble', '1-282-581-0551', 'interdum.enim@protonmail.edu', '1985-11-17', 'United States', 'Lowell', 73544, '348-7818 Sagittis St.'),
(2, 'Garrett', 'Mcconnell', '(718) 257-2412', 'integer.vitae.nibh@protonmail.org', '1992-08-23', 'United States', 'Des Moines', 59464, '903 Sit Ave'),
(3, 'Ciaran', 'Harrison', '(522) 598-1365', 'interdum.feugiat@aol.org', '1998-04-29', 'United States', 'Columbus', 56518, '736-2063 Tellus St.'),
(4, 'Howard', 'Stafford', '1-411-740-3269', 'ornare.egestas@icloud.edu', '1989-02-18', 'United States', 'Kailua', 77417, 'Ap #545-2244 Erat. Rd.'),
(5, 'Hayfa', 'Pierce', '1-554-541-2077', 'et.malesuada.fames@hotmail.org', '1998-09-26', 'United States', 'Sandy', 31564, '341-2821 Ultrices Av.'),
(6, 'Joel', 'Tyson', '(718) 288-8020', 'gravida.nunc.sed@yahoo.ca', '1989-10-15', 'United States', 'Nashville', 96838, '888-2799 Amet Street'),
(7, 'Rafael', 'Jimenez', '(817) 689-0478', 'eget@outlook.ca', '1981-12-04', 'United States', 'Hillsboro', 29874, '8627 Malesuada Rd.'),
(8, 'Nissim', 'Franks', '(692) 157-3469', 'egestas.aliquam.fringilla@google.ca', '1993-08-01', 'United States', 'Jackson', 61750, 'Ap #251-7144 Integer St.'),
(9, 'Mannix', 'Mcclain', '(590) 883-2184', 'aliquam.nisl@outlook.com', '1987-01-24', 'United States', 'Richmond', 35987, '647-3080 Lacus. St.'),
(10, 'Robert', 'Mccarthy', '(324) 746-6771', 'fermentum@protonmail.com', '1984-04-30', 'United States', 'Eugene', 85526, 'P.O. Box 773, 3594 Ornare St.'),
(11, 'Joan', 'Baird', '(981) 429-8106', 'et@outlook.net', '1990-02-25', 'United States', 'Lincoln', 35211, 'P.O. Box 687, 8917 Ligula St.'),  
(12, 'Benedict', 'Wheeler', '1-515-824-2855', 'tincidunt.donec.vitae@hotmail.couk', '1999-08-06', 'United States', 'Lewiston', 92393, '748-8694 Porttitor Avenue'),  
(13, 'Allegra', 'Stanton', '1-927-753-6488', 'proin.eget@protonmail.ca', '1990-05-19', 'United States', 'Kearney', 14947, '4457 Ante. Av.'),  
(14, 'Sara', 'Flynn', '1-311-646-9333', 'integer@outlook.net', '1988-12-27', 'United States', 'Warren', 20288, 'P.O. Box 865, 4397 Ante St.'),  
(15, 'Noelani', 'Patrick', '1-723-488-5894', 'sem.magna@google.com', '1993-09-17', 'United States', 'Orlando', 47987, '596-5044 Sapien, Street'),  
(16, 'Eric', 'Roth', '1-218-549-8253', 'lorem.sit@yahoo.net', '1988-09-07', 'United States', 'Reading', 96697, 'P.O. Box 541, 5137 Non Road'),  
(17, 'Bruce', 'Gill', '(744) 732-8628', 'metus@aol.net', '1990-03-04', 'United States', 'Davenport', 43415, 'Ap #836-9508 Vitae, Ave'),  
(18, 'Russell', 'Jimenez', '(657) 779-2438', 'orci@outlook.edu', '1993-08-26', 'United States', 'Hattiesburg', 75647, '4095 Quam Rd.'),  
(19, 'Nicholas', 'Travis', '1-330-223-9652', 'libero.dui@hotmail.com', '1981-07-15', 'United States', 'Jacksonville', 71727, 'Ap #459-539 Lectus Avenue'),  
(20, 'Kelsey', 'Bates', '(653) 724-4754', 'ullamcorper.nisl@aol.com', '1981-05-06', 'United States', 'Gulfport', 50423, '824-3624 Lacinia St.'), 
(21, 'Hall', 'Reeves', '(241) 759-9235', 'erat.eget@hotmail.edu', '1987-07-22', 'United States', 'Warren', 85521, 'Ap #745-5948 Sollicitudin St.'),  
(22, 'Allistair', 'Holmes', '1-265-323-0812', 'donec.tempor.est@protonmail.com', '1990-11-05', 'United States', 'Montpelier', 85914, 'Ap #794-4229 Ante Rd.'),  
(23, 'Kelsie', 'Bass', '1-837-832-5631', 'consequat@google.ca', '1990-04-02', 'United States', 'Jefferson City', 97237, '407-7562 A, Road'),  
(24, 'Nolan', 'Cash', '(273) 334-3785', 'nam@hotmail.com', '1994-09-09', 'United States', 'Owensboro', 61256, '501-2733 Luctus. Rd.'),  
(25, 'Wanda', 'Campbell', '(702) 823-5535', 'sagittis@google.couk', '1999-05-31', 'United States', 'San Jose', 88665, 'Ap #337-8747 Auctor. Ave'),  
(26, 'Aquila', 'Strickland', '1-246-231-5495', 'enim.sit@icloud.com', '1982-09-28', 'United States', 'Colchester', 26637, 'Ap #260-4612 Massa Road'),  
(27, 'Diana', 'Williamson', '1-285-365-7779', 'id.nunc@google.com', '1991-12-14', 'United States', 'Kearney', 93484, '362-9552 Sed Rd.'),  
(28, 'Elmo', 'Cain', '1-663-583-6021', 'nec.metus.facilisis@google.org', '1980-10-13', 'United States', 'Columbus', 25225, 'P.O. Box 585, 4446 Suspendisse St.'),  
(29, 'Deacon', 'Sharpe', '(312) 529-1643', 'hendrerit@icloud.net', '1979-09-19', 'United States', 'Naperville', 63967, '672-9145 Ullamcorper, Ave'),  
(30, 'Martena', 'Blackwell', '1-336-632-3280', 'at.nisi.cum@icloud.org', '1987-02-21', 'United States', 'Columbia', 53144, '641 Lacus. St.'),
(31, 'Francis', 'Bryant', '(654) 360-7374', 'quisque.ac.libero@protonmail.edu', '1992-08-17', 'United States', 'Waterbury', 91358, 'P.O. Box 596, 9052 Quisque St.'),  
(32, 'Chase', 'Yang', '1-771-216-5335', 'pellentesque.eget@google.net', '1999-04-23', 'United States', 'Duluth', 32807, '207-9951 Mi, Avenue'),  
(33, 'Venus', 'Sanders', '(679) 326-6342', 'nec.ante.maecenas@aol.com', '1990-01-06', 'United States', 'Little Rock', 40790, '4840 Lorem Rd.'),  
(34, 'Sopoline', 'Branch', '1-557-503-3642', 'nec@yahoo.org', '1979-04-08', 'United States', 'Gary', 79667, '745 Vivamus Avenue'),  
(35, 'Yvonne', 'Gibson', '1-424-288-3275', 'risus@outlook.org', '1993-01-07', 'United States', 'Vancouver', 21213, 'Ap #356-7162 Ligula Rd.'),  
(36, 'Raymond', 'Thornton', '1-581-648-7426', 'enim.nisl@google.edu', '1982-12-06', 'United States', 'Kansas City', 26231, '746-3251 Aptent Avenue'),  
(37, 'Graiden', 'Glover', '(888) 957-3868', 'non.hendrerit@hotmail.ca', '1987-11-11', 'United States', 'Portland', 35397, 'Ap #497-8090 Vel Avenue'),  
(38, 'Abra', 'Doyle', '(367) 861-9621', 'augue.eu@outlook.edu', '1986-08-22', 'United States', 'Chicago', 54137, '409-9169 Cubilia St.'),  
(39, 'Nyssa', 'Shaffer', '1-899-494-4941', 'malesuada.fames@google.ca', '1991-07-02', 'United States', 'Columbus', 27828, '4215 Libero Road'),  
(40, 'Astra', 'Alexander', '1-877-546-5066', 'lectus.nullam.suscipit@google.org', '1983-03-12', 'United States', 'Columbus', 78276, 'P.O. Box 384, 117 Et St.'),
(41, 'Uriel', 'Hebert', '1-265-846-2455', 'donec@outlook.com', '1981-11-30', 'United States', 'Juneau', 33549, '670-5867 Eget Street'),  
(42, 'Lucy', 'Branch', '(459) 164-9989', 'odio.etiam@aol.couk', '1991-10-31', 'United States', 'Joliet', 27874, '134-848 Orci, Rd.'),  
(43, 'Jayme', 'Chavez', '(542) 568-7326', 'fusce.feugiat@outlook.com', '1984-07-29', 'United States', 'Aurora', 28283, '8659 Enim. Rd.'),  
(44, 'Aquila', 'Haley', '1-951-243-1892', 'tempus.risus@outlook.edu', '1996-01-21', 'United States', 'Newark', 51734, 'Ap #197-7436 Neque. Road'),  
(45, 'Richard', 'O\'donnell', '1-275-844-6782', 'ac.nulla@outlook.org', '1986-10-04', 'United States', 'Frankfort', 72520, 'P.O. Box 333, 3191 Ullamcorper, Ave'),  
(46, 'Alika', 'Valdez', '(781) 178-0838', 'dapibus.gravida@yahoo.net', '1990-08-08', 'United States', 'Salem', 55729, 'P.O. Box 580, 196 Cras Ave'),  
(47, 'Herrod', 'Wright', '(575) 645-3218', 'odio.auctor.vitae@yahoo.edu', '1999-11-11', 'United States', 'Fort Wayne', 72865, '8745 Elementum Road'),  
(48, 'Patrick', 'Reyes', '1-607-729-5993', 'conubia.nostra@icloud.com', '1986-07-29', 'United States', 'San Jose', 96740, '1150 Etiam Av.'),  
(49, 'Lev', 'Roth', '1-685-331-7392', 'auctor.vitae.aliquet@yahoo.net', '1981-12-03', 'United States', 'Richmond', 52748, 'P.O. Box 455, 4035 Ullamcorper, Road'),  
(50, 'Aretha', 'Chang', '1-634-250-1977', 'suspendisse.aliquet.molestie@hotmail.edu', '1998-05-11', 'United States', 'Jonesboro', 26937, '491 Neque St.'),
(51, 'Lionel', 'Griffith', '1-816-243-8788', 'ultricies.sem.magna@yahoo.org', '1993-04-03', 'United States', 'Wichita', 17638, 'P.O. Box 191, 5848 A, Ave'),
(52, 'Sheila', 'Sullivan', '(426) 608-1653', 'arcu.vel@google.edu', '1981-05-17', 'United States', 'Sacramento', 48147, 'Ap #644-7695 Nec, Rd.'),
(53, 'Lucas', 'Lloyd', '(513) 819-9413', 'sagittis.duis.gravida@outlook.net', '1980-06-20', 'United States', 'Waterbury', 56684, '745-3814 Metus. Rd.'),
(54, 'Emma', 'Park', '(581) 468-8549', 'vel.turpis.aliquam@icloud.org', '1991-05-27', 'United States', 'Topeka', 70684, 'Ap #558-7250 Vivamus Rd.'),
(55, 'Barrett', 'Andrews', '(573) 474-8979', 'ligula.consectetuer@protonmail.edu', '1995-11-28', 'United States', 'Tacoma', 14982, '5363 Rhoncus Street'),
(56, 'Odysseus', 'Frye', '(236) 402-6048', 'sociis.natoque@outlook.org', '1983-02-19', 'United States', 'Norman', 74030, '772-6878 Sociosqu Av.'),
(57, 'Daquan', 'Kirk', '1-748-565-9125', 'ultricies@hotmail.ca', '1994-12-22', 'United States', 'Grand Rapids', 46875, '5438 Odio. Avenue'),
(58, 'Sandra', 'Owens', '1-961-472-4829', 'eu.enim@icloud.ca', '1980-10-14', 'United States', 'Fort Worth', 44233, '465-230 Ullamcorper, Rd.'),
(59, 'Heather', 'Bradshaw', '1-535-845-1352', 'luctus.et@aol.couk', '1984-12-04', 'United States', 'Kaneohe', 85163, '6641 Convallis St.'),
(60, 'Roth', 'Cook', '(122) 759-2618', 'ullamcorper.eu@icloud.edu', '1996-11-23', 'United States', 'Aurora', 26839, 'Ap #815-8102 Ante. St.'),
(61, 'Duncan', 'Romero', '1-226-441-1416', 'ligula.aenean.euismod@hotmail.com', '1990-02-04', 'United States', 'Hilo', 68158, '267-173 Felis Rd.'),
(62, 'Phyllis', 'Holt', '1-806-654-1534', 'metus.vitae.velit@outlook.couk', '1987-06-07', 'United States', 'Newark', 81711, 'Ap #111-6364 Libero. Rd.'),
(63, 'Beverly', 'Burt', '(336) 263-4576', 'aliquam.enim@aol.edu', '1996-12-12', 'United States', 'Pittsburgh', 18438, 'P.O. Box 632, 6754 Fringilla Road'),
(64, 'Irma', 'Whitehead', '1-332-774-7232', 'mauris.quis@google.org', '1988-02-14', 'United States', 'Norman', 47637, '393-6189 Sem Ave'),
(65, 'Yeo', 'Emerson', '(473) 596-9486', 'lacinia.at.iaculis@aol.net', '1993-09-26', 'United States', 'Salem', 71835, 'Ap #897-3426 Orci, Av.'),
(66, 'Bert', 'Juarez', '1-404-537-2914', 'pede.nec@outlook.net', '1988-09-14', 'United States', 'Colchester', 85478, '757-6748 Placerat St.'),
(67, 'Kenneth', 'Morrison', '1-214-178-7152', 'elementum.sem.vitae@outlook.org', '1981-09-10', 'United States', 'Saint Louis', 65146, '801-4640 Odio Rd.'),
(68, 'Whoopi', 'Ford', '1-548-301-4313', 'enim.diam.vel@google.com', '1979-04-30', 'United States', 'Bloomington', 76233, 'P.O. Box 312, 3903 Aliquam Rd.'),
(69, 'Stone', 'Atkinson', '1-751-189-8258', 'etiam@outlook.com', '1993-01-31', 'United States', 'Columbus', 36506, 'Ap #820-7449 Tellus Rd.'),
(70, 'Debra', 'Farley', '(377) 214-5814', 'non.justo@aol.com', '1985-01-31', 'United States', 'San Jose', 88326, 'P.O. Box 855, 7643 Eu Street'),
(71, 'Emerson', 'Hess', '1-342-775-1174', 'orci.tincidunt.adipiscing@icloud.ca', '1984-05-12', 'United States', 'Mesa', 33568, 'Ap #191-5633 Lectus Rd.'),
(72, 'Jael', 'Robles', '(267) 616-3375', 'lorem.eget.mollis@protonmail.net', '1983-06-06', 'United States', 'Spokane', 97103, '266 Dictum Avenue'),
(73, 'Warren', 'Christian', '1-125-829-9354', 'malesuada.vel@icloud.ca', '1993-01-12', 'United States', 'Boise', 95246, 'Ap #323-5264 Convallis Rd.'),
(74, 'Zelenia', 'Good', '1-971-397-7840', 'aenean@google.couk', '1988-09-21', 'United States', 'Wichita', 78518, '176-5987 Sociis St.'),
(75, 'Colleen', 'Juarez', '1-647-277-0329', 'sodales@yahoo.edu', '1990-05-25', 'United States', 'Lewiston', 36194, '919-2582 Et, St.'),
(76, 'Glenna', 'Gutierrez', '(567) 428-5368', 'amet@outlook.couk', '1990-09-25', 'United States', 'Newark', 58673, '9288 Posuere St.'),
(77, 'Jared', 'Compton', '1-416-623-5165', 'vel.quam@outlook.net', '1999-01-18', 'United States', 'Norfolk', 13086, '354-782 Tempor Ave'),
(78, 'Camilla', 'Zimmerman', '(403) 839-3861', 'enim@aol.com', '1997-11-20', 'United States', 'Aurora', 79643, 'Ap #612-9307 Metus Av.'),
(79, 'Preston', 'Hubbard', '(485) 611-5951', 'in.cursus.et@protonmail.com', '2000-08-16', 'United States', 'Savannah', 73062, 'P.O. Box 761, 364 Mauris Road'),
(80, 'Sophia', 'Bradford', '(795) 358-4243', 'eu@outlook.com', '1985-02-10', 'United States', 'Paradise', 89058, 'Ap #425-5343 Fermentum Rd.'),
(81, 'Acton', 'Gallegos', '1-784-875-8068', 'rhoncus.donec@yahoo.org', '1989-02-06', 'United States', 'Lexington', 54348, '5613 Ut St.'),
(82, 'Stacey', 'Moses', '(768) 696-2845', 'ante.iaculis.nec@hotmail.edu', '1985-09-07', 'United States', 'South Portland', 84463, 'Ap #786-4555 Scelerisque Avenue'),
(83, 'Dana', 'Ware', '1-997-209-1750', 'nisi.a@outlook.net', '1979-11-29', 'United States', 'Hillsboro', 59188, 'Ap #801-3094 Nec Av.'),
(84, 'Craig', 'Shepherd', '1-817-268-8038', 'feugiat@protonmail.net', '1996-04-18', 'United States', 'Charlotte', 31072, 'Ap #167-3311 Rutrum, St.'),
(85, 'Aiden', 'Williams', '1-881-130-0495', 'eleifend.lacinia@aol.edu', '1993-01-03', 'United States', 'Rockford', 62241, 'Ap #214-6874 Eu St.'),
(86, 'Nancy', 'Harmon', '1-388-111-6392', 'neque@outlook.org', '1990-08-15', 'United States', 'Mesa', 27939, 'Ap #178-1493 Vestibulum Ave'),
(87, 'Ben', 'Carlson', '1-451-342-4577', 'etiam.sed.cursus@outlook.edu', '1982-04-20', 'United States', 'Cleveland', 39539, '337-3119 Cras Avenue'),
(88, 'Alana', 'Olson', '1-639-457-1563', 'etiam.sit@google.edu', '1983-03-01', 'United States', 'Norfolk', 46828, '5275 Ultrices Rd.'),
(89, 'Miranda', 'Wilkins', '1-179-372-9477', 'vulputate@outlook.com', '1996-11-14', 'United States', 'Lansing', 78522, 'Ap #698-2685 Cras Avenue'),
(90, 'Anabella', 'James', '(876) 506-5184', 'neque@protonmail.org', '1990-06-02', 'United States', 'Portland', 62931, 'P.O. Box 487, 7215 At Rd.'),
(91, 'Constance', 'Miller', '1-767-418-4127', 'lorem@outlook.couk', '1986-01-06', 'United States', 'Savannah', 28934, 'Ap #779-2710 Pretium, Av.'),
(92, 'Yehuda', 'Sharp', '1-925-939-1585', 'pellentesque.congue@protonmail.com', '1980-03-03', 'United States', 'Syracuse', 31457, '7925 Non St.'),
(93, 'Bernadette', 'Young', '1-342-561-7388', 'pharetra.suscipit@protonmail.com', '1989-05-16', 'United States', 'Killeen', 75961, '3300 Sit St.'),
(94, 'Karissa', 'Wilkerson', '(912) 867-7987', 'porta.lacinia.sit@google.net', '1990-11-16', 'United States', 'Newark', 59994, 'Ap #372-7581 Commodo Rd.'),
(95, 'Gilbert', 'Harrison', '1-375-548-1363', 'nunc@outlook.com', '1989-07-19', 'United States', 'Dayton', 13055, '717-4398 Eu Rd.'),
(96, 'Vincent', 'Yates', '1-199-128-6390', 'mauris@outlook.net', '1990-07-11', 'United States', 'Lansing', 25896, '670-6723 Lorem Road'),
(97, 'Bess', 'Gonzalez', '(236) 522-3424', 'velit@aol.net', '1982-07-05', 'United States', 'Burbank', 31986, '381-6634 Tempus St.'),
(98, 'Marcus', 'Hughes', '1-569-522-5283', 'enim@outlook.net', '1993-04-13', 'United States', 'Denver', 16006, '6259 Vulputate Avenue'),
(99, 'Neveah', 'Wong', '1-236-106-8432', 'nunc@aol.couk', '1989-01-04', 'United States', 'Green Bay', 84652, 'P.O. Box 926, 7280 Et Road'),
(100, 'Harold', 'Williams', '(450) 699-8998', 'ullamcorper@protonmail.org', '1995-08-06', 'United States', 'Washington', 38712, '322-2480 Commodo Rd.'),
(101, 'Sarah', 'Beck', '(358) 691-4345', 'vitae.risus@aol.couk', '1983-04-09', 'United States', 'Great Falls', 67129, '665-9047 In, Rd.'),
(102, 'Jasper', 'Landry', '1-397-765-1118', 'consectetuer.euismod@aol.org', '1982-04-16', 'United States', 'Columbus', 11595, 'Ap #374-7325 Sodales Rd.'),
(103, 'Upton', 'Chavez', '(227) 785-6484', 'euismod.est@aol.ca', '1986-03-15', 'United States', 'Essex', 95631, '1990 Vel, Av.'),
(104, 'Martha', 'Barlow', '(732) 326-5448', 'vulputate@hotmail.net', '1988-10-29', 'United States', 'Chicago', 41512, 'Ap #311-7103 In Avenue'),
(105, 'Hashim', 'Rose', '(858) 313-6727', 'urna@icloud.com', '1983-03-28', 'United States', 'Tacoma', 99632, '8034 Tortor, Road'),
(106, 'Tanner', 'Valenzuela', '1-346-421-3135', 'nascetur.ridiculus@google.net', '1993-04-06', 'United States', 'Naperville', 31130, 'Ap #114-2616 Fusce Road'),
(107, 'Victor', 'Valencia', '(239) 569-1938', 'non.enim@hotmail.couk', '1998-05-01', 'United States', 'Warren', 15158, 'Ap #182-9926 At St.'),
(108, 'Germaine', 'Suarez', '1-931-750-6983', 'risus@icloud.com', '1984-02-01', 'United States', 'Cleveland', 36183, 'Ap #383-1856 Mauris Avenue'),
(109, 'Raven', 'Reynolds', '(667) 453-9731', 'sed@aol.com', '1986-07-11', 'United States', 'Rockville', 64325, 'P.O. Box 753, 3474 Orci, Av.'),
(110, 'Neil', 'Powers', '(864) 881-6737', 'nec.metus@aol.edu', '1980-09-03', 'United States', 'Clarksville', 46921, '571-2024 Quam Avenue'),
(111, 'Astra', 'Baldwin', '1-643-565-3266', 'adipiscing.ligula.aenean@protonmail.net', '1999-07-03', 'United States', 'Indianapolis', 74764, '932-8297 Ac Ave'),
(112, 'Ryder', 'Cole', '1-572-759-8544', 'nec.enim.nunc@protonmail.net', '1990-09-04', 'United States', 'South Portland', 52161, 'Ap #286-4884 Arcu. Avenue'),
(113, 'Risa', 'Frost', '1-712-488-5451', 'neque.pellentesque@outlook.org', '1996-05-05', 'United States', 'Kearney', 88986, 'Ap #678-785 Leo. Road'),
(114, 'Jasmine', 'Castro', '1-512-143-0648', 'lorem@google.ca', '1987-01-05', 'United States', 'San Jose', 94101, '9948 Dictum. Road'),
(115, 'Urielle', 'Holman', '1-424-793-4354', 'leo@google.ca', '1985-10-11', 'United States', 'Green Bay', 29058, '268-1889 Adipiscing Rd.'),
(116, 'Sacha', 'Compton', '(265) 342-4775', 'sed.dictum.proin@yahoo.org', '1981-09-01', 'United States', 'Wilmington', 94151, 'Ap #722-5423 Velit. Road'),
(117, 'Halla', 'Pearson', '(681) 698-7518', 'lacus.etiam@protonmail.couk', '1994-04-19', 'United States', 'Biloxi', 65926, '664-903 In, Street'),
(118, 'Brooke', 'Jensen', '(124) 739-9067', 'purus.mauris.a@icloud.ca', '1981-08-23', 'United States', 'Erie', 68334, 'P.O. Box 718, 9538 Velit Road'),
(119, 'Damian', 'Mcgee', '(712) 572-8735', 'neque.nullam@hotmail.edu', '1988-09-20', 'United States', 'Racine', 67561, 'Ap #383-8201 Orci Street'),
(120, 'Solomon', 'Blake', '1-814-753-4054', 'in.at.pede@hotmail.edu', '1990-02-23', 'United States', 'Glendale', 32725, '469-4293 Aenean St.'),
(121, 'Ainsley', 'Herrera', '1-380-341-6875', 'est.congue@hotmail.couk', '1996-03-28', 'United States', 'Madison', 64252, '779-913 Cras Rd.'),
(122, 'Desiree', 'Carey', '(888) 429-3660', 'pellentesque.tellus.sem@protonmail.edu', '1989-09-10', 'United States', 'Reading', 71452, 'P.O. Box 651, 6745 Donec St.'),
(123, 'Dominique', 'Tillman', '1-956-793-8208', 'vitae.dolor.donec@google.ca', '1999-09-28', 'United States', 'New Orleans', 33029, '618-3352 Amet, Street'),
(124, 'Walter', 'Larsen', '(435) 652-7642', 'et.netus.et@yahoo.net', '1979-09-15', 'United States', 'College', 31347, 'Ap #946-1494 Mauris Rd.'),
(125, 'Celeste', 'Ellis', '1-847-855-3441', 'dapibus.rutrum@yahoo.org', '1994-01-29', 'United States', 'Wichita', 84214, 'Ap #521-1005 Dolor Av.'),
(126, 'Kim', 'Mooney', '1-252-337-6661', 'sed.nec@google.org', '2000-11-28', 'United States', 'Lewiston', 84345, '377-2270 Ante St.'),
(127, 'Ezra', 'Beard', '(743) 567-0923', 'morbi.sit@google.com', '1984-04-08', 'United States', 'Los Angeles', 43908, 'P.O. Box 783, 1432 Inceptos Rd.'),
(128, 'Lucas', 'Dawson', '(404) 491-1122', 'in.consectetuer.ipsum@yahoo.com', '1983-09-13', 'United States', 'Shreveport', 82532, 'P.O. Box 926, 2853 Non, Rd.'),
(129, 'Amber', 'Blevins', '(734) 712-6456', 'nunc@outlook.org', '1979-08-14', 'United States', 'Honolulu', 51863, 'P.O. Box 878, 292 Orci Rd.'),
(130, 'Oscar', 'Neal', '1-923-222-4140', 'magna.nec@icloud.net', '1983-12-29', 'United States', 'Casper', 94343, '653 Posuere Road'),
(131, 'Hiram', 'Preston', '(774) 220-4835', 'ridiculus.mus@yahoo.net', '1996-01-14', 'United States', 'Rochester', 24724, 'P.O. Box 579, 727 Ipsum Rd.'),
(132, 'Gisela', 'Johnston', '(223) 563-2771', 'accumsan.sed@outlook.couk', '1993-07-29', 'United States', 'Auburn', 58677, '489-8011 Faucibus Ave'),
(133, 'Iona', 'Soto', '1-249-240-5843', 'tristique.aliquet@protonmail.com', '1998-04-15', 'United States', 'Iowa City', 73017, 'Ap #327-9970 Sollicitudin St.'),
(134, 'Tiger', 'Davis', '(571) 492-5568', 'nonummy.ut@hotmail.ca', '1997-04-12', 'United States', 'Aurora', 80460, 'P.O. Box 346, 7204 Quam. Rd.'),
(135, 'Zahir', 'Swanson', '(758) 354-1913', 'nam.ac@hotmail.couk', '1991-01-12', 'United States', 'Dover', 27834, '684 Sed Ave'),
(136, 'Sonya', 'Hobbs', '1-508-176-1405', 'quis.pede@aol.com', '1981-01-08', 'United States', 'Memphis', 24123, 'Ap #959-1231 Aliquam Road'),
(137, 'Brody', 'Goodwin', '1-789-944-8575', 'donec.felis@outlook.couk', '1982-04-02', 'United States', 'Tucson', 61282, '779-7842 Dolor Ave'),
(138, 'Wesley', 'Bush', '1-814-353-8532', 'fermentum.arcu@hotmail.com', '1987-02-08', 'United States', 'Owensboro', 77662, '270-4210 Et, Road'),
(139, 'Walker', 'Gibson', '1-935-527-2111', 'ipsum.primis@yahoo.edu', '1980-01-20', 'United States', 'Annapolis', 99895, 'P.O. Box 694, 6043 Dolor. St.'),
(140, 'Oprah', 'Nicholson', '(485) 970-9786', 'a@google.edu', '1981-09-19', 'United States', 'Bridgeport', 38328, '8543 Velit Av.'),
(141, 'Clark', 'Hewitt', '1-522-475-6115', 'et.malesuada@aol.couk', '1997-10-20', 'United States', 'Tuscaloosa', 35547, 'Ap #260-1064 Quisque St.'),
(142, 'Wyatt', 'Morris', '1-402-317-8621', 'consequat@google.org', '1992-10-11', 'United States', 'Salt Lake City', 37463, 'P.O. Box 436, 6802 Purus Avenue'),
(143, 'Genevieve', 'Nolan', '1-346-724-1579', 'quis@outlook.com', '1990-09-03', 'United States', 'Springfield', 37616, 'Ap #124-9427 Ante. Rd.'),
(144, 'Jeanette', 'Blanchard', '1-287-355-3938', 'amet.dapibus@google.couk', '1996-07-06', 'United States', 'San Jose', 26707, 'Ap #529-6734 Ipsum Road'),
(145, 'Ursula', 'Stewart', '1-442-838-6756', 'commodo.auctor.velit@outlook.ca', '1994-02-17', 'United States', 'Lincoln', 69791, '161-6225 Ac, Street'),
(146, 'Priscilla', 'Skinner', '(468) 855-0771', 'laoreet.lectus@aol.edu', '1980-07-31', 'United States', 'Sandy', 86701, '207-6998 At Ave'),
(147, 'Brody', 'Talley', '(307) 307-2751', 'metus.sit.amet@outlook.org', '1991-06-13', 'United States', 'Fayetteville', 42374, '469-5852 Tellus Street'),
(148, 'Kerry', 'Adkins', '(528) 872-1974', 'augue.eu.tempor@icloud.couk', '1983-03-13', 'United States', 'Dallas', 86373, 'Ap #422-4836 Nunc Rd.'),
(149, 'Brock', 'Doyle', '(265) 140-9567', 'cursus.a@aol.edu', '1986-02-19', 'United States', 'Tuscaloosa', 77945, 'Ap #172-5737 Lorem St.'),
(150, 'Oleg', 'Coleman', '1-131-139-5673', 'dis@outlook.edu', '1981-12-02', 'United States', 'Indianapolis', 28528, '722-3056 Eu, Road');


-- Visualitzem la importació de users_usa.csv a users
SELECT * FROM users;

-- Importem les dades de  l'arxiu  users_uk.csv a la taula users

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\users_uk.csv'
INTO TABLE users
FIELDS TERMINATED BY ','          -- Els valors estan separats per comes
ENCLOSED BY '"'                   -- Els valors que tenen espais o caràcters especials estan entre cometes dobles
LINES TERMINATED BY '\r\n'          -- Les línies estan separades per salts de línia. Creat amb Windows
IGNORE 1 ROWS                     -- Ignorar la primera fila (capçalera)
(id, name, surname, phone, email, @birth_date,country, city, postal_code, address)
SET birth_date = STR_TO_DATE(@birth_date, '%b %d, %Y'); -- Convertim el valor de la variable @birth_date (en format text Mon DD, YYYY, ex: "Jan 15, 1990") a un format de data (DATE) utilitzant STR_TO_DATE().


-- Importem les dades de l'arxiu  users_ca.csv a la taula users

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\users_ca.csv'
INTO TABLE users
FIELDS TERMINATED BY ','          -- Els valors estan separats per comes
ENCLOSED BY '"'                   -- Els valors que tenen espais o caràcters especials estan entre cometes dobles
LINES TERMINATED BY '\r\n'          -- Les línies estan separades per salts de línia. Creat amb Windows
IGNORE 1 ROWS                     -- Ignorar la primera fila (capçalera)
(id, name, surname, phone, email, @birth_date,country, city, postal_code, address)
SET birth_date = STR_TO_DATE(@birth_date, '%b %d, %Y'); -- Convertim el valor de la variable @birth_date (en format text Mon DD, YYYY, ex: "Jan 15, 1990") a un format de data (DATE) utilitzant STR_TO_DATE().


-- Visualitzem les dades de la taula users completa
SELECT * FROM users;

-- Creació de la taula credit_cards
-- Visualitzem algunes dades de credit_cards.csv per a veure com elaborar la taula i tenim en compte la llargada màxima dels registres

/*credit_cards	 Exemple dades:								
Column	id	user_id	iban	pan	pin	cvv	track1	track2	expiring_date
Exemple	CcU-4842	3	SA2156708581957118818229	3774 636724 83250	4655	750	%B2216216733758821^CsszvisPjqcfh^95081856902?1	%B2517312164209886=54047891?9	11/11/2024
	CcU-4849	2	SE2813123487163628531121	5,22336E+15	9992	779	%B8844154447682199^JunfxuiCzhsrj^3805344275?5	%B2623983651705584=0207551226?9	03/21/25
MAX	8	3	31	19	4	3	46	32	8*/


-- Creem taula credit_cards

CREATE TABLE credit_cards (
    id VARCHAR(20) PRIMARY KEY,         -- ID de la targeta (8 caràcters)
    user_id INT,            			-- ID de l'usuari (3 dígits màxim)
    iban VARCHAR(50) ,       			-- IBAN (31 caràcters màxims)
    pan VARCHAR(50) ,        			-- Número de la targeta (19 caràcters)
    pin VARCHAR(4),            			-- PIN (4 dígits)
    cvv INT,            				-- CVV (3 dígits)
    track1 VARCHAR(50),              	-- Dades de la banda magnètica (46 caràcters)
    track2 VARCHAR(50),              	-- Dades de la banda magnètica (32 caràcters)
    expiring_date DATE   		      	-- Data d'expiració (8 caràcters, format MM/YY/YYYY o MM/YY) Convertirem les dades a DATE
);

-- Visualitzem i verifiquem l'estructura de la taula credit_cards

DESCRIBE credit_cards;

-- Importació de dades de credit_cards.csv a taula credit_cards

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\credit_cards.csv'
INTO TABLE credit_cards
FIELDS TERMINATED BY ','          -- Els valors estan separats per comes
ENCLOSED BY '"'                   -- Els valors que tenen espais o caràcters especials estan entre cometes dobles
LINES TERMINATED BY '\n'          -- Les línies estan separades per salts de línia. Creat amb LINUX o MAC
IGNORE 1 ROWS                     -- Ignorar la primera fila (capçalera)
(id, user_id, iban, pan, pin, cvv, track1, track2, @expiring_date)
SET expiring_date = STR_TO_DATE(@expiring_date, '%m/%d/%y'); -- converteix el valor de la variable @expiring_date (en format text MM/DD/YY) a un format de data (DATE) utilitzant STR_TO_DATE()

-- Visualitzem la importació de credit_cards.csv a taula credit_cards
SELECT * FROM credit_cards;

-- Creació de la taula companies 
-- Visualitzem algunes dades de companies.csv per a veure com elaborar la taula i tenim en compte la llargada màxima dels registres

/*companies						
Column	company_id	company_name	phone	email	country	website
Exemple	b-2578	Dui Quis Institute	06 93 28 72 81	luctus.sit.amet@yahoo.couk	New Zealand	https://yahoo.com/en-us
	b-2582	Nibh Phasellus Corporation	08 48 67 57 48	nisi@google.edu	China	https://netflix.com/sub/cars
MAX	6	35	14	38	14	31*/

-- Creem taula companies

CREATE TABLE companies (
    company_id VARCHAR(20) PRIMARY KEY,     	-- ID de l'empresa (6 caràcters)
    company_name VARCHAR(50),   				-- Nom de l'empresa (35 caràcters)
    phone VARCHAR(50),                    		-- Número de telèfon (14 caràcters)
    email VARCHAR(100),             			-- Correu electrònic (38 caràcters)
    country VARCHAR(100),                   	-- País (14 caràcters)
    website VARCHAR(200)                    	-- URL de la web (31 caràcters)
);

-- Visualitzem i verifiquem l'estructura de la taula companies
DESCRIBE companies;

-- Importació de dades de companies.csv a taula companies

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\companies.csv'
INTO TABLE companies
FIELDS TERMINATED BY ','          -- Els valors estan separats per comes
ENCLOSED BY '"'                   -- Els valors que tenen espais o caràcters especials estan entre cometes dobles
LINES TERMINATED BY '\r\n'        -- Les línies estan separades per salts de línia
IGNORE 1 ROWS                     -- Ignorar la primera fila (capçalera)
(company_id, company_name, phone, email, country, website);

-- Visualitzem la importació de companies.csv a taula companies
SELECT * FROM companies;

-- Creació de la taula products
-- Visualitzem algunes dades de products.csv per a veure com elaborar la taula i tenim en compte la llargada màxima dels registres

/*products						
column	id	product_name	price	colour	weight	warehouse_id
Exemple	99	the duel	$151.78	#212121	1.5	WH--94
	4	warden south duel	$71.89	#111111	3	WH-1
MAX	2	29	7	7	3	6*/

-- Creem taula products

CREATE TABLE products (
    id INT PRIMARY KEY,             -- ID del producte (2 dígits màxim)
    product_name VARCHAR(100),  	-- Nom del producte (29 caràcters màxims)
    price DECIMAL(7,2) NOT NULL,    -- Preu en format decimal (màxim 7 caràcters, incloent decimals)
    colour VARCHAR(10),        		-- Codi de color hexadecimal (#XXXXXX → sempre 7 caràcters)
    weight DECIMAL(5,1),    		-- Pes en format decimal (fins a 5 dígits amb 1 decimal)
    warehouse_id VARCHAR(20) 		-- ID del magatzem (6 caràcters màxims)	
);

-- Visualitzem i verifiquem l'estructura de la taula products
DESCRIBE products;

-- Importació de dades de products.csv a products

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','          -- Els valors estan separats per comes
ENCLOSED BY '"'                   -- Els valors que tenen espais o caràcters especials estan entre cometes dobles
LINES TERMINATED BY '\n'          -- Les línies estan separades per salts de línia. Creat amb LINUX o MAC
IGNORE 1 ROWS                     -- Ignorar la primera fila (capçalera)
(id, product_name, @price, colour, weight, warehouse_id)	-- Substituim el símbol $ de la columna price per un valor buit ('') per eliminar-lo, utilitzant una variable temporal @price.
SET price = REPLACE(@price, '$', '');  -- @price guarda temporalment el valor de la columna price per poder modificar-lo amb REPLACE()

-- Visualitzem la importació de products.csv a taula products
SELECT * FROM products;

-- Creació de la taula transactions
-- Visualitzem algunes dades de transactions.csv per a veure com elaborar la taula i tenim en compte la llargada màxima dels registres

/* transactions										
Column	id	card_id	business_id	timestamp	amount	declined	product_ids	user_id	lat	longitude
Exemple	3C291BE8-CA7C-39BA-76F8-7CB74937EC98	CcU-3652	b-2618	44376,60486	468.49	0	31	267	-1,81059E+11	1,08415E+11
	1DE927AB-29A8-654F-3372-43971B6844AA	CcU-3659	b-2618	44413,6614	440.13	0	73, 79, 97, 13	267	79946738688	9,03733E+11
MAX len	36	8	6	16	6	1	14	3	13	14*/


-- Creació taula transactions
CREATE TABLE transactions (
    id VARCHAR(50) PRIMARY KEY,			-- UUID de la transacció (36 caràcters)
    card_id VARCHAR(20),				-- FOREIGN KEY a credit_cards
    business_id VARCHAR(20),			-- FOREIGN KEY A companies
    timestamp TIMESTAMP,				-- TIMESTAMP
    amount DECIMAL(10, 2),				-- Import de la transacció (fins a 2 decimals, ex: 468.49)
    declined BOOLEAN,				-- Valor que indica si la transacció ha estat rebutjada (0 = FALSE o 1 = TRUE)
    product_ids VARCHAR(200),			-- Llista d'IDs de productes (fins a 14 caràcters)
    user_id INT	,                   	-- FOREIGN KEY A users
    lat FLOAT,                       	-- Latitud amb alta precisió (fins a 14 caràcters, ex: -1,81059E+11)
    longitude FLOAT,					-- Longitud amb alta precisió (fins a 14 caràcters, ex: 1,08415E+11)
    FOREIGN KEY (card_id) REFERENCES credit_cards(id),				-- Creació FOREIGN KEY a taula credit_cards
    FOREIGN KEY (business_id) REFERENCES companies(company_id),		-- Creació FOREIGN KEY a taula companies
    FOREIGN KEY (user_id) REFERENCES users(id)						-- Creació FOREIGN KEY a taula users
);

-- Visualitzem i verifiquem l'estructura de la taula transactions
DESCRIBE transactions
;

-- Importació de dades de transactions.csv a taula transactions

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\transactions.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ';'          -- Els valors estan separats per PUNT I COMA!!
ENCLOSED BY '"'                   -- Els valors que tenen espais o caràcters especials estan entre cometes dobles
LINES TERMINATED BY '\r\n'        -- Les línies estan separades per salts de línia
IGNORE 1 ROWS                     -- Ignorar la primera fila (capçalera)
(id, card_id, business_id, timestamp, amount, declined, product_ids, user_id, lat, longitude);

-- Visualitzem la importació de transactions.csv a taula transactions
SELECT * FROM transactions;

-- Exercici 1 ################################################## Incloure recompte de total_transactions
-- Realitza una subconsulta que mostri tots els usuaris amb més de 30 transaccions utilitzant almenys 2 taules.
/*		Condicions
Taula	Camp	
Users	id	
Users	name	
Users	surname	
Transactions	id	count
*/

-- Fem la consulta amb subconsultes 
SELECT u.id, u.name, u.surname, 
    (SELECT COUNT(*) FROM transactions AS t WHERE t.user_id = u.id) AS total_transaccions
FROM users AS u
WHERE id IN (
    SELECT user_id 
    FROM transactions 
    GROUP BY user_id 
    HAVING COUNT(id) > 30
);

-- El mateix pero amb JOIN
SELECT u.id, u.name, u.surname, COUNT(t.id) AS total_transactions
FROM users AS u
JOIN transactions AS t 
ON u.id = t.user_id
GROUP BY u.id, u.name, u.surname
HAVING total_transactions > 30;

-- Exercici 2
-- Mostra la mitjana d'amount per IBAN de les targetes de crèdit a la companyia Donec Ltd, utilitza almenys 2 taules.

SELECT c.company_name, c_c.iban, ROUND(AVG(t.amount),2) AS mitjana_import
FROM companies AS C
JOIN transactions AS t ON c.company_id = t.business_id
JOIN users AS u ON u.id = t.user_id
JOIN credit_cards AS c_c ON c_c.id = t.card_id
WHERE c.company_name = 'Donec Ltd'
GROUP BY c.company_name, c_c.iban;


#################################################### Nivell 2 ##############################################################################

-- Crea una nova taula que reflecteixi l'estat de les targetes de crèdit basat en si les últimes tres transaccions van ser declinades i genera la següent consulta:

-- Creem la taula credit_card_estat que contindrà les dades

CREATE TABLE credit_card_estat (
    card_id VARCHAR(20) PRIMARY KEY,    
    estat ENUM('activa', 'bloquejada') NOT NULL -- ENUM permet que hi hagi 2 possibilitats exclusivament anomenades 'activa' i 'bloquejada' 
);

-- Visualitzem i verifiquem l'estructura de la taula
DESCRIBE credit_card_estat
;

-- ANIREM PAS A PAS PER A FER CADA PART
-- Numerar les transaccions per cada targeta
-- ROW_NUMBER() enumerarà consecutivament les transaccions (t.id) de cada card_id ordenant-les per timestamp de més recent a més antiga
-- PARTITION BY t.card_id dividirà les dades per card_id (cada targeta té la seva numeració independent).
SELECT t.card_id, t.id, t.timestamp, t.declined,  
       ROW_NUMBER() OVER (PARTITION BY t.card_id ORDER BY t.timestamp DESC) AS numero_transaccio
       FROM transactions AS t;
       
-- Filtrar targetes amb almenys 3 transaccions rebutjades

SELECT t.card_id, t.id, t.timestamp, t.declined,  
       ROW_NUMBER() OVER (PARTITION BY t.card_id ORDER BY t.timestamp DESC) AS numero_transaccio
FROM transactions AS t
WHERE t.card_id IN (
-- Seleccionem targetes que tinguin almenys 3 transaccions rebutjades
    SELECT t.card_id 
    FROM transactions AS t
    WHERE declined = 1
    GROUP BY card_id
    HAVING COUNT(*) >= 3
);

-- Verificar si les últimes 3 transaccions han estat rebutjades
-- Ara filtrem només les últimes 3 transaccions de cada targeta i sumem els valors declined. Si la suma és 3, vol dir que les últimes 3 han estat rebutjades.

SELECT ranking.card_id, ranking.id, SUM(ranking.declined) AS suma_declined
FROM 
(SELECT t.card_id, t.id, t.timestamp, t.declined,  
       ROW_NUMBER() OVER (PARTITION BY t.card_id ORDER BY t.timestamp DESC) AS numero_transaccio
FROM transactions AS t) AS ranking
-- Ens quedem només amb les últimes 3 transaccions de cada targeta
WHERE ranking.numero_transaccio <=3
GROUP BY ranking.id
-- Si la suma de 'declined' és 3, vol dir que les últimes 3 transaccions han estat rebutjades
HAVING suma_declined = 3
;

-- Escriure la consulta que determina l'estat de cada targeta
-- Modifiquem la consulta per obtenir quines targetes han tingut les últimes tres transaccions rebutjades (declined = 1).
WITH ultima_transaccio AS (
    SELECT ranking.card_id,
           SUM(ranking.declined) AS suma_declined
    FROM (
        SELECT card_id, declined,
               ROW_NUMBER() OVER (PARTITION BY card_id ORDER BY timestamp DESC) AS numero_transaccio
        FROM transactions t) AS ranking
    WHERE ranking.numero_transaccio <= 3
    GROUP BY ranking.card_id
)
SELECT COUNT(card_id) AS recompte_targetes,
       CASE WHEN suma_declined = 3 THEN 'bloquejada' ELSE 'activa' END AS estat
FROM ultima_transaccio
GROUP BY estat;

-- Escriure la consulta que determina l'estat de cada targeta
-- Modifiquem la consulta per obtenir quines targetes han tingut les últimes tres transaccions rebutjades (declined = 1).
-- Determinem l'estat de cada targeta (activa o bloquejada)
-- Per últim fem un INSERT TO a la taula credit_card_estat amb les dades de la consulta

INSERT INTO credit_card_estat (card_id, estat)
WITH ultima_transaccio AS (
    SELECT ranking.card_id,
           SUM(ranking.declined) AS suma_declined
    FROM (
        SELECT card_id, declined,
               ROW_NUMBER() OVER (PARTITION BY card_id ORDER BY timestamp DESC) AS numero_transaccio
        FROM transactions AS t
    ) AS ranking
    WHERE ranking.numero_transaccio <= 3
    GROUP BY ranking.card_id
)
SELECT ranking.card_id,
       CASE 
           WHEN suma_declined = 3 THEN 'bloquejada'
           ELSE 'activa'
       END AS estat
FROM ultima_transaccio AS ranking
GROUP BY ranking.card_id, estat;

-- Es crea una subconsulta (WITH ultima_transaccio AS (...)) que calcula quantes de les últimes 3 transaccions han estat rebutjades per cada card_id.
-- S'usa CASE WHEN per determinar l'estat:

-- Si total_declined = 3, aleshores la targeta està bloquejada.
-- En qualsevol altre cas, està activa.
-- S'insereixen els resultats a la taula credit_card_estat amb INSERT INTO


-- Exercici 1
-- Quantes targetes estan actives?
SELECT COUNT(*) AS targetes_actives
FROM credit_card_estat
WHERE estat = 'activa';

########################################################## Nivell 3 #######################################################################
-- Crea una taula amb la qual puguem unir les dades del nou arxiu products.csv amb la base de dades creada, tenint en compte que des de transaction tens product_ids. Genera la següent consulta:


-- Creació taula intermitja transactions_products
CREATE TABLE transactions_products (
transaction_id VARCHAR(50), 
product_id INT,
PRIMARY KEY(transaction_id, product_id),
FOREIGN KEY (transaction_id) REFERENCES transactions(id),
FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Visualitzem la estructura i composició de la taula transactions_products
DESCRIBE transactions_products;

-- Exercici 1
-- Necessitem conèixer el nombre de vegades que s'ha venut cada producte.
    
  INSERT INTO transactions_products (transaction_id, product_id)
SELECT 
    t.id AS transaction_id,
    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(t.product_ids, ',', n.n), ',', -1) AS UNSIGNED) AS product_id
FROM 
    transactions t
JOIN 
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) n
WHERE 
    CHAR_LENGTH(t.product_ids) - CHAR_LENGTH(REPLACE(t.product_ids, ',', '')) >= n.n - 1;  
  --  Aquest codi desglossa la llista de product_ids per separa els productes que hi ha a cada transacció. L'ús de SUBSTRING_INDEX permet separar la cadena per comes i crear una fila per cada producte. Aquesta consulta utilitza una taula auxiliar de números per determinar quants productes hi ha a cada llista.

-- Pas 2: Comptar les vegades que cada producte ha estat venut.
-- Ara podem comptar les vegades que s'ha venut cada producte
SELECT tp.product_id, COUNT(tp.product_id) AS total_productes_venuts, p.price
FROM transactions_products AS tp
JOIN products AS p
ON p.id = tp.product_id
GROUP BY 1;