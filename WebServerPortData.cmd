@ECHO OFF
ECHO Creating directory...

mkdir c:\WebServerData
echo.

ECHO Running Tests, this may take a few minutes.....
echo.

netstat >c:\WebServerData\AllConections.txt
ECHO one done...
netstat -r >c:\WebServerData\RoutingTable.txt
ECHO two done...
netstat -t >c:\WebServerData\ActiveConnections.txt
ECHO ALL done...
echo.

ECHO All results are in c:\WebServerData, please go there to find all data aquired.
echo.

ECHO OK, I'll do it for you.... 
echo.

START c:\WebServerData

ECHO Your Welcome, Goodbye....

pause
exit
