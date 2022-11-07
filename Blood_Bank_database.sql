/* Drop tables */

DROP TABLE Blood_migration;
DROP TABLE Blood_donation;
DROP TABLE TOSS;
DROP TABLE White_coats;
DROP TABLE Patient;
DROP TABLE Donor;
/* create Tables */

/* Donor */

CREATE TABLE Donor(
donor_ID INT NOT NULL,
d_first_name VARCHAR(30) NOT NULL,
d_last_name VARCHAR(30) NOT NULL,
d_age NUMBER(2) NOT NULL,
d_gender CHARACTER,
d_address VARCHAR(30) NOT NULL,
d_phone_num VARCHAR(8) NOT NULL,
d_email VARCHAR(30) NOT NULL,
d_blood_type VARCHAR(3) NOT NULL,
PRIMARY KEY (donor_ID));


/* Patient */

CREATE TABLE Patient(
patient_ID INT NOT NULL,
p_first_name VARCHAR(30) NOT NULL,
p_last_name VARCHAR(30) NOT NULL,
p_age NUMBER(2) NOT NULL,
p_gender CHARACTER,
p_address VARCHAR(30) NOT NULL,
p_phone_num VARCHAR(8) NOT NULL,
p_email VARCHAR(30) NOT NULL,
p_blood_type VARCHAR(3) NOT NULL,
PRIMARY KEY (patient_ID));


/* White_coats */

CREATE TABLE White_coats(
coat_ID INT NOT NULL,
c_first_name VARCHAR(30) NOT NULL,
c_last_name VARCHAR(30) NOT NULL,
c_age NUMBER(2) NOT NULL,
c_address VARCHAR(30) NOT NULL,
c_phone_num VARCHAR(8) NOT NULL,
c_email VARCHAR(30) NOT NULL,
y_experience NUMBER(2) NOT NULL,
PRIMARY KEY (coat_ID));

/* Blood_donation */

CREATE TABLE Blood_donation(
blood_bag_num INT NOT NULL,
donor_ID INT NOT NULL,
coat_ID INT NOT NULL,
donation_date DATE NOT NULL,
quantity_donated INT NOT NULL,
bag_migration VARCHAR(20) DEFAULT NULL,
PRIMARY KEY (blood_bag_num),
FOREIGN KEY (donor_ID) REFERENCES Donor(donor_ID),
FOREIGN KEY (coat_ID) REFERENCES White_coats(coat_ID));

/* Blood_migration */

CREATE TABLE Blood_migration(
migration_ID INT NOT NULL,
patient_ID INT NOT NULL,
coat_ID INT NOT NULL,
migration_date DATE NOT NULL,
quantity_migrated INT NOT NULL,
blood_bag_num INT NOT NULL,
PRIMARY KEY (migration_ID),
FOREIGN KEY (patient_ID) REFERENCES Patient(patient_ID),
FOREIGN KEY (coat_ID) REFERENCES White_coats(coat_ID),
FOREIGN KEY (blood_bag_num) REFERENCES blood_donation(blood_bag_num));


/* Add records */

/* Insert - Table Donor */
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (1234,'Ons','Benzid',21,'f','Benikhiar-Nabeul','50678098','onsbenzid@gmail.com','O+');
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (1345,'Nour','Jbeli',19,'f','Maamoura-Nabeul','24567890','nourjbeli@gmail.com','A+');
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (1456,'Ibtihel','Gharsalah',20,'f','Kelibia-Nabeul','21346987','ibtihelgharsalah@gmail.com','A+');
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (1567,'Rayen','Benamor',25,'m','Maamoura-Nabeul','98764120','rayenbenamor@gmail.com','O+');
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (1678,'Islem','Naffeti',30,'f','Darchaaben-Nabeul','55789234','islemnaffeti@gmail.com','O+');
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (1789,'Mohamed','Hajji',44,'m','Benikhiar-Nabeul','90712653','mohamedhajji@gmail.com','O+');
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (2345,'Jihed','Benslama',32,'m','Nabeul','56783124','jihedbenslama@gmail.com','O-');
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (2456,'Ghada','Bensmida',57,'f','Slimen-Nabeul','22678935','ghadabensmida@gmail.com','O-');
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (2567,'Maram','Azzouz',28,'f','Korbous-Nabeul','57632146','maramazzouz@gmail.com','A-');
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (2678,'Sondess','Jemai',31,'f','Elmourouj-BenArous','93567821','sondessjemai@gmail.com','B+');
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (2789,'Arij','Gharbi',24,'f','Maamoura-Nabeul','91345987','arijgharbi@gmail.com','B+');
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (2890,'Maissa','Mejri',29,'f','Korbous-Nabeul','57632146','maissamejri@gmail.com','A-');
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (2987,'Nahed','Jarrar',44,'f','Benikhiar-Nabeul','93194821','nahedjarrar@gmail.com','AB+');
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (2912,'Aziza','Midouni',37,'f','Maamoura-Nabeul','91345209','azizamidouni@gmail.com','AB-');
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (2923,'Jannet','Labyedh',33,'f','Maamoura-Nabeul','91345987','jannetlabyedh@gmail.com','O+');
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (2934,'Bilel','Gharbi',23,'m','Kelibia-Nabeul','91314787','bilelgharbi@gmail.com','A+');
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (2945,'Hamza','Werteni',22,'m','Korbous-Nabeul','91345015','hamzawerteni@gmail.com','A+');
insert into Donor (donor_ID,d_first_name,d_last_name,d_age,d_gender,d_address,d_phone_num,d_email,d_blood_type)
values (2900,'Nabila','Mezgheni',36,'m','Maamoura-Nabeul','91567815','nabilamezgheni@gmail.com','B-');

/* Insert - Table Patient */
insert into patient (patient_ID,p_first_name,p_last_name,p_age,p_gender,p_address,p_phone_num,p_email,p_blood_type)
values (3245,'Souad','Makhlouf',52,'f','Maamoura-Nabeul','54678098','souadmakhlouf@gmail.com','O-');
insert into patient (patient_ID,p_first_name,p_last_name,p_age,p_gender,p_address,p_phone_num,p_email,p_blood_type)
values (3456,'Mohamed','Baltagi',67,'m','Maamoura-Nabeul','54634998','mohamedbaltagi@gmail.com','A+');
insert into patient (patient_ID,p_first_name,p_last_name,p_age,p_gender,p_address,p_phone_num,p_email,p_blood_type)
values (3567,'Samira','Sari',43,'f','Benikhiar-Nabeul','43567890','samirasari@gmail.com','B-');
insert into patient (patient_ID,p_first_name,p_last_name,p_age,p_gender,p_address,p_phone_num,p_email,p_blood_type)
values (3678,'Salah','Garrach',32,'m','Darchaaben-Nabeul','42867890','salahgarrach@gmail.com','B+');
insert into patient (patient_ID,p_first_name,p_last_name,p_age,p_gender,p_address,p_phone_num,p_email,p_blood_type)
values (3789,'Layla','Badis',22,'f','Maamoura-Nabeul','56767890','laylabadis@gmail.com','A-');
insert into patient (patient_ID,p_first_name,p_last_name,p_age,p_gender,p_address,p_phone_num,p_email,p_blood_type)
values (3890,'Thouraya','Benslimen',43,'f','Benikhiar-Nabeul','90567890','thourayabenslimen@gmail.com','A-');
insert into patient (patient_ID,p_first_name,p_last_name,p_age,p_gender,p_address,p_phone_num,p_email,p_blood_type)
values (3987,'Bouthayna','Benzayed',43,'f','Nabeul','52367890','bouthainabenzayed@gmail.com','O+');
insert into patient (patient_ID,p_first_name,p_last_name,p_age,p_gender,p_address,p_phone_num,p_email,p_blood_type)
values (4567,'Wael','Maalej',43,'m','Slimen-Nabeul','53467890','waelmaalej@gmail.com','A-');
insert into patient (patient_ID,p_first_name,p_last_name,p_age,p_gender,p_address,p_phone_num,p_email,p_blood_type)
values (4678,'Maher','Chebbi',43,'m','kelibia-Nabeul','97367890','maherchebbi@gmail.com','O-');
insert into patient (patient_ID,p_first_name,p_last_name,p_age,p_gender,p_address,p_phone_num,p_email,p_blood_type)
values (4789,'Akram','Zallel',43,'m','Korbous-Nabeul','42847890','akramzallel@gmail.com','AB+');
insert into patient (patient_ID,p_first_name,p_last_name,p_age,p_gender,p_address,p_phone_num,p_email,p_blood_type)
values (4123,'Saber','Azzouz',43,'m','Benikhiar-Nabeul','56567890','saberazzouz@gmail.com','AB-');

/* Insert - Table White_coats */
insert into White_coats (coat_ID,c_first_name,c_last_name,c_age,c_address,c_phone_num,c_email,y_experience)
values (8123,'Salha','Benthabet',45,'Maamoura-Nabeul','57843236','salhabenthabet@gmail.com',20);
insert into White_coats (coat_ID,c_first_name,c_last_name,c_age,c_address,c_phone_num,c_email,y_experience)
values (8234,'Ines','Dabbebi',29,'BeniKhiar-Nabeul','57509236','inesdabbebi@gmail.com',3);
insert into White_coats (coat_ID,c_first_name,c_last_name,c_age,c_address,c_phone_num,c_email,y_experience)
values (8345,'Bayrem','Gharsallah',34,'DarChaaben-Nabeul','98843236','bayremgharsalah@gmail.com',9);
insert into White_coats (coat_ID,c_first_name,c_last_name,c_age,c_address,c_phone_num,c_email,y_experience)
values (8976,'Mokhtar','Benzid',42,'Maamoura-Nabeul','57847126','mokhtarbenzid@gmail.com',16);

/*uncomment this trigger and run it individually before insertion to the following Table Blood_donation*/

/* CREATE TABLE Toss (xDonor_ID INT); */

/* CREATE OR REPLACE TRIGGER World_Blood_Donor_Day
AFTER INSERT ON Blood_donation
FOR EACH ROW
BEGIN
IF :NEW.donation_date ='14/JUN/2021' THEN
INSERT INTO TOSS (xDonor_ID)
VALUES (:NEW.donor_ID);
END IF;
END; */

/* Insert - Table Blood_donation */
insert into Blood_donation (blood_bag_num,donor_ID,coat_ID,donation_date,quantity_donated,bag_migration)
values (123456,2945,8345,'14/JUN/2021',1,DEFAULT);/*A+*/
insert into Blood_donation (blood_bag_num,donor_ID,coat_ID,donation_date,quantity_donated,bag_migration)
values (223456,2567,8976,'14/JUN/2021',1,DEFAULT);/*A-*/
insert into Blood_donation (blood_bag_num,donor_ID,coat_ID,donation_date,quantity_donated,bag_migration)
values (323456,1678,8123,'14/JUN/2021',1,DEFAULT);/*O+*/
insert into Blood_donation (blood_bag_num,donor_ID,coat_ID,donation_date,quantity_donated,bag_migration)
values (423456,2456,8234,'14/JUN/2021',1,DEFAULT);/*O-*/
insert into Blood_donation (blood_bag_num,donor_ID,coat_ID,donation_date,quantity_donated,bag_migration)
values (523456,2678,8345,'14/JUN/2021',1,DEFAULT);/*B+*/
insert into Blood_donation (blood_bag_num,donor_ID,coat_ID,donation_date,quantity_donated,bag_migration)
values (623456,2900,8123,'19/JUL/2021',1,DEFAULT);/*B-*/
insert into Blood_donation (blood_bag_num,donor_ID,coat_ID,donation_date,quantity_donated,bag_migration)
values (133456,2987,8234,'11/JUL/2021',1,DEFAULT);/*AB+*/
insert into Blood_donation (blood_bag_num,donor_ID,coat_ID,donation_date,quantity_donated,bag_migration)
values (143456,2912,8123,'30/JUL/2021',1,DEFAULT);/*AB-*/
insert into Blood_donation (blood_bag_num,donor_ID,coat_ID,donation_date,quantity_donated,bag_migration)
values (153456,1567,8976,'25/AUG/2021',1,DEFAULT);/*O+*/
insert into Blood_donation (blood_bag_num,donor_ID,coat_ID,donation_date,quantity_donated,bag_migration)
values (163456,1234,8976,'22/DEC/2021',1,DEFAULT);/*O+*/
insert into Blood_donation (blood_bag_num,donor_ID,coat_ID,donation_date,quantity_donated,bag_migration)
values (124456,2934,8234,'30/DEC/2021',1,DEFAULT);/*A+*/
insert into Blood_donation (blood_bag_num,donor_ID,coat_ID,donation_date,quantity_donated,bag_migration)
values (125456,1456,8123,'24/DEC/2021',1,DEFAULT);/*A+*/
insert into Blood_donation (blood_bag_num,donor_ID,coat_ID,donation_date,quantity_donated,bag_migration)
values (126456,2923,8234,'08/DEC/2021',1,DEFAULT);/*O+*/
insert into Blood_donation (blood_bag_num,donor_ID,coat_ID,donation_date,quantity_donated,bag_migration)
values (123556,2345,8234,'11/DEC/2021',1,DEFAULT);/*O-*/

/*uncomment this trigger and run it individually before insertion to the following Table Blood_migration*/
/* CREATE OR REPLACE TRIGGER migrate_bloood 
AFTER INSERT ON Blood_migration
FOR EACH ROW
BEGIN
UPDATE Blood_Donation
SET bag_migration = 'migrated'
WHERE Blood_donation.blood_bag_num=:NEW.blood_bag_num;
END; */

/* Insert - Table Blood_migration */
insert into Blood_migration (migration_ID,patient_ID,coat_ID,migration_date,quantity_migrated,blood_bag_num)
values (123,3789,8234,'22/JUL/2021',1,123456); /* A- <= O- A- */
insert into Blood_migration (migration_ID,patient_ID,coat_ID,migration_date,quantity_migrated,blood_bag_num)
values (134,3678,8123,'25/JUL/2021',1,223456); /* B+ <= O+ O- B+ B- */
insert into Blood_migration (migration_ID,patient_ID,coat_ID,migration_date,quantity_migrated,blood_bag_num)
values (145,4789,8976,'23/AUG/2021',1,323456); /* AB+ <= all */
insert into Blood_migration (migration_ID,patient_ID,coat_ID,migration_date,quantity_migrated,blood_bag_num)
values (156,4123,8345,'06/SEP/2021',1,623456); /* AB- <= O- A- B- AB- */
insert into Blood_migration (migration_ID,patient_ID,coat_ID,migration_date,quantity_migrated,blood_bag_num)
values (178,3567,8345,'15/OCT/2021',1,153456); /* B- <= O- B- */
insert into Blood_migration (migration_ID,patient_ID,coat_ID,migration_date,quantity_migrated,blood_bag_num)
values (180,3567,8345,'15/OCT/2021',1,523456);
commit;




















