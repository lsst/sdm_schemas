#!/usr/bin/env python


from MySQLAdmin import MySQLAdmin
from administerRuns import AdminRuns


gDb = "GlobalDB"

def dropDB():
    admin = MySQLAdmin("localhost")
    admin.connect("becla", "")
    admin.execCommand0("DROP DATABASE IF EXISTS " + gDb)
    admin.execCommand0("DROP DATABASE IF EXISTS becla_DC3a_u_myFirstRun")
    admin.execCommand0("DROP DATABASE IF EXISTS becla_DC3a_u_mySecondRun")
    admin.execCommand0("DROP DATABASE IF EXISTS becla_DC3a_p_prodRunA")

dropDB()

x = AdminRuns("localhost", # mysql host
              gDb)  # global db name


x.setupGlobalDB("globalDBPolicy.txt")

x.checkStatus("perRunDBPolicy.txt", 
              "becla",     # non-superuser
              "",          # password
              "localhost") # machine where mysql client is executed

#x.prepareForNewRun("perRunDBPolicy.txt", "myFirstRun",  "u", "becla", "");
#x.prepareForNewRun("perRunDBPolicy.txt", "mySecondRun", "u", "becla", "");
#x.prepareForNewRun("perRunDBPolicy.txt", "prodRunA",    "p", "becla", "");
