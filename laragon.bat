@echo off

setlocal enableDelayedExpansion
cls
setlocal
:: Initialize local environment variables

:: General
Set downloads_path=%USERPROFILE%\Downloads\
Set /p downloads_path="Downloads directory [default %USERPROFILE%\Downloads\]: "
call :checkDownloadsPath
pause

:checkDownloadsPath
if not exist %downloads_path% (
	echo %downloads_path% folder cannot be found.
	exit /b 1
)

:: Winrar
Set item[0]=winrar
Set link[0]=https://www.rarlab.com/rar/winrar-x64-602.exe
Set filename[0]=winrar-x64-602.exe
Set dir[0]=%ProgramFiles%\WinRAR\
Set bin[0]=
Set extract[0]="%downloads_path%winrar-x64-602.exe" /S
Set app[0]=WinRAR.exe
Set method[0]=Installing

:: Laragon
Set item[1]=laragon-portable
Set link[1]=https://github.com/leokhoa/laragon/releases/download/5.0.0/laragon-portable.zip
Set filename[1]=laragon-portable.zip
Set dir[1]=C:\laragon\
Set bin[1]=
Set extract[1]="%dir[0]%%app[0]%" x -ibck %downloads_path%%filename[1]% *.* %dir[1]%
Set app[1]=laragon.exe
Set method[1]=Extracting

:: Git
Set item[2]=git-portable
Set link[2]=https://github.com/git-for-windows/git/releases/download/v2.33.0.windows.2/PortableGit-2.33.0.2-64-bit.7z.exe
Set filename[2]=PortableGit-2.33.0.2-64-bit.7z.exe
Set dir[2]=C:\laragon\bin\git\
Set bin[2]=bin\
Set extract[2]="%downloads_path%%filename[2]%" -y -o C:\laragon\bin\git
Set app[2]=git.exe
Set method[2]=Extracting

:: Sublime
::Set item[3]=sublime-portable
::Set link[3]=https://download.sublimetext.com/sublime_text_build_4113_x64.zip
::Set filename[3]=sublime_text_build_4113_x64.zip
::Set dir[3]=C:\laragon\bin\sublime\
::Set bin[3]=
::Set extract[3]="%dir[0]%%app[0]%" x -ibck %downloads_path%%filename[3]% *.* %dir[3]%
::Set app[3]=subl.exe
::Set method[3]=Extracting

:: Laragon packages conf
Set packages_conf=%dir[1]%usr\packages.conf
Set packages_conf_default=%~dp0packages.conf
Set /p packages_conf_default="Path to packages.conf [default %~dp0packages.conf]: "
call :checkPackagesConf
pause

:checkPackagesConf
if not exist %packages_conf_default% (
	echo %packages_conf_default% does not exist.
	exit /b 1
)

echo [33mConfiguring[0m laragon packages
copy /Y %packages_conf_default% "%packages_conf%"
echo [32mConfigured[0m laragon packages

:: Begin Setup
:: https://ss64.com/nt/for_l.html
for /L %%i in (0,1,2) do (
	echo [36mChecking[0m !item[%%i]!
	echo Checking !dir[%%i]!!bin[%%i]!!app[%%i]!
	if exist !dir[%%i]!!bin[%%i]!!app[%%i]! (
		echo [32mFound[0m !item[%%i]!
	) else (
		echo [33mDownloading[0m !item[%%i]!
		powershell -c "Invoke-WebRequest -Uri '!link[%%i]!' -OutFile '%downloads_path%!filename[%%i]!'"
		echo [32mDownloaded[0m !item[%%i]!

		echo [33m!method[%%i]![0m !item[%%i]!
		echo Runnning command: !extract[%%i]!
		!extract[%%i]!
		echo [32mInstalled[0m !item[%%i]!
	)
)

:: Git config
echo [33mConfiguring[0m git-portable
!dir[2]!!bin[2]!!app[2]! config --global user.name "Dale Ryan Aldover"
%dir[2]%%bin[2]%%app[2]% config --global user.email "bk2o1.syndicates@gmail.com"
echo [32mGit user[0m & %dir[2]%%bin[2]%%app[2]% config --global user.name
echo [32mGit email[0m & %dir[2]%%bin[2]%%app[2]% config --global user.email

:: delete unecessary packages

:: NGINX
Set toRemove[0]=nginx
Set remove[0]=C:\laragon\bin\nginx\

:: Composer
Set toRemove[1]=composer
Set remove[1]=C:\laragon\bin\composer\

for /L %%i in (0,1,1) do (
	echo [36mChecking[0m !toRemove[%%i]!
	if exist C:\laragon\bin\nginx\ (
		echo [91mDeleting[0m !toRemove[%%i]!
		Rmdir /s /q !remove[%%i]!
		echo [32mRemoved[0m !toRemove[%%i]!
	) else (
		echo [36mNot Found[0m !toRemove[%%i]!
	)
)

:: https://stackoverflow.com/questions/46712814/get-current-users-path-variable-without-system-path-using-cmd
::@For /F "Skip=2Tokens=1-2*" %%A In ('Reg Query HKCU\Environment /V PATH 2^>Nul') Do @Echo %%A=%%C
::@For /F "Skip=2Tokens=1-2*" %%A In ('Reg Query HKCU\Environment /V PATH 2^>Nul') Do Set user_path=%%C
::echo %user_path%

::echo %PATH% | find /C /I "C:\laragon\bin\sublime" > nul || SETX Path %user_path%C:\laragon\bin\sublime;

:: Directory array
Set directory[0]=C:\laragon\bin\sublime
Set directory[1]=C:\laragon\bin\php\php-8.0.9-Win32-vs16-x64
Set directory[2]=C:\laragon\bin\composer
Set directory[3]=C:\Users\Administrator\AppData\Roaming\Composer\vendor\bin
Set directory[4]=C:\laragon\bin\git\bin

for /L %%i in (0,1,4) do (
	echo [36mChecking[0m !directory[%%i]!
	for /F "Skip=2Tokens=1-2*" %%A in ('Reg Query HKCU\Environment /V PATH 2^>Nul') do (
		Set user_path=%%C
		echo !user_path!
		echo !PATH! | find /C /I "!directory[%%i]!" > nul || SETX Path !user_path!!directory[%%i]!;
	)
)

::path C:\laragon\bin\sublime;%PATH%

:: Remove last character from string
::set test=C:\laragon\bin\sublime\
::echo %test:~0,-1%

:: https://newbedev.com/replace-character-of-string-in-batch-script
:: https://stackoverflow.com/questions/60034/how-can-you-find-and-replace-text-in-a-file-using-the-windows-command-line-envir

pause