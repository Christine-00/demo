	<?php
		include 'header.php';
        $cat_id	=	$_POST['cat_id'];

        $prod_id	                =	$_POST['prod_id'];
        $cat_code                   =	$_POST['cat_code'];
        $search_val                 =	$_POST['search_val'];
        $member_fav_item            =	$_POST['member_fav_item'];
        $item_cnt                   = $_POST['item_cnt'];


        if ($item_cnt != '')
        {
            $tsql = "select top $item_cnt ";
        }
        else
        {
            $tsql = "select ";
        }

		$tsql = $tsql." cast(ProdID as varchar(20))		as [prod_id],
                            ProdSKU		                    as [prod_sku],
                            ProdName		                as [prod_name],

                            Case When PromoPrice = 0 then ProdUp else PromoPrice end as [prod_up],


                            'https://sls.gold.alphaclick.com.my/ProdAtt/' + cast(ProductList.AttName as nvarchar(30)) as [att_name_1],
                            '$CurrPath' + 'ProdAtt/' + cast(ProductList.AttName as nvarchar(30)) as [att_name],
                            cast(productcatlist.CatID as numeric(16,0))			as  [cat_id],
                            productcatlist.CatName          as  [cat_name],
                            CostPrice                      as [cost_price],
                            isnull(ProdDesc1,'') +
                            isnull(ProdDesc2,'') +
                            isnull(ProdDesc3,'') +
                            isnull(ProdDesc4,'') +
                            isnull(ProdDesc5,'') as [prod_desc],
                            PromoPrice                      as [promo_price],
                            Att1Name                        as [att_1_name],
                            Att1Active                      as [att_1_active],
                            Att2Name                        as [att_2_name],
                            Att2Active                      as [att_2_active],
                            Att3Name                        as [att_3_name],
                            Att3Active                      as [att_3_active],
                            Att4Name                        as [att_4_name],
                            Att4Active                      as [att_4_active],
                            Att5Name                        as [att_5_name],
                            Att5Active                      as [att_5_active],

                            Att1MultiSel                      as [att_1_multi_sel],
                            Att2MultiSel                      as [att_2_multi_sel],
                            Att3MultiSel                      as [att_3_multi_sel],
                            Att4MultiSel                      as [att_4_multi_sel],
                            Att5MultiSel                      as [att_5_multi_sel]

		                from
                            productlist(nolock)
                            ,productcatlist(nolock)
                        where
                            productlist.CatID = productcatlist.CatID and productlist.Active = 'Y' ";

        if ($cat_id != '')
        {
            $tsql = $tsql . " and productlist.CatID = '$cat_id' ";
        }



        else if ($search_val != '')
        {
            $tsql = $tsql . " and ProdName like '%$search_val%' ";
        }
        else if ($cat_code == 'cat_1')
        {
            $tsql = $tsql . " and productlist.FavItem = 'Y' ";
        }
        else if ($cat_code == 'cat_2')
        {
            $tsql = $tsql . " and productlist.Cat2 = 'Y' ";
        }
        else if ($cat_code == 'cat_3')
        {
            $tsql = $tsql . " and productlist.Cat3 = 'Y' ";
        }
        else if ($cat_code == 'cat_4')
        {
            $tsql = $tsql . " and productlist.Cat4 = 'Y' ";
        }
        else if ($cat_code == 'cat_5')
        {
            $tsql = $tsql . " and productlist.Cat5 = 'Y' ";
        }

        $tsql = $tsql . " order by ProdName desc ";

		$stmt = sqlsrv_query($conn, $tsql);
		if ( $stmt )
		{
			$count = 0;
			$fg_info = array();
			
			while( $row = sqlsrv_fetch_array( $stmt))    
				{    
					sqlsrv_free_stmt( $stmt_fl);

					$fg_info[] = array(
						'prod_id'	=> $row['prod_id'],
						'prod_sku'		=> $row['prod_sku'],
						'att_name'		=> $row['att_name'],
						'cat_id'		=> $row['cat_id'],
						'cat_name'		=> $row['cat_name'],
						'prod_name'	    => $row['prod_name'],
						'prod_up'	    => $row['prod_up'],
						'cost_price'	=> $row['cost_price'],
						'prod_desc'	=> $row['prod_desc'],
						'promo_price'	=> $row['promo_price'],
						'att_1_name'	=> $row['att_1_name'],
                        'att_1_active'	=> $row['att_1_active'],
                        'att_2_name'	=> $row['att_2_name'],
                        'att_2_active'	=> $row['att_2_active'],
                        'att_3_name'	=> $row['att_3_name'],
                        'att_3_active'	=> $row['att_3_active'],
                        'att_4_name'	=> $row['att_4_name'],
                        'att_4_active'	=> $row['att_4_active'],
                        'att_5_name'	=> $row['att_5_name'],
                        'att_5_active'	=> $row['att_5_active'],

                        'att_1_multi_sel'	=> $row['att_1_multi_sel'],
                        'att_2_multi_sel'	=> $row['att_2_multi_sel'],
                        'att_3_multi_sel'	=> $row['att_3_multi_sel'],
                        'att_4_multi_sel'	=> $row['att_4_multi_sel'],
                        'att_5_multi_sel'	=> $row['att_5_multi_sel'],

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