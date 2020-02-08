for /f "usebackq" %%x in (`wsl bash download-apod.sh`) do set APOD_WP_FILENAME=%%x

reg add "HKCU\Control Panel\Desktop" /v Wallpaper /f /t REG_SZ /d C:\Users\hen\workspace\apod-wallpaper\%APOD_WP_FILENAME%