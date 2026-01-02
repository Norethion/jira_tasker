@echo off
chcp 65001 >nul
echo ===================================
echo Jira Task Creator - Baslatici
echo ===================================
echo.

REM Python kontrolu
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Python bulunamadi. Kurulum baslatiliyor...
    echo.

    REM winget ile Python kur
    winget install Python.Python.3.12 --accept-package-agreements --accept-source-agreements

    if %errorlevel% neq 0 (
        echo.
        echo [HATA] Python otomatik kurulamadi.
        echo Manuel kurulum icin: https://www.python.org/downloads/
        pause
        exit /b 1
    )

    echo.
    echo [OK] Python kuruldu!
    echo [!] Terminal kapatilip tekrar acilmali. Lutfen bu dosyayi tekrar calistirin.
    pause
    exit /b 0
)

for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYVER=%%i
echo [OK] Python %PYVER% bulundu

REM Paketleri kur (yoksa)
echo.
echo Gerekli paketler kontrol ediliyor...
pip install -r requirements.txt -q

echo.
echo [OK] Paketler hazir
echo.
echo ===================================
echo Server baslatiliyor...
echo Tarayicida ac: http://localhost:5000
echo Durdurmak icin: Ctrl+C
echo ===================================
echo.

python server.py
pause
