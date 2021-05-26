	<?php
		include 'header.php';
        $prod_id = $_POST['prod_id'];
   
		$tsql_att_1 = "select AttributeOptionRowID, Up, AttributeOption, AttType from productattributeoption(nolock) where AttType = 'Att1' and prodid = '$prod_id' order by AttributeOptionRowID";
		$tsql_att_2 = "select AttributeOptionRowID, Up, AttributeOption, AttType from productattributeoption(nolock) where AttType = 'Att2' and prodid = '$prod_id' order by AttributeOptionRowID";
		$tsql_att_3 = "select AttributeOptionRowID, Up, AttributeOption, AttType from productattributeoption(nolock) where AttType = 'Att3' and prodid = '$prod_id' order by AttributeOptionRowID";
		$tsql_att_4 = "select AttributeOptionRowID, Up, AttributeOption, AttType from productattributeoption(nolock) where AttType = 'Att4' and prodid = '$prod_id' order by AttributeOptionRowID";
		$tsql_att_5 = "select AttributeOptionRowID, Up, AttributeOption, AttType from productattributeoption(nolock) where AttType = 'Att5' and prodid = '$prod_id' order by AttributeOptionRowID";

        $att_1_info = array();
        $att_2_info = array();
        $att_3_info = array();
        $att_4_info = array();
        $att_5_info = array();

        //  Attribute 1
		$stmt = sqlsrv_query($conn, $tsql_att_1);
		if ( $stmt )
		{
			$count = 0;

			while( $row = sqlsrv_fetch_array( $stmt))    
				{    
					sqlsrv_free_stmt( $stmt_fl);
					$att_1_info[] = array(
					    'AttributeOptionRowID'	=> $row['AttributeOptionRowID'],
					    'Up'	                => $row['Up'],
					    'AttributeOption'	    => $row['AttributeOption'],
					    'AttType'	            => $row['AttType'],
					);
					$count++;
				}

			if($count != 0)
				{$att_1_status = 'PASS';}
			else
				{$att_1_status = 'FAIL';}
		}
		else
		{$att_1_status = 'FAIL';}


        //  Attribute 2
        $stmt = sqlsrv_query($conn, $tsql_att_2);
        if ( $stmt )
        {
            $count = 0;
            while( $row = sqlsrv_fetch_array( $stmt))
            {
                sqlsrv_free_stmt( $stmt_fl);
                $att_2_info[] = array(
                                'AttributeOptionRowID'	=> $row['AttributeOptionRowID'],
        					    'Up'	                => $row['Up'],
        					    'AttributeOption'	    => $row['AttributeOption'],
        					    'AttType'	            => $row['AttType'],
                );
                $count++;
            }

            if($count != 0)
                {$att_2_status = 'PASS';}
            else
                {$att_2_status = 'FAIL';}
        }
        else
            {$att_2_status = 'FAIL';}

////////
        //  Attribute 3
        $stmt = sqlsrv_query($conn, $tsql_att_3);
        if ( $stmt )
        {
            $count = 0;
            while( $row = sqlsrv_fetch_array( $stmt))
            {
                sqlsrv_free_stmt( $stmt_fl);
                $att_3_info[] = array(
                                'AttributeOptionRowID'	=> $row['AttributeOptionRowID'],
        					    'Up'	                => $row['Up'],
        					    'AttributeOption'	    => $row['AttributeOption'],
        					    'AttType'	            => $row['AttType'],
                );
                $count++;
            }

            if($count != 0)
                {$att_3_status = 'PASS';}
            else
                {$att_3_status = 'FAIL';}
        }
        else
            {$att_3_status = 'FAIL';}

/////////////
//  Attribute 4
        $stmt = sqlsrv_query($conn, $tsql_att_4);
        if ( $stmt )
        {
            $count = 0;
            while( $row = sqlsrv_fetch_array( $stmt))
            {
                sqlsrv_free_stmt( $stmt_fl);
                $att_4_info[] = array(
                                'AttributeOptionRowID'	=> $row['AttributeOptionRowID'],
        					    'Up'	                => $row['Up'],
        					    'AttributeOption'	    => $row['AttributeOption'],
        					    'AttType'	            => $row['AttType'],
                );
                $count++;
            }

            if($count != 0)
                {$att_4_status = 'PASS';}
            else
                {$att_4_status = 'FAIL';}
        }
        else
            {$att_4_status = 'FAIL';}


//  Attribute 5
        $stmt = sqlsrv_query($conn, $tsql_att_5);
        if ( $stmt )
        {
            $count = 0;
            while( $row = sqlsrv_fetch_array( $stmt))
            {
                sqlsrv_free_stmt( $stmt_fl);
                $att_5_info[] = array(
                                'AttributeOptionRowID'	=> $row['AttributeOptionRowID'],
        					    'Up'	                => $row['Up'],
        					    'AttributeOption'	    => $row['AttributeOption'],
        					    'AttType'	            => $row['AttType'],
                );
                $count++;
            }

            if($count != 0)
                {$att_5_status = 'PASS';}
            else
                {$att_5_status = 'FAIL';}
        }
        else
            {$att_5_status = 'FAIL';}



    $result = array(
        "att_1_status"      => $att_1_status,
        "att_1_option_data" => $att_1_info,

        "att_2_status"      => $att_2_status,
        "att_2_option_data" => $att_2_info,

        "att_3_status"      => $att_3_status,
        "att_3_option_data" => $att_3_info,

        "att_4_status"      => $att_4_status,
        "att_4_option_data" => $att_4_info,

        "att_5_status"      => $att_5_status,
        "att_5_option_data" => $att_5_info,
    );

    echo json_encode($result);

	sqlsrv_free_stmt( $stmt);
	include 'footer.php';
	?>