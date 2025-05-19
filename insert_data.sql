INSERT INTO USER_ACCOUNT (UID, Name, Phone) VALUES 
(1, 'A', '682-111-1111'),
(2, 'B', '682-222-2222'),
(3, 'C', '682-333-3333'),
(4, 'D', '682-444-4444'),
(5, 'E', '682-555-5555'),
(6, 'F', '682-666-6666'),
(7, 'G', '682-777-7777'),
(8, 'H', '682-888-8888'),
(9, 'I', '682-999-9999'),
(10,'J', '682-101-1010');

INSERT INTO USER_ROLES (RoleID, RoleName, Role_desc, UID) VALUES 
(1, 'Admin', 'Privleged and Unprivileged Access', 1), -- table1 Account A 
(2, 'Edit', 'Read or Update only', 2),   -- table2 Account B
(3, 'View', 'Only Read', 3); -- table3 AccountC

INSERT INTO TABLES (TableId, TableName, OwnerId) VALUES 
(1, 'TAB1', 1),
(2, 'TAB2', 2),
(3, 'TAB3', 3),
(4, 'TAB4', 4),
(5, 'TAB5', 5),
(6, 'TAB6', 6),
(7, 'TAB7', 7),
(8, 'TAB8', 8),
(9, 'TAB9', 9),
(10, 'TAB10', 10);

INSERT INTO PRIVILEGE (PrivilegeId, PrivilegeName, PrivilegeType) VALUES 
(1, 'select', 'Account'), -- view, edit, admin
(2, 'insert', 'Account'), -- admin
(3, 'update', 'Account'), -- edit,admin
(4,'alter',  'Relation'); -- admin 

INSERT INTO ACCOUNT_PRIVILEGE (Privilege_Id)
SELECT PrivilegeId
FROM PRIVILEGE
WHERE PrivilegeType = 'Account';

INSERT INTO RELATION_PRIVILEGE (Privilege_Id)
SELECT PrivilegeId
FROM PRIVILEGE
WHERE PrivilegeType = 'Relation';

INSERT INTO UR_AP (RoleId, AP_ID) VALUES 
(1, 1), -- Admin role with Read access
(1, 2), -- Admin role with Write access
(1, 3), -- Admin role with Update access
(2, 1), -- Edit role with read access
(2, 3), -- Edit role with update access
(3, 1); -- view role with read only access

INSERT INTO USER_RELATION_TABLE (URT_ID, RoleId, Relation_Id, TableId) VALUES 
(1,1, 1, 1); -- ADMIN alter  A
