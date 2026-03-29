#!/bin/bash
# =============================================================
# Script 5: Open Source Manifesto Generator
# Author: Aayush Mittal | Course: Open Source Software
# Description: Interactively generates a personalised open-source
#              philosophy statement from user responses and saves
#              it to a .txt file.
# =============================================================

# --- Alias demonstration (as a comment, since aliases do not export to scripts) ---
# In a normal shell session, a user might set:
#   alias manifesto='bash ~/scripts/script5_manifesto_generator.sh'
# This would allow running the script simply by typing: manifesto
# Aliases are shell conveniences — they do not persist in child scripts.

echo "================================================================"
echo "      OPEN SOURCE MANIFESTO GENERATOR"
echo "      Powered by your beliefs, not a corporation."
echo "================================================================"
echo ""
echo "Answer three questions honestly to generate your personal"
echo "open-source philosophy manifesto."
echo ""

# --- read: capture user input interactively ---
# -p displays a prompt inline before reading input
read -p "1. Name one open-source tool you use every day: " TOOL
read -p "2. In one word, what does 'freedom' mean to you? " FREEDOM
read -p "3. Name one thing you would build and share freely: " BUILD

# --- Variables for metadata ---
DATE=$(date '+%d %B %Y')          # e.g. "20 March 2026"
AUTHOR=$(whoami)                   # Username of the person running the script
OUTPUT="manifesto_${AUTHOR}.txt"  # Output filename derived from username

echo ""
echo "Generating your manifesto..."
echo ""

# --- String concatenation to compose the manifesto paragraph ---
# Using heredoc (<<) for clean multi-line string writing
# > creates/overwrites the file; >> appends (used for subsequent lines)

# Write the manifesto to the output file
{
    echo "================================================================"
    echo "  MY OPEN SOURCE MANIFESTO"
    echo "  Author : $AUTHOR"
    echo "  Date   : $DATE"
    echo "================================================================"
    echo ""
    echo "I am a part of a world built on openness. Every day, I rely on"
    echo "$TOOL — a tool that someone chose to build in the open and share"
    echo "freely, not for profit, but because they believed that knowledge"
    echo "belongs to everyone. That act of generosity shapes everything I do."
    echo ""
    echo "To me, freedom means $FREEDOM. In the context of software, that"
    echo "word is not abstract — it is the right to read the code that runs"
    echo "my computer, to change it when it does not serve me, and to share"
    echo "those changes with others who might benefit. Without that freedom,"
    echo "technology becomes a cage instead of a tool."
    echo ""
    echo "I commit to contributing to this tradition. One day, I will build"
    echo "$BUILD and release it openly — not to gain credit, but because"
    echo "the open-source community gave me everything I know, and the only"
    echo "honest response to that gift is to pass it forward."
    echo ""
    echo "The software I write will be free as in freedom."
    echo ""
    echo "  — $AUTHOR, $DATE"
    echo "================================================================"
} > "$OUTPUT"   # > redirects the entire block output into the file

# --- Confirm and display the saved manifesto ---
echo "Manifesto saved to: $OUTPUT"
echo ""

# cat: display the file contents to the terminal
cat "$OUTPUT"
