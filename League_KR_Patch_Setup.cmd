:BEGIN
@echo off
@Title 
@chcp 949
@SETLOCAL ENABLEDELAYEDEXPANSION
cls

:UAC
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto gotAdmin 
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
cls

:Settings
set drivec==00
set drived==00
set drivee==00

IF EXIST "C:\Riot Games\League of Legends\LeagueClient.exe" (set drivec==01
) ELSE IF EXIST "D:\Riot Games\League of Legends\LeagueClient.exe" (set drived==01
) ELSE IF EXIST "E:\Riot Games\League of Legends\LeagueClient.exe" (set drivee==01
)
echo Looking for League of Legends.... && timeout /t 3 > NUL

:check
IF %drivec% EQU 01 (call :c) else (echo.)
IF %drived% EQU 01 (call :d) else (echo.)
IF %drivee% EQU 01 (call :e) else (echo.)


:none
echo Can't Find the Root Directory of League of Legends.
echo Please Check if League of Legends is downloaded on C, D, or E Drive.
timeout /t 5 > NUL && exit

:c
rem starting :c
echo.
echo Found! Patching.....
powershell set-ExecutionPolicy -Force RemoteSigned
powershell .\c_krpatch.ps1
"C:\Riot Games\League of Legends\LeagueClient.exe" --locale=ko_KR
set drivec==00
call :exit

:d
rem starting :d
echo.
echo Found! Patching.....
powershell set-ExecutionPolicy -Force RemoteSigned
powershell .\d_krpatch.ps1
"D:\Riot Games\League of Legends\LeagueClient.exe" --locale=ko_KR
set drived==00
call :exit

:e
rem starting :e
echo.
echo Found! Patching.....
powershell set-ExecutionPolicy -Force RemoteSigned
powershell .\e_krpatch.ps1
"E:\Riot Games\League of Legends\LeagueClient.exe" --locale=ko_KR
set drivee==00
call :exit

:exit
ENDLOCAL
exit