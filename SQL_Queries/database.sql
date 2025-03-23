-- Create the database
CREATE DATABASE UniversityCourses;
USE UniversityCourses;

-- Table for Course Types
CREATE TABLE Course_Types (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50) NOT NULL UNIQUE
);

-- Table for Subjects (Academic Disciplines)
CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(100) NOT NULL UNIQUE
);

-- Table for Departments (Faculties/Schools)
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- Table for Course Delivery Modes (e.g., Online, Sandwich Year)
CREATE TABLE Course_Delivery (
    delivery_id INT PRIMARY KEY AUTO_INCREMENT,
    delivery_mode VARCHAR(50) NOT NULL UNIQUE
);

-- Main Courses Table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(255) NOT NULL,
    type_id INT,
    subject_id INT,
    department_id INT,
    delivery_id INT,
    FOREIGN KEY (type_id) REFERENCES Course_Types(type_id) ON DELETE SET NULL,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id) ON DELETE SET NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE SET NULL,
    FOREIGN KEY (delivery_id) REFERENCES Course_Delivery(delivery_id) ON DELETE SET NULL
);

