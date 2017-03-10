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
	--user-id)
	    export USER_ID=${2} &&
		shift &&
		shift
	    ;;
	--authentication-token)
	    export AUTHENTICATION_TOKEN=${2} &&
		shift &&
		shift
	    ;;
	user)
	    shift &&
		sh git-github-api-user.sh "${@}" &&
		exit 0 ||
		    exit 64
	    ;;
    esac
done
