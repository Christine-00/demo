	<?php
		include 'header.php';
        $member_id = $_POST['member_id'];

		$tsql = "select
                RowID           as      [row_id],
                TransNo         as      [trans_no],
                RefNo           as      [ref_no],
                ItemCnt         as      [item_cnt],
                SubTotal        as      [sub_total],
                Disc            as      [disc],
                Total           as      [total],
                replace(convert(varchar,TransDate, 106),' ','-') as [trans_date],
                MemberEmail     as      [member_email],
                AmtPaid         as      [amt_paid],
                AmtChange       as      [amt_change],
                TransType       as      [trans_type],
                (case transtype when 'POS' then 'Payment' when 'TOP_UP' then 'Reload' end)  as [trans_type_1]
                from OrderM(nolock) where MemberID = '$member_id' order by TransDate desc";

		$stmt = sqlsrv_query($conn, $tsql);
		if ( $stmt )
		{
			$count = 0;
			$fg_info = array();
			
			while( $row = sqlsrv_fetch_array( $stmt))    
				{    
					sqlsrv_free_stmt( $stmt_fl);

					$fg_info[] = array(
					    'trans_no'	=> $row['trans_no'],
					    'ref_no'	=> $row['ref_no'],
					    'item_cnt'	=> $row['item_cnt'],
					    'sub_total'	=> $row['sub_total'],
					    'disc'	=> $row['disc'],
					    'total'	=> $row['total'],
					    'trans_date'	=> $row['trans_date'],
                        'member_email'	=> $row['member_email'],
                        'amt_paid'	=> $row['amt_paid'],
                        'amt_change'	=> $row['amt_change'],
                        'trans_type'	=> $row['trans_type'],
                        'trans_type_1'	=> $row['trans_type_1']
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
					"status" => "failed",
					"error" => "No transaction record found."
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