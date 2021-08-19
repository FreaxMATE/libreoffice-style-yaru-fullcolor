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

prefix="/"
dest=""

usage() {
  printf "%s\n" "Usage: $0 [OPTIONS...]"
  printf "\n%s\n" "OPTIONS:"
  printf "  %-25s%s\n" "-p, --prefix PREFIX" "Specify prefix directory (Default: \"${prefix}\")"
  printf "  %-25s%s\n" "-d, --dest DIR" "Specify theme destination directory (e.g.: \"/usr/lib/\", \"/usr/share/\")"
  printf "  %-25s%s\n" "-h, --help" "Show this help"
}

while [[ $# -gt 0 ]]; do
  case "${1}" in
    -p|--prefix)
      prefix="$(realpath "${2}")"
      if [[ ! -d "${prefix}" ]]; then
        echo "ERROR: Prefix directory does not exist."
        exit 1
      fi
      shift 2
      ;;
    -d|--dest)
      dest="$(realpath "${2}")"
      if [[ ! -d "${dest}" ]]; then
        echo "ERROR: Destination directory does not exist."
        exit 1
      fi
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: Unrecognized installation option '$1'."
      echo "Try '$0 --help' for more information."
      exit 1
      ;;
  esac
done

./generate-oxt.sh


echo -e "\n=> 📥 Installing Libreoffice style Yaru\n"

if [ -z ${dest} ]; then
	sudo mkdir -p -v "${prefix}/usr/share/libreoffice/share/config"
	sudo cp -v "images_yaru.zip" "${prefix}/usr/share/libreoffice/share/config/images_yaru.zip"
	sudo cp -v "images_yaru_svg.zip" "${prefix}/usr/share/libreoffice/share/config/images_yaru_svg.zip"
	sudo cp -v "images_yaru_mate.zip" "${prefix}/usr/share/libreoffice/share/config/images_yaru_mate.zip"
	sudo cp -v "images_yaru_mate_svg.zip" "${prefix}/usr/share/libreoffice/share/config/images_yaru_mate_svg.zip"

	for dir in \
		${prefix}/usr/lib64/libreoffice/share/config \
		${prefix}/usr/lib/libreoffice/share/config \
		${prefix}/usr/local/lib/libreoffice/share/config \
		${prefix}/opt/libreoffice*/share/config; do
		    [ -d "$dir" ] || continue
		    sudo ln -sf -v "${prefix}/usr/share/libreoffice/share/config/images_yaru.zip" "$dir"
		    sudo ln -sf -v "${prefix}/usr/share/libreoffice/share/config/images_yaru_svg.zip" "$dir"
		    sudo ln -sf -v "${prefix}/usr/share/libreoffice/share/config/images_yaru_mate.zip" "$dir"
		    sudo ln -sf -v "${prefix}/usr/share/libreoffice/share/config/images_yaru_mate_svg.zip" "$dir"
	done
else
	sudo mkdir -p -v "${prefix}/${dest}/libreoffice/share/config"
	sudo cp -v "images_yaru.zip" "${prefix}/${dest}/libreoffice/share/config/images_yaru.zip"
	sudo cp -v "images_yaru_svg.zip" "${prefix}/${dest}/libreoffice/share/config/images_yaru_svg.zip"
	sudo cp -v "images_yaru_mate.zip" "${prefix}/${dest}/libreoffice/share/config/images_yaru_mate.zip"
	sudo cp -v "images_yaru_mate_svg.zip" "${prefix}/${dest}/libreoffice/share/config/images_yaru_mate_svg.zip"
fi;


echo -e "\n=> 🎉 Finish (don't forget to restart Libreoffice)!\n"
