<!--
<p align="center">
  <img src="https://github.com/user-attachments/assets/3354a13f-45ad-4528-b2dd-0ba6dc50c5b6" />
</p>
-->



<div align="center">
  
# Crack_Master: Automate Hashcat - deprecated
<p align="center">
  <img src="https://img.shields.io/github/license/ente0/Crack_Master">
  <img src="https://img.shields.io/badge/language-shell-green" alt="Language: Shell">
  <img src="https://img.shields.io/badge/dependencies-hashcat--aircrack--hcxtools--hcxdumptool-green" alt="Dependencies">
  
  <a href="https://github.com/ente0/Crack_Master/releases">
    <img src="https://img.shields.io/badge/build-v1.4.1-blue" alt="Build Version">
  </a>

</p>

### **A Shell-based wrapper for [Hashcat](https://hashcat.net/hashcat/), that offers a streamlined, user-friendly interface for password-cracking tasks. This tool enables users to conduct various attack types—including wordlist, rule-based, brute-force, and hybrid attacks—through an intuitive, menu-driven interface.** 

</div>

> [!CAUTION]
> This tool is provided "as-is," without any express or implied warranties. The author assumes no responsibility for any damages, losses, or consequences arising from the use of this tool. It is specifically designed for penetration testing purposes, and should only be used in legal and authorized environments, such as with explicit permission from the system owner. Unauthorized use or misuse of this tool, in violation of applicable laws, is strictly prohibited. Users are strongly advised to comply with all relevant local, national, and international laws and obtain proper authorization before performing any security assessments.

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
   git clone --depth 1 https://github.com/ente0/Crack_Master.git
   ```
2. **Place the hash**:
   ```bash
   cp hash.txt Crack_Master
   ```
3. **Run Crack_Master**:
   ```bash
   cd Crack_Master
   ./crackmaster.sh
   ```

<p align="center">
  <video src="https://github.com/user-attachments/assets/c756c4cd-6d22-4c49-a4aa-91fe07dda5d4" />
</p>
    
>[!TIP]
> **(Optional) Download default wordlists and rules**:
   ```bash
   git clone https://github.com/ente0/hashcat-defaults
   git lfs install
   git pull
   cd ..
   cp -rf hashcat-defaults/* .
   sudo rm -r hashcat-defaults
   ```

## Latest Releases
For the latest release versions of hashCrack, visit the [Crack_Master Releases](https://github.com/ente0v1/Crack_Master/releases) page.

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
|------------|----------------------------|--------|
| 1 (Mode 0) | Crack with Wordlist        | Executes wordlist-based cracking |
| 2 (Mode 9) | Crack with Rules           | Executes rule-based cracking |
| 3 (Mode 3) | Crack with Brute-Force     | Executes brute-force cracking |
| 4 (Mode 6) | Crack with Combinator      | Executes hybrid wordlist + mask cracking |
| Q          | Quit                       | Saves settings and logs, then exits |

### Example Commands
```bash
hashcat -a 0 -m 400 example400.hash example.dict              # Wordlist
hashcat -a 0 -m 0 example0.hash example.dict -r best64.rule   # Wordlist + Rules
hashcat -a 3 -m 0 example0.hash ?a?a?a?a?a?a                  # Brute-Force
hashcat -a 1 -m 0 example0.hash example.dict example.dict     # Combination
hashcat -a 9 -m 500 example500.hash 1word.dict -r best64.rule # Association
```
---
## Troubleshooting Hashcat Issues

If you encounter errors when running Hashcat, you can follow these steps to troubleshoot:

1. **Test Hashcat Functionality**:
   First, run a benchmark test to ensure that Hashcat is working properly:
   ```bash
   hashcat -b
   ```
   This command will perform a benchmark on your system to check Hashcat's overall functionality. If this command works without issues, Hashcat is likely properly installed.

2. **Check Available Devices**:
   To verify that Hashcat can detect your devices (such as GPUs) for cracking, use the following command:
   ```bash
   hashcat -I
   ```
   This command will list the available devices. Ensure that the correct devices are listed for use in cracking.

3. **Check for Errors in Hashcat**:
   If the cracking process fails or Hashcat doesn't seem to recognize your devices, running the above tests should help identify potential problems with your system configuration, such as missing or incompatible drivers.

4. **Permissions**:
   If you encounter permission issues (especially on Linux), consider running Hashcat with elevated privileges or configuring your user group correctly for GPU access. You can run Hashcat with `sudo` if necessary:
   ```bash
   sudo hashcat -b
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

### Support

To report bugs, issues, or feature requests, please open a new issue on [GitHub Issues](https://github.com/ente0/Crack_Master/issues).

For further questions or assistance, contact us via [email](mailto:enteo.dev@protonmail.com).

For more resources, consider the following repositories:
- [hashcat-defaults](https://github.com/ente0v1/hashcat-defaults)
- [wpa2-wordlists](https://github.com/kennyn510/wpa2-wordlists.git)
- [paroleitaliane](https://github.com/napolux/paroleitaliane)
- [SecLists](https://github.com/danielmiessler/SecLists)
- [hashcat-rules](https://github.com/Unic0rn28/hashcat-rules)


To capture WPA2 hashes, follow [this guide on the 4-way handshake](https://notes.networklessons.com/security-wpa-4-way-handshake) and see this [video](https://www.youtube.com/watch?v=WfYxrLaqlN8) to see how the attack actually works.
For more details on Hashcat’s attack modes and usage, consult the [Hashcat Wiki](https://hashcat.net/wiki/), [Radiotap Introduction](https://www.radiotap.org/), or [Aircrack-ng Guide](https://wiki.aircrack-ng.org/doku.php?id=airodump-ng).
