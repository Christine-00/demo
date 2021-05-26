	<?php
		include 'header.php';
		$user_id = $_POST['user_id'];
		$user_pwd = $_POST['user_pwd'];

        $tsql = "select count(1) as [RecCnt]
                from WebUserReg(nolock) where UserID = '$user_id' and UserPwd = '$user_pwd'";


        $stmt = sqlsrv_query($conn, $tsql);
		    if ($stmt)
            {
                $count = 0;
                $fg_info = array();

                while( $row = sqlsrv_fetch_array( $stmt))
                {
                    sqlsrv_free_stmt( $stmt_fl);

                    $fg_info[] = array(
                        'RecCnt'	=> $row['RecCnt']
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
                    "status" => "fail",
                    "data" => "No data found"
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
