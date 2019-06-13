# Autonomous Data Warehouse Wallet files

Navigate to your ADW instance on the Oracle Cloud Infrastructure Console. Next click `DB Connection` and download the Client Credentials (Wallet) and unzip the files in the wallet folder in this project.

Example files include cwallet.sso, sqlnet.ora, tnsnames.ora, etc...

I have created the Dockerfile in such a way that you don't need to change the sqlnet.ora file to point the Wallet location. It will point to the default ?/network/admin 

We set the Environment Variable. The following two lines will take care of that.

ENV TNS_ADMIN=/usr/lib/oracle/${release}.${update}/client64/lib/network/admin
ADD ./wallet /usr/lib/oracle/${release}.${update}/client64/lib/network/admin/

