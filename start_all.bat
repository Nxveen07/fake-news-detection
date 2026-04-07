@echo off
echo =================================================================
echo  TruthTrace AI - Full Stack Launcher
echo =================================================================

:: Start backend in a new terminal window
echo [1/2] Starting Backend (http://127.0.0.1:8001)...
start "TruthTrace Backend" cmd /k "cd /d ""%~dp0backend"" && call start_backend.bat"

:: Wait a moment before starting frontend
timeout /t 1 /nobreak >nul

:: Start frontend static server in a new terminal window
echo [2/2] Starting Frontend (http://127.0.0.1:5500)...
start "TruthTrace Frontend" cmd /k "cd /d ""%~dp0prt"" && python -m http.server 5500"

:: Wait then open browser
timeout /t 1 /nobreak >nul
echo [INFO] Opening browser at http://127.0.0.1:5500
start http://127.0.0.1:5500

echo.
echo =================================================================
echo  Local Backend  : http://127.0.0.1:8001
echo  Local Frontend : http://127.0.0.1:5500
echo  API Docs       : http://127.0.0.1:8001/docs
echo =================================================================
echo  Fetching local network IP to access from your phone/other devices...
for /f "delims=" %%I in ('powershell -NoProfile -Command "(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -like '*Wi-Fi*' -or $_.InterfaceAlias -like '*Wireless*' -or $_.InterfaceAlias -like '*Ethernet*' } | Select-Object -First 1).IPAddress"') do set "NETWORK_IP=%%I"
if defined NETWORK_IP (
    echo  Network Frontend : http://%NETWORK_IP%:5500  ^<^-- OPEN THIS ON PHONE
    echo  Network Backend  : http://%NETWORK_IP%:8001
) else (
    echo  Network details unavailable. You may not be connected to Wi-Fi.
)
echo =================================================================
echo  Both servers are running in separate windows.
echo  Close those windows to stop the servers.
echo =================================================================
pause
