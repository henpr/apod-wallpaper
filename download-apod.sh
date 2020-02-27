address=https://apod.nasa.gov/apod/
datepattern="$(date +'%Y')"
filename=$(date +'%Y-%m-%d').jpg
path=/mnt/d/HenryP/Pictures/apod
winpath="d:/henryp/pictures/apod"
test='<a href="image/2002/LaSillaLaPalma_Horalek_Casado_ZLCircle_viz_1500px.png">'
echo $test | sed -e 's#.*\(image.*\(\.png\|\.jpg\)\).*#'$address'\1#'
#if [[ ! -f "$path$filename" ]]; then
path=$(wget -O - $address \
    | awk '/'$datepattern'/{getline; getline; print}' \
    | sed -e 's#.*\(image.*\.png\).*#\1#'\
    | xargs echo) # wget -O - >> $path$filename 
echo $path
#fi
# if run on windows
# echo $winpath/$filename
# in run on linux
# xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/image-path --set $path$filename