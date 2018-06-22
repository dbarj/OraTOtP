/************************************************************************

   OraTOtP - Oracle Time-based One-time Password
   Copyright 2016  Rodrigo Jorge <http://www.dbarj.com.br/>

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

************************************************************************/
WHENEVER SQLERROR EXIT SQL.SQLCODE

COLUMN SCRIPT_NAME NEW_VALUE V_SCRIPT_NAME
SET VERIFY OFF
SET DEFINE ON
SET FEEDBACK OFF

DEFINE _vUsername = "TOTP" (CHAR)

ACCEPT _vUsername CHAR DEFAULT '&_vUsername' PROMPT "Schema Name for 2-Factor [&_vUsername]: "
ACCEPT _vSYSDBAstr CHAR DEFAULT '/ as sysdba' PROMPT "String to connect as SYS [/ as sysdba]: "

DEFINE _vDVAcctMgrstr = "&_vSYSDBAstr" (CHAR)
DEFINE _vDVOwnerstr = "&_vSYSDBAstr" (CHAR)
DEFINE _vDBAstr = "&_vSYSDBAstr" (CHAR)

-- Check if the current database has Fine-grained access control (EE) and Oracle Database Vault (option) enabled.
conn &_vSYSDBAstr
@@sql/CHECK_OPTIONS

-- If has DB Vault option, ask for users credentials.
SET TERMOUT OFF
SELECT DECODE(:HASDBVAULT, 'TRUE', 'VAULT_USERS', 'SKIP') SCRIPT_NAME FROM DUAL;
SET TERMOUT ON
SET DEFINE ON
@@sql/&V_SCRIPT_NAME 'DB Vault Users script skipped - Database Vault not enabled.'

-- Create user.
conn &_vDVAcctMgrstr
@@sql/CREATE_USER
prompt User created.

-- Grant privs used by procedures.
conn &_vSYSDBAstr
@@sql/USER_PRIVS
prompt User privs granted.

-- Create objects.
conn &_vDBAstr
@@sql/USER_OBJS
@@sql/TWOFACTOR_INTERNAL
@@sql/TWOFACTOR_ADMIN
@@sql/TWOFACTOR
@@sql/ENABLE_ROLE
@@sql/GRANT_SYNONYM
@@sql/SET_TWOFACTOR_CTX_TRIG
prompt Objects created.

-- If not SE, create Policies.
SET TERMOUT OFF
SELECT DECODE(:HASVPD, 'TRUE', 'POLICIES', 'SKIP') SCRIPT_NAME FROM DUAL;
SET TERMOUT ON
SET DEFINE ON
@@sql/&V_SCRIPT_NAME 'Policies script skipped - Oracle Standard Edition'

-- If has DB Vault option, create Realm to proctect schemas objects.
conn &_vDVOwnerstr
SET TERMOUT OFF
SELECT DECODE(:HASDBVAULT, 'TRUE', 'VAULT_REALM', 'SKIP') SCRIPT_NAME FROM DUAL;
SET TERMOUT ON
SET DEFINE ON
@@sql/&V_SCRIPT_NAME 'DB Vault Realms script skipped - Database Vault not enabled.'

prompt => SCRIPT EXECUTED SUCCESSFULLY! <=

SET FEEDBACK ON
SET VERIFY ON

EXIT
