address=https://apod.nasa.gov/apod/
datepattern="$(date +'%Y')"
filename=$(date +'%Y-%m-%d').jpg
path=/mnt/c/users/hen/Pictures/
winpath="C:\\Users\\hen\\Pictures\\"

if [[ ! -f "$path$filename" ]]; then
wget -O - $address \
    | awk '/'$datepattern'/{getline; getline; print}' \
    | sed -e 's#^.*\(image.*\.jpg\).*$#'$address'\1#'\
    | xargs wget -O - >> $path$filename 
fi
# if run on windows
echo $winpath$filename
# in run on linux
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/image-path --set $path$filename