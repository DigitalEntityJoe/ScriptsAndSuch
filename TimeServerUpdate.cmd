@echo off
::-----------------------------::
:: First, we need admin rights ::
::-----------------------------::

CLS
echo We need Admin Rights, I'll Check that for you...

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
echo.
echo Nope, Not an Admin, I'll Fix that...
echo.
echo Click on Yes/OK if the UAC box pops up... thanks 

setlocal DisableDelayedExpansion
set "batchPath=%~0"
setlocal EnableDelayedExpansion
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs"
ECHO args = "ELEV " >> "%temp%\OEgetPrivileges.vbs"
ECHO For Each strArg in WScript.Arguments >> "%temp%\OEgetPrivileges.vbs"
ECHO args = args ^& strArg ^& " "  >> "%temp%\OEgetPrivileges.vbs"
ECHO Next >> "%temp%\OEgetPrivileges.vbs"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs"
"%SystemRoot%\System32\WScript.exe" "%temp%\OEgetPrivileges.vbs" %*
exit /B

:gotPrivileges
echo.
echo Yay, we have Admin rights, moving along... 
if '%1'=='ELEV' shift /1
setlocal & pushd .
cd /d %~dp0

::ECHO Arguments: %1 %2 %3 %4 %5 %6 %7 %8 %9

::----------------------------------------------------------------------::
:: Now that thats taken care of we can kill that annoying beeping sound ::
::----------------------------------------------------------------------::

::we dont like beeps
@echo off
@sc config beep start= disabled /f > nul
:: or outputs on service controls (/f > nul)



::----------------------::
:: Ok, now we can Start ::
::----------------------::
:STARTINGNTP
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

:: this prints the ASCII art
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A


:: gotta be hacker green
color 0A

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
SETLOCAL
echo This will change your time service to pool.ntp.org servers.
:CHANGETIMEYN
echo.
set /P CHANGETIME=Do you want to change your time server? [Y/N]:
if /I "%CHANGETIME%" EQU "Y" goto CHANGETIMEY
if /I "%CHANGETIME%" EQU "N" goto CHANGETIMEN
goto CHANGETIMEYN

:CHANGETIMEN
goto BYEBYE

:CHANGETIMEY
echo.
echo Stopping the time services
net stop w32time
echo.
echo Setting the NTP Server to pool.ntp.org
w32tm /config /syncfromflags:manual /manualpeerlist:"0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org"
echo.
echo done, now we turn back on the services and check...
net start w32time
echo.
echo Updating....
w32tm /config /update
echo.
echo Resyncing the time using the new servers....
w32tm /resync
goto LOOKGOODYN

:LOOKGOODYN
echo.
echo %DATE%_%TIME%
echo.
set /P LOOKGOOD=Does this look good? [Y/N]:
if /I "%LOOKGOOD%" EQU "Y" goto BYEBYE
if /I "%LOOKGOOD%" EQU "N" goto CHECKSETTINGSYN
goto LOOKGOODYN

:CHECKSETTINGSYN
echo.
echo wait about 20 seconds then proceed...
pause
echo.
set /P CHECKSETTINGS=Do you want to check your settings now? [Y/N]:
if /I "%CHECKSETTINGS%" EQU "Y" goto CHECKSETTINGSY
if /I "%CHECKSETTINGS%" EQU "N" goto BYEBYE
goto CHECKSETTINGSYN

:CHECKSETTINGSY
echo.
w32tm /query /status
goto LOOKBETTERYN

:LOOKBETTERYN
echo.
set /P LOOKBETTER=Does the "source" (second from bottom) say x.pool.ntp.org? [Y/N]:
if /I "%LOOKBETTER%" EQU "Y" goto BYEBYE
if /I "%LOOKBETTER%" EQU "N" goto ISVMYN
goto LOOKBETTERYN

:ISVMYN
echo.
set /P ISVM=Does it say "VM IC ..."? [Y/N]:
if /I "%ISVM%" EQU "Y" goto ISVMY
if /I "%ISVM%" EQU "N" goto ISVMN
goto ISVMYN

:ISVMY
echo.
echo You have a VM in front of you. You should find the Host and run this.
goto BYEBYE 

:ISVMN
echo.
echo So we will try this again...
goto STARTINGNTP

:BYEBYE
echo.
echo Ok, we are all done here,
echo thanks.... Bye
pause
ENDLOCAL 
goto :EOF








::ASCI ART, You know you love it...

:::                  _   _ ___________   _____ _                
:::                 | \ | |_   _| ___ \ |_   _(_)               
:::                 |  \| | | | | |_/ /   | |  _ _ __ ___   ___ 
:::                 | . ` | | | |  __/    | | | | '_ ` _ \ / _ \
:::                 | |\  | | | | |       | | | | | | | | |  __/
:::                 \_| \_/ \_/ \_|       \_/ |_|_| |_| |_|\___|
                                            










::Peace, DigitalEntity
