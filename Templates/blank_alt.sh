#!/bin/bash

tput reset
printf '\e[3J'

##########################################################################################
# CompanyName
# Author:
# Date: 
# Platform: MacOS
#
# Description
#
# Versions
# 1.	Features
#		
#
# Parameters
# -h|help	Help
# -l|log	Logging
# -d|debug	Debugging
#
# Known Bugs
# 
#
##########################################################################################
#
# Exit Codes
#	0. Success/Help
#	1. Bad parameter
#	2. Bad log file
#
#
#
#	100+. 100+ error from line of code
#
##########################################################################################

##########################################################################################
# Traps
################

ExitTrap () {
    # Restore output to terminal
    exec &>/dev/tty

    # Exit code/cleanup
    
    

    # Clean up tmpdir
	rm -rf "$TMPDIR" || printf "Error removing temporary directory %s\n" "$TMPDIR"

    # Restore formatting
    printf "${KNRM}"
    
    # Restore the cursor
    tput cnorm
    
    #printf "Exiting $1\n"
    exit $1
}
trap 'ExitTrap $?' INT EXIT TERM

ErrTrap () {
    # Error trapping
    local ERRLNE="$1"
    local ERRNUM="$2"
    local ERRCMD=$(sed -n -e "$1 p" "$0")
    local ERRDAT=$(date +"%Y.%m.%d %H.%M.%S")
    
    #Output err to screen and line
    printf "$ERRDAT Error: $ERRNUM on line $ERRLNE: $ERRCMD\n"

    # Ask to continue
    tput sc
    local OPT=""
    until [ "${OPT/Y/y}" == "y" ] || [ "${OPT/N/n}" == "n" ]; do
        tput rc
        ! (( LOGGING )) && read -p "Continue (y/n)? " -n 1 -s OPT
        OPT=${OPT:-0}
        (( LOGGING )) && OPT="y"
    done
    
    # Exit if the user chooses "N/n"
    [ "${OPT/N/n}" == "n" ] && exit $(( ERRNUM + 100 )) || printf "\nContinuing ....\n"
}
trap 'ErrTrap ${LINENO} ${?}' ERR



##########################################################################################
# Environment setup
################

# Global Variables
BASEPATH="$(dirname "$0")"
BASENAME="$(basename "$0")"


# Create temporary and working diorectory
WRKDIR="$TMPDIR"
TMPDIR="/tmp/$BASENAME."$(openssl rand -hex 12)
mkdir -p -m 777 "$TMPDIR"

# Colours (ex. ${KBLD}Bold Text${KNRM})
KNRM="\x1B[0m"
KRED="\x1B[31m"
KGRN="\x1B[32m"
KYEL="\x1B[33m"
KBLU="\x1B[34m"
KMAG="\x1B[35m"
KCYN="\x1B[36m"
KWHT="\x1B[37m"

KBLD="\033[1m"
KNRM="\033[0m"

# Default values
LOGGING=0

# Turn off line wrapping:
#printf '\033[?7l'
# Turn on  line wrapping:
#printf '\033[?7h'

# Set window size ex. 100w x 40h
#printf '\033[8;40;100t'

# Set window Title
printf "\033]0;%s\007" "${BASENAME%%.*}"

# Hide the cursor for the run of the script
tput civis


##########################################################################################
# Arguments
################

# Uncomment to require at least one parameter else throw help
#[[ ! $@ =~ ^\-.+ ]] && HELP=true

while [[ $# -gt 0 ]]
do
    KEY="$1"
    case $KEY in
        -l|--log)
            NEXT_ARG="$2"
            while ! [[ "$NEXT_ARG" =~ -.* ]] && [[ $# -gt 1 ]]; do
                LOGFILE=$NEXT_ARG
                if [ -d "$(dirname "$LOGFILE")" ]; then
          exec &> "$LOGFILE"
          LOGGING=1
        else
          printf "Invalid log path: %s\n" "$LOGFILE"
          exit 2
        fi
                if ! [[ "$2" =~ -.* ]]; then
                    shift
                    NEXT_ARG="$2"
                else
                    shift
                    break
                fi
            done
        ;;
        -d|--debug)
            echo "Debug ON"
            set -x
        ;;
        -h|--help)
            HELP=true
        ;;
        *)
            echo "Unknown flag $KEY"
            exit 1
        ;;
    esac
    shift
done

##########################################################################################
# Help
################

if ( ${HELP:-false} ); then
    printf "\n"

    # NAME
    printf "${KBLD}[NAME]${KNRM}\n"
    printf "\t%s\n\n" \
        "$(basename ${0%.*})"
    
    # SYNOPSIS
    printf "${KBLD}[SYNOPSIS]${KNRM}\n"
    printf "\t%s\n\n" \
        "$(basename $0) -hdl"
    
    # DESCRIPTION
    printf "${KBLD}[DESCRIPTION]${KNRM}\n"
    printf "\t%s\n\n" \
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Supports line wraping " | \
        fmt -p -w $(tput cols)

    # OPTIONS
    printf "${KBLD}[OPTIONS]${KNRM}\n"
    printf "\t%s\t%s\n" \
        "h|help" "Bring up this help message" \
        "d|debug" "Debug on" \
        "l|log" "Log all output to file to file specified (ex. -l /var/log/logfile.log)"\

    printf "\n\n"
    exit 0
fi


##########################################################################################
# Functions
################






##########################################################################################
# Main
################


printf "Do stuff\n"


exit 0