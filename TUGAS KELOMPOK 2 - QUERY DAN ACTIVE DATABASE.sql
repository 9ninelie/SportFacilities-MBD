CREATE TABLE Users(
user_id VARCHAR(10)PRIMARY KEY NOT NULL,
u_name VARCHAR(35)NOT NULL,
u_email VARCHAR(35),
u_phonenumber VARCHAR(15)NOT NULL
);

CREATE TABLE Jobs(
jobs_id VARCHAR(10)PRIMARY KEY NOT NULL,
j_name VARCHAR(20)NOT NULL
);

CREATE TABLE Employee(
employee_id VARCHAR(10)PRIMARY KEY NOT NULL,
e_name VARCHAR(35)NOT NULL,
e_phonenumber VARCHAR(15)NOT NULL,
e_email VARCHAR(35),
j_jobs_id VARCHAR(10) NOT NULL REFERENCES Jobs(jobs_id)
);

CREATE TABLE SF_Type(
sft_id VARCHAR(10)PRIMARY KEY NOT NULL,
sft_name VARCHAR(20)NOT NULL
);

CREATE TABLE SportsFacilities(
facility_id VARCHAR(10)PRIMARY KEY NOT NULL,
sf_name VARCHAR(50)NOT NULL,
sf_location VARCHAR(50) NOT NULL,
sf_rentalprice MONEY NOT NULL,
e_employee_id VARCHAR(10) NOT NULL REFERENCES Employee(employee_id),
sft_sft_id VARCHAR(10) NOT NULL REFERENCES SF_Type(sft_id)
);

CREATE TABLE Bookings(
booking_id VARCHAR(10)PRIMARY KEY NOT NULL,
b_date DATE,
b_start_time TIMESTAMP,
b_end_time TIMESTAMP,
b_confirmed BOOL,
b_completed BOOL,
b_extrashift INT,
sf_facility_id VARCHAR(10) NOT NULL REFERENCES SportsFacilities(facility_id),
e_employee_id VARCHAR(10) NOT NULL REFERENCES Employee(employee_id),
u_user_id VARCHAR(10) NOT NULL REFERENCES Users(user_id)
);

CREATE TABLE Transactions(
transaction_id VARCHAR(10)PRIMARY KEY NOT NULL,
t_timedate TIMESTAMP NOT NULL,
t_method VARCHAR(15) NOT NULL,
t_baseprice MONEY NOT NULL,
t_eq_rent MONEY,
t_extrashift MONEY,
t_fine MONEY,
t_total MONEY NOT NULL,
b_booking_id VARCHAR(10) NOT NULL REFERENCES Bookings(booking_id)
);

CREATE TABLE UserFeedbackType(
uftype_id VARCHAR(10)PRIMARY KEY NOT NULL,
type_name VARCHAR(20)NOT NULL
);

CREATE TABLE UserFeedback(
feedback_id VARCHAR(10)PRIMARY KEY NOT NULL,
uf_description VARCHAR(60) NOT NULL,
uft_uftype_id VARCHAR(10) NOT NULL REFERENCES UserFeedbackType(uftype_id),
b_booking_id VARCHAR(10) NOT NULL REFERENCES Bookings(booking_id)
);

CREATE TABLE SF_Maintenance(
sfm_id VARCHAR(10)PRIMARY KEY NOT NULL,
sfm_name VARCHAR(20)NOT NULL,
sfm_fee MONEY
);

CREATE TABLE SportsFacilities_SF_Reports(
sf_sfm_id VARCHAR(10)NOT NULL,
sf_facility_id VARCHAR(10) NOT NULL,
PRIMARY KEY(sf_sfm_id, sf_facility_id),
FOREIGN KEY(sf_sfm_id) REFERENCES SF_Maintenance(sfm_id),
FOREIGN KEY(sf_facility_id) REFERENCES SportsFacilities(facility_id)
);

CREATE TABLE Equipment(
equipment_id VARCHAR(10)PRIMARY KEY NOT NULL,
eq_name VARCHAR(20)NOT NULL,
eq_rentalprice MONEY NOT NULL,
eq_status BOOL,
sf_facility_id VARCHAR(10) NOT NULL REFERENCES SportsFacilities(facility_id)
);

CREATE TABLE SF_Reports(
sfr_id VARCHAR(10)PRIMARY KEY NOT NULL,
sfr_date DATE NOT NULL,
sfr_expense MONEY
);

CREATE TABLE SF_Maintenance_SF_Reports(
sf_sfm_id VARCHAR(10)NOT NULL,
sf_sfr_id VARCHAR(10) NOT NULL,
PRIMARY KEY(sf_sfm_id, sf_sfr_id),
FOREIGN KEY(sf_sfm_id) REFERENCES SF_Maintenance(sfm_id),
FOREIGN KEY(sf_sfr_id) REFERENCES SF_Reports(sfr_id)
);

CREATE TABLE EQ_Maintenance(
eqm_id VARCHAR(10)PRIMARY KEY NOT NULL,
eqm_name VARCHAR(20)NOT NULL,
eqm_fee MONEY
);

CREATE TABLE EQ_Reports(
eqr_id VARCHAR(10)PRIMARY KEY NOT NULL,
eqr_date DATE NOT NULL,
eqr_fine MONEY,
transaction_id VARCHAR(10) NOT NULL REFERENCES Transactions(transaction_id)
);

CREATE TABLE Equipment_EQ_Reports(
eq_equipment_id VARCHAR(10)NOT NULL,
eq_eqr_id VARCHAR(10) NOT NULL,
PRIMARY KEY(eq_equipment_id, eq_eqr_id),
FOREIGN KEY(eq_equipment_id) REFERENCES Equipment(equipment_id),
FOREIGN KEY(eq_eqr_id) REFERENCES EQ_Reports(eqr_id)
);

CREATE TABLE EQ_Maintenance_EQ_Reports(
eq_eqm_id VARCHAR(10)NOT NULL,
eq_eqr_id VARCHAR(10) NOT NULL,
PRIMARY KEY(eq_eqm_id, eq_eqr_id),
FOREIGN KEY(eq_eqm_id) REFERENCES EQ_Maintenance(eqm_id),
FOREIGN KEY(eq_eqr_id) REFERENCES EQ_Reports(eqr_id)
);

INSERT INTO Users (user_id, u_name, u_email, u_phonenumber)
VALUES
    ('U_001', 'Anita Widjaja', 'anita.widjaja@gmail.com', '+6281234567890'),
    ('U_002', 'Bambang Susanto', 'bambang.susanto@yahoo.com', '+6282345678901'),
    ('U_003', 'Cindy Sari', 'cindy.sari@hotmail.com', '+6283456789012'),
    ('U_004', 'Dedi Kurniawan', 'dedi.kurniawan@gmail.com', '+6284567890123'),
    ('U_005', 'Eka Pratiwi', 'eka.pratiwi@yahoo.com', '+6285678901234'),
    ('U_006', 'Fajar Rahman', 'fajar.rahman@hotmail.com', '+6286789012345'),
    ('U_007', 'Gita Wulandari', 'gita.wulandari@gmail.com', '+6287890123456'),
    ('U_008', 'Hendra Prasetya', 'hendra.prasetya@yahoo.com', '+6288901234567'),
    ('U_009', 'Indra Nugraha', 'indra.nugraha@hotmail.com', '+6289012345678'),
    ('U_010', 'Joko Santoso', 'joko.santoso@gmail.com', '+6280123456789');

INSERT INTO Jobs (jobs_id, j_name)
VALUES
    ('J_001', 'Manajer'),
    ('J_002', 'Petugas Administrasi'),
    ('J_003', 'Petugas Lapangan'),
    ('J_004', 'Petugas Kebersihan');
	
INSERT INTO Employee (employee_id, e_name, e_phonenumber, e_email, j_jobs_id)
VALUES
    ('E_001', 'Aris Prasetyo', '+6281111111111', 'aris.prasetyo@example.com', 'J_001'),
    ('E_002', 'Budi Santoso', '+6282222222222', 'budi.santoso@example.com', 'J_002'),
    ('E_003', 'Cahya Kusuma', '+6283333333333', 'cahya.kusuma@example.com', 'J_002'),
    ('E_004', 'Dewi Sari', '+6284444444444', 'dewi.sari@example.com', 'J_003'),
    ('E_005', 'Eko Sutrisno', '+6285555555555', 'eko.sutrisno@example.com', 'J_003'),
    ('E_006', 'Fanny Wijaya', '+6286666666666', 'fanny.wijaya@example.com', 'J_004'),
    ('E_007', 'Gina Yuliana', '+6287777777777', 'gina.yuliana@example.com', 'J_004');

INSERT INTO SF_Type (sft_id, sft_name)
VALUES
    ('SFT_001', 'Lapangan Futsal'),
    ('SFT_002', 'Lapangan Badminton'),
    ('SFT_003', 'Lapangan Basket');
	
INSERT INTO SportsFacilities (facility_id, sf_name, sf_location, sf_rentalprice, e_employee_id, sft_sft_id)
VALUES
    ('F_001', 'Lapangan Futsal A', 'Jl. Ahmad Yani No.1, Surabaya', 150000, 'E_004', 'SFT_001'),
    ('F_002', 'Lapangan Futsal B', 'Jl. Diponegoro No.10, Surabaya', 150000, 'E_004', 'SFT_001'),
    ('F_003', 'Lapangan Badminton A', 'Jl. Gajah Mada No.50, Surabaya', 100000, 'E_004', 'SFT_002'),
    ('F_004', 'Lapangan Basket A', 'Jl. Basuki Rahmat No.100, Surabaya', 200000, 'E_005', 'SFT_003'),
    ('F_005', 'Lapangan Basket B', 'Jl. Manyar Kertoarjo No.20, Surabaya', 200000, 'E_005', 'SFT_003');

INSERT INTO SF_Maintenance (sfm_id, sfm_name, sfm_fee)
VALUES
    ('SFM_001', 'Lapangan Futsal A', 750000),
    ('SFM_002', 'Lapangan Futsal B', 750000),
    ('SFM_003', 'Lapangan Basket A', 600000),
    ('SFM_004', 'Lapangan Basket B', 600000),
    ('SFM_005', 'Lapangan Badminton A', 550000);
	
INSERT INTO SF_Reports (sfr_id, sfr_date, sfr_expense)
VALUES
    ('SFR_001', '2023-04-09', 750000),
    ('SFR_002', '2023-04-10', 750000),
    ('SFR_003', '2023-04-11', 600000),
    ('SFR_004', '2023-04-12', 600000),
    ('SFR_005', '2023-04-13', 550000);

	
INSERT INTO Equipment (equipment_id, eq_name, eq_rentalprice, eq_status, sf_facility_id)
VALUES
    ('EQ_001', 'Bola Basket Nike', 20000, TRUE, 'F_004'),
    ('EQ_002', 'Bola Basket Adidas', 20000, TRUE, 'F_004'),
    ('EQ_003', 'Bola Futsal Putih', 15000, TRUE, 'F_001'),
    ('EQ_004', 'Bola Futsal Hitam', 15000, TRUE, 'F_001'),
    ('EQ_005', 'Shuttlecock JP Gold', 25000, TRUE, 'F_003'),
    ('EQ_006', 'Shuttlecock Mavis', 25000, TRUE, 'F_003'),
    ('EQ_007', 'Raket Yonex Merah', 35000, TRUE, 'F_003'),
    ('EQ_008', 'Raket Yonex Putih', 35000, TRUE, 'F_003'),
    ('EQ_009', 'Raket Lining Hitam', 30000, TRUE, 'F_003'),
    ('EQ_010', 'Raket Lining Merah', 30000, TRUE, 'F_003'),
    ('EQ_011', 'Bola Basket Nike', 20000, TRUE, 'F_005'),
    ('EQ_012', 'Bola Basket Adidas', 20000, TRUE, 'F_005'),
    ('EQ_013', 'Bola Futsal Putih', 15000, TRUE, 'F_002'),
    ('EQ_014', 'Bola Futsal Hitam', 15000, TRUE, 'F_002');
	
INSERT INTO EQ_Maintenance (eqm_id, eqm_name, eqm_fee)
VALUES
    ('EQM_001', 'Bola Basket', 650000),
    ('EQM_002', 'Bola Futsal', 550000),
    ('EQM_003', 'Shuttlecock', 50000),
    ('EQM_004', 'Raket', 150000);

INSERT INTO Bookings (booking_id, b_date, b_start_time, b_end_time, b_confirmed, b_completed, b_extrashift, sf_facility_id, e_employee_id, u_user_id)
VALUES
    ('B_001', '2023-04-15', '2023-04-15 18:00:00', '2023-04-15 19:00:00', TRUE, TRUE, 0, 'F_001', 'E_002', 'U_001'),
    ('B_002', '2023-04-16', '2023-04-16 10:00:00', '2023-04-16 11:00:00', TRUE, TRUE, 1, 'F_002', 'E_002', 'U_002'),
    ('B_003', '2023-04-17', '2023-04-17 14:00:00', '2023-04-17 16:00:00', TRUE, TRUE, 0, 'F_003', 'E_003', 'U_003'),
    ('B_004', '2023-04-18', '2023-04-18 09:00:00', '2023-04-18 11:00:00', TRUE, TRUE, 0, 'F_005', 'E_003', 'U_004'),
    ('B_005', '2023-04-19', '2023-04-19 16:00:00', '2023-04-19 17:00:00', TRUE, FALSE, 0, 'F_004', 'E_003', 'U_005'),
    ('B_006', '2023-04-20', '2023-04-20 11:00:00', '2023-04-20 12:00:00', TRUE, FALSE, 1, 'F_002', 'E_002', 'U_006'),
    ('B_007', '2023-04-21', '2023-04-21 19:00:00', '2023-04-21 20:00:00', TRUE, FALSE, 0, 'F_003', 'E_002', 'U_007'),
    ('B_008', '2023-04-22', '2023-04-22 16:00:00', '2023-04-22 17:00:00', TRUE, FALSE, 0, 'F_005', 'E_003', 'U_008'),
    ('B_009', '2023-04-23', '2023-04-23 18:00:00', '2023-04-23 19:00:00', TRUE, FALSE, 0, 'F_001', 'E_003', 'U_009'),
    ('B_010', '2023-04-24', '2023-04-24 10:00:00', '2023-04-24 11:00:00', TRUE, FALSE, 1, 'F_004', 'E_002', 'U_010'),
    ('B_011', '2023-05-15', '2023-05-15 18:00:00', '2023-04-15 19:00:00', TRUE, TRUE, 0, 'F_001', 'E_002', 'U_001'),
    ('B_012', '2023-05-16', '2023-05-16 10:00:00', '2023-04-16 11:00:00', TRUE, TRUE, 1, 'F_002', 'E_002', 'U_002'),
    ('B_013', '2023-05-17', '2023-05-17 14:00:00', '2023-04-17 16:00:00', TRUE, TRUE, 0, 'F_003', 'E_003', 'U_003'),
	('B_014', '2023-05-16', '2023-05-16 10:00:00', '2023-04-16 11:00:00', TRUE, TRUE, 1, 'F_002', 'E_002', 'U_002'),
    ('B_015', '2023-05-25', '2023-05-29 14:00:00', '2023-04-29 16:00:00', TRUE, TRUE, 0, 'F_003', 'E_003', 'U_003'),
	('B_016', '2023-05-16', '2023-05-16 10:00:00', '2023-04-16 11:00:00', TRUE, TRUE, 1, 'F_002', 'E_002', 'U_002'),
    ('B_017', '2023-05-20', '2023-05-28 14:00:00', '2023-04-28 16:00:00', TRUE, TRUE, 0, 'F_003', 'E_003', 'U_003'),
    ('B_018', '2023-05-24', '2023-05-24 10:00:00', '2023-04-24 11:00:00', TRUE, FALSE, 1, 'F_004', 'E_002', 'U_010');
	
INSERT INTO Transactions (transaction_id, t_timedate, t_method, t_baseprice, t_eq_rent, t_extrashift, t_fine, t_total, b_booking_id)
VALUES
    ('T_001', CURRENT_TIMESTAMP, 'Credit Card', 150000, NULL, NULL, 650000, 800000, 'B_001'),
    ('T_002', CURRENT_TIMESTAMP, 'Debit Card', 150000, NULL, 150000, 550000, 850000, 'B_002'),
    ('T_003', CURRENT_TIMESTAMP, 'Cash', 100000, NULL, NULL, NULL, 100000, 'B_003'),
    ('T_004', CURRENT_TIMESTAMP, 'Cash', 200000, NULL, NULL, NULL, 100000, 'B_004');
	
INSERT INTO EQ_Reports (eqr_id, eqr_date, eqr_fine, transaction_id)
VALUES
    ('EQR_001', '2023-04-10', 650000, 'T_001'),
    ('EQR_002', '2023-04-10', 550000, 'T_002');

INSERT INTO UserFeedbackType (uftype_id, type_name)
VALUES 
    ('uftype_001', 'kritik dan saran'),
    ('uftype_002', 'apresiasi');
	
INSERT INTO UserFeedback (feedback_id, uf_description, uft_uftype_id, b_booking_id)
VALUES
('FB_001', 'Sangat puas dengan layanan yang diberikan', 'uftype_002', 'B_001'),
('FB_002', 'Kurang puas dengan kondisi lapangan futsal yang kecil', 'uftype_001', 'B_002'),
('FB_003', 'Pelayanan karyawan sangat ramah', 'uftype_002', 'B_003'),
('FB_004', 'Lapangan basketnya kotor tidak dibersihkan', 'uftype_001', 'B_004');

-- QUERIES

-- Aggregate
-- 1. Get the average rental price of sports facilities
SELECT ('Rp' || ROUND(AVG(sf_rentalprice::NUMERIC), 0))::MONEY AS AverageRentalPrice
FROM SportsFacilities;

-- 2. Get the total number of bookings per user
SELECT u.u_name, COUNT(b.booking_id) AS TotalBookings
FROM Users u
LEFT JOIN Bookings b ON u.user_id = b.u_user_id
GROUP BY u.u_name;

-- 3. Get the sf that had the most uses this month, as well as the frequency
SELECT sf.sf_name, COUNT(*) AS Frequency
FROM SportsFacilities sf
JOIN Bookings b ON b.sf_facility_id = sf.facility_id
WHERE DATE_TRUNC('month', b.b_date) = DATE_TRUNC('month', CURRENT_DATE)
GROUP BY sf.sf_name
HAVING COUNT(*) = (
    SELECT MAX(freq) AS Frequency
    FROM (
        SELECT COUNT(*) AS freq
        FROM SportsFacilities sf
        JOIN Bookings b ON b.sf_facility_id = sf.facility_id
        WHERE DATE_TRUNC('month', b.b_date) = DATE_TRUNC('month', CURRENT_DATE)
        GROUP BY sf.sf_name
    ) subquery
)
ORDER BY Frequency DESC;

-- Outer Join
-- 1. Retrieve the user names and booking IDs for all users, including those who have not made any bookings. (Left Outer Join)
SELECT u.u_name, b.booking_id
FROM Users u
LEFT OUTER JOIN Bookings b ON b.u_user_id = u.user_id;

-- 2. Retrieve the employee names and sports facility names for all sports facilities, including those that do not have any employees assigned to them. (Right Outer Join)
SELECT e.e_name, sf.sf_name
FROM Employee e
RIGHT OUTER JOIN SportsFacilities sf ON sf.e_employee_id = e.employee_id;

-- 3. Retrieve the sports facility names, the total number of bookings for each sports facility, and the total revenue generated by each sports facility, regardless of whether there are matching rows in the Bookings or Transactions tables. (Full Outer Join)
SELECT sf.sf_name, COUNT(b.booking_id) AS TotalBookings, COALESCE(CAST(SUM(t.t_total) AS pg_catalog.money), '0.00') AS TotalRevenue
FROM SportsFacilities sf
LEFT JOIN Bookings b ON b.sf_facility_id = sf.facility_id
LEFT JOIN Transactions t ON t.b_booking_id = b.booking_id
GROUP BY sf.sf_name;

-- Nested Query
-- 1. Find the users who have made at least one booking for a sports facility that has a rental price greater than the average rental price of all sports facilities.
SELECT *
FROM Users
WHERE user_id IN (
  SELECT DISTINCT u_user_id
  FROM Bookings
  WHERE sf_facility_id IN (
    SELECT facility_id
    FROM SportsFacilities
    WHERE CAST(sf_rentalprice AS numeric) > (
      SELECT AVG(CAST(sf_rentalprice AS numeric))
      FROM SportsFacilities
    )
  )
);

-- 2. Find the sports facilities that have been booked for the longest duration in the current month.
SELECT sf_name, MAX(duration) AS MaxDuration
FROM (
  SELECT sf.sf_name, b.booking_id, (b.b_end_time - b.b_start_time) AS duration
  FROM SportsFacilities sf
  FULL OUTER JOIN Bookings b ON b.sf_facility_id = sf.facility_id
  WHERE DATE_TRUNC('month', COALESCE(b.b_date, b.b_end_time)) = DATE_TRUNC('month', CURRENT_DATE)
    AND b.b_completed = TRUE
) AS subquery
GROUP BY sf_name;

-- ACTIVE DB

-- VIEW
-- 1. View Detail Fasilitas Olahraga

CREATE VIEW DetailSportsFacilities AS
SELECT sf.facility_id, sf.sf_name, sf.sf_rentalprice, e.e_name, 
    CASE 
        WHEN EXISTS (
            SELECT 1
            FROM SF_Reports sfr, SportsFacilities_SF_Reports sfsf
            WHERE sfsf.sf_facility_id = sf.facility_id 
			AND sfsf.sf_sfm_id = sfr.sfr_id 
			AND sfr.sfr_date = CURRENT_DATE
        )
        THEN 'Tidak Tersedia'
        WHEN EXISTS (
            SELECT 1
            FROM Bookings b
            WHERE b.sf_facility_id = sf.facility_id 
			AND b.b_date = CURRENT_DATE
        )
        THEN 'Terpakai'
        ELSE 'Tersedia'
    END AS status
FROM SportsFacilities sf
INNER JOIN Employee e ON sf.e_employee_id = e.employee_id

-- 2. View User Bookings

CREATE VIEW UserBookings AS
SELECT  b.booking_id, u.u_name, b.b_date, b.b_start_time, b.b_end_time, sf.sf_name, 
	CASE 
		WHEN b.b_confirmed = TRUE AND b.b_completed = TRUE THEN 'Selesai'
		WHEN b.b_confirmed = TRUE AND b.b_completed = FALSE THEN 'Sudah Dikonfirmasi'
		WHEN b.b_confirmed = FALSE THEN 'Belum dikonfirmasi'
    END AS status
FROM Bookings b
INNER JOIN Users u ON b.u_user_id = u.user_id
INNER JOIN SportsFacilities sf ON b.sf_facility_id = sf.facility_id
SELECT * FROM UserBookings;

-- FUNCTION
-- 1. Function untuk menampilkan jumlah equipment yang tersedia pada suatu sports facility:
CREATE OR REPLACE FUNCTION get_available_equipment_count(sf_id VARCHAR)
RETURNS TABLE (eq_count INTEGER) AS $$
BEGIN
    SELECT COUNT(*) INTO eq_count FROM Equipment WHERE sf_facility_id = sf_id AND eq_status = TRUE;
    RETURN QUERY SELECT eq_count;
END;
$$ LANGUAGE plpgsql;

SELECT get_available_equipment_count('F_004');

-- 2. Function untuk menghitung jumlah transaksi berdasarkan metode pembayaran tertentu
CREATE OR REPLACE FUNCTION count_transactions_by_method(t_method VARCHAR)
RETURNS INTEGER AS $$
BEGIN
    RETURN (SELECT COUNT(*) FROM Transactions WHERE Transactions.t_method = $1);
END;
$$ LANGUAGE plpgsql;

SELECT count_transactions_by_method('Credit Card');

-- PROCEDURE
-- 1. Tujuan prosedur ini untuk melakukan update pada stok pada tabel alat sesuai id alat yang diberikan berdasarkan parameter dipinjam dan kembali oleh user.
ALTER TABLE Equipment
ADD COLUMN stok INT;

UPDATE Equipment
SET stok = CASE
    WHEN equipment_id = 'EQ_001' THEN 10
    WHEN equipment_id = 'EQ_002' THEN 20
    WHEN equipment_id = 'EQ_003' THEN 15
    WHEN equipment_id = 'EQ_004' THEN 10
    WHEN equipment_id = 'EQ_005' THEN 25
    WHEN equipment_id = 'EQ_006' THEN 30
    WHEN equipment_id = 'EQ_007' THEN 20
    WHEN equipment_id = 'EQ_008' THEN 15
    WHEN equipment_id = 'EQ_009' THEN 10
    WHEN equipment_id = 'EQ_010' THEN 5
    WHEN equipment_id = 'EQ_011' THEN 20
    WHEN equipment_id = 'EQ_012' THEN 15
    WHEN equipment_id = 'EQ_013' THEN 10
    WHEN equipment_id = 'EQ_014' THEN 5
    ELSE 0
END;

SELECT * FROM Equipment;

CREATE OR REPLACE PROCEDURE updateStokAlat (
  IN IDequipment VARCHAR(10),
  IN dipinjam INT,
  IN dikembalikan INT
)
LANGUAGE plpgsql AS $$
BEGIN
  UPDATE Equipment
  SET stok = stok - dipinjam + dikembalikan
  WHERE IDequipment = equipment_id;
  RAISE INFO 'Stok Berhasil Diupdate';
END $$;

CALL updateStokAlat('EQ_010',3,1);

--TRIGGER
-- 1. Melakukan pengecekan pada nama user yang memiliki nama yang sama. Apabila ada nama user yang sama maka nama user yang diinputkan setelahnya akan diberikan tambahan (number).

CREATE OR REPLACE FUNCTION add_number_to_duplicate_names() RETURNS TRIGGER AS $$
DECLARE
    new_name VARCHAR(35);
    suffix INT;
BEGIN
    SELECT COUNT(*) INTO suffix FROM Users WHERE u_name = NEW.u_name;

    IF suffix > 0 THEN
        new_name := NEW.u_name || '(' || suffix || ')';
        LOOP
            EXIT WHEN NOT EXISTS (SELECT 1 FROM Users WHERE u_name = new_name);
            suffix := suffix + 1;
            new_name := NEW.u_name || '(' || suffix || ')';
        END LOOP;
        NEW.u_name := new_name;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER add_number_to_duplicate_names_trigger
BEFORE INSERT ON Users
FOR EACH ROW
EXECUTE FUNCTION add_number_to_duplicate_names();

INSERT INTO Users (user_id, u_name, u_email, u_phonenumber)
VALUES
    ('U_011', 'Anton', 'anton.widjaja@gmail.com', '+6281234567899'),
    ('U_012', 'Anton', 'anton.susanto@yahoo.com', '+6282345678909'),
    ('U_013', 'Anton', 'anton.susanti@yahoo.com', '+6282345678909');

INSERT INTO Users (user_id, u_name, u_email, u_phonenumber)
VALUES
    ('U_014', 'Anton', 'anton.widjajo@gmail.com', '+6281234567899');

INSERT INTO Users (user_id, u_name, u_email, u_phonenumber)
VALUES
    ('U_015', 'Anton', 'anton.widjojo@gmail.com', '+6281234567899');
	
select * from users

-- SEQUENCE
-- 1. Create AUTO_NUMBER on the Users table
DROP SEQUENCE IF EXISTS users_seq;
CREATE SEQUENCE users_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
SELECT SETVAL('users_seq', (TRIM(LEADING 'U_' FROM user_id)::INTEGER)) FROM users ORDER BY user_id DESC LIMIT 1;
CREATE OR REPLACE FUNCTION add_new_users()
    RETURNS TRIGGER
    AS $add_new_users$
DECLARE
    next_val INT = NEXTVAL('users_seq');
    digits INTEGER := CEIL(LOG(100, next_val + 1))+2;
BEGIN
    IF NEW.user_id IS NULL THEN
        NEW.user_id := 'U_' || LPAD(next_val::text, digits, '0');
    END IF;
    RETURN NEW;
END;
$add_new_users$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS add_new_users ON users;
CREATE TRIGGER add_new_users BEFORE INSERT ON Users
    FOR EACH ROW EXECUTE PROCEDURE add_new_users();
















	
