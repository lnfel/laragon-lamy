@echo off

setlocal enableDelayedExpansion
setlocal

:: Override laragon settings

:: httpd.conf
Set item[0]=httpd.conf
Set file[0]=C:\laragon\bin\apache\httpd-2.4.48-o111k-x64-vs16\conf\httpd.conf
Set toFind[0]='/Apache24'
Set toSet[0]='C:/laragon/bin/apache/httpd-2.4.48-o111k-x64-vs16'

for /L %%i in (0,1,2) do (
	echo [36mOverriding[0m !item[%%i]!
)
:: powershell -c "(Get-Content -Path C:\laragon\bin\apache\httpd-2.4.48-o111k-x64-vs16\conf\httpd.conf) | ForEach-Object { $_ -Replace '/Apache24', 'C:/laragon/bin/apache/httpd-2.4.48-o111k-x64-vs16' } | Set-Content -Path C:\laragon\bin\apache\httpd-2.4.48-o111k-x64-vs16\conf\httpd.conf"

pause