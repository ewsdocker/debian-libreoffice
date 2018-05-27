# =========================================================================================
# =========================================================================================
#
#	lmsConCli
#	  cli parsing library.
#
# =========================================================================================
#
# @author Jay Wheeler.
# @version 0.0.2
# @copyright © 2017, 2018. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package ewsdocker/debian-libreoffice
# @subpackage lmsConCli
#
# =========================================================================
#
#	Copyright © 2017, 2018. EarthWalk Software
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
#
# =========================================================================================
# =========================================================================================

# =========================================================================================
#
#    Command line parameter input parsing
#
# =========================================================================================

declare -A cliParam=()
declare -a cliKey=()

declare -a cliBuffer=( "${@}" )

declare    pName=""
declare    pValue=""
declare    strUnquoted=""

# =========================================================================================
#
#	lmsDeclareStr
#
#	    creates a global string variable and sets it's value
#
#	parameters:
#		name = name of global variable
#		value = value to set
#    Result:
#        0 = no error
#        non-zero = error number
#
# =========================================================================================
function lmsDeclareStr()
{
    [[ -z "${1}" ]] && return 1
    declare -g "${1}"

    local  svValue=${2:-""}

    eval ${1}="'${svValue}'"
    [[ $? -eq 0 ]] || return 1

    return 0
}

# =========================================================================================
#
#    lmsStrUnquote
#
#	remove leading and trailing quotes
#
#	parameters:
#	    string = the string to unquote
#	    result = (optional) location to place the unquoted string
#    Result:
#        0 = no error
#        non-zero = error number
#
# =========================================================================================
function lmsStrUnquote()
{
	local quoted=${1}

	strUnquoted="${quoted%\"}"
	strUnquoted="${strUnquoted#\"}"

	[[ -n "$2" ]] &&
	{
	    lmsDeclareStr $2 "${strUnquoted}"
	    [[ $? -eq 0 ]] || return 1
	}

	return 0
}

# =========================================================================================
#
#	lmsStrExplode
#
#		explodes a string into an array of lines split at the specified seperator
#
#	attributes:
#		string = string to explode
#		separator = (optional) parameter-option separator, defaults to ' '
#		array =  location (array name) to copy the exploded data
#    Result:
#        0 = no error
#        non-zero = error number
#
# =========================================================================================
function lmsStrExplode()
{
	local string="${1}"
	local separator=${2:-" "}

	OIFS="$IFS"
	IFS=$separator

	    read -a ${3} <<< "${string}"

	IFS="$OIFS"
}

# =========================================================================================
#
#	lmsStrSplit
#
#	    Splits a string into name and value at the specified seperator character
#
#	attributes:
#	    string = string to split
#	    parameter = parameter name
#	    value = parameter value
#	    separator = (optional) parameter-value separator, defaults to '='
#    Result:
#        0 = no error
#        non-zero = error number
#
# =========================================================================================
function lmsStrSplit()
{
    local -a nv=()

    lmsStrExplode "${1}" ${4:-"="} nv

    lmsDeclareStr ${2} "${nv[0]}"
    [[ $? -eq 0 ]] || return 1

    lmsDeclareStr ${3} "${nv[1]}"
    [[ $? -eq 0 ]] || return 2

    return 0
}

# *********************************************************************************
#
#	lmsSplitParameter
#
#	    Splits the parameter string into name and value
#
#	parameters:
#	    parameter = parameter string
#    Result:
#        0 = no error
#        non-zero = error number
#
# *********************************************************************************
function lmsSplitParameter()
{
    [[ -z "${1}" ]] && return 1

    lmsStrSplit "${1}" pName pValue
    [[ $? -eq 0 ]] || return 2

    cliParam[${pName}]=${pValue}
    cliKey[${#cliKey[@]}]=${pName}

    return 0
}

# **************************************************************************
#
#	lmsCliParse
#
#		parse the cli parameters in global cliBuffer array
#			and store results in lmscli_shellParam, lmscli_command,
#		    lmscli_cmndsValid
#
#	parameters:
#		none
#
#	returns:
#		Result = 0 if no error,
#				 1 if empty parameter buffer,
#				 2 if parse error
#
# **************************************************************************
function lmsCliParse()
{
	[[ ${#cliBuffer[@]} -eq 0 ]] && return 1

	local pString

	for pString in "${cliBuffer[@]}"
	do
		lmsSplitParameter "${pString}"
		[[ $? -eq 0 ]] || break
	done

    [[ ${#cliBuffer[@]} -eq 0 ]] && return 2

	return 0
}

