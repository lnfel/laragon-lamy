@echo off

setlocal enableDelayedExpansion
setlocal

:: Override laragon settings

:: httpd.conf
Set item[0]=httpd.conf
Set file[0]=C:\laragon\bin\apache\httpd-2.4.48-o111k-x64-vs16\conf\httpd.conf
Set toFind[0]=/Apache24
Set toSet[0]=C:/laragon/bin/apache/httpd-2.4.48-o111k-x64-vs16

:: httpd.ssl.conf
Set item[1]=httpd.ssl.conf
Set file[1]=C:/laragon/etc/apache2/httpd-ssl.conf
Set toFind[1]=Listen 443
Set toSet[1]=#Listen 443

::  laragon/bin/mysql8.0.0.x/bin

:: 0,1,0 == start,step,end
for /L %%i in (0,1,1) do (
	echo [36mOverriding[0m !item[%%i]!
	powershell -c "(Get-Content -Path '!file[%%i]!') | ForEach-Object { $_ -Replace '!toFind[%%i]!', '!toSet[%%i]!' } | Set-Content -Path '!file[%%i]!'"
	echo [32mDone[0m !item[%%i]!
)

:: delete folder and files
Rmdir /s /q C:\laragon\bin\mysql\mysql-8.0.26-winx64\data
:: init
C:\laragon\bin\mysql\mysql-8.0.26-winx64\bin\mysqld.exe --initialize --console
:: powershell -c "(Get-Content -Path C:\laragon\bin\apache\httpd-2.4.48-o111k-x64-vs16\conf\httpd.conf) | ForEach-Object { $_ -Replace '/Apache24', 'C:/laragon/bin/apache/httpd-2.4.48-o111k-x64-vs16' } | Set-Content -Path C:\laragon\bin\apache\httpd-2.4.48-o111k-x64-vs16\conf\httpd.conf"
:: th=OrWDtK2w&
pause