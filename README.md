# Open Source Audit Project

**Course:** Open Source Software | **Capstone Project**

---

## Student Information

| Field | Details |
|-------|---------|
| **Name** | Aayush Mittal |
| **Registration Number** | 24BAI10251 |
| **Date of Submission** | 31.03.2026 |
| **Slot** | A24 |
| **Chosen Software** | Python |

---

## Project Overview

This repository contains the capstone project for the Open Source Software course. The project involves a comprehensive audit of **Python**, one of the world's most influential open-source programming languages. The audit covers the origin story, license analysis, ethical considerations, Linux footprint, and comparison with proprietary alternatives.

---

## Repository Structure

```
oss-audit-24bai10251/
│
├── README.md                           # This file - Project documentation
│
├── script1_system_identity.sh          # Script 1: System Identity Report
│
├── script2_foss_package_inspector.sh   # Script 2: FOSS Package Inspector
│
├── script3_disk_permission_auditor.sh  # Script 3: Disk and Permission Auditor
│
├── script4_log_file_analyzer.sh        # Script 4: Log File Analyzer
│
└── script5_manifesto_generator.sh      # Script 5: Open Source Manifesto Generator
```

---

## Scripts Description

### Script 1: System Identity Report (`script1_system_identity.sh`)

**Purpose:** Displays a comprehensive welcome screen with system information including Linux distribution, kernel version, current user, uptime, and open-source license information.

**Features:**
- Detects Linux distribution automatically
- Shows kernel version and system uptime
- Displays current user and home directory
- Checks Python installation status
- Shows OS license information

**Shell Concepts Used:**
- Variables and command substitution `$()`
- `echo` for output formatting
- Conditional statements for distribution detection
- uname, whoami, uptime, date commands

---

### Script 2: FOSS Package Inspector (`script2_foss_package_inspector.sh`)

**Purpose:** Checks if Python is installed on the system, retrieves version and license information, and displays philosophical notes about various FOSS packages.

**Features:**
- Detects package manager (dpkg/rpm)
- Shows package version, license, and description
- Case statement for FOSS philosophy notes
- Installation instructions if package not found

**Shell Concepts Used:**
- `if-then-else` conditional statements
- `case` statement for multiple conditions
- `rpm -qi` and `dpkg -l` package queries
- Pipe with `grep` for filtering
- Functions for code organization

---

### Script 3: Disk and Permission Auditor (`script3_disk_permission_auditor.sh`)

**Purpose:** Audits important system directories for disk usage, permissions, and ownership. Specifically checks Python-related directories for the audit.

**Features:**
- Scans multiple system directories
- Shows disk usage, owner, and permissions
- Python-specific directory audit
- Security analysis for world-writable directories
- Disk space summary

**Shell Concepts Used:**
- `for` loops with arrays
- `du` for disk usage
- `ls -ld` for directory permissions
- `awk` and `cut` for text processing
- `df -h` for filesystem information

---

### Script 4: Log File Analyzer (`script4_log_file_analyzer.sh`)

**Purpose:** Reads log files line by line, counts occurrences of specified keywords (ERROR, WARNING, etc.), and provides detailed analysis with context.

**Features:**
- Keyword counting with case-insensitive search
- Multi-keyword analysis
- Python-related log entry detection
- Last matching lines display
- File validation and error handling

**Shell Concepts Used:**
- `while read` loop with IFS
- Command-line arguments `$1`, `$2`
- Counter variables
- `grep` with `-i` for case-insensitive search
- `tail` for displaying last lines

---

### Script 5: Open Source Manifesto Generator (`script5_manifesto_generator.sh`)

**Purpose:** Interactive script that asks the user three questions and generates a personalized open-source philosophy statement saved to a text file.

**Features:**
- Interactive user input with `read`
- Input validation
- Personalized manifesto generation
- Timestamped output files
- Four Freedoms declaration

**Shell Concepts Used:**
- `read -p` for interactive input
- String concatenation
- File redirection `>` and `>>`
- `date` command for timestamps
- `cat` with heredoc for multi-line text
- Alias concept (explained in comments)

---

## Requirements

### System Requirements
- Linux operating system (any distribution)
- Bash shell (version 4.0 or higher recommended)
- Standard Linux utilities (coreutils)

### Dependencies
The scripts use standard Linux utilities that are typically pre-installed:

| Utility | Purpose | Usually Available |
|---------|---------|-------------------|
| `bash` | Shell interpreter | ✓ Yes |
| `grep` | Pattern matching | ✓ Yes |
| `awk` | Text processing | ✓ Yes |
| `sed` | Stream editor | ✓ Yes |
| `du` | Disk usage | ✓ Yes |
| `df` | Disk free space | ✓ Yes |
| `uname` | System information | ✓ Yes |
| `wc` | Word/line count | ✓ Yes |

### Optional Dependencies
- `python3` - For Python-specific checks
- `dpkg` or `rpm` - For package information (depends on distribution)

---

## Installation & Usage

### Step 1: Clone the Repository

```bash
# Clone from GitHub
git clone https://github.com/aayush29xd/oss-audit-24bai10251.git

# Navigate to the repository
cd oss-audit-24bai10251
```

### Step 2: Make Scripts Executable

```bash
# Make all scripts executable
chmod +x script*.sh

# Or make each script individually executable
chmod +x script1_system_identity.sh
chmod +x script2_foss_package_inspector.sh
chmod +x script3_disk_permission_auditor.sh
chmod +x script4_log_file_analyzer.sh
chmod +x script5_manifesto_generator.sh
```

### Step 3: Run the Scripts

#### Script 1: System Identity Report
```bash
./script1_system_identity.sh
```

#### Script 2: FOSS Package Inspector
```bash
./script2_foss_package_inspector.sh
```

#### Script 3: Disk and Permission Auditor
```bash
./script3_disk_permission_auditor.sh
```

#### Script 4: Log File Analyzer
```bash
# Basic usage (searches for 'error' by default)
./script4_log_file_analyzer.sh /var/log/syslog

# Search for specific keyword
./script4_log_file_analyzer.sh /var/log/syslog warning

# Search for ERROR (case-insensitive)
./script4_log_file_analyzer.sh /var/log/kern.log ERROR
```

#### Script 5: Open Source Manifesto Generator
```bash
./script5_manifesto_generator.sh
```

---

## Testing the Scripts

### Quick Test All Scripts
```bash
# Run Script 1
./script1_system_identity.sh

# Run Script 2
./script2_foss_package_inspector.sh

# Run Script 3
./script3_disk_permission_auditor.sh

# Run Script 4 (create a test log first)
echo -e "INFO: System started\nERROR: Test error\nWARNING: Test warning\nERROR: Another error" > test.log
./script4_log_file_analyzer.sh test.log error

# Run Script 5 (interactive)
./script5_manifesto_generator.sh
```

---

## About Python (Chosen Software)

**Python** is a high-level, interpreted programming language created by **Guido van Rossum** and first released in 1991. It has become one of the most popular programming languages worldwide, known for its clear syntax and readability.

### Key Facts

| Aspect | Details |
|--------|---------|
| **License** | PSF License (Python Software Foundation License) |
| **First Released** | February 1991 |
| **Creator** | Guido van Rossum |
| **Current Version** | Python 3.12+ |
| **Website** | [python.org](https://www.python.org) |
| **Repository** | [github.com/python/cpython](https://github.com/python/cpython) |

### The PSF License
Python is released under the PSF License, which is a permissive open-source license similar to MIT and BSD licenses. It allows:
- Free use for any purpose
- Modification and distribution
- Commercial use
- No copyleft requirements (unlike GPL)

---

## License

All scripts in this repository are released for educational purposes as part of the Open Source Software course capstone project.

The project report and documentation are original work by **Aayush Mittal** (Registration No: 24BAI10251).

---

## References

- [Python Official Website](https://www.python.org)
- [Python Software Foundation](https://www.python.org/psf/)
- [The Linux Command Line](https://linuxcommand.org/)
- [GNU Bash Manual](https://www.gnu.org/software/bash/manual/)
- [Free Software Foundation](https://www.fsf.org/)
- [Open Source Initiative](https://opensource.org/)

---

## Contact

For questions about this project:
- **Name:** Aayush Mittal
- **Registration Number:** 24BAI10251
- **Course:** Open Source Software

---

*"Talk is cheap. Show me the code." — Linus Torvalds*

*"Python is an experiment in how much freedom programmers need." — Guido van Rossum*
