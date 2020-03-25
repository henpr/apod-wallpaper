# apod-wallpaper
this downloads the current nasa astronomy picture of the day and sets it to wallpaper automatically.

## usage:
`download-apod.sh` will ask you where to store the pictures on first run, then sets the wallpaper for you (if you have a DE other than xfce, you have to adjust the appropriate call).

When you run from Windows, you will have to set up the `config.txt` manually with the following values:

    APOD_DIR=<UNIX_DIRECTORY_FOR_PICTURES>
    WIN_APOD_DIR=<WINDOWS_DIRECTORY_FOR_PICTURES>

Both directories have to be the same on the file system, so windows can access the pictures downloaded by Linux (via WSL or MinGW or whatever). 

`set-wallpaper.bat` implements running the script with wsl. Just start in from cmd.
Run on startup: open startup folder (<win>+'r' shell:startup) and copy link to set-wallpaper.bat there.
