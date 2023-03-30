CREATE TABLE Hospital ( -- s a facut
 id_hospital INT NOT NULL,
 hospital_name VARCHAR2(20),
 adress VARCHAR2(20),
 CONSTRAINT hospital_pk PRIMARY KEY (id_hospital)
);

CREATE TABLE Dentist (  -- s a facut
 id_dentist INT NOT NULL,
 first_name VARCHAR2(20),
 last_name VARCHAR2(20),
 CONSTRAINT dentist_pk PRIMARY KEY (id_dentist)
);

CREATE TABLE Patient ( -- s a facut
 id_patient INT NOT NULL,
 first_name VARCHAR2(20),
 last_name VARCHAR2(20),
 CONSTRAINT patient_pk PRIMARY KEY (id_patient)
);

CREATE TABLE Surgery_room ( -- s a facut
 room_number INT NOT NULL,
 status INT NOT NULL CONSTRAINT status_check CHECK (status in (0, 1)),
 CONSTRAINT surgery_room_pk PRIMARY KEY (room_number)
);

CREATE TABLE Contract (  -- s a facut
 id_hospital INT NOT NULL,
 id_dentist INT NOT NULL,
 CONSTRAINT contract_pk1 PRIMARY KEY (id_hospital, id_dentist),
 CONSTRAINT contract_fk1 FOREIGN KEY (id_hospital) REFERENCES Hospital(id_hospital),
 CONSTRAINT contract_fk2 FOREIGN KEY (id_dentist) REFERENCES Dentist(id_dentist)
);

CREATE TABLE Anesthetic (  -- s a facut
 id_anesthetic INT NOT NULL,
 anesthetic_name VARCHAR2(20),
 CONSTRAINT anesthetic_pk PRIMARY KEY (id_anesthetic)
);

CREATE TABLE Material_prosthesis (  -- s a facut
 id_material_prosthesis INT NOT NULL,
 material_prosthesis_name VARCHAR2(20),
 CONSTRAINT material_prosthesis_pk PRIMARY KEY (id_material_prosthesis)
);

CREATE TABLE Surgery (
 id_surgery INT NOT NULL,
 id_dentist INT NOT NULL,
 id_hospital INT NOT NULL,
 room_number INT NOT NULL,
 id_material_prosthesis INT NOT NULL,
 id_anesthetic INT NOT NULL,
 id_patient INT NOT NULL,
 date_surgery DATE NOT NULL,

 CONSTRAINT surgery_pk PRIMARY KEY (id_surgery),
 CONSTRAINT surgery_fk1 FOREIGN KEY (id_dentist) REFERENCES Dentist(id_dentist),
 CONSTRAINT surgery_fk2 FOREIGN KEY (room_number) REFERENCES Surgery_room(room_number),
 CONSTRAINT surgery_fk3 FOREIGN KEY (id_material_prosthesis) REFERENCES Material_prosthesis(id_material_prosthesis),
 CONSTRAINT surgery_fk4 FOREIGN KEY (id_anesthetic) REFERENCES Anesthetic(id_anesthetic),
 CONSTRAINT surgery_fk5 FOREIGN KEY (id_patient) REFERENCES Patient(id_patient),
 CONSTRAINT surgery_fk6 FOREIGN KEY (id_hospital) REFERENCES Hospital(id_hospital)
);

-- INSEREZ VALORI

INSERT INTO Hospital VALUES (1, 'Hospital 1', 'Street 1');
INSERT INTO Hospital VALUES (2, 'Hospital 2', 'Street 2');
INSERT INTO Hospital VALUES (3, 'Hospital 3', 'Street 3');
INSERT INTO Hospital VALUES (4, 'Hospital 4', 'Street 4');
INSERT INTO Hospital VALUES (5, 'Hospital 5', 'Street 5');

INSERT INTO Dentist VALUES (1, 'Alan', 'G');
INSERT INTO Dentist VALUES (2, 'Bogdan', 'G');
INSERT INTO Dentist VALUES (3, 'Cosmin', 'G');
INSERT INTO Dentist VALUES (4, 'Doru', 'G');
INSERT INTO Dentist VALUES (5, 'Emilian', 'G');

INSERT INTO Patient VALUES (1, 'Alan', 'G');
INSERT INTO Patient VALUES (2, 'Bogdan', 'G');
INSERT INTO Patient VALUES (3, 'Cosmin', 'G');
INSERT INTO Patient VALUES (4, 'Doru', 'G');
INSERT INTO Patient VALUES (5, 'Emilian', 'G');

INSERT INTO Surgery_room VALUES (1, 0);
INSERT INTO Surgery_room VALUES (2, 0);
INSERT INTO Surgery_room VALUES (3, 0);
INSERT INTO Surgery_room VALUES (4, 0);
INSERT INTO Surgery_room VALUES (5, 0);

INSERT INTO Contract VALUES (1, 1);
INSERT INTO Contract VALUES (2, 1);
INSERT INTO Contract VALUES (1, 2);
INSERT INTO Contract VALUES (1, 3);
INSERT INTO Contract VALUES (2, 4);
INSERT INTO Contract VALUES (2, 5);

INSERT INTO Anesthetic VALUES (1, 'anestezic 1');
INSERT INTO Anesthetic VALUES (2, 'anestezic 2');
INSERT INTO Anesthetic VALUES (3, 'anestezic 3');
INSERT INTO Anesthetic VALUES (4, 'anestezic 4');
INSERT INTO Anesthetic VALUES (5, 'anestezic 5');

INSERT INTO Material_prosthesis VALUES (1, 'material_proteza 1');
INSERT INTO Material_prosthesis VALUES (2, 'material_proteza 2');
INSERT INTO Material_prosthesis VALUES (3, 'material_proteza 3');
INSERT INTO Material_prosthesis VALUES (4, 'material_proteza 4');
INSERT INTO Material_prosthesis VALUES (5, 'material_proteza 5');

INSERT INTO Surgery VALUES (1, 1, 1, 1, 1, 1, 1, TO_DATE('2022-11-29', 'yyyy-mm-dd'));
INSERT INTO Surgery VALUES (2, 1, 2, 1, 2, 5, 2, TO_DATE('2022-11-28', 'yyyy-mm-dd'));
INSERT INTO Surgery VALUES (3, 1, 2, 1, 3, 2, 3, TO_DATE('2022-10-29', 'yyyy-mm-dd'));
INSERT INTO Surgery VALUES (4, 2, 2, 1, 4, 1, 4, TO_DATE('2022-9-29', 'yyyy-mm-dd'));
INSERT INTO Surgery VALUES (5, 2, 3, 1, 5, 3, 5, TO_DATE('2022-8-29', 'yyyy-mm-dd'));
INSERT INTO Surgery VALUES (6, 3, 3, 1, 1, 5, 1, TO_DATE('2022-1-29', 'yyyy-mm-dd'));
INSERT INTO Surgery VALUES (7, 2, 4, 1, 3, 1, 4, TO_DATE('2022-5-14', 'yyyy-mm-dd'));
INSERT INTO Surgery VALUES (8, 3, 4, 1, 3, 2, 3, TO_DATE('2022-3-29', 'yyyy-mm-dd'));
INSERT INTO Surgery VALUES (9, 4, 5, 1, 4, 4, 4, TO_DATE('2022-4-29', 'yyyy-mm-dd'));
INSERT INTO Surgery VALUES (10, 5, 5, 1, 5, 1, 4, TO_DATE('2022-5-29', 'yyyy-mm-dd'));



--ex6
--Afisez toate spitalele care ii au angajati pe anumiti doctori


CREATE TYPE vector IS VARRAY(10) OF NUMBER;

CREATE OR REPLACE PROCEDURE ex6
 (v vector)
AS
 
 TYPE tablou_indexat IS TABLE OF Contract%ROWTYPE 
                      INDEX BY BINARY_INTEGER; 
 h    tablou_indexat; 
 
BEGIN
    
    SELECT * BULK COLLECT INTO h FROM Contract;       
       
    FOR i IN h.FIRST..h.LAST LOOP
        FOR j IN v.FIRST..v.LAST LOOP
            if v(j) = h(i).id_dentist THEN
                DBMS_OUTPUT.PUT_LINE('spitalul ' || h(i).id_hospital 
                || ' il are angajat pe ' || v(j) || '');
            END IF;
        END LOOP;
    END LOOP;
    
END ex6;
/
execute ex6(vector(3,1,2,7));





--ex7

--incrementez numarul salilor de operatie cu 1 

--afisez pentru fiecare contract existent spitalul cu datele aferente si dentistii angajati

CREATE OR REPLACE PROCEDURE ex7
AS    
   CURSOR c IS -- toate numeele si adresele spitalelor 
    SELECT id_hospital, hospital_name, adress
    FROM Hospital;
    
  CURSOR c2(parametru NUMBER) is  -- toti dentistii din spitalul parametru
    SELECT d.first_name from Dentist d, Contract c
    where d.id_dentist = c.id_dentist 
    and c.id_hospital = parametru;
    
 total_rows NUMBER;
 
BEGIN
    
    UPDATE Surgery_room  -- cursor implicit(cresc numarul salilor cu 1) 
    SET status = 0; 
    IF sql%notfound THEN 
      dbms_output.put_line('nu exista sali de operatie'); 
    ELSIF sql%found THEN 
      total_rows := sql%rowcount;
      dbms_output.put_line( ' statusul a ' || total_rows || ' sali de operatie 
      a fost setat cu 0'); 
    END IF;
    
    
    for i in c loop
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE( i.adress || '-' || i.hospital_name || ' ' || i.id_hospital || ' ');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        for j in c2( i.id_hospital ) loop
            DBMS_OUTPUT.PUT_LINE( j.first_name || ' ');
        end loop;
    end loop;
        
END ex7;
/
execute ex7;





--ex 8
--adresa spitalului unde lucreaza cel putin un doctor cu nume X


CREATE OR REPLACE FUNCTION ex8 (nume_doctor Dentist.first_name%TYPE) 
RETURN Hospital.adress%TYPE IS
	Adresa Hospital.adress%TYPE;
BEGIN

        select h.adress into Adresa from 
        Hospital h join Contract c on (c.id_hospital = h.id_hospital)
        join Dentist d on (c.id_dentist = d.id_dentist)
        and LOWER(d.first_name) = LOWER(nume_doctor);

        if Adresa <> NULL and Adresa <> ' ' and Adresa <> ' ' THEN
            DBMS_OUTPUT.PUT_LINE('Adressa este ' || lower(Adresa));
        END IF;

        RETURN Adresa;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20343,'Nu exista niciun spital cu cel putin un dentist cu numele dat');
            WHEN TOO_MANY_ROWS THEN
                RAISE_APPLICATION_ERROR(-20344, 'Exista mai multe spitale unde lucreaza cel putin un doctor cu numele dat');
END ex8;
/

BEGIN
 DBMS_OUTPUT.PUT_LINE('Adresa spitalului unde lucreaza Alan: ' ||
 ex8('Alan'));
END;
/
BEGIN
  DBMS_OUTPUT.PUT_LINE('Adresa spitalului unde lucreaza Cosmin: ' ||
 ex8('Cosmin'));
END;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Adresa spitalului unde lucreaza Cosmin: ' ||
 ex8('Cossmin'));
END;
/









--ex9
--afisati toate detaliile operatiilor facute de un doctor, adica
--nume spital, nume pacient, nume anestezic, status camera, nume proteza

CREATE OR REPLACE PROCEDURE ex9 (nume_doctor Dentist.first_name%TYPE)
IS    
   id_doctor Dentist.id_dentist%TYPE;
   TYPE r IS RECORD 
   (
       spital Hospital.hospital_name%TYPE, 
       pacient Patient.first_name%TYPE, 
       anestezic Anesthetic.anesthetic_name%TYPE, 
       proteza Material_prosthesis.material_prosthesis_name%TYPE,
       status Surgery_room.status%TYPE
   );
   
   operatii_auxiliar r; 

    CURSOR operatii (id_doctor Dentist.id_dentist%TYPE) RETURN r IS
         select 
            h.hospital_name, p.first_name, a.anesthetic_name, mp.material_prosthesis_name, sr.status
        from 
            Surgery s, Hospital h, Patient p, Anesthetic a, Material_prosthesis mp, Surgery_room sr
        where
            s.id_dentist = id_doctor and s.id_hospital = h.id_hospital and
            s.id_patient = p.id_patient and s.id_anesthetic = a.id_anesthetic
            and s.id_material_prosthesis = mp.id_material_prosthesis
            and s.room_number = sr.room_number
            group by 
            h.hospital_name, p.first_name, a.anesthetic_name, mp.material_prosthesis_name, sr.status;

BEGIN
    
    select id_dentist into id_doctor from Dentist where
    first_name = nume_doctor; 
                
    OPEN operatii(id_doctor);
    LOOP
        FETCH operatii INTO operatii_auxiliar;
        EXIT WHEN operatii%notfound;
            DBMS_OUTPUT.PUT_LINE('nume spital ' ||
                operatii_auxiliar.spital || ': ' || 'nume pacient ' || operatii_auxiliar.pacient || ': ' ||
                'nume anestezic ' || operatii_auxiliar.anestezic || ': ' ||'status camera ' || operatii_auxiliar.status || ': ' ||
                'nume proteza ' || operatii_auxiliar.proteza
            );
    END LOOP;
    CLOSE operatii;
        
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20344,'Nu exista doctorul cu numele dat');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20345, 'Exista mai multi doctori cu numele dat');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20346,'Alta eroare!');    
END ex9;
/
execute ex9('Alan');










--ex10
--trigger care nu te lasa sa adaugi mai mult de 10 proteze

CREATE OR REPLACE TRIGGER numar_proteze
 BEFORE INSERT ON Material_prosthesis
DECLARE
 mp_count INT;
BEGIN
 select count(id_material_prosthesis) into mp_count from Material_prosthesis;
 IF mp_count > 10 THEN
 RAISE_APPLICATION_ERROR(-20011,'Ai depasit limita maxima a protezlor!');
 END IF;
END;
/
-- Declansare trigger
BEGIN
 FOR i in 1 .. 11 LOOP
 insert into Material_prosthesis values (i+10, 'material p test ' || i);
 END LOOP;
 delete from Material_prosthesis where material_prosthesis_name like 'material p test %';
END;
/
-- Sterge trigger
DROP TRIGGER numar_proteze;

select * from Material_prosthesis;







--ex11
--trigger care afiseaza operatiile nou adaugate
CREATE OR REPLACE TRIGGER operatie_noua 
AFTER INSERT ON Surgery
FOR EACH ROW 
DECLARE 
   id Surgery.id_surgery%TYPE;
   spital Hospital.id_hospital%TYPE; 
   doctor Dentist.id_dentist%TYPE;
   pacient Patient.first_name%TYPE; 
   anestezic Anesthetic.anesthetic_name%TYPE; 
   proteza Material_prosthesis.material_prosthesis_name%TYPE;
   camera Surgery_room.room_number%TYPE;
BEGIN 
   id := :NEW.id_surgery;
   spital := :NEW.id_hospital; 
   doctor := :NEW.id_dentist;
   pacient := :NEW.id_patient;
   anestezic := :NEW.id_anesthetic;
   proteza := :NEW.id_material_prosthesis;
   camera := :NEW.room_number;
   
   DBMS_OUTPUT.PUT_LINE('operatie nou aduagata : ' || 'id spital ' ||
                spital || ': ' || 'id pacient ' || pacient || ': ' ||
                'id anestezic ' || anestezic || ': ' ||'numar camera ' || camera || ': ' ||
                'id proteza ' || proteza
            );
   
END; 
/ 
drop trigger operatie_noua;

INSERT INTO Surgery VALUES (11, 1, 1, 1, 1, 1, 1, TO_DATE('2023-11-29', 'yyyy-mm-dd'));









--ex12
--trigger LDD care arata istoricul modificarilor 
CREATE OR REPLACE TRIGGER istoric
 BEFORE CREATE OR DROP OR ALTER ON SCHEMA
BEGIN

    DBMS_OUTPUT.PUT_LINE('modificare efectuta: ' || SYS.LOGIN_USER || ' ' || SYS.DATABASE_NAME || ' ' || SYS.DICTIONARY_OBJ_NAME || ' ' || SYSDATE);
END;
/
-- Declansare trigger
CREATE TABLE TestTable AS
SELECT *
FROM Hospital;
DROP TABLE TestTable;
-- Stergere trigger
DROP TRIGGER istoric;












--ex13
--Definiți un pachet care să conțină toate obiectele definite în cadrul proiectului.
CREATE OR REPLACE PACKAGE pachet_proiect AS 

   -- ex6
   TYPE vector IS VARRAY(10) OF NUMBER;
   PROCEDURE ex6 (v vector);
   
   -- ex7
   PROCEDURE ex7;
   
   -- ex8
   FUNCTION ex8 (nume_doctor Dentist.first_name%TYPE)
        RETURN Hospital.adress%TYPE;
   
   -- ex9
   PROCEDURE ex9 (nume_doctor Dentist.first_name%TYPE);
  
END pachet_proiect; 
/


CREATE OR REPLACE PACKAGE BODY pachet_proiect AS 
    
    --ex6
    --Afisez toate spitalele care ii au angajati pe anumiti doctori
    
    PROCEDURE ex6 (v vector)
    AS 
     TYPE tablou_indexat IS TABLE OF Contract%ROWTYPE 
                          INDEX BY BINARY_INTEGER; 
     h    tablou_indexat; 
     
    BEGIN
        SELECT * BULK COLLECT INTO h FROM Contract;          
        FOR i IN h.FIRST..h.LAST LOOP
            FOR j IN v.FIRST..v.LAST LOOP
                if v(j) = h(i).id_dentist THEN
                    DBMS_OUTPUT.PUT_LINE('spitalul ' || h(i).id_hospital 
                    || ' il are angajat pe ' || v(j) || '');
                END IF;
            END LOOP;
        END LOOP;   
    END ex6;
     
     
     
     
    -- ex7
    --incrementez numarul salilor de operatie cu 1 
    --afisez pentru fiecare contract existent spitalul cu datele aferente si dentistii angajati

    PROCEDURE ex7
    AS    
       CURSOR c IS -- toate numeele si adresele spitalelor 
        SELECT id_hospital, hospital_name, adress
        FROM Hospital;
        
      CURSOR c2(parametru NUMBER) is  -- toti dentistii din spitalul parametru
        SELECT d.first_name from Dentist d, Contract c
        where d.id_dentist = c.id_dentist 
        and c.id_hospital = parametru;
        
     total_rows NUMBER;
     
    BEGIN
        
        UPDATE Surgery_room  -- cursor implicit(cresc numarul salilor cu 1) 
        SET status = 0; 
        IF sql%notfound THEN 
          dbms_output.put_line('nu exista sali de operatie'); 
        ELSIF sql%found THEN 
          total_rows := sql%rowcount;
          dbms_output.put_line( 'statusul a ' || total_rows || ' sali de operatie 
          a fost setat cu 0'); 
        END IF;
        
        
        for i in c loop
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
            DBMS_OUTPUT.PUT_LINE( i.adress || '-' || i.hospital_name || ' ' || i.id_hospital || ' ');
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
            for j in c2( i.id_hospital ) loop
                DBMS_OUTPUT.PUT_LINE( j.first_name || ' ');
            end loop;
        end loop;
        
    END ex7;

     
     
     
    -- ex8
    FUNCTION ex8 (nume_doctor Dentist.first_name%TYPE) 
    RETURN Hospital.adress%TYPE IS
        Adresa Hospital.adress%TYPE;
    BEGIN
    
            select h.adress into Adresa from 
            Hospital h join Contract c on (c.id_hospital = h.id_hospital)
            join Dentist d on (c.id_dentist = d.id_dentist)
            and LOWER(d.first_name) = LOWER(nume_doctor);
    
            if Adresa <> NULL and Adresa <> ' ' and Adresa <> ' ' THEN
                DBMS_OUTPUT.PUT_LINE('Adressa este ' || lower(Adresa));
            END IF;
    
            RETURN Adresa;
            
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RAISE_APPLICATION_ERROR(-20343,'Nu exista niciun spital cu cel putin un dentist cu numele dat');
                WHEN TOO_MANY_ROWS THEN
                    RAISE_APPLICATION_ERROR(-20344, 'Exista mai multe spitale unde lucreaza cel putin un doctor cu numele dat');
    END ex8;


    
    --ex9
--afisati toate detaliile operatiilor facute de un doctor, adica
--nume spital, nume pacient, nume anestezic, status camera, nume proteza

    PROCEDURE ex9 (nume_doctor Dentist.first_name%TYPE)
    IS    
       id_doctor Dentist.id_dentist%TYPE;
       TYPE r IS RECORD 
       (
           spital Hospital.hospital_name%TYPE, 
           pacient Patient.first_name%TYPE, 
           anestezic Anesthetic.anesthetic_name%TYPE, 
           proteza Material_prosthesis.material_prosthesis_name%TYPE,
           status Surgery_room.status%TYPE
       );
       
       operatii_auxiliar r; 
    
        CURSOR operatii (id_doctor Dentist.id_dentist%TYPE) RETURN r IS
             select 
                h.hospital_name, p.first_name, a.anesthetic_name, mp.material_prosthesis_name, sr.status
            from 
                Surgery s, Hospital h, Patient p, Anesthetic a, Material_prosthesis mp, Surgery_room sr
            where
                s.id_dentist = id_doctor and s.id_hospital = h.id_hospital and
                s.id_patient = p.id_patient and s.id_anesthetic = a.id_anesthetic
                and s.id_material_prosthesis = mp.id_material_prosthesis
                and s.room_number = sr.room_number
                group by 
                h.hospital_name, p.first_name, a.anesthetic_name, mp.material_prosthesis_name, sr.status;
    
    BEGIN
        
        select id_dentist into id_doctor from Dentist where
        first_name = nume_doctor; 
                    
        OPEN operatii(id_doctor);
        LOOP
            FETCH operatii INTO operatii_auxiliar;
            EXIT WHEN operatii%notfound;
                DBMS_OUTPUT.PUT_LINE('nume spital ' ||
                    operatii_auxiliar.spital || ': ' || 'nume pacient ' || operatii_auxiliar.pacient || ': ' ||
                    'nume anestezic ' || operatii_auxiliar.anestezic || ': ' ||'status camera ' || operatii_auxiliar.status || ': ' ||
                    'nume proteza ' || operatii_auxiliar.proteza
                );
        END LOOP;
        CLOSE operatii;
            
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20344,'Nu exista doctorul cu numele dat');
            WHEN TOO_MANY_ROWS THEN
                RAISE_APPLICATION_ERROR(-20345, 'Exista mai multi doctori cu numele dat');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20346,'Alta eroare!');    
    END ex9;

     
END pachet_proiect; 
/


-- testez ex 6 
DECLARE
  v pachet_proiect.vector := pachet_proiect.vector(1,2,4);
BEGIN
  pachet_proiect.ex6(v);
END;
/ 

--testez ex7
execute pachet_proiect.ex7;


--testez ex8
BEGIN
 DBMS_OUTPUT.PUT_LINE('Adresa spitalului unde lucreaza Alan: ' ||
 pachet_proiect.ex8('Alan'));
END;
/
BEGIN
  DBMS_OUTPUT.PUT_LINE('Adresa spitalului unde lucreaza Cosmin: ' ||
 pachet_proiect.ex8('Cosmin'));
END;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Adresa spitalului unde lucreaza Cosmin: ' ||
 pachet_proiect.ex8('Cossmin'));
END;



--testez ex9
execute pachet_proiect.ex9('Bogdan');


















--ex14
-- Definiți un pachet care să includă tipuri de date complexe și
--obiecte necesare pentru acțiuni integrate. 

CREATE OR REPLACE PACKAGE pachet_ex14 AS 

   TYPE vector IS VARRAY(10) OF NUMBER;
   PROCEDURE p1 (v vector);
   
   FUNCTION f1 (nume_doctor Dentist.first_name%TYPE)
        RETURN Hospital.adress%TYPE;
   
   PROCEDURE p2 (nume_doctor Dentist.first_name%TYPE);
   
   TYPE operatie_custom IS RECORD 
   (
       spital Hospital.hospital_name%TYPE, 
       pacient Patient.first_name%TYPE, 
       anestezic Anesthetic.anesthetic_name%TYPE, 
       proteza Material_prosthesis.material_prosthesis_name%TYPE,
       status Surgery_room.status%TYPE
   );
   
    CURSOR cursor (id_doctor Dentist.id_dentist%TYPE) RETURN operatie_custom IS
         select 
            h.hospital_name, p.first_name, a.anesthetic_name, mp.material_prosthesis_name, sr.status
        from 
            Surgery s, Hospital h, Patient p, Anesthetic a, Material_prosthesis mp, Surgery_room sr
        where
            s.id_dentist = id_doctor and s.id_hospital = h.id_hospital and
            s.id_patient = p.id_patient and s.id_anesthetic = a.id_anesthetic
            and s.id_material_prosthesis = mp.id_material_prosthesis
            and s.room_number = sr.room_number
            group by 
            h.hospital_name, p.first_name, a.anesthetic_name, mp.material_prosthesis_name, sr.status;
        
   aux operatie_custom; -- folosit pentru fetch ul cursorului
   
   FUNCTION f2 (nume_doctor Dentist.first_name%TYPE) -- returneaza numarul de operatii efectuste de un doctor si le afiseaza
        RETURN NUMBER;
   
END pachet_ex14; 
/

CREATE OR REPLACE PACKAGE BODY pachet_ex14 AS 
  
   --p1
   --Afisez toate spitalele care ii au angajati pe anumiti doctori
    
    PROCEDURE p1 (v vector)
    AS 
     TYPE tablou_indexat IS TABLE OF Contract%ROWTYPE 
                          INDEX BY BINARY_INTEGER; 
     h    tablou_indexat; 
     
    BEGIN
        SELECT * BULK COLLECT INTO h FROM Contract;          
        FOR i IN h.FIRST..h.LAST LOOP
            FOR j IN v.FIRST..v.LAST LOOP
                if v(j) = h(i).id_dentist THEN
                    DBMS_OUTPUT.PUT_LINE('spitalul ' || h(i).id_hospital 
                    || ' il are angajat pe ' || v(j) || '');
                END IF;
            END LOOP;
        END LOOP;   
    END p1;
    
    
    
    
    FUNCTION f1 (nume_doctor Dentist.first_name%TYPE) 
    RETURN Hospital.adress%TYPE IS
        Adresa Hospital.adress%TYPE;
    BEGIN
    
            select h.adress into Adresa from 
            Hospital h join Contract c on (c.id_hospital = h.id_hospital)
            join Dentist d on (c.id_dentist = d.id_dentist)
            and LOWER(d.first_name) = LOWER(nume_doctor);
    
            if Adresa <> NULL and Adresa <> ' ' and Adresa <> ' ' THEN
                DBMS_OUTPUT.PUT_LINE('Adressa este ' || lower(Adresa));
            END IF;
    
            RETURN Adresa;
            
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RAISE_APPLICATION_ERROR(-20343,'Nu exista niciun spital cu cel putin un dentist cu numele dat');
                WHEN TOO_MANY_ROWS THEN
                    RAISE_APPLICATION_ERROR(-20344, 'Exista mai multe spitale unde lucreaza cel putin un doctor cu numele dat');
    END f1;




    --afisati toate detaliile operatiilor facute de un doctor, adica
    --nume spital, nume pacient, nume anestezic, status camera, nume proteza
    PROCEDURE p2 (nume_doctor Dentist.first_name%TYPE)
    IS    
       id_doctor Dentist.id_dentist%TYPE;
       TYPE r IS RECORD 
       (
           spital Hospital.hospital_name%TYPE, 
           pacient Patient.first_name%TYPE, 
           anestezic Anesthetic.anesthetic_name%TYPE, 
           proteza Material_prosthesis.material_prosthesis_name%TYPE,
           status Surgery_room.status%TYPE
       );
       
       operatii_auxiliar r; 
    
        CURSOR operatii (id_doctor Dentist.id_dentist%TYPE) RETURN r IS
             select 
                h.hospital_name, p.first_name, a.anesthetic_name, mp.material_prosthesis_name, sr.status
            from 
                Surgery s, Hospital h, Patient p, Anesthetic a, Material_prosthesis mp, Surgery_room sr
            where
                s.id_dentist = id_doctor and s.id_hospital = h.id_hospital and
                s.id_patient = p.id_patient and s.id_anesthetic = a.id_anesthetic
                and s.id_material_prosthesis = mp.id_material_prosthesis
                and s.room_number = sr.room_number
                group by 
                h.hospital_name, p.first_name, a.anesthetic_name, mp.material_prosthesis_name, sr.status;
    
    BEGIN
        
        select id_dentist into id_doctor from Dentist where
        first_name = nume_doctor; 
                    
        OPEN operatii(id_doctor);
        LOOP
            FETCH operatii INTO operatii_auxiliar;
            EXIT WHEN operatii%notfound;
                DBMS_OUTPUT.PUT_LINE('nume spital ' ||
                    operatii_auxiliar.spital || ': ' || 'nume pacient ' || operatii_auxiliar.pacient || ': ' ||
                    'nume anestezic ' || operatii_auxiliar.anestezic || ': ' ||'status camera ' || operatii_auxiliar.status || ': ' ||
                    'nume proteza ' || operatii_auxiliar.proteza
                );
        END LOOP;
        CLOSE operatii;
            
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20344,'Nu exista doctorul cu numele dat');
            WHEN TOO_MANY_ROWS THEN
                RAISE_APPLICATION_ERROR(-20345, 'Exista mai multi doctori cu numele dat');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20346,'Alta eroare!');    
    END p2;
    
    
    
    
    -- returnez toate operatiile facute de un doctor prin index table  
    FUNCTION f2 (nume_doctor Dentist.first_name%TYPE) 
    RETURN NUMBER IS
        id_doctor Dentist.id_dentist%TYPE;
        i NUMBER(10); -- index
        numarOperatii NUMBER;
    BEGIN
    
        select id_dentist into id_doctor from Dentist where
        first_name = nume_doctor; 
         
        i := 0; -- index incepe de la 0
                    
        OPEN cursor(id_doctor);
        numarOperatii := cursor%rowcount;
        LOOP
            FETCH cursor INTO aux;
            EXIT WHEN cursor%notfound;
            DBMS_OUTPUT.PUT_LINE('nume spital ' ||
                aux.spital || ': ' || 'nume pacient ' || aux.pacient || ': ' ||
                'nume anestezic ' || aux.anestezic || ': ' ||'status camera ' || aux.status || ': ' ||
                'nume proteza ' || aux.proteza
            );
            
        END LOOP;
        CLOSE cursor;
       
        RETURN numarOperatii;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20344,'Nu exista doctorul cu numele dat');
            WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20345, 'Exista mai multi doctori cu numele dat');
            WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20346,'Alta eroare!'); 
            
    END f2;
    
    
END pachet_ex14; 
/



--tetez 
BEGIN
 DBMS_OUTPUT.PUT_LINE('numarul de oepratii efectuate de Bogdan ' || pachet_ex14.f2('Bogdan'));
END;
/
