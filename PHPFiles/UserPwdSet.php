	<?php
		include 'header.php';
		$old_user_pwd         = $_POST['old_user_pwd'];
		$new_user_pwd         = $_POST['new_user_pwd'];
		$user_id              = $_POST['user_id'];

        $tsql_exec = "Update WebUserReg set UserPwd = '$new_user_pwd' where UserPwd = '$old_user_pwd' and UserID = '$user_id'";
        $stmt = sqlsrv_query($conn, $tsql_exec);

        //  $tsql_exec = "Insert into notificationlist(NotificationTitle,NotificationContent1,MemberCode,notificationshortcontent) select 'Change Password Alert','You have successfully change your password.','$member_code','You have successfully change your password.'";
        //  $stmt = sqlsrv_query($conn, $tsql_exec);

        if( $stmt === false )
            {
                $result = array(
                    "status" => "failed",
                    "data" => "User Password fail to update."
                    );

            }
        else
            {
                $result = array(
                    "status" => "success",
                    "data" => "User Password updated successfully."
                );
            }

        echo json_encode($result);

	include 'footer.php';
	?>
