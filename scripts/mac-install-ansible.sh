#/usr/bin/env bash
# mac-install-ansible.sh - This script should do the absolute minimum to get
# Ansible installed.  This script is intended to be run to prepare an OS X
# machine to execute an Ansible playbook locally.  The playbook should do the
# heavy lifting of setting up the machine.  This script is not necessary if
# you intend to run the playbook from a remote host.
# NOTE: Full XCode should be installed manually before this script is run.
#

# Bash "strict" mode
set -euo pipefail
IFS=$'\n\t'

# Install the Command Line Tools
set +e
xcode-select -p
RETVAL=$?
set -e
if [[ "$RETVAL" -ne "0" ]]; then
    echo "Installing XCode Command Line Tools"
    xcode-select --install
    read -p "Continue? [Enter]"
fi

# Install brew
if [[ ! -x "/usr/local/bin/brew" ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap homebrew/dupes

# Install sqllite
if [[ ! -d "/usr/local/Cellar/sqlite" ]]; then
    echo "Installing sqlite"
    brew install sqlite --with-function --with-secure-delete
fi

# Install Tcl/Tk
if [[ ! -d "/usr/local/Cellar/tcl-tk" ]]; then
    echo "Installing tcl-tk"
    brew install tcl-tk --with-threads
fi

# Install Python 2
if [[ ! -d "/usr/local/Cellar/python" ]]; then
    echo "Installing python 2"
    brew install python --with-berkeley-db4 --with-tcl-tk
fi

# Install Python 3
if [[ ! -d "/usr/local/Cellar/python3" ]]; then
    echo "Installing python 3"
    brew install python3 --with-tcl-tk
fi

# Update Pip2 packages
/usr/local/bin/pip2 install -U pip setuptools wheel
/usr/local/bin/pip3 install -U pip setuptools wheel

# Install Ansible
if [[ ! -x "/usr/local/bin/ansible" ]]; then
    echo "Installing ansible"
    /usr/local/bin/pip2 install ansible kerberos pywinrm
fi
