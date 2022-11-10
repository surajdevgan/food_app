<?php

	include '../connection.php';
	

	$userEmail = $_POST['user_email'];
	$userPassword = md5($_POST['user_password']);
	
	$sqlQuery = "SELECT * FROM Users Where user_email = '$userEmail' AND  user_password = '$userPassword'";
    
    $resultOfQuery = $connect->query($sqlQuery);

    if($resultOfQuery->num_rows > 0) // allow user to login
    {

        $userRecord  = array();

        while($rowFound = $resultOfQuery->fetch_assoc())
        {

            $userRecord[] = $rowFound;
        }


        echo json_encode(
            array(
            "success"=>true,
            "userData"=>$userRecord[0],
        )
    );
    }

    else 
    // do not allow use to login 
    {
                echo json_encode(array("success"=>false));
 
    }