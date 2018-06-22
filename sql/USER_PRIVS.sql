WHENEVER SQLERROR EXIT SQL.SQLCODE

SET DEFINE ON

GRANT EXECUTE ON DBMS_CRYPTO TO &_vUsername -- To encrypt user Keys
/
GRANT SELECT ON V_$SESSION TO &_vUsername   -- For remembering user login data (machine name, os user, terminal, etc)
/
