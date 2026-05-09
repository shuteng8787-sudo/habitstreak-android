@echo off
chcp 65001 >nul
echo ==========================================
echo  HabitStreak AAB 一键签名
echo ==========================================
echo.

set KEYSTORE_PWD=xiaoniao1987

REM 查找下载的 artifact 目录
if exist "habitstreak-unsigned-aab" (
    set AAB_DIR=habitstreak-unsigned-aab
) else if exist "app-release" (
    set AAB_DIR=app-release
) else (
    echo 错误：找不到 AAB 文件！
    echo 请先从 GitHub Actions 下载 artifact 并解压到此目录。
    pause
    exit /b 1
)

if exist "android-keystore" (
    set KEYSTORE_FILE=android-keystore\android.keystore
) else if exist "android.keystore" (
    set KEYSTORE_FILE=android.keystore
) else (
    echo 错误：找不到 keystore 文件！
    echo 请先从 GitHub Actions 下载 keystore artifact 并解压到此目录。
    pause
    exit /b 1
)

echo [1/2] 正在签名 AAB 文件...
echo 使用的密码: %KEYSTORE_PWD%
echo.

jarsigner -keystore "%KEYSTORE_FILE%" -storepass %KEYSTORE_PWD% -keypass %KEYSTORE_PWD% -sigalg SHA256withRSA -digestalg SHA-256 "%AAB_DIR%\app-release.aab" android

if errorlevel 1 (
    echo.
    echo 签名失败！可能原因：
    echo 1. JDK 未安装或未添加到 PATH
    echo 2. keystore 密码错误
    echo 3. AAB 文件已损坏
    pause
    exit /b 1
)

echo.
echo [2/2] 验证签名...
jarsigner -verify "%AAB_DIR%\app-release.aab"

echo.
echo ==========================================
echo  签名完成！
echo ==========================================
echo.
echo 最终文件位置：
echo   %AAB_DIR%\app-release.aab
echo.
echo 现在你可以去 Google Play Console 上传此 AAB 文件了。
echo.
pause
