CREATE DATABASE WLV;
USE WLV;
CREATE TABLE Faculties (
    Faculty_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Description TEXT
);

CREATE TABLE Departments (
    Department_ID INT PRIMARY KEY AUTO_INCREMENT,
    Faculty_ID INT,
    Name VARCHAR(255) NOT NULL,
    FOREIGN KEY (Faculty_ID) REFERENCES Faculties(Faculty_ID) ON DELETE CASCADE
);

CREATE TABLE Buildings (
    Building_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Purpose TEXT,
    Location VARCHAR(255)
);

CREATE TABLE Courses (
    Course_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Type ENUM('Undergraduate', 'Postgraduate', 'Research', 'Online', 'Apprenticeship', 'CPD'),
    Faculty_ID INT,
    FOREIGN KEY (Faculty_ID) REFERENCES Faculties(Faculty_ID) ON DELETE SET NULL
);
