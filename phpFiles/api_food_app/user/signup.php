<?php

	include '../connection.php';
	
	$userName = $_POST['user_name'];
	$userEmail = $_POST['user_email'];
    $userProvince = $_POST['user_province'];
    $userGender = $_POST['user_gender'];
	$userPassword = md5($_POST['user_password']);
	
	$sqlQuery = "INSERT INTO Users SET user_name = '$userName', user_email = '$userEmail', user_province = '$userProvince', user_gender = '$userGender' , user_password = '$userPassword'";
    
    $resultOfQuery = $connect->query($sqlQuery);

    if($resultOfQuery)
    {

        echo json_encode(array("success"=>true));
    }

    else{

                echo json_encode(array("success"=>false));


    }