	<?php
		include 'header.php';
		//$from_email         = $_POST['from_email'];
		$member_id         = $_POST['member_id'];
		//$to_user_id         = $_POST['to_user_id'];
		$admin_id         = $_POST['admin_id'];

        $tsql_exec  =   "insert into TransMemberId(key4,key3,AdminUserID,StoreRegId,TransCat,MsgTitle,MsgBody,AddDate)
                        Select '$member_id',0,'$admin_id','-','POS_REQ','Check In POS','Check In POS',getdate()";



//	update transmemberid set key3 = '0' where rowid = @RowId
//	Key2 = username


        $stmt = sqlsrv_query($conn, $tsql_exec);

        if( $stmt === false )
            {
                $result = array(
                    "status" => "failed",
                    "data" => "POS Check in failed."
                    );
            }
        else
            {
                $result = array(
                    "status" => "success",
                    "data" => "POS Check In successfully."
                );
            }

        echo json_encode($result);

	include 'footer.php';
	?>
