<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST,GET,OPTIONS");
header("Content-Type: application/json");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

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

// Log the incoming POST data 
file_put_contents('php://stderr', print_r($_POST, true));

// Check if username and password are being sent correctly
if (!isset($_POST['username']) || !isset($_POST['password'])) {
    echo json_encode(['success' => false, 'message' => 'Username and password are required']);
    exit();
}

// Get the data from the POST request
$user = $_POST['username'];
$pass = $_POST['password'];

// Log username and password separately 
file_put_contents('php://stderr', "Username: $user\n", FILE_APPEND);
file_put_contents('php://stderr', "Password: $pass\n", FILE_APPEND);

// Check if both username and password are provided
if (!$user || !$pass) {
    echo json_encode(['success' => false, 'message' => 'Username and password are required']);
    exit();
}

// Query the database to find the user
$stmt = $conn->prepare("SELECT * FROM appdata WHERE Username = ?");
$stmt->bind_param("s", $user);
$stmt->execute();
$result = $stmt->get_result();

// Check if the user was found
if ($result->num_rows > 0) {
    // If found, get the stored password hash
    $user_data = $result->fetch_assoc();
    $stored_hash = $user_data['Password']; 

    // Verify the password
    if (password_verify($pass, $stored_hash)) {
        echo json_encode(['success' => true, 'message' => 'Login successful']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Invalid username or password']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid username or password']);
}

$stmt->close();
$conn->close();
?>