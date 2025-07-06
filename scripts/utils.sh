#!/usr/bin/env bash
# Utility functions and variables for scripts

# COLORS -----------------------------------------------------------------------
DANGER='\033[0;31m'  # Red
SUCCESS='\033[0;32m' # Green
WARN='\033[1;33m'    # Yellow
INFO='\033[0;34m'    # Blue
DEBUG='\033[1;37m'   # White
NC='\033[0m'         # No Color

# UTILITY FUNCTIONS ------------------------------------------------------------

# Log function with color support
log() {
    local level=$1
    local message=$2
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    case $level in
    "DANGER" | "ERROR")
        printf "${DANGER}[${timestamp}] ERROR: ${message}${NC}\n" >&2
        ;;
    "SUCCESS")
        printf "${SUCCESS}[${timestamp}] SUCCESS: ${message}${NC}\n"
        ;;
    "WARN" | "WARNING")
        printf "${WARN}[${timestamp}] WARN: ${message}${NC}\n"
        ;;
    "INFO")
        printf "${INFO}[${timestamp}] INFO: ${message}${NC}\n"
        ;;
    "DEBUG")
        printf "${DEBUG}[${timestamp}] DEBUG: ${message}${NC}\n"
        ;;
    *)
        printf "[${timestamp}] ${message}\n"
        ;;
    esac
}
