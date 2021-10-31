# Laragon Lamy
Automated setup for Laragon portable **without dependencies**.

## How to use
1. Download or clone this repo
2. Run `laragon.bat`
3. Open the installed laragon.exe in C:\laragon
4. Install the preconfigured packages via laragon menu, **Right click > Tools > Quick Add > All**
5. Run `settings.bat` for final setup
6. Finally using laragon menu, **Click Menu > Apache > SSL > Add laragon.crt to Trust Store**

## TO DO
Everything is hard coded at the moment, and assumes the user is gonna use the default setup.

- [x] Allow user to specify where to dump winrar, laragon portable and git portable, currently using C:\Users\Administrator\Downloads
- [x] Allow user to specify a custom packages conf file to use, currently uses the hard coded packages_conf block
- [x] Allow user to opt in using nginx instead of deleting it by default
- [x] (When user uses custom packages.conf sublime won't be installed) Allow user to opt in for other text editor instead of assuming they would use sublime text
- [x] Ask if user would like to use cmder_mini
- [ ] Test setting up Rails on Laragon (this was difficult than expected, no wonder laragon had a separate repo for rails setup)
- [x] Prompt user to setup git username and email

## Defaults
- PHP 8.0.9
- Apache 2.4.48
- PHPMyAdmin 5.1.1
- MySQL 8.0.26
- Sublime 4 Portable build 4113
- Cmder mini 1.3.18
- Git Portable

## Manual Steps for reference

### Initial laragon setup
1. Download laragon portable, run and extract to `C:\laragon`
2. Update `C:\laragon\usr\packages.conf` and include the packages needed to install by laragon
3. Download all using laragon menu, **Right click > Tools > Quick Add > All**
4. Download git portable and extract to `C:\laragon\bin\git`
    - Don't forget to set up `git config --global user.name` and `git config --global user.email`
    - `git config --global init.defaultBranch main`
    - `git branch -m master main`
5. Add sublime path to Environment PATH variable
6. Select corresponding versions for PHP, Apache, MySQL

### Setup Apache
1. This step is now moved as the final override step ~~Using laragon menu, **Right click > Apache > SSL > Enabled** and **Add laragon.crt to Trust Store**~~
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
7. **Click Menu > Apache > SSL > Add laragon.crt to Trust Store**

### Replace laragon cmder with updated cmder mini
Since cmder mini is installed already via laragon package that we had customized we can just rename it.
1. Rename `C:\laragon\bin\cmder` to **cmder.bak**
2. Rename `C:\laragon\bin\cmdermini` to **cmder**
3. Copy the following from `C:\laragon\bin\cmder.bak\vendor\init.bat`

```sh
:: Laragon Start -------------------------------------------------------------------


if exist "%CMDER_ROOT%\..\git" (
    set "GIT_INSTALL_ROOT=%CMDER_ROOT%\..\git"
)

if exist "%GIT_INSTALL_ROOT%\post-install.bat" (
    echo Running Git for Windows one time Post Install....
    pushd "%GIT_INSTALL_ROOT%"
    call "%GIT_INSTALL_ROOT%\git-bash.exe" --no-needs-console --hide --no-cd --command=post-install.bat
    @DEL post-install.bat

    popd
    :: cd /d %USERPROFILE%
    rem
)

for /f "delims=" %%i in ("%CMDER_ROOT%\..\..\usr") do set USER_DIR=%%~fi
set USR_DIR=%USER_DIR%



if exist "%CMDER_ROOT%\..\laragon\laragon.cmd" (
    :: call Laragon own commands
    call "%CMDER_ROOT%\..\laragon\laragon.cmd"
)

if exist "%USER_DIR%\user.cmd" (
    rem create this file and place your own command in there
    call "%USER_DIR%\user.cmd"
) else (
    echo Creating user startup file: "%USER_DIR%\user.cmd"
    (
    echo :: use this file to run your own startup commands
    echo :: use  in front of the command to prevent printing the command
    echo.
    echo :: call %%GIT_INSTALL_ROOT%%/cmd/start-ssh-agent.cmd
    echo :: set PATH=%%USER_DIR%%\bin\whatever;%%PATH%%
    echo.
    echo :: cmd /c start http://localhost 
    echo.
    ) > "%USER_DIR%\user.cmd"
    
    :: cd /d "%CMDER_ROOT%\..\..\www"
    rem
)

:: Laragon End -------------------------------------------------------------------
```

4. Then insert it into `C:\laragon\bin\cmder\vendor\init.bat` after the following lines:

```sh
:: some code at the top...

:: Set home path
if not defined HOME set "HOME=%USERPROFILE%"
%print_debug% init.bat "Env Var - HOME=%HOME%"

:: paste it here
```
5. This should make laragon detect the updated cmder mini we just installed, to test open `laragon.exe` and click on Terminal button.

## Known errors
- Error: webpack toast encountered an error Please make sure that the app id is set correctly.
- Solution: windows settings -> Notifications and Actions (on Windows 10)
- Source: https://stackoverflow.com/questions/64949275/npm-run-dev-not-compiling-assets-with-error-notifications-for-user-are-disabled