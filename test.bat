@echo off
::call laravel_install
:: %USERPROFILE%\AppData\Local\Microsoft\WindowsApps
echo "%~dp0"
echo @php "%%~dp0composer.phar" %*
pause