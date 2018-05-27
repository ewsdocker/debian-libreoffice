# =========================================================================
# =========================================================================
#
#	lmsDisplay
#     display a message on the console output device
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 0.1.0
# @copyright © 2016, 2018. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package ewsdocker/debian-libreoffice
# @subpackage lmsconDisplay
#
# =========================================================================
#
#	Copyright © 2016, 2018. EarthWalk Software
#	Licensed under the GNU General Public License, GPL-3.0-or-later.
#
#   This file is part of ewsdocker/debian-libreoffice.
#
#   ewsdocker/debian-libreoffice is free software: you can redistribute 
#   it and/or modify it under the terms of the GNU General Public License 
#   as published by the Free Software Foundation, either version 3 of the 
#   License, or (at your option) any later version.
#
#   ewsdocker/debian-libreoffice is distributed in the hope that it will 
#   be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
#   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with ewsdocker/debian-libreoffice.  If not, see 
#   <http://www.gnu.org/licenses/>.
#
# =========================================================================
# =========================================================================

declare    lmsDisplayBuffer=""
declare    lmscli_optQuiet=0

# =========================================================================
#
#   lmsDisplay
#		display message on the console
#
#	parameters:
#		message = message to display
#	returns:
#		0 = no errors
#		non-zero = error code
#
# =========================================================================
function lmsDisplay()
{
    lmsDisplayBuffer="${1}"

    [[ ${lmscli_optQuiet} -eq 0 ]] &&
     {
        [[ -z "${2}" ]] && echo "${lmsDisplayBuffer}" || echo -n "${lmsDisplayBuffer}"
     }

    return 0
}

