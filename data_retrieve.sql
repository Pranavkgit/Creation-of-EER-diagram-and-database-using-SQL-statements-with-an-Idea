select " ---- USER_ACCOUNT ---- " as heading;
select
    UID AS "Account Number", 
    Name AS "Account Name", 
    Phone AS "Phone Number"
FROM USER_ACCOUNT;

select " ---- USER_ROLES ---- " as heading;
select
    RoleID AS "User_Role Number", 
    RoleName AS "User_Role Name", 
    Role_desc AS "Role Description", 
    UID AS "Related Account"
FROM USER_ROLES;

select " ---- TABLES ---- " as heading;
select
    TableID AS "Table Number", 
    TableName AS "Table Name", 
    OwnerID AS "Account related"
FROM TABLES;

select " ---- PRIVILEGES ---- " as heading;
select
    PrivilegeID AS "Privilege ID", 
    PrivilegeName AS "Privilege Name", 
    PrivilegeType AS "Privilege Type"
FROM PRIVILEGE;

select " ---- ACCOUNT_PRIVILEGES ---- " as heading;
select
    Account_ID AS "Account Privilege ID", 
    PrivilegeName AS "Privilege Name"
FROM ACCOUNT_PRIVILEGE as AP, Privilege as P WHERE AP.Privilege_Id = P.privilegeID;

select " ---- RELATION_PRIVILEGES ---- " as heading;
select
    Relation_ID AS "Relation Privilege ID", 
    PrivilegeName AS "Privilege Name"
FROM RELATION_PRIVILEGE as RP, Privilege as p where RP.Privilege_Id = P.PrivilegeID;

select " ---- USER_ROLE - ACCOUNT_PRIVILEGES ---- " as heading;
select
    UR.RoleID AS "Userrole ID", 
    UR.RoleName AS "Role Name", 
    P.PrivilegeName AS "Account Privilege Name"
FROM UR_AP as UAP,USER_ROLES AS UR,ACCOUNT_PRIVILEGE AS AP,PRIVILEGE AS P
WHERE UAP.RoleId = UR.RoleID AND UAP.AP_ID = AP.Account_ID AND AP.Privilege_Id = P.PrivilegeID;

select " ----USER_ROLE - RELATION_PRIVILEGE - TABLE ---- " as heading;
select
    UR.RoleID AS "Role ID", 
    UR.RoleName AS "Role Name", 
    P.PrivilegeName AS "Relation Privilege Name", 
    T.TableName AS "Table Name"
FROM USER_RELATION_TABLE AS URT,USER_ROLES AS UR,RELATION_PRIVILEGE AS RP,PRIVILEGE AS P,TABLES AS T
WHERE URT.RoleId = UR.RoleID AND URT.Relation_Id = RP.Relation_ID AND P.PrivilegeID = RP.Privilege_Id AND URT.TableId = T.TableID;
