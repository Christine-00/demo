<?php    
$serverName = "42.1.62.128,1533";

$uid = "APEC";
$pwd = "APEC_be1gen2tle3";
$databaseName = "APEC";

$CurrPath = 'https://apec.myekad.com/';

$connectionInfo = array( "UID"=>$uid,
                         "PWD"=>$pwd,                              
                         "Database"=>$databaseName);   
$conn = sqlsrv_connect( $serverName, $connectionInfo);

function lastInsertId($queryID) {
        sqlsrv_next_result($queryID);
        sqlsrv_fetch($queryID);
        return sqlsrv_get_field($queryID, 0);
    } 

?>    
