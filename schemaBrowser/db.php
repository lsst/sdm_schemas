<?php

include_once("constants.php");

class MySQLDB {

    private $connection;

    public
    function MySQLDB() {
        $this->connection = mysqli_connect(DB_SERVER, DB_USER, DB_PASS)
            or die("MySQL error");

        // check which schema version should be displayed
        if ( array_key_exists('sVer', $_GET) ) {
            $csv = $_GET['sVer'];
        } else {
            $csv = DEFAULT_VERSION;
        }

        mysqli_select_db($this->connection, DB_NAME_PREFIX . $csv) 
            or die(mysqli_error($this->connection));
    }

    
    /** returns array **/
    public
    function getTableNames() {
        $q = "SELECT name FROM md_Table ORDER BY name ASC";
        return $this->fetchIntoArray($q);
    }

    /** returns array **/
    public
    function getTableInfo($tName) {
        $q = "SELECT tableId, engine, description FROM md_Table WHERE name='$tName'";
        return $this->fetchIntoArray($q);
    }

    /** returns array **/
    public
    function getTableColumns($tId) {
        if ( !is_numeric($tId) ) return;
        if ( $tId < 0 ) return;
        $q = "SELECT name, ".
                    "description, ".
                    "type, ".
                    "notNull, ".
                    "defaultValue, ".
                    "unit, ".
                    "ucd ".
             "FROM  md_Column ".
             "WHERE tableId='$tId' ".
             "ORDER BY displayOrder";
        return $this->fetchIntoArray($q);
    }

    private
    function query($query) {
        $result = mysqli_query($this->connection, $query);
        if ( ! $result ) {
            die($this->reportError($query));
        }
        return $result;
    }

    function fetchIntoArray($query) {
        $mm = array();
        $result = $this->query($query);
        if ( !$result ) {
            return $mm;
        }
        while ( $row = mysqli_fetch_array($result) ) {
            array_push($mm, $row);
        }
        mysqli_free_result($result);
        return $mm;
    }

    private
    function reportError($q) {
        return "MySQL error\r\n\r\n".
            "page: "        . $_SERVER['PHP_SELF']     . "\r\n\r\n" .
            "queryString: " . $_SERVER['QUERY_STRING'] . "\r\n\r\n" .
            "error: "       . $this->connection->error . "\r\n\r\n" .
            "query: "       . $query;
    }
}

$database = new MySQLDB;

?>
