	<?php
		include 'header.php';
		$member_id      =   $_POST['member_id'];
		$stamp_status   =   $_POST['stamp_status'];

		if($RewardCardID == 0)
		{
			$tsql = "select
				cast(RewardM.RewardID as nvarchar(10))		as [reward_id],
				RewardM.RewardDesc		as [reward_desc],
				RewardM.RewardDesc1		as [reward_desc_1],
				RewardMember.StampCount as [stamp_count],
				RewardM.TotalStamp		as [total_stamp],




				'$CurrPath' + 'OtherAtt/' + cast(RewardM.REwardAtt as nvarchar(30)) as [att_name],

				RewardM.StampType		as [stamp_type],
				storegrouping.StoreGroupName	as [store_group_name],
				'http://cwg.com.my/SLS_B/OtherAtt/star_checked.png'  as [reward_image_att_checked],
				'http://cwg.com.my/SLS_B/OtherAtt/star_unchecked.png'  as [reward_image_att_unchecked],
				cast(rewardmember.rewardCardId as nvarchar(10))		as [reward_card_id],
				CASE
					WHEN stampcount = RewardM.totalStamp THEN 'Redeem your reward now'
					WHEN stampcount < RewardM.totalStamp THEN cast(RewardM.totalStamp - stampcount as varchar(10)) + ' more to go'
				END as [rem]
			from RewardMember(nolock),RewardM(nolock),storegrouping(nolock)
			where
                RewardMember.UserID = $member_id
				and RewardM.StoreGroupID = storegrouping.StoreGroupID
				and RewardMember.RewardID = RewardM.RewardID ";

            if($stamp_status == 'TO_REDEEM')
				{
                    //$tsql = $tsql." and RewardMember.StampCount = RewardMember.TotalStamp";
                    $tsql = $tsql." and RewardMember.alreadyRedeem = 'N' ";
				}
            else if($stamp_status == 'HISTORY')
                {
                    //$tsql = $tsql." and RewardMember.StampCount < RewardMember.TotalStamp";
                    $tsql = $tsql." and RewardMember.alreadyRedeem = 'Y'";
                }
		}
		else
		{
			$tsql = "select
				RewardM.RewardID		as [reward_id],
				RewardM.RewardDesc		as [reward_desc],
				RewardM.RewardDesc1		as [reward_desc_1],
				RewardMember.StampCount as [stamp_count],
				RewardM.TotalStamp		as [total_stamp],
				RewardM.REwardAtt		as [att_name],
				RewardM.StampType		as [stamp_type],
				storegrouping.StoreGroupName	as [store_group_name],
				'http://cwg.com.my/SLS_B/OtherAtt/star_checked.png'  as [reward_image_att_checked],
				'http://cwg.com.my/SLS_B/OtherAtt/star_unchecked.png'  as [reward_image_att_unchecked],
				rewardmember.rewardCardId		as [reward_card_id],
				CASE
					WHEN stampcount = RewardM.totalStamp THEN 'Redeem your reward now'
					WHEN stampcount < RewardM.totalStamp THEN cast(RewardM.totalStamp - stampcount as varchar(10)) + ' more to go'
				END as [rem]
			from RewardMember(nolock),RewardM(nolock),storegrouping(nolock)
			where
				RewardM.StoreGroupID = storegrouping.StoreGroupID
				and RewardMember.RewardCardId = $RewardCardID
				and RewardMember.RewardID = RewardM.RewardID";
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
						'reward_id'		=> $row['reward_id'],
						'reward_desc'		=> $row['reward_desc'],
						'reward_desc_1'		=> $row['reward_desc_1'],
						'stamp_count'		=> $row['stamp_count'],
						'att_name'			=> $row['att_name'],
						'total_stamp'		=> $row['total_stamp'],
						'store_group_name'	=> $row['store_group_name'],
						'reward_image_att_checked'	=> $row['reward_image_att_checked'],
						'reward_image_att_unchecked'	=> $row['reward_image_att_unchecked'],
						'reward_card_id'	=> $row['reward_card_id'],
						'stamp_type'	=> $row['stamp_type'],
						'rem'		=> $row['rem']
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