# OraTOtP - Oracle Time-based One-time Password

**OraTOtP** ( Oracle Time-based One-time Password ) is a free tool that adds **2-Factor Authentication** layer as an extra security when allowing users to execute anything inside your Oracle Database.

Usage examples of OraTOtP:

* Add an extra security layer for your database users, making the user password less powerful.
* If someone discovers any schema password, he will have limited or no access to the DB objects.
* You want to meet some compliance requirement (e.g.: PCI DSS Requirement 8.3)

Tested on all Oracle Database versions (SE and EE) from **10gR2 until latest 12c**.

More information at: http://www.dbarj.com.br/en/oratotp-oracle-time-based-one-time-password

## 1. How it Works ##

After the user connects, his roles will be disabled and the only way to enable them is typing a correct 6-digits token that is generated using a mobile app. The DBA can easily define which roles are required to have **2-Factor Authentication** before they get enabled by someone.

OraTOtP tool is intended to be very easy to setup and use, not requiring any major skills for anyone to enable it.

You should not enable 2-Factor Authentication for roles used by logins with unattended access (application, batch jobs, etc) unless there is some application interface to type the token. It is also **not** recommended to enable it on default roles (DBA, RESOURCE, etc.) as it may impact internal Oracle processes, the most appropriate is that clone these roles with another name and enable this protection.

## 2. Features ##

* If you always connect from the same application and machine, you can ask the tool to trust it for 7 days. So you won't need to type the token again if  you connect on the database from the exactly same place.
* User can reconfigure the 2-Factor if changing phone or app.
* Protection against tokens brute-force attacks.
* The token seed is stored encrypted inside the database. User can provide a password for the encryption seed to make it irreversible by anyone (not even me).

## 3. Instructions ##

1. Download an Authenticator app for your mobile. I recommend "Google Authenticator", as it is free, simple and stable:
  * Android: https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2
  * iOS: https://itunes.apple.com/br/app/google-authenticator/id388497605
  * Windows Phone: https://www.microsoft.com/en-us/store/p/authenticator/9wzdncrfj3rj
  * There are also tons of other Third-Party apps that are based on the same TOTP algorithm.

2. Install OraTOtP tool in your database.

3. CREATE or ALTER any existing ROLE to be only enabled after 2-Step Authentication is complete.

**P.S.: Ensure your system clock is synchronized with UTC and in the correct timezone.**

## 4. Versions ##

* v1.00 - Initial Release
* v1.01 - Defined a separated Secret Encryption Function
* v1.02 - Corrected transmission delay as per RFC6238.

## 5. Other Information ##

Check http://www.dbarj.com.br/en/oratotp-oracle-time-based-one-time-password for installation instructions, usage examples and objects documentation.
