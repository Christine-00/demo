	<?php
		include 'header.php';
		$user_id            = $_POST['user_id'];
        $row_id             = $_POST['row_id'];

        $tsql_exec = "Delete from cartDetTemp where UserID = $user_id and RowID = '$row_id';
                        Delete from cartDetOptionTemp where UserID = $user_id and OrderDetRowID = '$row_id'";
        $stmt = sqlsrv_query($conn, $tsql_exec);

        $tsql = "select
                 	isnull(sum(ProdQty),    0) as [ProdCnt],
                    isnull(sum(ProdTotal),  0)	as [ProdTotal]
                 from cartdettemp(nolock) where UserID = '$user_id'";

		$stmt = sqlsrv_query($conn, $tsql);
		if ( $stmt )
		{
			$count = 0;
			$fg_info = array();

			while( $row = sqlsrv_fetch_array( $stmt))
				{
					sqlsrv_free_stmt( $stmt_fl);

					$fg_info[] = array(
						'ProdCnt'	=> $row['ProdCnt'],
						'ProdTotal'=> $row['ProdTotal']
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

	include 'footer.php';
	?>
