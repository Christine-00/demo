	<?php
		include 'header.php';
//		$consult_type = $_POST['consult_type'];

		$tsql = "select
		NotificationID			as [notification_id],
		NotificationTitle		as [notification_title],
		NotificationContent1 + NotificationContent2 + NotificationContent3 + NotificationContent4 + NotificationContent5
		    as [notification_content],

		replace(convert(varchar,AddDate, 106),' ','-') as [add_date],
		'http://alphaclick.com.my/SLS_A/OtherAtt/' + cast(AttName as nvarchar(30)) as [att_name]
		from NotificationList(nolock) order by adddate desc";
		
		$stmt = sqlsrv_query($conn, $tsql);
		if ( $stmt )
		{
			$count = 0;
			$fg_info = array();
			
			while( $row = sqlsrv_fetch_array( $stmt))    
				{    
					sqlsrv_free_stmt( $stmt_fl);

					$fg_info[] = array(
						'notification_id'	=> $row['notification_id'],
						'notification_title'=> $row['notification_title'],
						'notification_content'	=> $row['notification_content'],
						'add_date'			=> $row['add_date'],
						'att_name'			=> $row['att_name']
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
					"status" => "no_data_found",
					"error" => "No data found"
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