address=https://apod.nasa.gov/apod/
sedscript='s#^.*\(image.*\.jpg\).*$#'$address'\1#'

wget -O - $address \
| awk '/2020 February 8/{getline; getline; print}' \
| sed -e  $sedscript\
| xargs wget