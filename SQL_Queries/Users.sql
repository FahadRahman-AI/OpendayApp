CREATE TABLE Users (
    User_ID INT PRIMARY KEY AUTO_INCREMENT,
    Full_Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Contact_Number VARCHAR(20),
    Gender ENUM('Male', 'Female', 'Other', 'Prefer not to say'),
    Date_of_Birth DATE,
    Address VARCHAR(255),
    City VARCHAR(100),
    Postal_Code VARCHAR(20),
    Country VARCHAR(100),
    Username VARCHAR(100) UNIQUE NOT NULL,
    Password_Hash VARCHAR(255) NOT NULL, -- Store hashed passwords
    User_Role ENUM('Student', 'Staff', 'Visitor') NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
