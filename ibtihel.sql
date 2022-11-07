SET SERVEROUTPUT ON
/* Create new user "new_admin" and Grant roles and previledges" */
DROP user "NEW_ADMIN";
CREATE USER new_admin IDENTIFIED BY abc;
GRANT CONNECT TO new_admin;
GRANT CONNECT, RESOURCE, DBA TO new_admin;
GRANT CREATE SESSION, GRANT ANY PRIVILEGE TO new_admin;
GRANT UNLIMITED TABLESPACE TO new_admin;
GRANT
 SELECT,
 INSERT,
 UPDATE,
 DELETE
ON
 Donor
TO
 new_admin;
GRANT
 SELECT,
 INSERT,
 UPDATE,
 DELETE
ON
 White_coats
TO
 new_admin;
GRANT
 SELECT,
 INSERT,
 UPDATE,
 DELETE
ON
 Blood_migration
TO
 new_admin;
GRANT
 SELECT,
 INSERT,
 UPDATE,
 DELETE
ON
 Blood_donation
TO
 new_admin;
GRANT
 SELECT,
 INSERT,
 UPDATE,
 DELETE
ON
 Patient
TO
 new_admin;

/* to know the name of my server */
SELECT * FROM GLOBAL_NAME;

/* Create procedures */
/* PROCEDURE1: Display all information about a blood donor whose ID is specified */
CREATE OR REPLACE PROCEDURE donor_information (x_donor_ID IN Donor.donor_ID%TYPE)
IS
y_donor_ID Donor.donor_ID%TYPE;
x_d_first_name Donor.d_first_name%TYPE;
x_d_last_name Donor.d_last_name%TYPE;
x_d_age Donor.d_age%TYPE;
x_d_gender Donor.d_gender%TYPE;
x_d_address Donor.d_address%TYPE;
x_d_phone_num Donor.d_phone_num%TYPE;
x_d_email Donor.d_email%TYPE;
x_d_blood_type Donor.d_blood_type%TYPE;
BEGIN
SELECT * INTO y_donor_ID,x_d_first_name, x_d_last_name, x_d_age, x_d_gender, 
              x_d_address, x_d_phone_num, x_d_email, x_d_blood_type FROM Donor WHERE donor_ID=x_donor_ID;
DBMS_OUTPUT.PUT_LINE(y_donor_ID || '  ' || x_d_first_name || ' ' || x_d_last_name 
                     || '  ' || x_d_age || '  ' || x_d_gender || '  ' || x_d_address 
                     || '  ' || x_d_phone_num || '  ' || x_d_email || '  ' || x_d_blood_type);
EXCEPTION                     
WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20001,'There is no donor with such ID');
END donor_information;

/* PROCEDURE2: Display all information about a patient whose ID is specified */
CREATE OR REPLACE PROCEDURE patient_information (x_patient_ID IN Patient.patient_ID%TYPE)
IS
p_info_rec Patient%ROWTYPE;
BEGIN
SELECT * INTO p_info_rec FROM Patient WHERE patient_ID=x_patient_ID;
DBMS_OUTPUT.PUT_LINE(p_info_rec.patient_ID || '  ' || p_info_rec.p_first_name || ' ' || p_info_rec.p_last_name || '  ' ||  
                     p_info_rec.p_age || '  ' || p_info_rec.p_gender || '  ' ||  p_info_rec.p_address || '  ' || 
                     p_info_rec.p_phone_num || '  ' || p_info_rec.p_email || '  ' || p_info_rec.p_blood_type);
EXCEPTION                     
WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20002,'There is no patient with such ID');
END patient_information;

/* PROCEDURE3: Display all information about a white coat (a doctor or a nurse) whose ID is specified */
CREATE OR REPLACE PROCEDURE white_coats_information (x_white_coats_ID IN White_coats.coat_ID%TYPE)
IS
c_info_rec White_coats%ROWTYPE;
BEGIN
SELECT * INTO c_info_rec FROM White_coats WHERE coat_ID=x_white_coats_ID;
DBMS_OUTPUT.PUT_LINE(c_info_rec.coat_ID || '  ' || c_info_rec.c_first_name || ' ' || c_info_rec.c_last_name || '  ' ||  
                     c_info_rec.c_age || '  ' || c_info_rec.c_address || '  ' || 
                     c_info_rec.c_phone_num || '  ' || c_info_rec.c_email || '  ' || c_info_rec.y_experience);
EXCEPTION                     
WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20003,'There is no doctor or nurse with such ID');
END white_coats_information;

/* PROCEDURE4: Display the name and blood type of a patient whose ID is specified and IDs and blood types of the donors whose 
   blood types are compatible */
   
CREATE OR REPLACE PROCEDURE compatible_donors (y_patient_ID IN patient.patient_ID%TYPE)
IS
CURSOR C1(bt1 Donor.d_blood_type%TYPE, bt2 Donor.d_blood_type%TYPE, bt3 Donor.d_blood_type%TYPE, bt4 Donor.d_blood_type%TYPE, 
          bt5 Donor.d_blood_type%TYPE, bt6 Donor.d_blood_type%TYPE, bt7 Donor.d_blood_type%TYPE, bt8 Donor.d_blood_type%TYPE) IS 
                (SELECT donor_ID, d_blood_type FROM DONOR WHERE d_blood_type=bt1 OR d_blood_type=bt2 
                                                             OR d_blood_type=bt3 OR d_blood_type=bt4 
                                                             OR d_blood_type=bt5 OR d_blood_type=bt6
                                                             OR d_blood_type=bt7 OR d_blood_type=bt8);                                                                                              
first_name Donor.d_first_name%TYPE;
last_name Donor.d_last_name%TYPE;
patient_bt Patient.p_blood_type%TYPE;
c_donor_ID Donor.donor_ID%TYPE;
compatible_bt Patient.p_blood_type%TYPE;
BEGIN
SELECT p_first_name, p_last_name, p_blood_type INTO first_name, last_name, patient_bt FROM Patient WHERE patient_ID=y_patient_ID;
IF patient_bt = 'AB+' THEN
DBMS_OUTPUT.PUT_LINE('patient name: ' || first_name || ' ' || last_name || ' his/her blood type :' || patient_bt);
OPEN C1('O-', 'O+', 'A-', 'A+', 'B-', 'B+', 'AB-', 'AB+');
LOOP
FETCH C1 INTO c_donor_ID, compatible_bt;
EXIT WHEN C1%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE('compatible donor ID: ' || c_donor_ID || ' his/her blood type: ' || compatible_bt);
END LOOP;
CLOSE C1;

ELSIF patient_bt = 'AB-' THEN
DBMS_OUTPUT.PUT_LINE('patient name: ' || first_name || ' ' || last_name || ' his/her blood type :' || patient_bt);
OPEN C1('O-', 'O-', 'A-', 'A-', 'B-', 'B-', 'AB-', 'AB-');
LOOP
FETCH C1 INTO c_donor_ID, compatible_bt;
EXIT WHEN C1%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE('compatible donor ID: ' || c_donor_ID || ' his/her blood type: ' || compatible_bt);
END LOOP;
CLOSE C1;

ELSIF patient_bt = 'A+' THEN
DBMS_OUTPUT.PUT_LINE('patient name: ' || first_name || ' ' || last_name || ' his/her blood type :' || patient_bt);
OPEN C1('O-', 'O+', 'A-', 'A+', 'O-', 'A-', 'O+', 'A+');
LOOP
FETCH C1 INTO c_donor_ID, compatible_bt;
EXIT WHEN C1%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE('compatible donor ID: ' || c_donor_ID || ' his/her blood type: ' || compatible_bt);
END LOOP;
CLOSE C1;

ELSIF patient_bt = 'A-' THEN
DBMS_OUTPUT.PUT_LINE('patient name: ' || first_name || ' ' || last_name || ' his/her blood type :' || patient_bt);
OPEN C1('O-', 'O-', 'A-', 'A-', 'O-', 'O-', 'A-', 'A-');
LOOP
FETCH C1 INTO c_donor_ID, compatible_bt;
EXIT WHEN C1%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE('compatible donor ID: ' || c_donor_ID || ' his/her blood type: ' || compatible_bt);
END LOOP;
CLOSE C1;

ELSIF patient_bt = 'B+' THEN
DBMS_OUTPUT.PUT_LINE('patient name: ' || first_name || ' ' || last_name || ' his/her blood type :' || patient_bt);
OPEN C1('O-', 'O+', 'B-', 'O-', 'B-', 'B+', 'B-', 'B+');
LOOP
FETCH C1 INTO c_donor_ID, compatible_bt;
EXIT WHEN C1%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE('compatible donor ID: ' || c_donor_ID || ' his/her blood type: ' || compatible_bt);
END LOOP;
CLOSE C1;

ELSIF patient_bt = 'B-' THEN
DBMS_OUTPUT.PUT_LINE('patient name: ' || first_name || ' ' || last_name || ' his/her blood type :' || patient_bt);
OPEN C1('O-', 'B-', 'O-', 'B-', 'O-', 'B-', 'O-', 'B-');
LOOP
FETCH C1 INTO c_donor_ID, compatible_bt;
EXIT WHEN C1%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE('compatible donor ID: ' || c_donor_ID || ' his/her blood type: ' || compatible_bt);
END LOOP;
CLOSE C1;

ELSIF patient_bt = 'O+' THEN
DBMS_OUTPUT.PUT_LINE('patient name: ' || first_name || ' ' || last_name || ' his/her blood type :' || patient_bt);
OPEN C1('O-', 'O+', 'O-', 'O+', 'O-', 'O+', 'O-', 'O+');
LOOP
FETCH C1 INTO c_donor_ID, compatible_bt;
EXIT WHEN C1%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE('compatible donor ID: ' || c_donor_ID || ' his/her blood type: ' || compatible_bt);
END LOOP;
CLOSE C1;

ELSIF patient_bt = 'O-' THEN
DBMS_OUTPUT.PUT_LINE('patient name: ' || first_name || ' ' || last_name || ' his/her blood type :' || patient_bt);
OPEN C1('O-', 'O-', 'O-', 'O-', 'O-', 'O-', 'O-', 'O-');
LOOP
FETCH C1 INTO c_donor_ID, compatible_bt;
EXIT WHEN C1%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE('compatible donor ID: ' || c_donor_ID || ' his/her blood type: ' || compatible_bt);
END LOOP;
CLOSE C1;
END IF;
END compatible_donors;

/* PROCEDURE5: Display the total number of blood bags (leters) in stock categorized by blood type */

CREATE OR REPLACE PROCEDURE total_blood_in_stock
IS
CURSOR C3 IS SELECT donor.d_blood_type, SUM(Blood_donation.quantity_donated) FROM Blood_donation, Blood_migration, Donor
             WHERE Blood_donation.blood_bag_num != Blood_migration.blood_bag_num AND Donor.donor_ID=Blood_donation.donor_ID
             GROUP BY donor.d_blood_type;
in_stock Blood_donation.quantity_donated%TYPE;
blood_t donor.d_blood_type%TYPE;
BEGIN
OPEN C3;
LOOP
FETCH C3 INTO blood_t, in_stock;
EXIT WHEN C3%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE ('Blood type: ' || blood_t || ' Quantity in stock: ' || in_stock);
END LOOP;
CLOSE C3;
END total_blood_in_stock;

/* PROCEDURE6: Display the number of blood bags (leters) in stock where blood type is specified */
CREATE OR REPLACE PROCEDURE blood_in_stock (blood_type IN Donor.d_blood_type%TYPE)
IS
in_stock Blood_donation.quantity_donated%TYPE;
BEGIN
SELECT SUM(Blood_donation.quantity_donated) INTO in_stock FROM Blood_donation, Blood_migration, Donor
       WHERE Blood_donation.blood_bag_num != Blood_migration.blood_bag_num AND Donor.d_blood_type=blood_type 
       AND Donor.donor_ID=Blood_donation.donor_ID;
DBMS_OUTPUT.PUT_LINE ('Blood type: ' || blood_type || ' Quantity in stock: ' || in_stock);
END blood_in_stock;

/*_______________________________________________________________________________________________________________________________________________*/

/* Create functions */
/* FUNCTION1: Display the remaining period until the expiration date of an existing blood bag in the bank 
where the blood bag number is specified (the experation period of a blood bag is 42 days*/
CREATE OR REPLACE FUNCTION blood_expiration (specified_blood_bag IN Blood_donation.blood_bag_num%TYPE) RETURN VARCHAR
IS
expiration NUMBER;
bagmigration Blood_donation.bag_migration%TYPE;
expired EXCEPTION;
migrated EXCEPTION;
BEGIN
SELECT 42-(SYSDATE-1-donation_date), bag_migration INTO expiration, bagmigration FROM Blood_donation WHERE blood_bag_num=specified_blood_bag;
IF expiration < 0 AND bagmigration IS NULL THEN RAISE expired;
ELSIF bagmigration = 'migrated' THEN RAISE migrated;
ELSE
RETURN TO_CHAR(ROUND(expiration)) || ' days';
END IF;
EXCEPTION
WHEN expired THEN RETURN 'the blood bag expired ' || TO_CHAR(ROUND(-expiration)) || ' days ago';
WHEN migrated THEN RETURN 'the blood bag has already been migrated';
END blood_expiration;



/*_______________________________________________________________________________________________________________________________________________*/

/* Create triggers */
/* TRIGGER1: After insertion on Blood_migration, update the column bag_migration in Blood_donation and set 
it to 'migrated' to indicate that that specefic bag was already migrated */
CREATE OR REPLACE TRIGGER migrate_bloood 
AFTER INSERT ON Blood_migration
FOR EACH ROW
BEGIN
UPDATE Blood_Donation
SET bag_migration = 'migrated'
WHERE Blood_donation.blood_bag_num=:NEW.blood_bag_num;
END;

/* TRIGGER2: all donors that have donated blood on the World Blood Donor Day (14/JUN/2021) will be automatically 
inserted to another table (to enter a toss to win gifts later on) */
CREATE TABLE Toss (xDonor_ID INT);
CREATE OR REPLACE TRIGGER World_Blood_Donor_Day
AFTER INSERT ON Blood_donation
FOR EACH ROW
BEGIN
IF :NEW.donation_date ='14/JUN/2021' THEN
INSERT INTO TOSS (xDonor_ID)
VALUES (:NEW.donor_ID);
END IF;
END;

/* Create one package containing all functions, procedures and triggers */
/* Create package specification */
CREATE OR REPLACE PACKAGE blood_bank_pack AS
PROCEDURE donor_information (x_donor_ID IN Donor.donor_ID%TYPE);
PROCEDURE patient_information (x_patient_ID IN Patient.patient_ID%TYPE);
PROCEDURE white_coats_information (x_white_coats_ID IN White_coats.coat_ID%TYPE);
PROCEDURE compatible_donors (y_patient_ID IN patient.patient_ID%TYPE);
PROCEDURE total_blood_in_stock;
PROCEDURE blood_in_stock (blood_type IN Donor.d_blood_type%TYPE);
FUNCTION blood_expiration (specified_blood_bag IN Blood_donation.blood_bag_num%TYPE) RETURN VARCHAR;
END blood_bank_pack;

/* create package body */
CREATE OR REPLACE PACKAGE BODY blood_bank_pack AS
PROCEDURE donor_information (x_donor_ID IN Donor.donor_ID%TYPE) IS
y_donor_ID Donor.donor_ID%TYPE;
x_d_first_name Donor.d_first_name%TYPE;
x_d_last_name Donor.d_last_name%TYPE;
x_d_age Donor.d_age%TYPE;
x_d_gender Donor.d_gender%TYPE;
x_d_address Donor.d_address%TYPE;
x_d_phone_num Donor.d_phone_num%TYPE;
x_d_email Donor.d_email%TYPE;
x_d_blood_type Donor.d_blood_type%TYPE;
BEGIN
SELECT * INTO y_donor_ID,x_d_first_name, x_d_last_name, x_d_age, x_d_gender, 
              x_d_address, x_d_phone_num, x_d_email, x_d_blood_type FROM Donor WHERE donor_ID=x_donor_ID;
DBMS_OUTPUT.PUT_LINE(y_donor_ID || '  ' || x_d_first_name || ' ' || x_d_last_name 
                     || '  ' || x_d_age || '  ' || x_d_gender || '  ' || x_d_address 
                     || '  ' || x_d_phone_num || '  ' || x_d_email || '  ' || x_d_blood_type);
EXCEPTION                     
WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20001,'There is no donor with such ID');
END donor_information;

PROCEDURE patient_information (x_patient_ID IN Patient.patient_ID%TYPE)
IS
p_info_rec Patient%ROWTYPE;
BEGIN
SELECT * INTO p_info_rec FROM Patient WHERE patient_ID=x_patient_ID;
DBMS_OUTPUT.PUT_LINE(p_info_rec.patient_ID || '  ' || p_info_rec.p_first_name || ' ' || p_info_rec.p_last_name || '  ' ||  
                     p_info_rec.p_age || '  ' || p_info_rec.p_gender || '  ' ||  p_info_rec.p_address || '  ' || 
                     p_info_rec.p_phone_num || '  ' || p_info_rec.p_email || '  ' || p_info_rec.p_blood_type);
EXCEPTION                     
WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20002,'There is no patient with such ID');
END patient_information;

PROCEDURE white_coats_information (x_white_coats_ID IN White_coats.coat_ID%TYPE)
IS
c_info_rec White_coats%ROWTYPE;
BEGIN
SELECT * INTO c_info_rec FROM White_coats WHERE coat_ID=x_white_coats_ID;
DBMS_OUTPUT.PUT_LINE(c_info_rec.coat_ID || '  ' || c_info_rec.c_first_name || ' ' || c_info_rec.c_last_name || '  ' ||  
                     c_info_rec.c_age || '  ' || c_info_rec.c_address || '  ' || 
                     c_info_rec.c_phone_num || '  ' || c_info_rec.c_email || '  ' || c_info_rec.y_experience);
EXCEPTION                     
WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20003,'There is no doctor or nurse with such ID');
END white_coats_information;

PROCEDURE compatible_donors (y_patient_ID IN patient.patient_ID%TYPE)
IS
CURSOR C1(bt1 Donor.d_blood_type%TYPE, bt2 Donor.d_blood_type%TYPE, bt3 Donor.d_blood_type%TYPE, bt4 Donor.d_blood_type%TYPE, 
          bt5 Donor.d_blood_type%TYPE, bt6 Donor.d_blood_type%TYPE, bt7 Donor.d_blood_type%TYPE, bt8 Donor.d_blood_type%TYPE) IS 
                (SELECT donor_ID, d_blood_type FROM DONOR WHERE d_blood_type=bt1 OR d_blood_type=bt2 
                                                             OR d_blood_type=bt3 OR d_blood_type=bt4 
                                                             OR d_blood_type=bt5 OR d_blood_type=bt6
                                                             OR d_blood_type=bt7 OR d_blood_type=bt8);                                                                                              
first_name Donor.d_first_name%TYPE;
last_name Donor.d_last_name%TYPE;
patient_bt Patient.p_blood_type%TYPE;
c_donor_ID Donor.donor_ID%TYPE;
compatible_bt Patient.p_blood_type%TYPE;
BEGIN
SELECT p_first_name, p_last_name, p_blood_type INTO first_name, last_name, patient_bt FROM Patient WHERE patient_ID=y_patient_ID;
IF patient_bt = 'AB+' THEN
DBMS_OUTPUT.PUT_LINE('patient name: ' || first_name || ' ' || last_name || ' his/her blood type :' || patient_bt);
OPEN C1('O-', 'O+', 'A-', 'A+', 'B-', 'B+', 'AB-', 'AB+');
LOOP
FETCH C1 INTO c_donor_ID, compatible_bt;
EXIT WHEN C1%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE('compatible donor ID: ' || c_donor_ID || ' his/her blood type: ' || compatible_bt);
END LOOP;
CLOSE C1;

ELSIF patient_bt = 'AB-' THEN
DBMS_OUTPUT.PUT_LINE('patient name: ' || first_name || ' ' || last_name || ' his/her blood type :' || patient_bt);
OPEN C1('O-', 'O-', 'A-', 'A-', 'B-', 'B-', 'AB-', 'AB-');
LOOP
FETCH C1 INTO c_donor_ID, compatible_bt;
EXIT WHEN C1%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE('compatible donor ID: ' || c_donor_ID || ' his/her blood type: ' || compatible_bt);
END LOOP;
CLOSE C1;

ELSIF patient_bt = 'A+' THEN
DBMS_OUTPUT.PUT_LINE('patient name: ' || first_name || ' ' || last_name || ' his/her blood type :' || patient_bt);
OPEN C1('O-', 'O+', 'A-', 'A+', 'O-', 'A-', 'O+', 'A+');
LOOP
FETCH C1 INTO c_donor_ID, compatible_bt;
EXIT WHEN C1%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE('compatible donor ID: ' || c_donor_ID || ' his/her blood type: ' || compatible_bt);
END LOOP;
CLOSE C1;

ELSIF patient_bt = 'A-' THEN
DBMS_OUTPUT.PUT_LINE('patient name: ' || first_name || ' ' || last_name || ' his/her blood type :' || patient_bt);
OPEN C1('O-', 'O-', 'A-', 'A-', 'O-', 'O-', 'A-', 'A-');
LOOP
FETCH C1 INTO c_donor_ID, compatible_bt;
EXIT WHEN C1%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE('compatible donor ID: ' || c_donor_ID || ' his/her blood type: ' || compatible_bt);
END LOOP;
CLOSE C1;

ELSIF patient_bt = 'B+' THEN
DBMS_OUTPUT.PUT_LINE('patient name: ' || first_name || ' ' || last_name || ' his/her blood type :' || patient_bt);
OPEN C1('O-', 'O+', 'B-', 'O-', 'B-', 'B+', 'B-', 'B+');
LOOP
FETCH C1 INTO c_donor_ID, compatible_bt;
EXIT WHEN C1%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE('compatible donor ID: ' || c_donor_ID || ' his/her blood type: ' || compatible_bt);
END LOOP;
CLOSE C1;

ELSIF patient_bt = 'B-' THEN
DBMS_OUTPUT.PUT_LINE('patient name: ' || first_name || ' ' || last_name || ' his/her blood type :' || patient_bt);
OPEN C1('O-', 'B-', 'O-', 'B-', 'O-', 'B-', 'O-', 'B-');
LOOP
FETCH C1 INTO c_donor_ID, compatible_bt;
EXIT WHEN C1%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE('compatible donor ID: ' || c_donor_ID || ' his/her blood type: ' || compatible_bt);
END LOOP;
CLOSE C1;

ELSIF patient_bt = 'O+' THEN
DBMS_OUTPUT.PUT_LINE('patient name: ' || first_name || ' ' || last_name || ' his/her blood type :' || patient_bt);
OPEN C1('O-', 'O+', 'O-', 'O+', 'O-', 'O+', 'O-', 'O+');
LOOP
FETCH C1 INTO c_donor_ID, compatible_bt;
EXIT WHEN C1%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE('compatible donor ID: ' || c_donor_ID || ' his/her blood type: ' || compatible_bt);
END LOOP;
CLOSE C1;

ELSIF patient_bt = 'O-' THEN
DBMS_OUTPUT.PUT_LINE('patient name: ' || first_name || ' ' || last_name || ' his/her blood type :' || patient_bt);
OPEN C1('O-', 'O-', 'O-', 'O-', 'O-', 'O-', 'O-', 'O-');
LOOP
FETCH C1 INTO c_donor_ID, compatible_bt;
EXIT WHEN C1%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE('compatible donor ID: ' || c_donor_ID || ' his/her blood type: ' || compatible_bt);
END LOOP;
CLOSE C1;
END IF;
END compatible_donors;

PROCEDURE total_blood_in_stock
IS
CURSOR C3 IS SELECT donor.d_blood_type, SUM(Blood_donation.quantity_donated) FROM Blood_donation, Blood_migration, Donor
             WHERE Blood_donation.blood_bag_num != Blood_migration.blood_bag_num AND Donor.donor_ID=Blood_donation.donor_ID
             GROUP BY donor.d_blood_type;
in_stock Blood_donation.quantity_donated%TYPE;
blood_t donor.d_blood_type%TYPE;
BEGIN
OPEN C3;
LOOP
FETCH C3 INTO blood_t, in_stock;
EXIT WHEN C3%NOTFOUND; 
DBMS_OUTPUT.PUT_LINE ('Blood type: ' || blood_t || ' Quantity in stock: ' || in_stock);
END LOOP;
CLOSE C3;
END total_blood_in_stock;

PROCEDURE blood_in_stock (blood_type IN Donor.d_blood_type%TYPE)
IS
in_stock Blood_donation.quantity_donated%TYPE;
BEGIN
SELECT SUM(Blood_donation.quantity_donated) INTO in_stock FROM Blood_donation, Blood_migration, Donor
       WHERE Blood_donation.blood_bag_num != Blood_migration.blood_bag_num AND Donor.d_blood_type=blood_type 
       AND Donor.donor_ID=Blood_donation.donor_ID;
DBMS_OUTPUT.PUT_LINE ('Blood type: ' || blood_type || ' Quantity in stock: ' || in_stock);
END blood_in_stock;

FUNCTION blood_expiration (specified_blood_bag IN Blood_donation.blood_bag_num%TYPE) RETURN VARCHAR
IS
expiration NUMBER;
bagmigration Blood_donation.bag_migration%TYPE;
expired EXCEPTION;
migrated EXCEPTION;
BEGIN
SELECT 42-(SYSDATE-1-donation_date), bag_migration INTO expiration, bagmigration FROM Blood_donation WHERE blood_bag_num=specified_blood_bag;
IF expiration < 0 AND bagmigration IS NULL THEN RAISE expired;
ELSIF bagmigration = 'migrated' THEN RAISE migrated;
ELSE
RETURN TO_CHAR(ROUND(expiration)) || ' days';
END IF;
EXCEPTION
WHEN expired THEN RETURN 'the blood bag expired ' || TO_CHAR(ROUND(-expiration)) || ' days ago';
WHEN migrated THEN RETURN 'the blood bag has already been migrated';
END blood_expiration;
END blood_bank_pack;

/* EXECUTE PROCEDURES AND FUNCTIONS */
/* execute PROCEDURE1 donor_information */
EXECUTE donor_information (1234); /* in case of exception */ EXECUTE donor_information (9783);

/* execute PROCEDURE2 patient_information */
EXECUTE patient_information (3245); /* in case of exception */ EXECUTE patient_information (9783);

/* execute PROCEDURE3 white_coats_information */
EXECUTE white_coats_information (8123); /* in case of exception */ EXECUTE white_coats_information (9783);

/* execute PROCEDURE4 compatible_donors */
EXECUTE compatible_donors (4789);

/* execute PROCEDURE5 total_blood_in_stock */
EXECUTE total_blood_in_stock;

/* execute PROCEDURE6 blood_in_stock */
EXECUTE blood_in_stock ('A-');

/* execute FUNCTION1 blood_expiration */
VARIABLE expires_in VARCHAR2(50);
EXECUTE :expires_in:= blood_expiration(123556);
PRINT expires_in;                               /* in case of exception 1 */ VARIABLE expires_in VARCHAR2(50);
                                                                             EXECUTE :expires_in:= blood_expiration(423456);
                                                                             PRINT expires_in;
                                                                             
                                                /* in case of exception 2 */ VARIABLE expires_in VARCHAR2(50);
                                                                             EXECUTE :expires_in:= blood_expiration(123456);
                                                                             PRINT expires_in;                             


