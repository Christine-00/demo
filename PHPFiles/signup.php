<?php    
include 'header.php';
$username = $_POST['username'];
$useremail = $_POST['useremail'];
$pwd = $_POST['pwd'];
$dob = $_POST['dob'];
    
$tsql = "SELECT * FROM dbo.WebUserReg WHERE UserEmail = '$useremail'";    
    

    
$stmt = sqlsrv_query( $conn, $tsql);    
    
if ( $stmt )    
{
	$count = 0;
	while( $row = sqlsrv_fetch_array( $stmt))    
	{
		$count++;
	}
	if($count > 0){
		$result = array(
			"status" => "failed",
			"error" => "User is existed already."
		);

		echo json_encode($result);
	} else{
		$add_sql = "INSERT INTO  dbo.WebUserReg (DOB,UserEmail, UserName, UserPwd, AddBy, SocialToken) VALUES ('$dob','$useremail', '$username', '$pwd', 'Phone', '');";
		$stmt1 = sqlsrv_query( $conn, $add_sql);
		if($stmt1){
			$tsql = "SELECT * FROM dbo.WebUserReg WHERE UserEmail = '$useremail' AND UserPwd = '$pwd'";    
    

			$stmt2 = sqlsrv_query( $conn, $tsql);  
				
			if ( $stmt2 )    
			{/* Iterate through the result set printing a row of data upon each iteration.*/    
				$count = 0;
				$user_info = array();
				 while( $row = sqlsrv_fetch_array( $stmt2))    
				{ 
					  $userID = $row['UserID'];
					$reviewSql = "SELECT * FROM dbo.StoreReview WHERE AddBy = '$userID'";
					$stmt_rate = sqlsrv_query($conn, $reviewSql);
					$rcount = 0;
					while( $row3 = sqlsrv_fetch_array( $stmt_rate))    
					{
						$rcount++;
					}
					sqlsrv_free_stmt( $stmt_rate);

					$flSql = "SELECT * FROM dbo.UserFollower WHERE FollowID = '$userID'";
					$stmt_fl = sqlsrv_query($conn, $flSql);
					$fcount = 0;
					while( $row3 = sqlsrv_fetch_array( $stmt_fl))    
					{
						$fcount++;
					}
					sqlsrv_free_stmt( $stmt_fl);
					$user_info = array(
						'UserID' => $row['UserID'],
						'UserEmail' => $row['UserEmail'],
						'UserName' => $row['UserName'],
						'AddBy' => $row['AddBy'],
						'AddDate' => $row['AddDate'],
						'SocialToken' => $row['SocialToken'],
						'Photo' => $row['PhotoFileName'],
						'RvCount' => $rcount,
						'FlCount' => $fcount
						);		
					$count++;
				}    
				if($count == 1){
					$result = array(
					"status" => "success",
					"data" => $user_info
					);
					echo json_encode($result);  
				} else{
					$result = array(
					"status" => "failed",
					"error" => "Can't register user. Please try again."
					);
					echo json_encode($result);
				}				
			}
			sqlsrv_free_stmt( $stmt2);
		} else{
			$result = array(
			"status" => "failed",
			"error" => "Can't register user. Please try again."
			);
			echo json_encode($result);
		}
		sqlsrv_free_stmt( $stmt1);
	}
}     
else     
{    
	$result = array(
    "status" => "failed",
    "error" =>sqlsrv_errors()
	);

	echo json_encode($result);      
}    
/* Free statement and connection resources. */    
sqlsrv_free_stmt( $stmt);
include 'footer.php';
?>    
