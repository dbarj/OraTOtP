WHENEVER SQLERROR EXIT SQL.SQLCODE

prompt Oracle Database Vault Detected.

ACCEPT _vDVAcctMgrstr CHAR DEFAULT '/ as sysdba' PROMPT "String to connect as DV Acct Mgr [/ as sysdba]: "
ACCEPT _vDVOwnerstr CHAR DEFAULT '/ as sysdba' PROMPT "String to connect as DV Owner [/ as sysdba]: "
ACCEPT _vDBAstr CHAR DEFAULT '/ as sysdba' PROMPT "String to connect as DBA [/ as sysdba]: "
