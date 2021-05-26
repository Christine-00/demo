	<?php
		include 'header.php';
		$currLocLat = $_POST['currLocLat'];
		$currLocLng = $_POST['currLocLng'];
		$currUserEmail = $_POST['currUserEmail'];

        $tsql_exec = "exec [SP_GetStoreListWithDistance] '$currUserEmail','$currLocLat','$currLocLng' ";
        $stmt = sqlsrv_query($conn, $tsql_exec);

        $tsql = "select
        		            StoreList.StoreAdd1 + ', '
        		            + (case when len(StoreList.StoreAdd2) = 0 then '' else StoreList.StoreAdd2 + ', '  end)
        		            + StoreList.StorePostalCode + ', '
        		            + StoreList.StoreArea + ', '
        		            + StoreList.StoreState + ', '
        		            + StoreList.StoreCountry as [store_full_address],
        					isnull('$CurrPath' + 'storeatt/' + StoreList.AttName,'-')  as [store_att_name],

        		            TempStoreList.StoreArea as [store_area],
        		            TempStoreList.StoreState as [store_state],
        		            cast(TempStoreList.Storeid as nvarchar(10)) as [store_id],
        		            TempStoreList.StoreName as [store_name],
        		            TempStoreList.StoreLng as [store_lng],
        		            TempStoreList.StoreLat as [store_lat],
        		            TempStoreList.storeadd1 + ', ' + TempStoreList.storepostalcode + ', ' + TempStoreList.storearea + ', ' + TempStoreList.storestate as [store_add],
        		            cast(TempStoreList.StoreRating as nvarchar(10)) as [store_rating],
        		            TempStoreList.distance as [distance],
        		            TempStoreList.distancerem as [distance_rem],
        		            isnull(StoreList.storewhatsappno,'-')   as [store_whatsapp_no],
                            StoreList.storecontactno    as [store_contact_no],
                            REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day0TimeFrom,100),7)),7),'AM',' AM'),'PM',' PM') as [Day0TimeFrom],
                            REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day0TimeTo,100),7)),7),'AM',' AM'),'PM',' PM') as [Day0TimeTo],
                            REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day1TimeFrom,100),7)),7),'AM',' AM'),'PM',' PM') as [Day1TimeFrom],
                            REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day1TimeTo,100),7)),7),'AM',' AM'),'PM',' PM') as [Day1TimeTo],
                            REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day2TimeFrom,100),7)),7),'AM',' AM'),'PM',' PM') as [Day2TimeFrom],
                            REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day2TimeTo,100),7)),7),'AM',' AM'),'PM',' PM') as [Day2TimeTo],
                            REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day3TimeFrom,100),7)),7),'AM',' AM'),'PM',' PM') as [Day3TimeFrom],
                            REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day3TimeTo,100),7)),7),'AM',' AM'),'PM',' PM') as [Day3TimeTo],
                            REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day4TimeFrom,100),7)),7),'AM',' AM'),'PM',' PM') as [Day4TimeFrom],
                            REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day4TimeTo,100),7)),7),'AM',' AM'),'PM',' PM') as [Day4TimeTo],
                            REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day5TimeFrom,100),7)),7),'AM',' AM'),'PM',' PM') as [Day5TimeFrom],
                            REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day5TimeTo,100),7)),7),'AM',' AM'),'PM',' PM') as [Day5TimeTo],
                            REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day6TimeFrom,100),7)),7),'AM',' AM'),'PM',' PM') as [Day6TimeFrom],
                            REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day6TimeTo,100),7)),7),'AM',' AM'),'PM',' PM') as [Day6TimeTo],
                            CASE DATEPART(WEEKDAY, GETDATE())
                                     WHEN 1 THEN 'Today : ' + REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day0TimeFrom,100),7)),7),'AM',' AM'),'PM',' PM') + ' to ' + REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day0TimeTo,100),7)),7),'AM',' AM'),'PM',' PM')
                                     WHEN 2 THEN 'Today : ' + REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day1TimeFrom,100),7)),7),'AM',' AM'),'PM',' PM') + ' to ' + REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day1TimeTo,100),7)),7),'AM',' AM'),'PM',' PM')
                                     WHEN 3 THEN 'Today : ' + REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day2TimeFrom,100),7)),7),'AM',' AM'),'PM',' PM') + ' to ' + REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day2TimeTo,100),7)),7),'AM',' AM'),'PM',' PM')
                                     WHEN 4 THEN 'Today : ' + REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day3TimeFrom,100),7)),7),'AM',' AM'),'PM',' PM') + ' to ' + REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day3TimeTo,100),7)),7),'AM',' AM'),'PM',' PM')
                                     WHEN 5 THEN 'Today : ' + REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day4TimeFrom,100),7)),7),'AM',' AM'),'PM',' PM') + ' to ' + REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day4TimeTo,100),7)),7),'AM',' AM'),'PM',' PM')
                                     WHEN 6 THEN 'Today : ' + REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day5TimeFrom,100),7)),7),'AM',' AM'),'PM',' PM') + ' to ' + REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day5TimeTo,100),7)),7),'AM',' AM'),'PM',' PM')
                                     WHEN 7 THEN 'Today : ' + REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day6TimeFrom,100),7)),7),'AM',' AM'),'PM',' PM') + ' to ' + REPLACE(REPLACE(RIGHT('0'+LTRIM(RIGHT(CONVERT(varchar,StoreList.Day6TimeTo,100),7)),7),'AM',' AM'),'PM',' PM')
                            END as [OpeningNow],
                            DATEPART(WEEKDAY, GETDATE()) as [Day]
                        from TempStoreList(nolock),StoreList(nolock)
                            where
                                StoreList.Active = 'Y'
                                and TempStoreList.storeid = StoreList.storeID
                                and TempStoreList.UserEmail = '$currUserEmail' order by distance asc;";



		$stmt = sqlsrv_query($conn, $tsql);
		if ( $stmt )
		{
			$count = 0;
			$fg_info = array();
			
			while( $row = sqlsrv_fetch_array( $stmt))    
				{    
					sqlsrv_free_stmt( $stmt_fl);

					$fg_info[] = array(
						'store_id' => $row['store_id'],
                        						'Day' => $row['Day'],
                        					    'store_name' => $row['store_name'],
                        					    'store_full_address' => $row['store_full_address'],
                                                'OpeningNow' => $row['OpeningNow'],

                        						'store_att_name' => $row['store_att_name'],
                        						'store_area' => $row['store_area'],
                        						'store_state' => $row['store_state'],
                        						'store_add' => $row['store_add'],
                        						'store_lat' => $row['store_lat'],
                        						'store_lng' => $row['store_lng'],
                        						'store_rating' => $row['store_rating'],
                        						'distance' => $row['distance'],
                        						'distance_rem' => $row['distance_rem'],
                                                'store_whatsapp_no' => $row['store_whatsapp_no'],
                                                'store_contact_no' => $row['store_contact_no'],
                                                'Day0TimeFrom' => $row['Day0TimeFrom'],
                                                'Day0TimeTo' => $row['Day0TimeTo'],
                                                'Day1TimeFrom' => $row['Day1TimeFrom'],
                                                'Day1TimeTo' => $row['Day1TimeTo'],
                                                'Day2TimeFrom' => $row['Day2TimeFrom'],
                                                'Day2TimeTo' => $row['Day2TimeTo'],
                                                'Day3TimeFrom' => $row['Day3TimeFrom'],
                                                'Day3TimeTo' => $row['Day3TimeTo'],
                                                'Day4TimeFrom' => $row['Day4TimeFrom'],
                                                'Day4TimeTo' => $row['Day4TimeTo'],
                                                'Day5TimeFrom' => $row['Day5TimeFrom'],
                                                'Day5TimeTo' => $row['Day5TimeTo'],
                                                'Day6TimeFrom' => $row['Day6TimeFrom'],
                                                'Day6TimeTo' => $row['Day6TimeTo'],
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
