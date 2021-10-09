@echo off

setlocal enableDelayedExpansion

::for /F "delims=" %%i in (C:\laragon\bin\cmdermini\vendor\init.bat) do (
    ::echo %%i
    ::Set addafter=%%i
    ::for /F "delims=" %%n in ('type C:\laragon\bin\cmdermini\vendor\init.bat') do (
        ::echo %%n
    ::)
::)

echo [33mConfiguring[0m laragon packages

Set file[0]=C:\laragon\bin\cmdermini\vendor\init.bat
Set toFind[0]=%%print_debug%% init.bat "Env Var - HOME=%%HOME%%"

for /F "delims=" %%n in ('type C:\laragon\bin\cmdermini\vendor\init.bat') do (
    Set toSet[0]=%%n
)

echo !toSet[0]!

::powershell -c "(Get-Content -Path '%file[0]%') | ForEach-Object { $_ -Replace '%toFind[0]%', '!toSet[%%i]!' } | Set-Content -Path '!file[%%i]!'"
::powershell -c "(Get-Content -Path '%file[0]%') | ForEach-Object { $_ -Replace '%toFind[0]%', '!toSet[%%i]!' } | Set-Content -Path '!file[%%i]!'"

pause