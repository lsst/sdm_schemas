#!/usr/bin/env python


from lsst.cat.mysqlBase import MySQLBase


x = MySQLBase("localhost")

x.connect("becla", "")
x.execCommandN("SHOW DATABASES")
x.execCommand0("DROP DATABASE IF EXISTS db1")
x.execCommand0("CREATE DATABASE db1")
x.execCommandN("SHOW DATABASES")


x.connect("becla", "", "db1")
x.execCommand0("CREATE TABLE t1 (i int)")
x.execCommandN("SHOW TABLES")
x.connect("becla", "", "db1")
x.execCommand0("CREATE TABLE t2 (i int)")
x.execCommandN("SHOW TABLES")
x.loadSqlScript("../sql/setup_DB_global.sql", "becla", "", "db1")


