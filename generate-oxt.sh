#!/bin/bash

cd "png"

echo "Zip icons"

zip -r -q "images_yaru.zip" *

cd "../"

cp "png/images_yaru.zip" \
"oxt/iconsets/images_yaru.zip"

cd "oxt"

echo "Create oxt"

zip -r "yaru-theme.zip" *

mv "yaru-theme.zip" "../yaru-theme.oxt"

echo "Finish"
