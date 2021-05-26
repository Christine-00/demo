	<?php
		include 'header.php';
		$user_id         = $_POST['user_id'];
		$prod_sku        = $_POST['prod_sku'];
		$prod_name       = $_POST['prod_name'];
        $prod_up         = $_POST['prod_up'];
		$prod_qty        = $_POST['prod_qty'];
        $order_detail	 = $_POST['order_detail'];

        //$tsql_exec = "update cartDetTemp
        //                set
        //                    ProdQty =   ProdQty + $prod_qty,
        //                    ProdUP =    $prod_up,
        //                    ProdTotal = (ProdQty + $prod_qty) * $prod_up
        //                from cartDetTemp
        //                where
        //                    ProdSKU = '$prod_sku'
        //                    and UserID = '$user_id'
        //                    and Exists (select ProdSku from cartDetTemp where ProdSKU = '$prod_sku' and UserID = '$user_id')
        //                    ";
        //$stmt = sqlsrv_query($conn, $tsql_exec);


        $tsql_exec = "insert into cartDetTemp (UserID,ProdSKU,ProdName,ProdUP,ProdQty,ProdTotal)
                        select '$user_id','$prod_sku','$prod_name',$prod_up,$prod_qty,$prod_up * $prod_qty";
        $stmt = sqlsrv_query($conn, $tsql_exec);


        if($order_detail != null)
                {
                    $array_json = json_decode($order_detail,true);

                    foreach($array_json as $orderDetail){
                        $attribute_option_row_id    =   $orderDetail[AttributeOptionRowId];
                        $attribute_option           =   $orderDetail[AttributeOption];
                        $up                         =   $orderDetail[Up];
                        $user_id                    =   $orderDetail[UserId];
                        $prod_id                    =   $orderDetail[ProdId];

                        $tsql = "Insert into CartDetOptionTemp(UserID,ProdSKU,OrderDetRowID,AttributeOptionRowID,AttributeOption,UP)
                                select $user_id,$prod_id,
                                (select max(rowID) from cartdettemp(nolock) where UserID = $user_id and ProdSKU = $prod_sku)
                                ,$attribute_option_row_id,'$attribute_option',$up";

                        $stmt_ptt = sqlsrv_query( $conn, $tsql);


                        //$tsql = "Update CartDetTemp set
                        //            ProdTotal = ProdQty * (ProdUP + (select sum(UP) from CartDetOptionTemp(nolock) where OrderDetRowID = (select max(rowID) from cartdettemp(nolock) where UserID = $user_id and ProdSKU = $prod_sku)))
                        //            where RowID = (select max(rowID) from cartdettemp(nolock) where UserID = $user_id and ProdSKU = $prod_sku)";
                        //$stmt_ptt = sqlsrv_query( $conn, $tsql);
                    }
                }
                else
                {
                        echo ('no data');
                }


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
