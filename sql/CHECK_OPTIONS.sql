VARIABLE HASVPD VARCHAR2(5)
VARIABLE HASDBVAULT VARCHAR2(5)

BEGIN
  select value into :HASVPD from v$option where parameter='Fine-grained access control';
EXCEPTION
  when no_data_found then
    :HASDBVAULT := 'FALSE';
END;
/

BEGIN
  select value into :HASDBVAULT from v$option where parameter='Oracle Database Vault';
EXCEPTION
  when no_data_found then
    :HASDBVAULT := 'FALSE';
END;
/
