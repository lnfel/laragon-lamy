@echo off

setlocal enableDelayedExpansion
:: https://stackoverflow.com/questions/2048509/how-to-echo-with-different-colors-in-the-windows-command-line
:: https://stackoverflow.com/a/38617204
:: https://gist.githubusercontent.com/mlocati/fdabcaeb8071d5c75a2d51712db24011/raw/b710612d6320df7e146508094e84b92b34c77d48/win10colors.cmd

:: https://documentation.help/WinRAR/HELPCommandLineSyntax.htm
:: https://documentation.help/WinRAR/HELPSwitches.htm

:: https://npp-user-manual.org/docs/command-prompt/
cls
REM echo [101;93m STYLES [0m
REM echo ^<ESC^>[0m [0mReset [0m
REM echo ^<ESC^>[1m [1mBold [0m
REM echo ^<ESC^>[4m [4mUnderline [0m
REM echo ^<ESC^>[7m [7mInverse [0m
REM echo.
REM echo [101;93m NORMAL FOREGROUND COLORS [0m
REM echo ^<ESC^>[30m [30mBlack [0m (black)
REM echo ^<ESC^>[31m [31mRed [0m
REM echo ^<ESC^>[32m [32mGreen [0m
REM echo ^<ESC^>[33m [33mYellow [0m
REM echo ^<ESC^>[34m [34mBlue [0m
REM echo ^<ESC^>[35m [35mMagenta [0m
REM echo ^<ESC^>[36m [36mCyan [0m
REM echo ^<ESC^>[37m [37mWhite [0m
REM echo.
REM echo [101;93m NORMAL BACKGROUND COLORS [0m
REM echo ^<ESC^>[40m [40mBlack [0m
REM echo ^<ESC^>[41m [41mRed [0m
REM echo ^<ESC^>[42m [42mGreen [0m
REM echo ^<ESC^>[43m [43mYellow [0m
REM echo ^<ESC^>[44m [44mBlue [0m
REM echo ^<ESC^>[45m [45mMagenta [0m
REM echo ^<ESC^>[46m [46mCyan [0m
REM echo ^<ESC^>[47m [47mWhite [0m (white)
REM echo.
REM echo [101;93m STRONG FOREGROUND COLORS [0m
REM echo ^<ESC^>[90m [90mWhite [0m
REM echo ^<ESC^>[91m [91mRed [0m
REM echo ^<ESC^>[92m [92mGreen [0m
REM echo ^<ESC^>[93m [93mYellow [0m
REM echo ^<ESC^>[94m [94mBlue [0m
REM echo ^<ESC^>[95m [95mMagenta [0m
REM echo ^<ESC^>[96m [96mCyan [0m
REM echo ^<ESC^>[97m [97mWhite [0m
REM echo.
REM echo [101;93m STRONG BACKGROUND COLORS [0m
REM echo ^<ESC^>[100m [100mBlack [0m
REM echo ^<ESC^>[101m [101mRed [0m
REM echo ^<ESC^>[102m [102mGreen [0m
REM echo ^<ESC^>[103m [103mYellow [0m
REM echo ^<ESC^>[104m [104mBlue [0m
REM echo ^<ESC^>[105m [105mMagenta [0m
REM echo ^<ESC^>[106m [106mCyan [0m
REM echo ^<ESC^>[107m [107mWhite [0m
REM echo.
REM echo [101;93m COMBINATIONS [0m
REM echo ^<ESC^>[31m                     [31mred foreground color [0m
REM echo ^<ESC^>[7m                       [7minverse foreground ^<-^> background [0m
REM echo ^<ESC^>[7;31m                   [7;31minverse red foreground color [0m
REM echo ^<ESC^>[7m and nested ^<ESC^>[31m [7mbefore [31mnested [0m
REM echo ^<ESC^>[31m and nested ^<ESC^>[7m [31mbefore [7mnested [0m

setlocal
:: Initialize local environment variables

:: General
Set downloads_path=C:\Users\Administrator\Downloads\

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

:: Config files
Set packages_conf=%dir[1]%usr\packages.conf

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

:: Laragon packages conf
echo [33mConfiguring[0m laragon packages
break>%packages_conf%
(
	echo # PHP
	echo php-8.0.9=https://windows.php.net/downloads/releases/archives/php-8.0.9-Win32-vs16-x64.zip
	echo # Apache
	echo apache-2.4.48=https://www.apachehaus.com/downloads/httpd-2.4.48-o111k-x64-vs16.zip
	echo # phpMyAdmin
	echo phpmyadmin-5.1.1=https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-english.zip
	echo # MySQL
	echo mysql-8.0.26=https://cdn.mysql.com//Downloads/MySQL-8.0/mysql-8.0.26-winx64.zip
	echo # Node.js
	echo nodejs-14.17.5=https://nodejs.org/dist/v14.17.5/node-v14.17.5-win-x64.zip
	echo # Sublime
	echo sublime-4113=https://download.sublimetext.com/sublime_text_build_4113_x64.zip
	echo # Cmder
	echo cmder_mini-1.3.18=https://github.com/cmderdev/cmder/releases/download/v1.3.18/cmder_mini.zip
) > %packages_conf%
echo [32mConfigured[0m laragon packages

:: https://stackoverflow.com/questions/46712814/get-current-users-path-variable-without-system-path-using-cmd::@For /F "Skip=2Tokens=1-2*" %%A In ('Reg Query HKCU\Environment /V PATH 2^>Nul') Do @Echo %%A=%%C
@For /F "Skip=2Tokens=1-2*" %%A In ('Reg Query HKCU\Environment /V PATH 2^>Nul') Do Set user_path=%%C
::echo %user_path%
::SETX Path %user_path%C:\laragon\bin\sublime;
::path C:\laragon\bin\sublime;%PATH%

pause