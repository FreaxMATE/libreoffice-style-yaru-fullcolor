#!/bin/bash

if ! command -v inkscape >/dev/null
then
    echo "Please install inkscape"
    exit 1
fi

if ! command -v optipng >/dev/null
then
    echo "Please install optipng"
    exit 1
fi

echo "=> Remove old pngs"

rm -Rf "png"

cp -Rf "svg" \
"png"

cd "./png"

echo "=> Export SVG to PNG ..."
find -name "*.svg" -o -name "*.SVG" | while read i;
do
	inkscape -f "$i" -e "${i%.*}.png"
	optipng -o7 "${i%.*}.png"
	rm "$i"

    echo "This $i file is exported"
done

zip -r "images_yaru.zip" *

echo "=> Finish"
