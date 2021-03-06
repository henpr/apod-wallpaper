force=false 
run_from_windows=false

for arg in $@ 
do
    if [ $arg = "--force" ]
    then
        force=true
    elif [ $arg = "--windows" ]
    then
        run_from_windows=true
    fi
done

if [ $run_from_windows = false ]
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

if [ ! -f "$path/$filename" ] || [ "$force" = true ]
then
    apodPage=$(wget -O - $address)
    if [ $? != 0 ]
    then
        echo "error: could not connect to nasa!"
        exit 1
    fi
    filenameOnPage=$(echo "$apodPage" | awk '/'$datepattern'/{getline; getline; print; exit}' | sed -e 's#.*\(image.*\(\.png\|\.jpg\)\).*#\1#')
    wget -O $path/$filename $address$filenameOnPage 
elif [ $run_from_windows = false ]
then
    echo "File already exists -- nothing to do."
fi

if [ "$connect_failed" != true ]
then
    if [ $run_from_windows = true ]
    then
        echo $winpath/$filename
    else
        xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitoreDP1/workspace0/last-image --set $path/$filename
    fi
else
    echo "error: could not connect to nasa!"
fi
