
# cleanup from previous test
mysql -e "drop database if exists dummy1_DC3a_u_runX"
mysql -e "drop database if exists dummy2_DC3a_u_runY"


# one time
mysql -e "drop database if exists GlobalDB"
mysql < setup_GlobalDB.sql


# authorize user "dummy1"
mysql -e 'GRANT ALL ON `dummy1\_%`.* TO `dummy1`@`localhost` IDENTIFIED BY "dummyPwd1"'
mysql -e 'GRANT SELECT ON *.* TO `dummy1`@`localhost` IDENTIFIED BY "dummyPwd1"'
mysql -e 'GRANT SELECT, INSERT ON GlobalDB.RunInfo_DC3a TO `dummy1`@`localhost` IDENTIFIED BY "dummyPwd1"'
mysql -e 'GRANT EXECUTE ON FUNCTION GlobalDB.extendRun TO `dummy1`@`localhost` IDENTIFIED BY "dummyPwd1"'


# authorize user "dummy2"
mysql -e 'GRANT ALL ON `dummy2\_%`.* TO `dummy2`@`localhost` IDENTIFIED BY "dummyPwd2"'
mysql -e 'GRANT SELECT ON *.* TO `dummy2`@`localhost` IDENTIFIED BY "dummyPwd2"'
mysql -e 'GRANT SELECT, INSERT ON GlobalDB.RunInfo_DC3a TO `dummy2`@`localhost` IDENTIFIED BY "dummyPwd2"'
mysql -e 'GRANT EXECUTE ON FUNCTION GlobalDB.extendRun TO `dummy2`@`localhost` IDENTIFIED BY "dummyPwd2"'


# dummy1 runX
mysql -udummy1 -pdummyPwd1 -e "CREATE DATABASE dummy1_DC3a_u_runX"
mysql -udummy1 -pdummyPwd1 dummy1_DC3a_u_runX < lsstSchema4mysqlDC3a.sql
mysql -udummy1 -pdummyPwd1 dummy1_DC3a_u_runX < setup_storedFunctions.sql
mysql -udummy1 -pdummyPwd1 dummy1_DC3a_u_runX < setup_sdqa.sql
mysql -udummy1 -pdummyPwd1 dummy1_DC3a_u_runX < setup_perRunTables.sql
mysql -udummy1 -pdummyPwd1 GlobalDB -e 'INSERT INTO RunInfo_DC3a (runName, dbName, startDate, expDate, initiator) VALUES ("runX", "dummy1_DC3a_u_runX", NOW(), DATE_ADD(NOW(), INTERVAL 2 WEEK), "dummy1")'


# dummy2 runY
mysql -udummy2 -pdummyPwd2 -e "CREATE DATABASE dummy2_DC3a_u_runY"
mysql -udummy2 -pdummyPwd2 dummy2_DC3a_u_runY < lsstSchema4mysqlDC3a.sql
mysql -udummy2 -pdummyPwd2 dummy2_DC3a_u_runY < setup_storedFunctions.sql
mysql -udummy2 -pdummyPwd2 dummy2_DC3a_u_runY < setup_sdqa.sql
mysql -udummy2 -pdummyPwd2 dummy2_DC3a_u_runY < setup_perRunTables.sql
mysql -udummy2 -pdummyPwd2 GlobalDB -e 'INSERT INTO RunInfo_DC3a (runName, dbName, startDate, expDate, initiator) VALUES ("runY", "dummy2_DC3a_u_runY", NOW(), DATE_ADD(NOW(), INTERVAL 2 WEEK), "dummy2")'



# try twice if extending run is allowed 
mysql -udummy2 -pdummyPwd2 GlobalDB -e "SELECT extendRun('runY', 'dummy2')"
mysql -udummy2 -pdummyPwd2 GlobalDB -e "SELECT extendRun('runY', 'dummy2')"

# try extending some elses run
mysql -udummy2 -pdummyPwd2 GlobalDB -e "SELECT extendRun('runX', 'dummy2')"

# try extending invalid run
mysql -udummy2 -pdummyPwd2 GlobalDB -e "SELECT extendRun('xyz', 'dummy2')"



# check things
mysql -e "SELECT * from GlobalDB.RunInfo_DC3a"
