#/usr/bin/env bash
# mac-set-hostname.sh - This script will set the local machines name and
# domain information.  Two parameters are required: <machine name> <domain name>

# Bash "strict" mode
set -euo pipefail
IFS=$'\n\t'

if [[ $# -lt 2 ]]; then
    echo "You must pass 2 parameters, the host name and the domain name."
fi

hostname=$1
domainname=$2

sudo scutil --set ComputerName $hostname
sudo scutil --set LocalHostName $hostname
sudo scutil --set HostName $hostname.$domainname
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $hostname
sudo domainname $domainname
