#!/bin/bash
# =============================================================================
# Script 3: Disk and Permission Auditor
# Author: Aayush Mittal | Course: Open Source Software
# Registration No: 24BAI10251
# Description: This script loops through important system directories and
#              reports disk usage, owner, and permissions. It also specifically
#              checks Python-related directories for the audit.
# Concepts Used: for loop, arrays, df command, ls -ld, awk, cut,
#                conditional tests (-d, -f), du command
# =============================================================================

# --- Configuration ---
AUTHOR="Aayush Mittal"
REG_NO="24BAI10251"
SOFTWARE="Python"

# --- Header Display ---
echo "╔══════════════════════════════════════════════════════════════════════════╗"
echo "║                    DISK AND PERMISSION AUDITOR                            ║"
echo "║                    Author: $AUTHOR | Reg No: $REG_NO"
echo "╚══════════════════════════════════════════════════════════════════════════╝"
echo ""

# --- Define Directories to Audit ---
# Array of important system directories to check
SYSTEM_DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/local" "/opt")

# --- Function to convert permission octal to symbolic notation explanation ---
explain_permissions() {
    local perms=$1
    local explanation=""
    
    # User permissions
    user_perm="${perms:1:3}"
    # Group permissions
    group_perm="${perms:4:3}"
    # Others permissions
    other_perm="${perms:7:3}"
    
    echo "User: $user_perm | Group: $group_perm | Others: $other_perm"
}

# --- Function to get directory information ---
get_dir_info() {
    local dir=$1
    
    # Check if directory exists using -d test
    if [ ! -d "$dir" ]; then
        echo "❌ $dir does not exist on this system"
        return 1
    fi
    
    # Get detailed listing using ls -ld (directory itself, not contents)
    # Using awk to extract specific fields
    local perms=$(ls -ld "$dir" 2>/dev/null | awk '{print $1}')
    local owner=$(ls -ld "$dir" 2>/dev/null | awk '{print $3}')
    local group=$(ls -ld "$dir" 2>/dev/null | awk '{print $4}')
    
    # Get directory size using du command
    # -s for summary, -h for human-readable format
    # 2>/dev/null suppresses permission denied errors
    local size=$(du -sh "$dir" 2>/dev/null | cut -f1)
    
    # Handle case where size couldn't be determined
    if [ -z "$size" ]; then
        size="Access Denied"
    fi
    
    # Display the information
    printf "%-15s | Size: %-10s | Owner: %-8s | Group: %-8s | Perms: %s\n" \
           "$dir" "$size" "$owner" "$group" "$perms"
}

# --- Section 1: System Directory Audit ---
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "                    SECTION 1: SYSTEM DIRECTORY AUDIT"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Directory       | Size        | Owner     | Group    | Permissions"
echo "────────────────────────────────────────────────────────────────────────────"

# For loop through system directories
for DIR in "${SYSTEM_DIRS[@]}"; do
    get_dir_info "$DIR"
done

echo ""

# --- Section 2: Python-Specific Directories Audit ---
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "                    SECTION 2: PYTHON DIRECTORIES AUDIT"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Python-specific directories to check
PYTHON_DIRS=(
    "/usr/lib/python3"
    "/usr/lib/python3.11"
    "/usr/lib/python3.12"
    "/usr/local/lib/python3"
    "/etc/python3"
    "$HOME/.local/lib/python"
    "$HOME/.local/bin"
)

echo "Python Installation Directories:"
echo "────────────────────────────────────────────────────────────────────────────"

# For loop through Python directories
for DIR in "${PYTHON_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Directory exists - show details
        PERMS=$(ls -ld "$DIR" 2>/dev/null | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" 2>/dev/null | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" 2>/dev/null | awk '{print $4}')
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        
        printf "✓ %-30s | %s | %s:%s | %s\n" "$DIR" "$SIZE" "$OWNER" "$GROUP" "$PERMS"
    else
        printf "✗ %-30s | Not found\n" "$DIR"
    fi
done

echo ""

# --- Section 3: Python Binary and Executable Check ---
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "                    SECTION 3: PYTHON EXECUTABLES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check Python executables
PYTHON_EXECUTABLES=("python" "python3" "python2" "pip" "pip3")

echo "Executable      | Location                               | Permissions"
echo "────────────────────────────────────────────────────────────────────────────"

for EXEC in "${PYTHON_EXECUTABLES[@]}"; do
    # Check if command exists
    if command -v "$EXEC" &>/dev/null; then
        LOCATION=$(which "$EXEC")
        # Check if it's a file (not alias or function)
        if [ -f "$LOCATION" ]; then
            PERMS=$(ls -l "$LOCATION" 2>/dev/null | awk '{print $1}')
            printf "%-15s | %-38s | %s\n" "$EXEC" "$LOCATION" "$PERMS"
        else
            printf "%-15s | %-38s | (alias/function)\n" "$EXEC" "$LOCATION"
        fi
    else
        printf "%-15s | Not installed\n" "$EXEC"
    fi
done

echo ""

# --- Section 4: Disk Space Summary ---
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "                    SECTION 4: DISK SPACE SUMMARY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Display filesystem disk usage
echo "Filesystem Disk Usage:"
echo ""
df -h | head -1  # Print header
df -h | grep -E "^/dev|^tmpfs|^overlay"  # Filter for relevant filesystems

echo ""

# --- Section 5: Security Analysis ---
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "                    SECTION 5: SECURITY ANALYSIS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check for world-writable directories (potential security risk)
echo "Checking for world-writable directories (potential security concern):"
echo ""

WORLD_WRITABLE=0
for DIR in "${SYSTEM_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Check if directory is world-writable
        if [ -w "$DIR" ] && [ "$(ls -ld "$DIR" | awk '{print $1}' | grep -c 'w.$')" -gt 0 ]; then
            # More precise check for world-writable
            PERMS=$(ls -ld "$DIR" | awk '{print $1}')
            if [[ "$PERMS" == *"w"* ]] && [[ "${PERMS: -1}" == "w" || "${PERMS: -1}" == "t" ]]; then
                echo "⚠️  $DIR is potentially world-writable: $PERMS"
                ((WORLD_WRITABLE++))
            fi
        fi
    fi
done

# Check /tmp specifically (expected to be world-writable with sticky bit)
if [ -d "/tmp" ]; then
    TMP_PERMS=$(ls -ld /tmp | awk '{print $1}')
    echo ""
    echo "Note: /tmp permissions: $TMP_PERMS"
    echo "  (World-writable with sticky bit is expected and secure for /tmp)"
fi

echo ""
if [ $WORLD_WRITABLE -eq 0 ]; then
    echo "✓ No unexpected world-writable directories found"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Audit completed at $(date '+%H:%M:%S on %d/%m/%Y')"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

exit 0
