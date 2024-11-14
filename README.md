<p align="center">
  <img src="https://github.com/user-attachments/assets/8c3f7403-d6be-40f4-8ec4-ee58d2572698" />
</p>


# Crack_Master: A Bash Hashcat Wrapper

## Description

Crack_Master is a Bash-based wrapper for [Hashcat](https://hashcat.net/hashcat/) that offers a streamlined, user-friendly interface for password-cracking tasks. This tool enables users to conduct various attack types—including wordlist, rule-based, brute-force, and hybrid attacks—through an intuitive, menu-driven interface. ![GitHub License](https://img.shields.io/github/license/ente0v1/Crack_Master)

> [!CAUTION]
> Crack_Master is provided as-is, without warranty. The author is not responsible for any misuse or damages incurred. Use responsibly and in accordance with all legal guidelines.

---

## Features
- Multiple attack types: wordlist, rules, brute-force, and hybrid attacks.
- Interactive menu for attack configuration and selection.
- Session restoration support for resuming interrupted sessions.
- Cross-platform compatibility (Linux and Windows).

## Installation & Setup

### Requirements

#### Linux:
- **OS**: Any major Linux distribution
- **Programs**:
  - **Hashcat**: Install from [hashcat.net](https://hashcat.net/hashcat/)
  - **Optional**: For WPA2 cracking, consider installing [aircrack-ng](https://www.aircrack-ng.org/), [hcxtools](https://github.com/zkryss/hcxtools), and [hcxdumptool](https://github.com/fg8/hcxdumptool).

**Install Commands**:
- **Debian/Ubuntu**:
  ```bash
  sudo apt update && sudo apt install hashcat aircrack-ng hcxtools hcxdumptool git
  ```
- **Fedora**:
  ```bash
  sudo dnf install hashcat aircrack-ng hcxtools hcxdumptool git
  ```
- **Arch Linux/Manjaro**:
  ```bash
  sudo pacman -S hashcat aircrack-ng hcxtools hcxdumptool git
  ```

#### Windows:
- **OS**: Windows 10 or later
- **Programs**:
  - **Hashcat**: Download from [hashcat.net](https://hashcat.net/hashcat/)
  - **Git Bash**: For a Linux-like terminal, install [Git Bash](https://git-scm.com/download/win)
  - **Optional**: For a more complete Linux environment, set up [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install)

> [!TIP]
> Recommended wordlists, rules, and masks: repositories like [SecLists](https://github.com/danielmiessler/SecLists) and [wpa2-wordlists](https://github.com/kennyn510/wpa2-wordlists.git). Store them in `Crack_Master` under `wordlists`, `rules`, and `masks` folders.

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
Capture WPA2 hashes using the [4-way handshake method](https://www.youtube.com/watch?v=WfYxrLaqlN8). Relevant capture scripts are provided in the `scripts` folder.

### Cracking the Hash
1. Rename the hash file to `hash.txt` and place it in the `Crack_Master` directory.
2. Run the cracking process:
   ```bash
   ./crackmaster.sh
   ```
3. Cracking results are saved in `logs/session.txt`.

<p align="center">
  <video src="https://github.com/user-attachments/assets/c756c4cd-6d22-4c49-a4aa-91fe07dda5d4" />
</p>

### Attack Modes
Crack_Master supports the following attack modes:
| # | Mode                 | Description                                                                                   |
|---|-----------------------|-----------------------------------------------------------------------------------------------|
| 0 | Straight              | Direct wordlist attack                                                                        |
| 1 | Combination           | Combines two dictionaries to create candidate passwords                                       |
| 3 | Brute-force           | Tries every possible password combination within the specified character set                  |
| 6 | Hybrid Wordlist + Mask| Uses a wordlist combined with a mask to generate variations                                   |
| 7 | Hybrid Mask + Wordlist| Uses a mask combined with a wordlist for generating password candidates                       |
| 9 | Association           | For specific hash types that combine known data with brute-force attempts                     |

---

## Menu Options
The main menu offers easy access to various cracking methods:
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

The `crackmaster.sh` script performs the following tasks:
1. **Initialization**: Loads default parameters and common functions.
2. **User Input**: Prompts for hash file location, wordlist, session name, and attack type.
3. **Command Construction**: Builds the Hashcat command based on user inputs and the selected attack type.
4. **Execution**: Runs the cracking session and displays live status updates.
5. **Logging**: Records session details and results in `logs` for future reference.

---

## Wordlist Manipulation Commands

Common bash commands for handling wordlists:
- **Remove duplicates**:
  ```bash
  awk '!(count[$0]++)' old.txt > new.txt
  ```
- **Sort by length**:
  ```bash
  awk '{print length, $0}' old.txt | sort -n | cut -d " " -f2- > new.txt
  ```
- **Sort alphabetically**:
  ```bash
  sort old.txt | uniq > new.txt
  ```
- **Merge files**:
  ```bash
  cat file1.txt file2.txt > combined.txt
  ```
- **Remove blank lines**:
  ```bash
  egrep -v "^[[:space:]]*$" old.txt > new.txt
  ```

---

## Help
For more resources, consider the following repositories:
- [wpa2-wordlists](https://github.com/kennyn510/wpa2-wordlists.git)
- [paroleitaliane](https://github.com/napolux/paroleitaliane)
- [SecLists](https://github.com/danielmiessler/SecLists)
- [hashcat-rules](https://github.com/Unic0rn28/hashcat-rules)

For more details on Hashcat’s attack modes and usage, consult the [Hashcat Wiki](https://hashcat.net/wiki/), [Radiotap Introduction](https://www.radiotap.org/), or [Aircrack-ng Guide](https://wiki.aircrack-ng.org/doku.php?id=airodump-ng).
