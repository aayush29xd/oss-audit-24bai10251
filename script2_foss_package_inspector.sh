#!/bin/bash
# =============================================================================
# Script 2: FOSS Package Inspector
# Author: Aayush Mittal | Course: Open Source Software
# Registration No: 24BAI10251
# Description: This script checks whether the chosen software (Python) is
#              installed on the system, finds its version, and uses a case
#              statement to print philosophical notes about various FOSS packages.
# Concepts Used: if-then-else, case statement, command substitution,
#                rpm/dpkg commands, pipe with grep, command -v
# =============================================================================

# --- Configuration Variables ---
PACKAGE="python3"                     # Package to inspect (Python 3)
AUTHOR="Aayush Mittal"
REG_NO="24BAI10251"

# --- Display Header ---
echo "╔══════════════════════════════════════════════════════════════════════════╗"
echo "║                    FOSS PACKAGE INSPECTOR                                ║"
echo "║                    Author: $AUTHOR | Reg No: $REG_NO"
echo "╚══════════════════════════════════════════════════════════════════════════╝"
echo ""

# --- Function to check package using apt/dpkg (Debian/Ubuntu) ---
check_dpkg() {
    local pkg=$1
    # dpkg -l lists installed packages, grep filters for exact match
    if dpkg -l | grep -q "^[[:space:]]*ii[[:space:]]*${pkg}"; then
        return 0  # Package found
    else
        return 1  # Package not found
    fi
}

# --- Function to check package using rpm (Red Hat/Fedora/CentOS) ---
check_rpm() {
    local pkg=$1
    # rpm -q queries if package is installed
    if rpm -q "$pkg" &>/dev/null; then
        return 0  # Package found
    else
        return 1  # Package not found
    fi
}

# --- Function to get package info from dpkg ---
get_dpkg_info() {
    local pkg=$1
    echo "--- Package Information (dpkg) ---"
    # Extract version, license, and description using dpkg and grep
    dpkg -l "$pkg" 2>/dev/null | tail -1 | awk '{print "Package: " $2 "\nVersion: " $3}'
    # Get description from apt-cache
    apt-cache show "$pkg" 2>/dev/null | grep -E "^Description:" | head -1
}

# --- Function to get package info from rpm ---
get_rpm_info() {
    local pkg=$1
    echo "--- Package Information (rpm) ---"
    # rpm -qi provides detailed package information
    rpm -qi "$pkg" 2>/dev/null | grep -E "Name|Version|License|Summary"
}

# --- Determine Package Manager and Check Installation ---
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Checking installation status for: $PACKAGE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Detect which package manager is available
if command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"
    if check_dpkg "$PACKAGE"; then
        INSTALLED=true
    else
        INSTALLED=false
    fi
elif command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"
    if check_rpm "$PACKAGE"; then
        INSTALLED=true
    else
        INSTALLED=false
    fi
else
    # Fallback: check using command -v (checks if command exists in PATH)
    PKG_MANAGER="command"
    if command -v "$PACKAGE" &>/dev/null; then
        INSTALLED=true
    else
        INSTALLED=false
    fi
fi

# --- Display Installation Status and Information ---
if [ "$INSTALLED" = true ]; then
    echo "✓ $PACKAGE is INSTALLED on this system"
    echo ""

    # Get detailed information based on package manager
    case $PKG_MANAGER in
        "dpkg")
            get_dpkg_info "$PACKAGE"
            ;;
        "rpm")
            get_rpm_info "$PACKAGE"
            ;;
        "command")
            # Use generic commands to get version
            echo "--- Package Information ---"
            echo "Command path: $(which $PACKAGE)"
            $PACKAGE --version 2>&1 | head -3
            ;;
    esac
else
    echo "✗ $PACKAGE is NOT INSTALLED on this system"
    echo ""
    echo "To install $PACKAGE:"
    if [ "$PKG_MANAGER" = "dpkg" ]; then
        echo "  sudo apt update && sudo apt install $PACKAGE"
    elif [ "$PKG_MANAGER" = "rpm" ]; then
        echo "  sudo dnf install $PACKAGE   (or: sudo yum install $PACKAGE)"
    else
        echo "  Please use your distribution's package manager"
    fi
fi

# --- Case Statement: Philosophical Notes about FOSS Packages ---
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "                    FOSS PHILOSOPHY CORNER"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Philosophical notes about open-source software (selected packages):"
echo ""

# Case statement to print philosophy notes based on package name
case "$PACKAGE" in
    python | python3)
        echo "🐍 PYTHON: 'Readability counts. Simple is better than complex.'"
        echo "   Python embodies the open-source spirit - a language built by community,"
        echo "   for community. Created by Guido van Rossum as a hobby project, it grew"
        echo "   into one of the world's most influential programming languages."
        echo "   The PSF License ensures it remains free and open for everyone."
        ;;
    httpd | apache2)
        echo "🌐 APACHE: The web server that built the open internet."
        echo "   Apache HTTP Server has powered the web since 1995, proving that"
        echo "   open-source can dominate even the most critical infrastructure."
        ;;
    mysql | mariadb)
        echo "🗄️  MySQL: Open source at the heart of millions of applications."
        echo "   From LAMP stacks to enterprise systems, MySQL demonstrates how"
        echo "   open-source databases can compete with proprietary alternatives."
        ;;
    firefox)
        echo "🦊 FIREFOX: A nonprofit fighting for an open web."
        echo "   Mozilla Firefox proves you don't need corporate profit motives"
        echo "   to build world-class software that respects user privacy."
        ;;
    vlc)
        echo "🎬 VLC: Plays anything - built by students in Paris."
        echo "   VideoLAN started as a student project and became the universal"
        echo "   media player, showing how academic freedom enables innovation."
        ;;
    git)
        echo "📦 GIT: The tool Linus built when proprietary failed him."
        echo "   Created in 2005 when BitKeeper revoked free access, Git shows"
        echo "   how necessity and open-source philosophy create powerful tools."
        ;;
    libreoffice)
        echo "📄 LIBREOFFICE: Born from a community fork - a real lesson."
        echo "   LibreOffice emerged when OpenOffice users forked the project,"
        echo "   demonstrating the GPL's power to protect community interests."
        ;;
    linux | kernel)
        echo "🐧 LINUX KERNEL: The foundation everything else runs on."
        echo "   Linus Torvalds' 'just for fun' project became the backbone of"
        echo "   modern computing - from phones to supercomputers."
        ;;
    *)
        echo "❓ $PACKAGE: Every open-source project has a story worth telling."
        echo "   Open-source software represents the collective wisdom of thousands"
        echo "   of contributors who chose to share rather than hoard knowledge."
        ;;
esac

# --- Extended Case Statement for Additional Packages ---
echo ""
echo "Additional FOSS philosophy notes:"
echo ""

# Loop through additional packages to show more philosophy notes
for pkg in git firefox vlc; do
    case $pkg in
        git)
            echo "  • Git: Distributed version control - because code freedom matters"
            ;;
        firefox)
            echo "  • Firefox: Privacy-focused browsing - the web should remain open"
            ;;
        vlc)
            echo "  • VLC: Universal media playback - codecs should be free"
            ;;
    esac
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Script execution completed at $(date '+%H:%M:%S')"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

exit 0
