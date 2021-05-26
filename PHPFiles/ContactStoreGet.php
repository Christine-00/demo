	<?php
		include 'header.php';

        $store_id               = $_POST['store_id'];
        $week_day               =   date('N');
        $week_day_name          =   date('l');

        if ($week_day == '1')
        {
            $tsql = "select
                         Day1TimeFrom				as [TimeFrom],
                         Day1TimeTo					as [TimeTo],
                         CASE WHEN cast(GETDATE() as time) >= cast(Day1TimeFrom as time) and cast(GETDATE() as time) <= cast(Day1TimeTo as time) THEN '1'        ELSE '0' END as [CurrentStatus],
                         cast(GETDATE() as time) 	as [CurrentTime],
                         CASE WHEN cast(GETDATE() as time) >= cast(Day1TimeFrom as time) and cast(GETDATE() as time) <= cast(Day1TimeTo as time) THEN ''        ELSE ContactAdminDay1Msg END as [Msg]
                     from StoreList(nolock) where StoreID = '$store_id'";
        }
        else if ($week_day == '2')
        {
            $tsql = "select
                         Day2TimeFrom				as [TimeFrom],
                         Day2TimeTo					as [TimeTo],
                         CASE WHEN cast(GETDATE() as time) >= cast(Day2TimeFrom as time) and cast(GETDATE() as time) <= cast(Day2TimeTo as time) THEN '1'        ELSE '0' END as [CurrentStatus],
                         cast(GETDATE() as time) 	as [CurrentTime],
                         CASE WHEN cast(GETDATE() as time) >= cast(Day2TimeFrom as time) and cast(GETDATE() as time) <= cast(Day2TimeTo as time) THEN ''        ELSE ContactAdminDay2Msg END as [Msg]
                     from StoreList(nolock) where StoreID = '$store_id'";
        }
        else if ($week_day == '3')
        {
            $tsql = "select
                         Day3TimeFrom				as [TimeFrom],
                         Day3TimeTo					as [TimeTo],
                         CASE WHEN cast(GETDATE() as time) >= cast(Day3TimeFrom as time) and cast(GETDATE() as time) <= cast(Day3TimeTo as time) THEN '1'        ELSE '0' END as [CurrentStatus],
                         cast(GETDATE() as time) 	as [CurrentTime],
                         CASE WHEN cast(GETDATE() as time) >= cast(Day3TimeFrom as time) and cast(GETDATE() as time) <= cast(Day3TimeTo as time) THEN ''        ELSE ContactAdminDay3Msg END as [Msg]
                     from StoreList(nolock) where StoreID = '$store_id'";
        }
        else if ($week_day == '4')
        {
            $tsql = "select
                         Day4TimeFrom				as [TimeFrom],
                         Day4TimeTo					as [TimeTo],
                         CASE WHEN cast(GETDATE() as time) >= cast(Day4TimeFrom as time) and cast(GETDATE() as time) <= cast(Day4TimeTo as time) THEN '1'        ELSE '0' END as [CurrentStatus],
                         cast(GETDATE() as time) 	as [CurrentTime],
                         CASE WHEN cast(GETDATE() as time) >= cast(Day4TimeFrom as time) and cast(GETDATE() as time) <= cast(Day4TimeTo as time) THEN ''        ELSE ContactAdminDay4Msg END as [Msg]
                     from StoreList(nolock) where StoreID = '$store_id'";
        }
        else if ($week_day == '5')
        {
            $tsql = "select
                         Day5TimeFrom				as [TimeFrom],
                         Day5TimeTo					as [TimeTo],
                         CASE WHEN cast(GETDATE() as time) >= cast(Day5TimeFrom as time) and cast(GETDATE() as time) <= cast(Day5TimeTo as time) THEN '1'        ELSE '0' END as [CurrentStatus],
                         cast(GETDATE() as time) 	as [CurrentTime],
                         CASE WHEN cast(GETDATE() as time) >= cast(Day5TimeFrom as time) and cast(GETDATE() as time) <= cast(Day5TimeTo as time) THEN ''        ELSE ContactAdminDay5Msg END as [Msg]
                     from StoreList(nolock) where StoreID = '$store_id'";
        }
        else if ($week_day == '6')
        {
            $tsql = "select
                         Day6TimeFrom				as [TimeFrom],
                         Day6TimeTo					as [TimeTo],
                         CASE WHEN cast(GETDATE() as time) >= cast(Day6TimeFrom as time) and cast(GETDATE() as time) <= cast(Day6TimeTo as time) THEN '1'        ELSE '0' END as [CurrentStatus],
                         cast(GETDATE() as time) 	as [CurrentTime],
                         CASE WHEN cast(GETDATE() as time) >= cast(Day6TimeFrom as time) and cast(GETDATE() as time) <= cast(Day6TimeTo as time) THEN ''        ELSE ContactAdminDay6Msg END as [Msg]
                     from StoreList(nolock) where StoreID = '$store_id'";
        }
        else if ($week_day == '7')
        {
            $tsql = "select
                         Day0TimeFrom				as [TimeFrom],
                         Day0TimeTo					as [TimeTo],
                         CASE WHEN cast(GETDATE() as time) >= cast(Day0TimeFrom as time) and cast(GETDATE() as time) <= cast(Day0TimeTo as time) THEN '1'        ELSE '0' END as [CurrentStatus],
                         cast(GETDATE() as time) 	as [CurrentTime],
                         CASE WHEN cast(GETDATE() as time) >= cast(Day0TimeFrom as time) and cast(GETDATE() as time) <= cast(Day0TimeTo as time) THEN ''        ELSE ContactAdminDay0Msg END as [Msg]
                     from StoreList(nolock) where StoreID = '$store_id'";
        }

		$stmt = sqlsrv_query($conn, $tsql);
		if ( $stmt )
		{
			$count = 0;
			$fg_info = array();

			while( $row = sqlsrv_fetch_array( $stmt))
				{

					sqlsrv_free_stmt( $stmt_fl);

					$fg_info[] = array(
                            'WeekDay'	        => $week_day,
                            'WeekDayName'	    => $week_day_name,

                            'TimeFrom'	        => $row['TimeFrom'],
                            'TimeTo'	        => $row['TimeTo'],
                            'CurrentTime'	    => $row['CurrentTime'],
                            'CurrentStatus'	    => $row['CurrentStatus'],
                            'Msg'	            => $row['Msg'],
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