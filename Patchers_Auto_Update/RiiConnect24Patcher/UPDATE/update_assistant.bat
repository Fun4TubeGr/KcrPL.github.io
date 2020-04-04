@echo off
:: ===========================================================================
:: Update Assistant for RiiConnect24
set version=1.0.1
:: AUTHORS: KcrPL
:: ***************************************************************************
:: Copyright (c) 2020 KcrPL, RiiConnect24 and it's (Lead) Developers
:: ===========================================================================
setlocal enableextensions
setlocal EnableDelayedExpansion

if exist temp.bat del /q temp.bat

set last_build=2020/02/05
set at=12:00
set header=Update Assistant - (C) KcrPL v%version% (Compiled on %last_build% at %at%)
::
set /a no_start=0
set FilesHostedOn=https://kcrPL.github.io/Patchers_Auto_Update/RiiConnect24Patcher
::

if "%1"=="-no_start" set /a no_start=1
if "%2"=="-no_start" set /a no_start=1

if "%1"=="-RC24_Patcher" goto start_download_rc24_patcher
if "%2"=="-RC24_Patcher" goto start_download_rc24_patcher
if "%1"=="-VFF_Downloader_Main_Exec" goto start_download_vff_downloader_main_exec
if "%1"=="-VFF_Downloader_Installer" goto start_download_vff_downloader_install

goto no_parameters

:no_parameters
echo.
echo :---------------------------------------------:
echo : RiiConnect24 Update Assistant for Windows.  :
echo : Usage: update_assistant.bat [options...]    :
echo :---------------------------------------------:
echo.
echo -RC24_Patcher                  Will download latest RiiConnect24 Patcher to current dir
echo -VFF_Downloader_Main_Exec      Will download executable for VFF Downloader for Dolphin
echo -VFF_Downloader_Installer      Will download installer for VFF Downloader for Dolphin
echo -no_start                      Won't start the patcher after the download is complete
GOTO:EOF
:start_download_vff_downloader_install
set mode=128,37
mode %mode%
cls
echo %header%
echo.
echo -----------------------------------------------------------------------------------------------------------------------------
echo Please wait! We are now downloading your new VFF Downloader for Dolphin update.
curl -s -S --insecure "https://kcrpl.github.io/Patchers_Auto_Update/VFF-Downloader-for-Dolphin/UPDATE/Install.bat" --output "InstallTEMP.bat"

set temperrorlev=%errorlevel%
if not %temperrorlev%==0 goto error_download

del /q Install.bat
ren "InstallTEMP.bat" "Install.bat"

if %no_start%==0 start "" Install.bat
del /q "%~n0.bat"
exit

:start_download_vff_downloader_main_exec
set mode=128,37
mode %mode%
cls
echo %header%
echo -----------------------------------------------------------------------------------------------------------------------------
echo.
echo Please wait! We are now downloading your new VFF Downloader for Dolphin update.
curl -s -S --insecure "https://kcrpl.github.io/Patchers_Auto_Update/VFF-Downloader-for-Dolphin/UPDATE/VFF-Downloader-for-Dolphin.exe" --output "VFF-Downloader-for-DolphinTEMP.exe"

set temperrorlev=%errorlevel%
if not %temperrorlev%==0 goto error_download

del /q VFF-Downloader-for-Dolphin.exe
ren "VFF-Downloader-for-DolphinTEMP.exe" "VFF-Downloader-for-Dolphin.exe"

if %no_start%==0 start VFF-Downloader-for-Dolphin.exe

del /q "%~n0.exe"
exit

:start_download_rc24_patcher
set mode=128,37
mode %mode%
cls
echo %header%
echo -----------------------------------------------------------------------------------------------------------------------------
echo.
echo Please wait! We are now downloading your new RiiConnect24 Patcher update.
curl -s -S --insecure "%FilesHostedOn%/UPDATE/RiiConnect24Patcher.bat" --output "RiiConnect24PatcherTEMP.bat"

set temperrorlev=%errorlevel%
if not %temperrorlev%==0 goto error_download

del RiiConnect24Patcher.bat
ren "RiiConnect24PatcherTEMP.bat" "RiiConnect24Patcher.bat"

if %no_start%==0 start RiiConnect24Patcher.bat
del /q "%~n0~x0"
exit

:error_download
cls
echo %header%
echo -----------------------------------------------------------------------------------------------------------------------------
echo.
echo Oops! There was an error while downloading the file(s).
echo.
echo Exit code: %temperrorlev%
echo.
echo Please contact KcrPL#4625 on Discord.
echo The update assistant will now return to loader or it will exit.
echo.
echo Press any button to continue.
pause>NUL
GOTO:EOF