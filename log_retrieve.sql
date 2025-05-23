mysql> source data_retrieve.sql
+--------------------------+
| heading                  |
+--------------------------+
|  ---- USER_ACCOUNT ----  |
+--------------------------+
1 row in set (0.02 sec)

+----------------+--------------+--------------+
| Account Number | Account Name | Phone Number |
+----------------+--------------+--------------+
|              1 | A            | 682-111-1111 |
|              2 | B            | 682-222-2222 |
|              3 | C            | 682-333-3333 |
|              4 | D            | 682-444-4444 |
|              5 | E            | 682-555-5555 |
|              6 | F            | 682-666-6666 |
|              7 | G            | 682-777-7777 |
|              8 | H            | 682-888-8888 |
|              9 | I            | 682-999-9999 |
|             10 | J            | 682-101-1010 |
+----------------+--------------+--------------+
10 rows in set (0.02 sec)

+------------------------+
| heading                |
+------------------------+
|  ---- USER_ROLES ----  |
+------------------------+
1 row in set (0.01 sec)

+------------------+----------------+-----------------------------------+-----------------+
| User_Role Number | User_Role Name | Role Description                  | Related Account |
+------------------+----------------+-----------------------------------+-----------------+
|                1 | Admin          | Privleged and Unprivileged Access |               1 |
|                2 | Edit           | Read or Update only               |               2 |
|                3 | View           | Only Read                         |               3 |
+------------------+----------------+-----------------------------------+-----------------+
3 rows in set (0.02 sec)

+--------------------+
| heading            |
+--------------------+
|  ---- TABLES ----  |
+--------------------+
1 row in set (0.02 sec)

+--------------+------------+-----------------+
| Table Number | Table Name | Account related |
+--------------+------------+-----------------+
|            1 | TAB1       |               1 |
|            2 | TAB2       |               2 |
|            3 | TAB3       |               3 |
|            4 | TAB4       |               4 |
|            5 | TAB5       |               5 |
|            6 | TAB6       |               6 |
|            7 | TAB7       |               7 |
|            8 | TAB8       |               8 |
|            9 | TAB9       |               9 |
|           10 | TAB10      |              10 |
+--------------+------------+-----------------+
10 rows in set (0.01 sec)

+------------------------+
| heading                |
+------------------------+
|  ---- PRIVILEGES ----  |
+------------------------+
1 row in set (0.02 sec)

+--------------+----------------+----------------+
| Privilege ID | Privilege Name | Privilege Type |
+--------------+----------------+----------------+
|            1 | select         | Account        |
|            2 | insert         | Account        |
|            3 | update         | Account        |
|            4 | alter          | Relation       |
+--------------+----------------+----------------+
4 rows in set (0.02 sec)

+--------------------------------+
| heading                        |
+--------------------------------+
|  ---- ACCOUNT_PRIVILEGES ----  |
+--------------------------------+
1 row in set (0.01 sec)

+----------------------+----------------+
| Account Privilege ID | Privilege Name |
+----------------------+----------------+
|                    1 | select         |
|                    2 | insert         |
|                    3 | update         |
+----------------------+----------------+
3 rows in set (0.02 sec)

+---------------------------------+
| heading                         |
+---------------------------------+
|  ---- RELATION_PRIVILEGES ----  |
+---------------------------------+
1 row in set (0.01 sec)

+-----------------------+----------------+
| Relation Privilege ID | Privilege Name |
+-----------------------+----------------+
|                     1 | alter          |
+-----------------------+----------------+
1 row in set (0.02 sec)

+--------------------------------------------+
| heading                                    |
+--------------------------------------------+
|  ---- USER_ROLE - ACCOUNT_PRIVILEGES ----  |
+--------------------------------------------+
1 row in set (0.01 sec)

+-------------+-----------+------------------------+
| Userrole ID | Role Name | Account Privilege Name |
+-------------+-----------+------------------------+
|           1 | Admin     | select                 |
|           1 | Admin     | insert                 |
|           1 | Admin     | update                 |
|           2 | Edit      | select                 |
|           2 | Edit      | update                 |
|           3 | View      | select                 |
+-------------+-----------+------------------------+
6 rows in set (0.02 sec)

+---------------------------------------------------+
| heading                                           |
+---------------------------------------------------+
|  ----USER_ROLE - RELATION_PRIVILEGE - TABLE ----  |
+---------------------------------------------------+
1 row in set (0.02 sec)

+---------+-----------+-------------------------+------------+
| Role ID | Role Name | Relation Privilege Name | Table Name |
+---------+-----------+-------------------------+------------+
|       1 | Admin     | alter                   | TAB1       |
+---------+-----------+-------------------------+------------+
1 row in set (0.01 sec)

mysql> exit
