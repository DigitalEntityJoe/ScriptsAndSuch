@ECHO OFF
echo.
echo.
echo I'm going to make logs to help troubleshoot...
echo please watch this curser blink...If you look away, I will know...
echo.

mkdir C:\%computername%-DCtest

FOR /F "tokens=2 delims=:" %%a IN ('ipconfig ^| findstr /IC:"IPv4 Address"') DO echo%%a >c:

\%computername%-DCtest\ip.txt

set /p myip=<c:\%computername%-DCtest\ip.txt

dcdiag /v /c /d /e /s:%computername% >c:\%computername%-DCtest\dcdiag.txt

repadmin /showrepl %computername% /verbose /all /intersite >c:\%computername%-DCtest

\repl.txt

netdom query FSMO >c:\%computername%-DCtest\FSMOrole.txt

repadmin /replsummary >c:\%computername%-DCtest\ReplicationSummary.txt

ipconfig /all >c:\%computername%-DCtest\ipconfig.txt

echo Done!
echo.
echo I have created the logs needed to troublesahoot, hit any key to open them.
echo I have stored them in c:\%computername%-DCtest\
pause
START c:\%computername%-DCtest\
echo.
echo You dont need me anymore, right? 
pause
