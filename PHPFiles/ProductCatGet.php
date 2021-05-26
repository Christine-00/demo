	<?php
		include 'header.php';
		$store_id = $_POST['store_id'];


		$tsql = "select
		            CatId   as [row_id],
		            CatName as [cat_name],
		            isnull('$CurrPath' + 'OtherAtt/' + AttName,'-')  as [att_name]

                from ProductCatList(nolock) where Active = 'Y' order by CatID";

		$stmt = sqlsrv_query($conn, $tsql);
		if ( $stmt )
		{
			$count = 0;
			$fg_info = array();
			
			while( $row = sqlsrv_fetch_array( $stmt))    
				{    
					sqlsrv_free_stmt( $stmt_fl);

					$fg_info[] = array(
						'row_id' => $row['row_id'],
						'cat_name' => $row['cat_name'],
						'att_name' => $row['att_name'],
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
