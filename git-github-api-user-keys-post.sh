#!/bin/sh
# Copyright © (C) 2017 Emory Merryman <emory.merryman@gmail.com>
#   This file is part of github-api.
#
#   github-api is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   github-api is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with github-api.  If not, see <http://www.gnu.org/licenses/>.

while [ ${#} -gt 0 ]
do
    case ${1} in
	--title)
	    TITLE=${2} &&
		shift &&
		shift
	    ;;
	--key)
	    KEY=${2} &&
		shift &&
		shift
	    ;;
    esac
done &&
    HEAD=$(mktemp) &&
    OUT=$(mktemp) &&
    ERR=$(mktemp) &&
    (cat <<EOF
{   
    	"title": "${TITLE}",
	"key": "${KEY}"
}
EOF
    ) | jq "." | curl --dump-header ${HEAD} --user "${USER_ID}:${AUTHENTICATION_TOKEN}" --data @- https://api.github.com/user/keys > ${OUT} 2> ${ERR} &&
    STATUS=$(grep "Status" ${HEAD} | sed -e "s#^Status: \([0-9]*\).*\$#\1#") &&
    cat ${OUT} | jq "{head: {status: \"${STATUS}\"}, data: .}" &&
    [ ${STATUS} == '402' ] &&
    exit 0 ||
	exit 64

