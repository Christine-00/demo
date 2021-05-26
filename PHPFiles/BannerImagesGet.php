	<?php
		include 'header.php';
		$currLocLat = $_POST['currLocLat'];
		$currLocLng = $_POST['currLocLng'];
		$currUserEmail = $_POST['currUserEmail'];


        $tsql = "select
                    PackageId
                    ,PackageName
                    ,LocAdd
                    ,AttName
                    ,isnull('$CurrPath' + 'PackageImage/' + AttName,'-')  as [AttName]
                from PackageMaster(nolock)";

		$stmt = sqlsrv_query($conn, $tsql);
		if ( $stmt )
		{
			$count = 0;
			$fg_info = array();

			while( $row = sqlsrv_fetch_array( $stmt))
				{
					sqlsrv_free_stmt( $stmt_fl);

					$fg_info[] = array(


						'PackageId' => $row['PackageId'],
                        'PackageName' => $row['PackageName'],
                        'LocAdd' => $row['LocAdd'],
                        'AttName' => $row['AttName'],
                        'AttName' => $row['AttName'],
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
