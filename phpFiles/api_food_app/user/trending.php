<?php

	include '../connection.php';

$minRating = 4.4;
$limitFoodItems = 5;

$sqlQuery = "Select * FROM Items WHERE item_rating>= '$minRating' ORDER BY item_rating DESC LIMIT $limitFoodItems";
                                                                    //5 or less than 5 newly available top rated food item
                                                                    //not greater than 5

$resultOfQuery = $connect->query($sqlQuery);

if($resultOfQuery->num_rows > 0) 
{
    $foodItemsRecord = array();
    while($rowFound = $resultOfQuery->fetch_assoc())
    {
        $foodItemsRecord[] = $rowFound;
    }

    echo json_encode(
        array(
            "success"=>true,
            "foodItemsData"=>$foodItemsRecord,
        )
    );
}
else 
{
    echo json_encode(array("success"=>false));
}