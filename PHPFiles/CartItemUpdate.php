	<?php
		include 'header.php';
		$user_id            = $_POST['user_id'];
		$row_id             = $_POST['row_id'];
        $prod_up            = $_POST['prod_up'];
		$prod_qty           = $_POST['prod_qty'];

        $tsql_exec = "update cartDetTemp
                        set  
                            ProdQty =   $prod_qty,
                            ProdUP =    $prod_up,
                            ProdTotal = $prod_qty * $prod_up
                        from    cartDetTemp
                        where   RowID = '$row_id'";

        $stmt = sqlsrv_query($conn, $tsql_exec);


        $tsql = "select
                 	sum(ProdQty) as [ProdCnt],
                    sum(ProdTotal)	as [ProdTotal]
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
