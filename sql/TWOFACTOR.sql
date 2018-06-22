WHENEVER SQLERROR EXIT SQL.SQLCODE

SET DEFINE ON

ALTER SESSION SET CURRENT_SCHEMA=&_vUsername
/

SET DEFINE OFF

CREATE OR REPLACE PACKAGE TWOFACTOR AS
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
  PROCEDURE SETUP;
  PROCEDURE DECONFIG(PCODE IN VARCHAR2 DEFAULT NULL);
  PROCEDURE VALIDATE(PCODE IN VARCHAR2);
  PROCEDURE AUTHENTICATE(PCODE IN VARCHAR2);
  PROCEDURE REMEMBER(PCODE IN VARCHAR2);
  PROCEDURE FORGET;
  PROCEDURE SETSECRETPASS(PPASS IN VARCHAR2);
END TWOFACTOR;
/

CREATE OR REPLACE PACKAGE BODY TWOFACTOR AS
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
  VUSER CONSTANT VARCHAR2(30) := SYS_CONTEXT('USERENV', 'SESSION_USER');
  VPASS VARCHAR2(30) := NULL;

  PROCEDURE SETUP IS
  BEGIN
    TWOFACTOR_ADMIN.SETUP(PUSER => VUSER, PPASS => VPASS, PGAP => NULL);
  END;

  PROCEDURE DECONFIG(PCODE IN VARCHAR2 DEFAULT NULL) IS
  BEGIN
    TWOFACTOR_ADMIN.DECONFIG(PUSER => VUSER, PCODE => PCODE, PPASS => VPASS, PISADMIN => FALSE);
  END;

  PROCEDURE VALIDATE(PCODE IN VARCHAR2) IS
  BEGIN
    TWOFACTOR_ADMIN.VALIDATE(PUSER => VUSER, PCODE => PCODE, PPASS => VPASS);
  END;

  PROCEDURE AUTHENTICATE(PCODE IN VARCHAR2) IS
  BEGIN
    TWOFACTOR_ADMIN.AUTHENTICATE(PCODE => PCODE, PPASS => VPASS);
  END;

  PROCEDURE REMEMBER(PCODE IN VARCHAR2) IS
  BEGIN
    TWOFACTOR_ADMIN.REMEMBER(PCODE => PCODE, PPASS => VPASS, PINT => NULL);
  END;

  PROCEDURE FORGET IS
  BEGIN
    TWOFACTOR_ADMIN.FORGET(PUSER => VUSER);
  END;

  PROCEDURE SETSECRETPASS(PPASS IN VARCHAR2) IS
  BEGIN
    VPASS := PPASS;
  END;

END TWOFACTOR;
/
