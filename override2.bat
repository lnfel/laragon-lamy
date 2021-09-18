@echo off

setlocal enableDelayedExpansion
setlocal

:: start server first
C:\laragon\bin\mysql\mysql-8.0.26-winx64\bin\mysql.exe -u root -p
:: enter password from override1.bat
:: enter ALTER USER 'root'@'localhost' IDENTIFIED BY ''; to remove password
:: enter exit to close mysql session
pause