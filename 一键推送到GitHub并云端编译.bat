@echo off
chcp 65001 >nul
echo ==========================================
echo  HabitStreak 一键推送 + GitHub 云端编译
echo ==========================================
echo.

set PROJECT_DIR=D:\下属\战略爱马仕\projects\genesis-forge
set REPO_NAME=habitstreak-android
set GITHUB_USER=genesis2026

cd /d "%PROJECT_DIR%"

REM 检查是否已初始化 git
if not exist ".git" (
    echo [1/5] 初始化 Git 仓库...
    git init
    git branch -m main
) else (
    echo [1/5] Git 仓库已存在，跳过初始化
)

echo.
echo [2/5] 添加所有文件到 Git...
git add .

echo.
echo [3/5] 提交代码...
git commit -m "Ready for GitHub Actions build - %date% %time%" 2>nul || echo 没有新变更需要提交

echo.
echo [4/5] 检查远程仓库配置...
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    echo.
    echo ==========================================
    echo  请先手动创建 GitHub 仓库！
    echo ==========================================
    echo.
    echo 1. 打开浏览器访问：
    echo    https://github.com/new
    echo.
    echo 2. Repository name 填：%REPO_NAME%
    echo    （可以选 Private，建议勾选 Add a README）
    echo.
    echo 3. 创建完成后，复制仓库地址，格式如下：
    echo    https://github.com/%GITHUB_USER%/%REPO_NAME%.git
    echo.
    echo 4. 然后回到这里，输入下面的命令：
    echo    git remote add origin https://github.com/%GITHUB_USER%/%REPO_NAME%.git
    echo    git push -u origin main
    echo.
    echo ==========================================
    echo  按任意键打开 GitHub 创建页面...
    echo ==========================================
    pause >nul
    start https://github.com/new?repo_name=%REPO_NAME%
    echo.
    echo 请创建仓库后，按任意键继续推送...
    pause >nul

    set /p REMOTE_URL="请粘贴你的仓库地址（https://github.com/...）: "
    git remote add origin %REMOTE_URL%
)

echo.
echo [5/5] 推送到 GitHub...
git push -u origin main

if errorlevel 1 (
    echo.
    echo ==========================================
    echo  推送失败，可能需要先拉取或处理冲突
    echo ==========================================
    pause
    exit /b 1
)

echo.
echo ==========================================
echo  推送成功！
echo ==========================================
echo.
echo 接下来：
echo 1. 打开浏览器访问：
echo    https://github.com/%GITHUB_USER%/%REPO_NAME%/actions
echo.
echo 2. 你会看到 "Build HabitStreak AAB" 正在运行
echo    （绿色圆点 = 运行中，黄色 = 排队，红色 = 失败）
echo.
echo 3. 等待 3-5 分钟，等状态变成绿色对勾后：
echo    - 点击最新的 workflow run
echo    - 滚动到最下方的 "Artifacts" 区域
echo    - 点击 "habitstreak-release-aab" 下载
echo.
echo ==========================================
echo  按任意键打开 Actions 页面...
echo ==========================================
pause >nul
start https://github.com/%GITHUB_USER%/%REPO_NAME%/actions

echo.
echo 完成！去 GitHub 页面等待编译结果并下载 AAB 吧。
pause
