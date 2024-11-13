# Crack_Master: A Bash Hashcat Wrapper

<p align="center">
  <video src="https://github.com/user-attachments/assets/d1d129df-9ed3-412f-9d64-0432a074e863" />
</p>

## Description

Crack_Master is a Bash script wrapper for [Hashcat](https://hashcat.net/hashcat/), offering a simplified, user-friendly interface for various password cracking tasks. With Crack_Master, you can easily choose from wordlist, rule-based, brute-force, and hybrid attack methods through an interactive menu. ![GitHub License](https://img.shields.io/github/license/ente0v1/Crack_Master)

**Disclaimer:**  
This tool is provided as-is, without warranties. The author is not responsible for any damage or misuse. Use responsibly and in compliance with applicable laws.

---

## Features
- Multiple attack modes: wordlists, rules, brute-force, and hybrid attacks.
- Interactive menu interface for attack selection and configuration.
- Session restoration for interrupted cracking operations.
- Cross-platform support for Linux and Windows environments.

## Installation & Setup

### Requirements

#### Linux:
- **OS**: Any Linux distribution
- **Programs**:
  - **Hashcat**: Install from [hashcat.net](https://hashcat.net/hashcat/)
  - **Optional**: For WPA2 cracking, install additional tools like [aircrack-ng](https://www.aircrack-ng.org/), [hcxtools](https://github.com/zkryss/hcxtools), and [hcxdumptool](https://github.com/fg8/hcxdumptool).

**For Ubuntu/Debian:**
```bash
sudo apt update && sudo apt install hashcat aircrack-ng hcxtools hcxdumptool git
```

#### Windows:
- **OS**: Windows 10 or later
- **Programs**:
  - **Hashcat**: Download from [hashcat.net](https://hashcat.net/hashcat/)
  - **Git Bash**: For Linux-like terminal, install [Git Bash](https://git-scm.com/download/win)
  - **Optional**: For a full Linux environment, set up [WSL](https://docs.microsoft.com/en-us/windows/wsl/install)

#### Additional Resources:
- Recommended wordlists, rules, and masks: [SecLists](https://github.com/danielmiessler/SecLists) and [wpa2-wordlists](https://github.com/kennyn510/wpa2-wordlists.git). Store them in `Crack_Master` under `wordlists`, `rules`, and `masks` folders.

---

### Clone and Run Crack_Master
1. **Clone the repository**:
   ```bash
   git clone --depth 1 https://github.com/ente0v1/Crack_Master.git
   cd Crack_Master
   ```
2. **Download default wordlists and rules**:
   ```bash
   git clone https://github.com/ente0v1/hashcat-defaults
   git lfs install
   git pull
   cd ..
   cp -rf hashcat-defaults/* .
   sudo rm -r hashcat-defaults
   ```
3. **Run Crack_Master**:
   ```bash
   ./crackmaster.sh
   ```

---

## Usage Overview

### Capturing WPA2 Hashes
For WPA2 cracking, capture the hash using the [4-way handshake method](https://www.youtube.com/watch?v=WfYxrLaqlN8). Capture scripts are available in the `scripts` folder.

### Cracking the Hash
1. Rename the hash file to `hash.txt` and move it to the `Crack_Master` directory.
2. Run the cracking process:
   ```bash
   ./crackmaster.sh
   ```
3. Cracking results will be stored in `logs/session.txt`.

### Attack Modes
Crack_Master supports the following attack modes:
| # | Mode                 | Description                                                                                   |
|---|-----------------------|-----------------------------------------------------------------------------------------------|
| 0 | Straight              | Uses a wordlist directly to attempt cracks                                                    |
| 1 | Combination           | Combines two dictionaries to produce candidate passwords                                      |
| 3 | Brute-force           | Attempts every possible password combination based on a specified character set               |
| 6 | Hybrid Wordlist + Mask| Uses a wordlist combined with a mask to generate variations                                   |
| 7 | Hybrid Mask + Wordlist| Uses a mask combined with a wordlist for generating password candidates                       |
| 9 | Association           | For specific hash types where known data is combined with brute-force attempts                |

---

## Menu Options

The main menu provides easy access to various cracking methods:
| Option | Description                | Script |
|--------|----------------------------|--------|
| 1      | Crack with Wordlist        | Executes wordlist-based cracking |
| 2      | Crack with Rules           | Executes rule-based cracking |
| 3      | Crack with Brute-Force     | Executes brute-force cracking |
| 4      | Crack with Combinator      | Executes combinator cracking |
| Q      | Quit                       | Saves settings and logs, then exits |

### Example Commands
```bash
hashcat -a 0 -m 400 example400.hash example.dict              # Wordlist
hashcat -a 0 -m 0 example0.hash example.dict -r best64.rule   # Wordlist + Rules
hashcat -a 3 -m 0 example0.hash ?a?a?a?a?a?a                  # Brute-Force
hashcat -a 1 -m 0 example0.hash example.dict example.dict     # Combination
hashcat -a 9 -m 500 example500.hash 1word.dict -r best64.rule # Association
```

---

## Script Walkthrough

The `crackmaster.sh` script performs the following:
1. **Initialization**: Loads default parameters and necessary functions.
2. **User Input**: Prompts for the hash file location, wordlist, session name, and attack mode.
3. **Command Construction**: Builds the Hashcat command according to user inputs and selected attack mode.
4. **Execution**: Runs the cracking session and displays status output.
5. **Logging**: Saves session parameters and results to logs.

---

## Help
For more resources:
- [wpa2-wordlists](https://github.com/kennyn510/wpa2-wordlists.git)
- [SecLists](https://github.com/danielmiessler/SecLists)
- [Hashcat Wiki](https://hashcat.net/wiki/)

