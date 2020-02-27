for /f "usebackq" %%x in (`wsl bash download-apod.sh`) do set APOD_WP_FILENAME=%%x

reg add "HKCU\Control Panel\Desktop" /v Wallpaper /f /t REG_SZ /d %APOD_WP_FILENAME%
call RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters
pause