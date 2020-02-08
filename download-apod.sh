address=https://apod.nasa.gov/apod/
datepattern="$(date +'%Y')"
filename=$(date +'%Y-%m-%d').jpg

echo $datepattern
wget -O - $address \
| awk '/'$datepattern'/{getline; getline; print}' \
| sed -e 's#^.*\(image.*\.jpg\).*$#'$address'\1#'\
| xargs wget -O - >> $filename \
&& echo $filename