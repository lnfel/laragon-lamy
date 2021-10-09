@echo off
::call laravel_install
:: %USERPROFILE%\AppData\Local\Microsoft\WindowsApps
echo "%~dp0"
echo @php "%%~dp0composer.phar" %*

echo %%print_debug%% init.bat "Env Var - HOME=%%HOME%%"

echo "Next is do the following and we are done!"
echo "Reload Apache - Laragon will generate new SAN certificate"
echo "Click Menu > Apache > SSL > Add laragon.crt to Trust Store"
echo "Configure init.bat"
echo "Copy text from cmder.txt and paste it C:\laragon\bin\cmder\vendor\init.bat after the lines:"
echo %%print_debug%% init.bat "Env Var - HOME=%%HOME%%"
copy /Y %~dp0init.bat "C:\laragon\bin\cmder\vendor\init.bat"
rename C:\laragon\bin\cmder.bak cmder.baks
pause