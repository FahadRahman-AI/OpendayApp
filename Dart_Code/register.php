<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST,GET,OPTIONS");
header("Content-Type: application/json");
HEADER("Access-Control-Allow-Headers: Content-Type, Authorization");

//LOCAL HOST DETAILS ONLY FOR TESTING OF THE APP. PORT CHANGED TO 3307 AS SECOND INSTANCE OF MYSQL OPEN!
$servername = "localhost:3307";
$username = "root";
$password = "Wolverine1..";  
$dbname = "appdata";  

// Create the connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get JSON input from Flutter
$data = json_decode(file_get_contents("php://input"), true);

// Check if all fields are provided
if (!isset($data['full_name'], $data['email'], $data['contact_number'], $data['dob'], $data['username'], $data['password'])) {
    echo json_encode(["success" => false, "message" => "All fields are required"]);
    exit();
}

// Escape the data to prevent SQL injection (EXTRA SAFETY FEATURE IMPLEMENTED BY CHATGPT, FURTHER UNDERSTANDING REQUIRED, WAS ORIGINALLY POST)
$full_name = $conn->real_escape_string($data['full_name']);
$email = $conn->real_escape_string($data['email']);
$contact_number = $conn->real_escape_string($data['contact_number']);
$dob = $conn->real_escape_string($data['dob']);
$username = $conn->real_escape_string($data['username']);
$password = password_hash($data['password'], PASSWORD_BCRYPT); 

// Prepare the SQL query to insert the user data
$sql = "INSERT INTO appdata (Full_Name, Email, Contact_Number, DOB, Username, Password) VALUES (?, ?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ssssss", $full_name, $email, $contact_number, $dob, $username, $password);

// Execute the query and check if successful
if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "User registered successfully"]);
} else {
    echo json_encode(["success" => false, "message" => "Error: " . $stmt->error]);
}

// Close the statement and connection
$stmt->close();
$conn->close();
?>