-- Clinic Booking System Database
-- Created by [Benard Abwao] on [2025-05-20]
-- This SQL script creates a database schema for a clinic booking system.

-- 1. Patients Table
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Doctors Table
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    specialization_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Specializations Table
CREATE TABLE Specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    specialization_name VARCHAR(100) UNIQUE NOT NULL
);

-- 4. Appointments Table
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- 5. Medical Records Table
CREATE TABLE MedicalRecords (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    diagnosis TEXT,
    treatment TEXT,
    visit_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- 6. Payments Table
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    method ENUM('Cash', 'Card', 'Insurance') NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- 7. Doctor-Specializations (Many-to-Many)
CREATE TABLE DoctorSpecializations (
    doctor_id INT NOT NULL,
    specialization_id INT NOT NULL,
    PRIMARY KEY (doctor_id, specialization_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id)
);

-- Insert Sample Data

-- Specializations
INSERT INTO Specializations (specialization_name) VALUES 
('Cardiology'), ('Dermatology'), ('Pediatrics'), ('General Medicine');

-- Patients
INSERT INTO Patients (full_name, email, phone, date_of_birth, gender) VALUES
('John Doe', 'john@example.com', '0712345678', '1990-05-20', 'Male'),
('Jane Smith', 'jane@example.com', '0723456789', '1985-07-15', 'Female'),
('Emily Clark', 'emily@example.com', '0734567890', '2000-01-30', 'Female');

-- Doctors
INSERT INTO Doctors (full_name, email, phone, specialization_id) VALUES
('Dr. Alan Grant', 'alan@clinic.com', '0700111222', 1),
('Dr. Ellie Sattler', 'ellie@clinic.com', '0700333444', 3),
('Dr. Ian Malcolm', 'ian@clinic.com', '0700555666', 2);

-- DoctorSpecializations
INSERT INTO DoctorSpecializations (doctor_id, specialization_id) VALUES
(1, 1),
(2, 3),
(3, 2),
(1, 4); -- Dr. Alan Grant also does General Medicine

-- Appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2025-05-20 09:00:00', 'Completed'),
(2, 2, '2025-05-21 10:30:00', 'Scheduled'),
(3, 3, '2025-05-22 14:00:00', 'Cancelled');

-- Medical Records
INSERT INTO MedicalRecords (patient_id, doctor_id, diagnosis, treatment, visit_date) VALUES
(1, 1, 'High blood pressure', 'Prescribed medication and lifestyle change', '2025-05-20'),
(2, 2, 'Seasonal flu', 'Rest and hydration', '2025-05-21');

-- Payments
INSERT INTO Payments (patient_id, amount, payment_date, method) VALUES
(1, 5000.00, '2025-05-20', 'Card'),
(2, 3000.00, '2025-05-21', 'Cash');
