if [[ ! -z "$1" && "$1" = "WIN" ]]
then
    run_from_windows=1
else
    run_from_windows=0
fi

if [ ! $run_from_windows = 1 ]
then
    echo "***************************************"
    echo "**         APOD Wallpaper            **"
    echo "***************************************"
    echo ""

    if [ ! -f config.txt ]
    then
        read -p "Welcome to the first run! Where shall I store all the pictures? [~/Pictures/apod] " apod_dir
        if [ -z "$apod_dir"]
        then
            apod_dir="/home/$USER/Pictures/apod"
        fi
        if [ ! -d "$apod_dir" ]
        then
            echo "Directory '$apod_dir' does not exist. I will create it for you."
            mkdir -p "$apod_dir"
        fi
        echo "APOD_DIR=\"$apod_dir\"" > config.txt        
    fi
fi

. config.txt

if [[ -z "$APOD_DIR" || ( -z "$WIN_APOD_DIR" && "$run_from_windows" = 1 ) ]]
then
    echo "Error: APOD_DIR not set in config file. Delete config file and try again."
    echo "Alternatively, set config.txt manually with APOD_DIR=/path/to/apod and"
    echo "WIN_APOD_DIR=windows/path/to/apod"
    exit 1
fi

address=https://apod.nasa.gov/apod/
datepattern="$(date +'%Y')"
filename=$(date +'%Y-%m-%d').jpg
path="$APOD_DIR"
winpath="$WIN_APOD_DIR"

if [ ! -f "$path/$filename" ]
then
    filenameOnPage=$(wget -O - $address | awk '/'$datepattern'/{getline; getline; print}' | sed -e 's#.*\(image.*\(\.png\|\.jpg\)\).*#\1#')
    if [ $? != 0 ]
    then
        connect_failed = true
    else
        wget -O $path/$filename $address$filenameOnPage 
    fi
fi

if [ connect_failed != true ]
then
    if [ $run_from_windows = 1 ]
    then
        echo $winpath/$filename
    else
        xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitoreDP1/workspace0/last-image --set $path/$filename
    fi
else
    echo "error: could not connect to nasa!"
fi
