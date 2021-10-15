@echo off
::call laravel_install
:: %USERPROFILE%\AppData\Local\Microsoft\WindowsApps
::echo "%~dp0"
::echo @php "%%~dp0composer.phar" %*

::echo %%print_debug%% init.bat "Env Var - HOME=%%HOME%%"

::echo "Next is do the following and we are done!"
::echo "Reload Apache - Laragon will generate new SAN certificate"
::echo "Click Menu > Apache > SSL > Add laragon.crt to Trust Store"
::echo "Configure init.bat"
::echo "Copy text from cmder.txt and paste it C:\laragon\bin\cmder\vendor\init.bat after the lines:"
::echo %%print_debug%% init.bat "Env Var - HOME=%%HOME%%"
::copy /Y %~dp0init.bat "C:\laragon\bin\cmder\vendor\init.bat"
::rename C:\laragon\bin\cmder.bak cmder.baks

:: https://stackoverflow.com/questions/31574365/best-practice-for-exiting-batch-file
::Set downloads_path=%USERPROFILE%\Downloads\
::Set /p downloads_path="Downloads directory [default %USERPROFILE%\Downloads\]: "

::call :checkDownloadsPath
::pause

:checkDownloadsPath
::if not exist %downloads_path% (
::	echo %downloads_path% folder cannot be found.
::	exit /b 1
::)

::echo We are in

:: Packages conf
::echo %~dp0

::Set dir[1]=C:\laragon\
::Set packages_conf=%dir[1]%usr\packages.conf
::Set packages_conf_default=%~dp0packages.conf
::Set /p packages_conf_default="Path to packages.conf [default %~dp0packages.conf]: "
::call :checkPackagesConf
::pause

:checkPackagesConf
::if not exist %packages_conf_default% (
::	echo %packages_conf_default% does not exist.
::	exit /b 1
::)

::echo We are in
::copy /Y %packages_conf_default% "%packages_conf%"

::echo [33mConfiguring[0m laragon packages
::break>%packages_conf%
::(
::	echo # PHP
::	echo php-8.0.9=https://windows.php.net/downloads/releases/archives/php-8.0.9-Win32-vs16-x64.zip
::	echo # Apache
::	echo apache-2.4.48=https://www.apachehaus.com/downloads/httpd-2.4.48-o111k-x64-vs16.zip
::	echo # phpMyAdmin
::	echo phpmyadmin-5.1.1=https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-english.zip
::	echo # MySQL
::	echo mysql-8.0.26=https://cdn.mysql.com//Downloads/MySQL-8.0/mysql-8.0.26-winx64.zip
::	echo # Node.js
::	echo nodejs-14.17.5=https://nodejs.org/dist/v14.17.5/node-v14.17.5-win-x64.zip
::	echo # Sublime
::	echo sublime-4113=https://download.sublimetext.com/sublime_text_build_4113_x64.zip
::	echo # Cmder
::	echo cmder_mini-1.3.18=https://github.com/cmderdev/cmder/releases/download/v1.3.18/cmder_mini.zip
::) > %packages_conf%
::echo [32mConfigured[0m laragon packages

:: NGINX
Set toRemove[0]=nginx
Set remove[0]=C:\laragon\bin\nginx\

:: Composer
Set toRemove[1]=composer
Set remove[1]=C:\laragon\bin\composer\

:: Prompt to delete nginx
Set remove_nginx=Y
Set /p remove_nginx="Remove NGINX (Y/N)? [default Y]: "

if /i %remove_nginx% EQU N (
	call :keepNginx
) else (
	call :deleteDefault
)

if /i %remove_nginx% EQU NO (
	call :keepNginx
) else (
	call :deleteDefault
)
pause

:: User opted to not delete nginx
:keepNginx
Set remove[0]=Nginx safe

echo %remove[0]%

:deleteDefault
echo Running delete operation