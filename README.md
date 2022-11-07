# Blood-Bank-Database-Management
This project is a useful yet a must-have system for the blood bank’s administration to visualize their assets and 
organize their processes depending on their patient’s blood types. 
In fact, The system also records the processes of donating as well as migrating blood bags by blood bags’ numbers. 
It contains one major package “blood_bank_pack” containing 6 procedures and 1 function described as followed:

Procedure1: Donor_information: It takes a donor’s ID as a parameter and displays all information about that
specified donor.

Procedure2: Patient_information: It takes a patient’s ID as a parameter and displays all information about that
specified patient.

Procedure3: White_coats_information: It takes a doctor or a nurse’s ID as a parameter and displays all information 
about that specified person.

Procedure4: compatible_donors: It takes a patient’s ID as a parameter then displays his blood type and lists all 
potential compatible donors with their blood types within the database.

Procedure5: total_blood_in_stock: It displays the total number of blood bags (1 bag = 1 leter) in stock categorized 
by blood type.

Procedure6: blood_in_stock: It takes a blood type as a parameter and displays the number of blood bags available 
of the specified type.

Function1: blood_expiration: Blood bags can remain in stock up to 42 days. So this function takes a blood bag 
number as a parameter and returns the remaining period until the expiration date of that specified blood bag. It also 
handles two exceptions: first, if the blood bag has already been migrated, the function returns a message ‘the blood 
bag has already been migrated’, second, if the blood bag has expired, it returns a message saying the blood bag 
expired and specifies how many days ago.


Along with the project comes a dashboard (a PowerBI file) containing 4 pages that describe data, transform them 
into meaningful information and allow the blood bank administration to visualize them to make reasonable 
decisions.

