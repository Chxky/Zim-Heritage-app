@echo off
cd /d "%~dp0"
echo ========================================
echo  ZimHeritage Deployment Script
echo ========================================
echo.

echo [1/6] Running dart pub audit...
call dart pub audit
if %ERRORLEVEL% neq 0 (
    echo WARNING: Security vulnerabilities found!
)

echo [2/6] Running flutter analyze...
call flutter analyze
if %ERRORLEVEL% neq 0 (
    echo ERROR: Analysis failed. Fix issues before deploying.
    pause
    exit /b 1
)

echo [3/6] Running tests...
call flutter test --coverage
if %ERRORLEVEL% neq 0 (
    echo ERROR: Tests failed. Fix issues before deploying.
    pause
    exit /b 1
)

echo [4/6] Building web release...
call flutter build web --release
if %ERRORLEVEL% neq 0 (
    echo ERROR: Web build failed.
    pause
    exit /b 1
)

echo [5/6] Building Android APK...
call flutter build apk --release
if %ERRORLEVEL% neq 0 (
    echo WARNING: Android build failed (may need Android SDK).
)

echo [6/6] Done!
echo.
echo Build outputs:
echo   Web:     build\web\index.html
echo   Android: build\app\outputs\flutter-apk\app-release.apk
echo.
pause
