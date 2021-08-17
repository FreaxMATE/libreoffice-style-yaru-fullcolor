#!/bin/bash
#
# Legal Stuff:
#
# This file is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free Software
# Foundation; version 3.
#
# This file is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU Lesser General Public License along with
# this program; if not, see <https://www.gnu.org/licenses/lgpl-3.0.txt>
dest="$(realpath "${1}")"

./generate-oxt.sh

echo -e "\n=> 📥 Installing Libreoffice style Yaru\n"

sudo mkdir -p -v "${dest}/usr/share/libreoffice/share/config"
sudo cp -v "images_yaru.zip" "${dest}/usr/share/libreoffice/share/config/images_yaru.zip"
sudo cp -v "images_yaru_svg.zip" "${dest}/usr/share/libreoffice/share/config/images_yaru_svg.zip"
sudo cp -v "images_yaru_mate.zip" "${dest}/usr/share/libreoffice/share/config/images_yaru_mate.zip"
sudo cp -v "images_yaru_mate_svg.zip" "${dest}/usr/share/libreoffice/share/config/images_yaru_mate_svg.zip"

for dir in \
    ${dest}/usr/lib64/libreoffice/share/config \
    ${dest}/usr/lib/libreoffice/share/config \
    ${dest}/usr/local/lib/libreoffice/share/config \
    ${dest}/opt/libreoffice*/share/config; do
        [ -d "$dir" ] || continue
        sudo ln -sf -v "${dest}/usr/share/libreoffice/share/config/images_yaru.zip" "$dir"
        sudo ln -sf -v "${dest}/usr/share/libreoffice/share/config/images_yaru_svg.zip" "$dir"
        sudo ln -sf -v "${dest}/usr/share/libreoffice/share/config/images_yaru_mate.zip" "$dir"
        sudo ln -sf -v "${dest}/usr/share/libreoffice/share/config/images_yaru_mate_svg.zip" "$dir"
done

echo -e "\n=> 🎉 Finish (don't forget to restart Libreoffice)!\n"
