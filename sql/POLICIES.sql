WHENEVER SQLERROR EXIT SQL.SQLCODE

SET DEFINE ON

ALTER SESSION SET CURRENT_SCHEMA=&_vUsername
/

SET DEFINE OFF

CREATE OR REPLACE FUNCTION FILTER_ACCESS(SCHEMA_VAR IN VARCHAR2, TABLE_VAR IN VARCHAR2) RETURN VARCHAR2 IS
  V_USER VARCHAR2(30) := SYS_CONTEXT('USERENV', 'CURRENT_USER');
BEGIN
  -- Created by Rodrigo Jorge - www.dbarj.com.br --
  RETURN 'SYS_CONTEXT(''USERENV'',''CURRENT_USER'') = ''' || V_USER || '''';
END FILTER_ACCESS;
/

SET DEFINE ON

SET TERMOUT OFF
WHENEVER SQLERROR CONTINUE
EXEC DBMS_RLS.DROP_POLICY(OBJECT_SCHEMA => '&_vUsername', POLICY_NAME => 'FACKEYS_POLICY_1', OBJECT_NAME => 'FACKEYS');
EXEC DBMS_RLS.DROP_POLICY(OBJECT_SCHEMA => '&_vUsername', POLICY_NAME => 'FACKEYS_POLICY_2', OBJECT_NAME => 'FACKEYS');
EXEC DBMS_RLS.DROP_POLICY(OBJECT_SCHEMA => '&_vUsername', POLICY_NAME => 'TRUSTEDLOCS_POLICY', OBJECT_NAME => 'TRUSTEDLOCS');
EXEC DBMS_RLS.DROP_POLICY(OBJECT_SCHEMA => '&_vUsername', POLICY_NAME => 'BFORCEPROT_POLICY', OBJECT_NAME => 'BFORCEPROT');
WHENEVER SQLERROR EXIT SQL.SQLCODE
SET TERMOUT ON

BEGIN
  DBMS_RLS.ADD_POLICY (
    object_schema    => '&_vUsername',
    object_name      => 'FACKEYS',
    policy_name      => 'FACKEYS_POLICY_1',
    function_schema  => '&_vUsername',
    policy_function  => 'FILTER_ACCESS',
    statement_types  => 'SELECT',
    enable => TRUE,
    static_policy => TRUE,
    sec_relevant_cols => 'KEY',
    sec_relevant_cols_opt => DBMS_RLS.ALL_ROWS
   );
 END;
/

BEGIN
  DBMS_RLS.ADD_POLICY (
    object_schema    => '&_vUsername',
    object_name      => 'FACKEYS',
    policy_name      => 'FACKEYS_POLICY_2',
    function_schema  => '&_vUsername',
    policy_function  => 'FILTER_ACCESS',
    statement_types  => 'INDEX, INSERT, UPDATE, DELETE',
    enable => TRUE,
    static_policy => TRUE
   );
 END;
/

BEGIN
  DBMS_RLS.ADD_POLICY (
    object_schema    => '&_vUsername',
    object_name      => 'TRUSTEDLOCS',
    policy_name      => 'TRUSTEDLOCS_POLICY',
    function_schema  => '&_vUsername',
    policy_function  => 'FILTER_ACCESS',
    statement_types  => 'INDEX, INSERT, UPDATE, DELETE',
    enable => TRUE,
    static_policy => TRUE
   );
 END;
/

BEGIN
  DBMS_RLS.ADD_POLICY (
    object_schema    => '&_vUsername',
    object_name      => 'BFORCEPROT',
    policy_name      => 'BFORCEPROT_POLICY',
    function_schema  => '&_vUsername',
    policy_function  => 'FILTER_ACCESS',
    statement_types  => 'INDEX, INSERT, UPDATE, DELETE',
    enable => TRUE,
    static_policy => TRUE
   );
 END;
/

prompt Policies created.
