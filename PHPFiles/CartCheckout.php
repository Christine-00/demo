	<?php
		include 'header.php';
		$user_id            = $_POST['user_id'];
		$pay_by             = $_POST['pay_by'];
        $store_id           = $_POST['store_id'];

        $tsql_exec = "Exec SP_ConvertCartToOrders '$user_id','$pay_by','$store_id'";
        $stmt = sqlsrv_query($conn, $tsql_exec);

        $tsql = "select top 1
                     TransNo,
                     RefNo,
                     ItemCnt,
                     SubTotal,
                     Total,
                     replace(convert(varchar,TransDate, 106),' ','-') as [TransDate1],
                     StoreId,
                     StoreName,
                     PayBy
                from OrderM(nolock) where MemberId = '$user_id' order by TransDate Desc";

		$stmt = sqlsrv_query($conn, $tsql);
		if ( $stmt )
		{
			$count = 0;
			$fg_info = array();

			while( $row = sqlsrv_fetch_array( $stmt))
				{
					sqlsrv_free_stmt( $stmt_fl);

					$fg_info[] = array(
					                'TransNo'=> $row['TransNo'],
					                'RefNo'=> $row['RefNo'],
					                'ItemCnt'=> $row['ItemCnt'],
					                'SubTotal'=> $row['SubTotal'],
					                'Total'=> $row['Total'],
					                'TransDate1'=> $row['TransDate1'],

					                'StoreId'=> $row['StoreId'],
					                'StoreName'=> $row['StoreName'],
					                'PayBy'=> $row['PayBy'],

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
