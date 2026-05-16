@echo off
cd /d "%~dp0"
echo ============================================
echo   ZimHeritage - Deploy Script
echo ============================================
echo.

:: Menu
echo Select build target:
echo   1) Web (Firebase Hosting)
echo   2) Android APK
echo   3) Android App Bundle (AAB - Play Store)
echo   4) Build ALL
echo.
set /p choice="Enter choice (1-4): "

if "%choice%"=="" set choice=1

:: ─── JAVA_HOME (for Android builds) ───────────────────────────────────────────
if "%choice%"=="2" set NEED_JAVA=1
if "%choice%"=="3" set NEED_JAVA=1
if "%choice%"=="4" set NEED_JAVA=1

if "%NEED_JAVA%"=="1" (
    if "%JAVA_HOME%"=="" (
        set JAVA_HOME=C:\Program Files\Android\Android Studio\jbr
    )
    if "%ANDROID_NDK_HOME%"=="" (
        set ANDROID_NDK_HOME=%LOCALAPPDATA%\Android\Sdk\ndk\28.2.13676358
    )
)

:: ─── WEB DEPLOY ───────────────────────────────────────────────────────────────
if "%choice%"=="1" goto web
if "%choice%"=="4" goto web

:web
echo.
echo [WEB] Building Flutter web...
call flutter build web --release
if %errorlevel% neq 0 (
    echo [ERROR] Web build failed.
    pause
    exit /b 1
)
echo [WEB] Build complete.

if "%choice%"=="1" (
    echo.
    echo [WEB] Checking Firebase login...
    firebase projects:list >nul 2>&1
    if %errorlevel% neq 0 (
        echo [!] Not logged in. Opening browser...
        firebase login
    )
    echo [WEB] Deploying to Firebase...
    firebase deploy
    echo.
    echo ============================================
    echo   Live at: https://zim-edu-bridge.web.app
    echo ============================================
    pause
    exit /b 0
)

:: ─── ANDROID APK ──────────────────────────────────────────────────────────────
:apk
if "%choice%"=="2" goto build_apk
if "%choice%"=="4" goto build_apk
goto aab

:build_apk
echo.
echo [APK] Building Android APK...
call flutter build apk --release
if %errorlevel% neq 0 (
    echo [ERROR] APK build failed.
    pause
    exit /b 1
)
echo [APK] APK ready: build\app\outputs\flutter-apk\app-release.apk
if "%choice%"=="2" goto done

:: ─── ANDROID AAB ──────────────────────────────────────────────────────────────
:aab
echo.
echo [AAB] Building Android App Bundle...
call flutter build appbundle --release
if %errorlevel% neq 0 (
    echo [ERROR] AAB build failed.
    pause
    exit /b 1
)
echo [AAB] AAB ready: build\app\outputs\bundle\release\app-release.aab

:: ─── DONE ─────────────────────────────────────────────────────────────────────
:done
echo.
echo ============================================
echo   ALL BUILDS COMPLETE!
echo ============================================
echo.
echo   Web:   build\web\
echo   APK:   build\app\outputs\flutter-apk\app-release.apk
echo   AAB:   build\app\outputs\bundle\release\app-release.aab
echo.
echo   Deploy web: firebase deploy
echo   Upload APK/AAB to Google Play Console
echo.
pause
