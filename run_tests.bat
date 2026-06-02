@echo off
cd /d "%~dp0"
echo [1/3] Running dart pub audit...
call dart pub audit
echo [2/3] Running flutter analyze...
call flutter analyze
echo [3/3] Running tests with coverage...
flutter test --coverage
echo.
echo Coverage report: build/coverage/html/index.html
pause
