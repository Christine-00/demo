	<?php
		include 'header.php';
        $item_cnt               = $_POST['item_cnt'];


        if ($item_cnt != '')
        {
            $tsql = "select top $item_cnt ";
        }
        else
        {
            $tsql = "select ";
        }

		$tsql = $tsql." cast(RowID as varchar(20))			as [row_id],
                            Title		as [title],
                            Desc1 + Desc2 + Desc3 + Desc4 + Desc5	as [desc],
                            replace(convert(varchar,AddDate, 106),' ','-') as [add_date],
                            replace(convert(varchar,DateFrom, 106),' ','-') as [date_from],
                            replace(convert(varchar,DateTo, 106),' ','-') as [date_to],
                            '$CurrPath' + 'OtherAtt/' + cast(AttName as nvarchar(30)) as [att_name]
		                from PromotionList(nolock) where
		                    cast(getdate() as date) between cast(DateFrom as date) and cast(DateTo as date)
		                    and    Active = 'Y' order by adddate desc";
		
		$stmt = sqlsrv_query($conn, $tsql);
		if ( $stmt )
		{
			$count = 0;
			$fg_info = array();
			
			while( $row = sqlsrv_fetch_array( $stmt))    
				{    
					sqlsrv_free_stmt( $stmt_fl);

					$fg_info[] = array(
						'row_id'	=> $row['row_id'],
						'title'		=> $row['title'],
						'desc'	=> $row['desc'],						
						'add_date'	=> $row['add_date'],
						'att_name'	=> $row['att_name'],
						'date_from'	=> $row['date_from'],
						'date_to'	=> $row['date_to'],
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