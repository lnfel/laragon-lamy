# Laragon Lamy
Automated setup for Laragon portable

## Defaults
- PHP 8.0.9
- Apache 2.4.48
- PHPMyAdmin 5.1.1
- MySQL 8.0.26
- Sublime 4 Portable build 4113
- Cmder mini 1.3.18
- Git Portable

## Steps
1. Download laragon portable, run and extract to `C:\laragon`
2. Copy and paste this whole text to `C:\laragon\usr\packages.conf` overriding it
3. Download all using laragon menu, **Right click > Tools > Quick Add > All**
4. Download git portable and extract to `C:\laragon\bin\git`
    - Don't forget to set up `git config --global user.name` and `git config --global user.email`
    - `git config --global init.defaultBranch main`
    - `git branch -m master main`
5. Add sublime path to Environment PATH variable
6. Select corresponding versions for PHP, Apache, MySQL

### Setup Apache
1. Using laragon menu, **Right click > Apache > SSL > Enabled** and **Add laragon.crt to Trust Store**
2. Open `C:/laragon/bin/apache/httpd-2.4.48-o111k-x64-vs16/conf/httpd.conf`
    - Change `Define SRVROOT "/Apache24"`
    - To `Define SRVROOT "C:/laragon/bin/apache/httpd-2.4.48-o111k-x64-vs16"`
3. Open `C:/laragon/etc/apache2/httpd.ssl.conf`
    - Comment out `Listen 443`

### Set up MySQL
1. Delete laragon/data/mysql-8
2. cd to laragon/bin/mysql8.0.0.x/bin folder via cmder
3. run `mysqld --initialize-insecure --console`

to test run `mysql -u root -p` and when it asks for password just hit enter since we already removed the password on step 3.

No need to do following steps steps since `--initialize-insecure` initializes mysql user without a password
3. ~~run `mysqld --initialize --console` (remember the password, important for step 6.)~~
4. ~~run `start mysqld`~~
5. ~~run `mysql -u root -p`~~
6. ~~put in the password from 6.~~
7. ~~You are now in mysql shell and can remove the password again: `ALTER USER 'root'@'localhost' IDENTIFIED BY '';`~~
8. ~~run `exit` and ctrl + c the spawned tab from step 4.~~

### Install Composer
1. cd `C:\laragon\bin\composer`
2. `php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"`
3. `php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"`
4. php composer-setup.php

### Install Laravel globally
1. `composer global require laravel/installer`

### Override laragon config [fixes ssl issue]
1. Open C:\laragon\bin\laragon\tpl\openssql.conf
2. Open C:\laragon\usr\tpl\openssql.conf.tpl
3. Open C:\laragon\etc\ssl\openssql.conf
4. Change keyUsage = keyEncipherment, dataEncipherment
5. To keyUsage = nonRepudiation, digitalSignature, keyEncipherment
6. Reload Apache - Laragon will generate new SAN certificate
7. Click Menu > Apache > SSL > Add laragon.crt to Trust Store

webpack toast encountered an error Please make sure that the app id is set correctly.
https://stackoverflow.com/questions/64949275/npm-run-dev-not-compiling-assets-with-error-notifications-for-user-are-disabled
windows settings -> Notifications and Actions (on Windows 10)