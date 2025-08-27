@echo off
REM WanderlustApi Publishing Helper Script (Batch Version)
REM Usage: publish.bat [profile] [configuration]
REM Example: publish.bat FolderProfile Release

setlocal enabledelayedexpansion

REM Default values
set "PROFILE=%1"
set "CONFIG=%2"
if "%CONFIG%"=="" set "CONFIG=Release"

REM Validate profile parameter
if "%PROFILE%"=="" (
    echo ❌ Error: Profile parameter is required
    echo.
    echo Available profiles:
    echo   - FolderProfile      : Publish to local folder
    echo   - Local-IIS         : Deploy to local IIS
    echo   - FTP-Production    : Deploy via FTP
    echo   - WebDeploy-Production : Deploy via Web Deploy
    echo   - Linux-Server      : Self-contained Linux deployment
    echo   - Linux-Server-FDD  : Framework-dependent Linux deployment
    echo   - Linux-Docker      : Docker containerized Linux deployment
    echo.
    echo Usage: publish.bat [profile] [configuration]
    echo Example: publish.bat FolderProfile Release
    goto :end
)

REM Check if dotnet is available
dotnet --version >nul 2>&1
if errorlevel 1 (
    echo ❌ .NET SDK not found. Please install .NET 8 SDK.
    goto :end
)

REM Check if project file exists
if not exist "WanderlustApi.csproj" (
    echo ❌ WanderlustApi.csproj not found in current directory.
    echo Current directory: %CD%
    goto :end
)

REM Check if publish profile exists
set "PROFILE_PATH=Properties\PublishProfiles\%PROFILE%.pubxml"
if not exist "%PROFILE_PATH%" (
    echo ❌ Publishing profile not found: %PROFILE_PATH%
    echo.
    echo Available profiles:
    for %%f in (Properties\PublishProfiles\*.pubxml) do (
        set "filename=%%~nf"
        echo   - !filename!
    )
    goto :end
)

echo 🚀 WanderlustApi Publishing Tool
echo ================================================
echo 📋 Profile: %PROFILE%
echo ⚙️  Configuration: %CONFIG%
echo 📁 Project: WanderlustApi.csproj
echo.

REM Special handling for Local-IIS
if /i "%PROFILE%"=="Local-IIS" (
    echo ⚠️  Local IIS deployment may require administrator privileges
    echo.
)

REM Run the publish command
echo 🔨 Publishing...
dotnet publish WanderlustApi.csproj --configuration %CONFIG% --verbosity minimal /p:PublishProfile=%PROFILE%

if errorlevel 1 (
    echo ❌ Publish failed with exit code: %errorlevel%
    goto :end
)

echo.
echo 🎉 Publish completed successfully!

REM Post-publish information
if /i "%PROFILE%"=="FolderProfile" (
    set "OUTPUT_PATH=bin\%CONFIG%\net8.0\win-x64\publish"
    echo 📁 Files published to: !OUTPUT_PATH!
    if exist "!OUTPUT_PATH!" (
        for /f %%i in ('dir /b /s "!OUTPUT_PATH!\*.*" ^| find /c /v ""') do (
            echo 📄 Total files: %%i
        )
    )
)

if /i "%PROFILE%"=="Local-IIS" (
    echo 🌐 Application should be available at: http://localhost/WanderlustApi
)

if /i "%PROFILE%"=="FTP-Production" (
    echo 🌐 Check your FTP server for the deployed files
)

if /i "%PROFILE%"=="WebDeploy-Production" (
    echo 🌐 Application deployed via Web Deploy
)

if /i "%PROFILE%"=="Linux-Server" (
    echo 🐧 Self-contained Linux deployment created
    echo 📁 Upload contents to your Linux server and run: ./WanderlustApi
)

if /i "%PROFILE%"=="Linux-Server-FDD" (
    echo 🐧 Framework-dependent Linux deployment created
    echo 📁 Upload contents to your Linux server and run: dotnet WanderlustApi.dll
    echo ⚠️  Requires .NET 8 runtime on the server
)

if /i "%PROFILE%"=="Linux-Docker" (
    echo 🐳 Docker deployment package created
    echo 📁 Use Dockerfile and docker-compose.yml to build and run container
)

:end
echo.
pause
