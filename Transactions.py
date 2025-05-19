import mysql.connector

# Connecting a database(configuration details) 
database_config = {
    'host': 'acadmysqldb001p.uta.edu',
    'user': 'pxm4180',
    'password': 'pxm4180db',
    'database': 'pxm4180'
}

def add_useraccount():
    UID = int(input("Enter UID: "))
    Name = input("Enter Account name: ")
    Phone = input("Enter phone number: ")
    query = "INSERT INTO USER_ACCOUNT (UID,Name, Phone) VALUES (%s,%s, %s)"
    args = (UID,Name, Phone)
    execute(query,args)

def add_userroles():
    RoleID = int(input("Enter user Role Id: "))
    RoleName = input("Enter role name: ")
    Role_desc = input("Enter role description: ")
    UId = int(input("Enter the Account to relate: "))
    query = "INSERT INTO USER_ROLES (RoleID, RoleName, Role_desc, UId) VALUES (%s, %s, %s, %s)"
    args = (RoleID, RoleName,Role_desc, UId)
    execute(query, args)

def add_table():
    TableId = int(input("Enter user Table Id: "))
    TableName = input("Enter Table name: ")
    OwnerId = int(input("Enter the Account to relate: "))
    query = "INSERT INTO TABLES (TableID, TableName, OwnerID) VALUES (%s, %s, %s)"
    args = (TableId, TableName, OwnerId)
    execute(query, args)

def add_privilege():
     PrivilegeID = int(input("Enter Privilege Id: "))
     PrivilegeName = input("Enter Privilege name: ")
     PrivilegeType = input("Enter Privilege Type Account or Relation: ")
     query = "INSERT INTO PRIVILEGE (PrivilegeID, PrivilegeName, PrivilegeType) VALUES (%s, %s, %s)"
     args = (PrivilegeID, PrivilegeName, PrivilegeType)
     execute(query, args)
     sort_accountPrivileges()
     sort_RelationalPrivileges()

def sort_accountPrivileges():
        query = """INSERT INTO ACCOUNT_PRIVILEGE (Privilege_Id)  
        SELECT PrivilegeID FROM PRIVILEGE WHERE PrivilegeType = 'Account'         
        AND NOT EXISTS (
            SELECT 1 
            FROM ACCOUNT_PRIVILEGE
            WHERE ACCOUNT_PRIVILEGE.Privilege_Id = PRIVILEGE.PrivilegeID
        )"""
        args =()
        execute(query,args)

def sort_RelationalPrivileges():
        query = """INSERT INTO RELATION_PRIVILEGE (Privilege_Id)
        SELECT PrivilegeID FROM PRIVILEGE WHERE PrivilegeType = 'Relation'
        AND NOT EXISTS (
            SELECT 1 
            FROM RELATION_PRIVILEGE
            WHERE RELATION_PRIVILEGE.Privilege_Id = PRIVILEGE.PrivilegeID
        )"""
        args =()
        execute(query,args)


def rel_Userrole_AP():
        RoleId = int(input("Enter user Role Id: "))
        AP_ID = int(input("Enter user Account Id to relate: "))
        query = "INSERT INTO UR_AP (RoleId, AP_ID) VALUES (%s, %s)"
        args = (RoleId, AP_ID)  
        execute(query,args)

def rel_Userrole_Tables_RP():
            URT_ID = int(input("Enter user URT Id: "))
            RoleId = int(input("Enter user Role Id: "))
            Relation_Id = int(input("Enter the Relation Id: "))
            TableId = int(input("Enter the Table Id: "))
            query = "INSERT INTO USER_RELATION_TABLE (URT_ID,RoleId, Relation_Id, TableId) VALUES (%s,%s, %s, %s)"
            args = (URT_ID, RoleId, Relation_Id,TableId) 
            execute(query,args)

check = 0
def privileges_role():
    global check
    Id = int(input("Enter user Role Id: "))
    query = '''SELECT p.PrivilegeID,p.PrivilegeName,p.PrivilegeType
            FROM USER_ROLES AS UR,UR_AP AS URAP,account_privilege AS AP,privilege AS P
            WHERE UR.RoleID = URAP.RoleId AND URAP.AP_ID = AP.Account_ID AND  AP.Privilege_Id = P.PrivilegeID
            AND UR.RoleId = %s
            UNION
            SELECT  p.PrivilegeID,p.PrivilegeName,p.PrivilegeType
            FROM USER_ROLES AS UR, USER_RELATION_TABLE AS URT, relation_privilege AS RP, privilege AS P
            WHERE UR.RoleID = URT.RoleId and URT.Relation_Id = RP.Relation_ID and RP.Privilege_Id = P.PrivilegeID
            AND UR.RoleId = %s;'''
    args = (Id,Id)
    check = 1
    execute(query,args)

def privileges_account():
    global check
    Id = int(input("Enter user Account Id: "))
    query = '''SELECT P.PrivilegeId,p.PrivilegeName, P.PrivilegeType
    FROM  USER_ACCOUNT as  UA,USER_ROLES AS UR,UR_AP AS URAP,account_privilege AS AP,privilege AS P
    WHERE UA.UID = UR.UId and URAP.RoleId = UR.RoleID and AP.Account_ID = URAP.AP_ID AND AP.Privilege_Id = P.PrivilegeID
    and ua.UID = %s
    UNION
    SELECT P.PrivilegeId, P.PrivilegeName, P.PrivilegeType
    FROM USER_ACCOUNT AS UA,USER_ROLES AS UR, USER_RELATION_TABLE AS URT, relation_privilege AS RP,privilege AS P
    WHERE UA.UID = UR.UId and UR.RoleID = URT.RoleId and URT.Relation_Id = RP.Relation_ID AND P.PrivilegeID = RP.Privilege_Id 
    and ua.UID = %s;'''
    args = (Id,Id)
    check = 1
    execute(query,args)

flag = 0
def check_accountprivilege():
    global flag
    user_name = input("Enter user name: ")
    privilege_name = input("Enter Privilege name: ")
    privilege_type = 'Account'
    if privilege_type == 'Account':
        query = ''' SELECT 'Granted' FROM USER_ACCOUNT AS UA,USER_ROLES AS UR,UR_AP AS URAP, ACCOUNT_PRIVILEGE AS AP,PRIVILEGE AS P
        WHERE UA.UID = UR.UId and UR.RoleID = URAP.RoleId and URAP.AP_ID = AP.Account_ID and p.privilegeID = AP.privilege_Id
		and UA.Name = %s and P.PrivilegeName = %s and P.PrivilegeType = %s;'''
        args =(user_name,privilege_name,privilege_type)
        flag = 1
        execute(query,args)

def check_Relationprivilege():
    global flag
    user_name = input("Enter user name: ")
    privilege_name = input("Enter Privilege name: ")
    privilege_type = 'Relation'
    if privilege_type == 'Relation':
        query = '''SELECT 'Granted' FROM USER_ACCOUNT AS UA,USER_ROLES AS UR,USER_RELATION_TABLE AS URT, relation_privilege AS RP, PRIVILEGE AS P
        where UA.UID = UR.UId and URT.RoleId = UR.RoleID and URT.Relation_Id = RP.Relation_ID and p.privilegeID = RP.privilege_Id
		and UA.Name = %s AND P.PrivilegeName = %s and P.PrivilegeType = %s;'''
        args =(user_name,privilege_name,privilege_type)
        flag = 1
        execute(query,args)

def execute(query,args):
    global flag
    global check
    # setting up the database and cursor connections  
    conn = mysql.connector.connect(**database_config)
    if conn and len(args)> 0:
        cursor = conn.cursor()
        cursor.execute(query,args)
        result = cursor.fetchall()
        # Print data from the select query
        if check and result:
            check = 0
            print("Privileges with Role:")
            for row in result:
                print(f"PrivilegeID: {row[0]},PrivilegeName: {row[1]},PrivilegeType: {row[2]}")
        else:
            if check:
                print("No privileges found")
                check = 0
        
        if flag and result:
             print("This Privilege is granted for the Account")
             flag = 0

        else:
            if flag:
                print("This Privilege is not granted for the Account.")
                flag = 0
        conn.commit()
        print("Transaction successful")
    elif conn and len(args) == 0:
        cursor = conn.cursor()
        cursor.execute(query) 
        conn.commit()
        print("Transaction sorted")       
    else:
        print("Connection failed")

while 1:
    print("1. Transaction to add User Account: ")
    print("2. Transaction to add User Roles: ")
    print("3. Transaction to add Table: ")
    print("4. Transaction to add Privilege: ")
    print("5. Transaction to add Relation b/w user role and account privilege: ")
    print("6. Transaction to add Relation between user_role table and relation privilege: ")  
    print("7. Transaction to check Privileges for the user role: ")
    print("8. Transaction to check Privileges for the user account: ")
    print("9. Transaction to check Account Privilege for the user account: ")
    print("10. Transaction to check Relation Privilege for the user account: ")
    print("11. exit: ")
    try:
        c = int(input("Enter the Choice: "))
        if c==1:
            add_useraccount()
        elif c==2:
            add_userroles()
        elif c==3:
             add_table()
        elif c==4:
             add_privilege()
        elif c==5:
             rel_Userrole_AP()
        elif c==6:
            rel_Userrole_Tables_RP()
        elif c==7:
            privileges_role()
        elif c==8:
            privileges_account()
        elif c==9:
             check_accountprivilege()
        elif c==10:
             check_Relationprivilege()
        elif c==11:
             break
        else:
             print("No option available")
        print("\n")
    except: 
        print("Enter only numeric value")
        print("\n")

         