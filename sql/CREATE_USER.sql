WHENEVER SQLERROR EXIT SQL.SQLCODE

SET DEFINE ON

BEGIN
  IF (SUBSTR(&_O_RELEASE,1,1) > 6 OR SUBSTR(&_O_RELEASE,1,4) < 1002)
  THEN
    RAISE_APPLICATION_ERROR(-20000, 'Database Version not supported');
  END IF;
END;
/

-- Account is locked and expired, you may never use it.
-- SYSAUX is used because the tablespace must always be available and RW.
CREATE USER &_vUsername identified by "AS81...9jsa1Xj10jx" account lock password expire QUOTA 10M ON SYSAUX
/

BEGIN
  IF &_O_RELEASE LIKE '12%'
  THEN
    EXECUTE IMMEDIATE 'REVOKE INHERIT PRIVILEGES ON USER &_vUsername FROM PUBLIC';
  END IF;
END;
/
