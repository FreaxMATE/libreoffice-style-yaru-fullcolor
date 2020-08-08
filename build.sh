#!/bin/bash

echo

if ! command -v inkscape >/dev/null
then
    echo  -e "=> 🙅 Please install inkscape\n"
    exit 1
fi

if ! command -v optipng >/dev/null
then
    echo  -e "=> 🙅 Please install optipng\n"
    exit 1
fi

if [[ -z $1 ]]
then
    echo  -e "=> 🙅 Please give a valid parameter\n"
    exit 1
elif [[ $1 = "--all" ]]
then
    echo -e "=> 🔥 Warning this will delete the /build folder and recreate it entirely from /src (will take a while)"
    read -p "=> Continue? (yes/no) " continue

    if [[ $continue != yes ]]
    then
        echo -e "\n=> Abort"
        exit 0
    fi

    echo -e "\n=> Remove old build"

    rm -Rf "build"

    cp "build/links.txt" \
    "src"

    cp -Rf "src" \
    "build"

    cd "./build"

    echo -e "\n=> 👷 Export all SVG to PNG ..."
    find -name "*.svg" -o -name "*.SVG" | while read i;
    do
        echo -e "\n=> 🔨 Render ${i}\n"
    	inkscape -f "$i" -e "${i%.*}.png"

        echo -e "\n=> ✨ Optimize PNG\n"
    	optipng -o7 "${i%.*}.png"
    	rm "$i"
    done

    cd "../"
else
    echo -e "=> 🔨 Render file\n"
    inkscape -f "./src${1}.svg" -e "./build${1}.png"

    echo -e "\n=> ✨ Optimize PNG\n"
    optipng -o7 "./build${1}.png"
fi

./generate-oxt.sh
