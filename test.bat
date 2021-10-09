@echo off
::call laravel_install
:: %USERPROFILE%\AppData\Local\Microsoft\WindowsApps
echo "%~dp0"
echo @php "%%~dp0composer.phar" %*

echo %%print_debug%% init.bat "Env Var - HOME=%%HOME%%"
pause