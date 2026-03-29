#!/bin/bash
# =============================================================================
# Script 1: System Identity Report
# Author: Aayush Mittal | Course: Open Source Software
# Registration No: 24BAI10251
# Description: This script introduces the Linux system like a welcome screen,
#              displaying system information including distribution, kernel,
#              user details, uptime, and open-source license information.
# Concepts Used: variables, echo, command substitution ($()), output formatting
# =============================================================================

# --- Variables ---
STUDENT_NAME="Aayush Mittal"           # Student name for display
SOFTWARE_CHOICE="Python"              # Chosen open-source software for audit
REGISTRATION_NO="24BAI10251"          # Student registration number

# --- System Information Collection ---
# Using command substitution $() to capture command output into variables
KERNEL=$(uname -r)                    # Kernel version using uname command
USER_NAME=$(whoami)                   # Current logged-in username
UPTIME=$(uptime -p)                   # System uptime in human-readable format
CURRENT_DATE=$(date '+%A, %d %B %Y')  # Current date with day name
CURRENT_TIME=$(date '+%H:%M:%S %Z')   # Current time with timezone
HOME_DIR=$(echo $HOME)                # Home directory of current user
HOSTNAME=$(hostname)                  # System hostname

# --- Distribution Detection ---
# Check for different distribution files to identify the Linux distro
if [ -f /etc/os-release ]; then
    # Most modern distributions have /etc/os-release
    DISTRO=$(grep "^PRETTY_NAME=" /etc/os-release | cut -d'"' -f2)
elif [ -f /etc/lsb-release ]; then
    # Ubuntu and derivatives
    DISTRO=$(grep "DISTRIB_DESCRIPTION=" /etc/lsb-release | cut -d'"' -f2)
elif [ -f /etc/redhat-release ]; then
    # Red Hat and derivatives
    DISTRO=$(cat /etc/redhat-release)
else
    DISTRO="Unknown Linux Distribution"
fi

# --- License Information ---
# The OS license message - Linux kernel and most components are GPL licensed
LICENSE_MSG="This operating system is primarily covered under GPL (GNU General Public License).
The Linux Kernel is licensed under GPL v2, ensuring freedom to use, study, modify, and distribute."

# --- Display Section ---
# Clear screen for a clean welcome display
clear

# Print decorative header
echo "╔══════════════════════════════════════════════════════════════════════════╗"
echo "║                    OPEN SOURCE AUDIT - SYSTEM IDENTITY                   ║"
echo "╠══════════════════════════════════════════════════════════════════════════╣"

# Display student information
echo "║  Student Name    : $STUDENT_NAME"
echo "║  Registration No : $REGISTRATION_NO"
echo "║  Software Audit  : $SOFTWARE_CHOICE"
echo "╠══════════════════════════════════════════════════════════════════════════╣"

# Display system information
echo "║                        SYSTEM INFORMATION                                ║"
echo "╠══════════════════════════════════════════════════════════════════════════╣"
echo "║  Hostname        : $HOSTNAME"
echo "║  Distribution    : $DISTRO"
echo "║  Kernel Version  : $KERNEL"
echo "║  Current User    : $USER_NAME"
echo "║  Home Directory  : $HOME_DIR"
echo "║  System Uptime   : $UPTIME"
echo "║  Current Date    : $CURRENT_DATE"
echo "║  Current Time    : $CURRENT_TIME"
echo "╠══════════════════════════════════════════════════════════════════════════╣"

# Display license information
echo "║                        LICENSE INFORMATION                               ║"
echo "╠══════════════════════════════════════════════════════════════════════════╣"
echo "║  $LICENSE_MSG"
echo "╚══════════════════════════════════════════════════════════════════════════╝"

# --- Python Installation Check ---
# Since Python is our chosen software, check its installation
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "                    PYTHON INSTALLATION STATUS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check for Python 3
if command -v python3 &> /dev/null; then
    PYTHON3_VERSION=$(python3 --version 2>&1)
    PYTHON3_PATH=$(which python3)
    echo "✓ $PYTHON3_VERSION is installed"
    echo "  Path: $PYTHON3_PATH"
else
    echo "✗ Python 3 is NOT installed"
fi

# Check for Python 2 (legacy)
if command -v python2 &> /dev/null; then
    PYTHON2_VERSION=$(python2 --version 2>&1)
    PYTHON2_PATH=$(which python2)
    echo "✓ $PYTHON2_VERSION is installed"
    echo "  Path: $PYTHON2_PATH"
else
    echo "✗ Python 2 is NOT installed (legacy version)"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Script execution completed at $(date '+%H:%M:%S on %d/%m/%Y')"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Exit with success status
exit 0
