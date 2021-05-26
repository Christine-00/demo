	<?php
		include 'header.php';
		$TransNo         = $_POST['TransNo'];


        $tsql = "select
                    Rowid       as [RowId],
                    TransNo     as [TransNo],
                    RefNo       as [RefNo],
                    ProdSKU     as [ProdSku],
                    ProdName    as [ProdName],
                    ProdUP      as [ProdUp],
                    ProdQty     as [ProdQty],
                    ProdTotal   as [ProdTotal]
                 from OrderDet (nolock)
                 where TransNo = '$TransNo'";

		$stmt = sqlsrv_query($conn, $tsql);
		if ( $stmt )
		{
			$count = 0;
			$fg_info = array();

			while( $row = sqlsrv_fetch_array( $stmt))
				{
					sqlsrv_free_stmt( $stmt_fl);

					$fg_info[] = array(
                            'RowId'	=> $row['RowId'],
                            'TransNo'	=> $row['TransNo'],
                            'RefNo'	=> $row['RefNo'],
                            'ProdSku'	=> $row['ProdSku'],
                            'ProdName'	=> $row['ProdName'],
                            'ProdUp'	=> $row['ProdUp'],
                            'ProdQty'	=> $row['ProdQty'],
                            'ProdTotal'	=> $row['ProdTotal'],
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
