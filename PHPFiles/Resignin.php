	<?php
		include 'header.php';
		$useremail	=	$_POST['useremail'];

		$tsql = "SELECT UserID				as [user_id],
		        replace(convert(varchar,DOB, 106),' ','-') as [dob],
		        replace(convert(varchar,AddDate, 106),' ','-') as [add_date],
				UserEmail					as [user_email],
				UserName					as [user_name],
				AttName						as [att_name],
				memberpoints				as [member_points]
			FROM
				dbo.WebUserReg(nolock)
			WHERE
				UserEmail = '$useremail'";


		$stmt = sqlsrv_query($conn, $tsql);
		if ( $stmt )
		{
			$count = 0;
			$fg_info = array();

			while( $row = sqlsrv_fetch_array( $stmt))
				{
					sqlsrv_free_stmt( $stmt_fl);

					$fg_info[] = array(
					    'user_id'	    => $row['user_id'],
					    'dob'	        => $row['dob'],
					    'add_date'	        => $row['add_date'],
					    'user_email'	=> $row['user_email'],
					    'user_name'	    => $row['user_name'],
					    'att_name'	    => $row['att_name'],
					    'member_points'	=> $row['member_points']
					);
					$count++;
				}

			if($count != 0)
				{
					$result = array(
					"status" => "success",
					"data" => $fg_info
					);
					echo json_encode($result);
				}
			else
				{
					$result = array(
			"status" => "failed",
			"error" => "Can't find registered user. Please sign up."
			);
			echo json_encode($result);
				}
		}
		else
		{
			$result = array(
			"status" => "fail",
			"error" =>sqlsrv_errors()
			);
			echo json_encode($result);
		}
	sqlsrv_free_stmt( $stmt);
	include 'footer.php';
	?>