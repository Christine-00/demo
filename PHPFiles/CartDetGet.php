	<?php
		include 'header.php';
		$user_id         = $_POST['user_id'];

        //$tsql = "select
        //             RowId      as [RowId],
        //             ProdSKU    as [ProdSku],
        //             ProdName   as [ProdName],
        //             ProdUP     as [ProdUp],
        //             ProdQty    as [ProdQty],
        //             ProdTotal  as [ProdTotal]
        //         from CartDetTemp (nolock)
        //         where UserID = '$user_id'";


////
        $tsql = "select	'A' as [Ref],
		                RowId      as [OrderDetRowID],
                        RowId      as [RowId],
                        ProdSKU    as [ProdSku],
                        ProdName   as [ProdName],
                        ProdUP     as [ProdUp],
                        ProdQty    as [ProdQty],
                        ProdTotal  as [ProdTotal]
                    from CartDetTemp (nolock) where UserID = '$user_id'
                union all
                select 'B' as [Ref],
                        OrderDetRowID       as [OrderDetRowID],
                        RowID               as [RowId],
                        ProdSKU             as [RowId],
                        AttributeOption     as [RowId],
                        UP                  as [RowId],
                        1                   as [RowId],
                        UP                  as [RowId]
                        from CartDetOptionTemp(nolock) where UserID = '$user_id'
                        order by OrderDetRowID,Ref";

		$stmt = sqlsrv_query($conn, $tsql);
		if ( $stmt )
		{
			$count = 0;
			$fg_info = array();

			while( $row = sqlsrv_fetch_array( $stmt))
				{
					sqlsrv_free_stmt( $stmt_fl);

					$fg_info[] = array(
					    'Ref'	    => $row['Ref'],
					    'RowId'	    => $row['RowId'],
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
