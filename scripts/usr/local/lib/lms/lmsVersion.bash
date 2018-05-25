#!/bin/bash
# =========================================================================
# =========================================================================
#
#	lmsVersion
#	  Build version message to be displayed
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 0.0.1
# @copyright © 2018. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package ewsdocker/debian-base
# @subpackage lmsVersion
#
# =========================================================================
#
#	Copyright © 2018. EarthWalk Software
#	Licensed under the GNU General Public License, GPL-3.0-or-later.
#
#   This file is part of ewsdocker/debian-base.
#
#   ewsdocker/debian-base is free software: you can redistribute 
#   it and/or modify it under the terms of the GNU General Public License 
#   as published by the Free Software Foundation, either version 3 of the 
#   License, or (at your option) any later version.
#
#   ewsdocker/debian-base is distributed in the hope that it will 
#   be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
#   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with ewsdocker/debian-base.  If not, see 
#   <http://www.gnu.org/licenses/>.
#
# =========================================================================
# =========================================================================

# ***********************************************************************************************************
#
#    lmsVersion
#
#		output version message
#
#	parameters:
#		none - response is placed in global lms_version
#
#	returns:
#		0 = no error
#
# ***********************************************************************************************************
function lmsVersion()
{
    local lines=()
    mapfile -t lines < /etc/ewsdocker-builds.txt

    local lsize=${#lines[@]}
    local lnumber=0

    (( lsize-- ))

    while [ ${lsize} -ge 0 ]
    do
        [[ ${lnumber} -eq 0 ]] || echo -n "    "
        echo "${lines[$lsize]}"

        (( ++lnumber ))
        (( --lsize ))
    done

    return 0    
}
