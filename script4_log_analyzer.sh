#!/bin/bash
# =============================================================
# Script 4: Log File Analyzer
# Author: Aayush Mittal| Course: Open Source Software
# Description: Reads a log file line by line, counts occurrences
#              of a keyword, handles missing/empty files, and
#              prints the last 5 matching lines.
# Usage: ./script4_log_analyzer.sh <logfile> [keyword]
# =============================================================

# --- Command-line arguments ---
# $1 = log file path (required), $2 = keyword (optional, defaults to "error")
LOGFILE=$1
KEYWORD=${2:-"error"}   # Use "error" as default if no keyword given

# --- Counter variable to track keyword matches ---
COUNT=0

echo "================================================================"
echo "              LOG FILE ANALYZER"
echo "================================================================"
echo "  Log file : ${LOGFILE:-[not specified]}"
echo "  Keyword  : $KEYWORD"
echo "----------------------------------------------------------------"

# --- Validate that a log file argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "[ERROR] No log file specified."
    echo "Usage: $0 <logfile> [keyword]"
    echo "Example: $0 /var/log/syslog error"
    exit 1
fi

# --- Do-while style retry: attempt to find/wait for a non-empty file ---
# Bash does not have native do-while; we simulate it with a loop + break
MAX_RETRIES=3  # Maximum number of retry attempts
RETRY=0        # Current retry count

while true; do
    # Check if file exists at all
    if [ ! -f "$LOGFILE" ]; then
        echo "[ERROR] File not found: $LOGFILE"
        RETRY=$((RETRY + 1))  # Increment retry counter

        # If we've exhausted retries, exit with an error
        if [ "$RETRY" -ge "$MAX_RETRIES" ]; then
            echo "[FAIL] File not found after $MAX_RETRIES attempts. Exiting."
            exit 1
        fi

        echo "[RETRY $RETRY/$MAX_RETRIES] Waiting 2 seconds before retry..."
        sleep 2   # Wait before retrying
        continue  # Go back to top of loop
    fi

    # Check if the file is empty
    if [ ! -s "$LOGFILE" ]; then
        echo "[WARN] File exists but is empty: $LOGFILE"
        RETRY=$((RETRY + 1))

        if [ "$RETRY" -ge "$MAX_RETRIES" ]; then
            echo "[FAIL] File remained empty after $MAX_RETRIES retries. Exiting."
            exit 1
        fi

        echo "[RETRY $RETRY/$MAX_RETRIES] File is empty, retrying in 2 seconds..."
        sleep 2
        continue
    fi

    # File exists and is non-empty — break out of the retry loop
    break
done

echo "[OK] File found and readable. Scanning..."
echo ""

# --- while-read loop: read the file line by line ---
# IFS= preserves leading/trailing whitespace in each line
# -r prevents backslash interpretation
while IFS= read -r LINE; do
    # if-then: check if this line contains the keyword (case-insensitive via -i)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))  # Increment counter for each matching line
    fi
done < "$LOGFILE"   # Redirect file into the while loop (not a pipe, preserves variables)

# --- Summary output ---
echo "  Total lines scanned : $(wc -l < "$LOGFILE")"
echo "  Keyword '$KEYWORD'  : found $COUNT time(s)"
echo ""

# --- Show the last 5 matching lines for context ---
echo "----------------------------------------------------------------"
echo "  Last 5 lines containing '$KEYWORD':"
echo "----------------------------------------------------------------"

# grep -i = case-insensitive | tail -5 = last 5 results
MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" | tail -5)

if [ -n "$MATCHES" ]; then
    # Loop through matched lines and print with indentation
    while IFS= read -r MATCH_LINE; do
        echo "  >> $MATCH_LINE"
    done <<< "$MATCHES"
else
    echo "  [NONE] No lines matched keyword '$KEYWORD'."
fi

echo "================================================================"
