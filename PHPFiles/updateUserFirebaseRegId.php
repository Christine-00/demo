	<?php
		include 'header.php';
		$user_email         = $_POST['user_email'];
		$firebase_reg_id    = $_POST['firebase_reg_id'];


        echo('so far so good');



        $tsql_exec = "Update WebUserReg set firebaseregid = null where firebaseregid = '$firebase_reg_id';Update WebUserReg set firebaseregid = '$firebase_reg_id' where useremail = '$user_email'";
        $stmt = sqlsrv_query($conn, $tsql_exec);

        if( $stmt === false )
            {
                $result = array(
                    "status" => "failed",
                    "data" => "Firebase Reg id fail to update."
                    );

            }
        else
            {
                $result = array(
                    "status" => "success",
                    "data" => "Firebase Reg id updated successfully."
                );
            }

        echo json_encode($result);

	include 'footer.php';
	?>
