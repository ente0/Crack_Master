# Crack_Master
A wrapper group of scripts for Hashcat: it can perform cracking operations by giving a user-friendly menu. ![GitHub](https://img.shields.io/github/license/ente0v1/CrackMaster)
<!--
![Test Image](./assets/pennybags.png)
-->
<!--
https://github.com/ente0v1/Crack_Master/assets/156426041/f085efaa-777b-40b3-8c82-a3ee1a8b360b
-->

## Disclaimer
This program is provided without warranties of any kind. The author assumes no responsibility for any damages resulting from the use of this software. We recommend that you use it only for lawful purposes and in accordance with local laws.

## Description
This Bash script provides a simple interface to perform cracking operations using Hashcat. It offers various options such as cracking with wordlists, rules, brute-force, and hybrid wordlist + mask attacks. To download it just go to the [Releases page](https://github.com/ente0v1/Crack_Master/releases).

## Features
- Crack passwords using wordlists, rules, or brute-force methods.
- Perform hybrid attacks combining wordlists and masks.
- Easy-to-use menu interface for selecting cracking options.
- Supports session restoration for interrupted cracking sessions.

## Requirements
- OS: Linux, Windows 10 or later
- Programs: [Hashcat](https://hashcat.net/hashcat/) and [Git Bash](https://git-scm.com/download/win) (if you are a Windows user)
- Resources: Wordlists, rules, and masks available in the specified paths

## Installation
**Command to clone (lightweight) repo**
```
git clone --depth 1 https://github.com/ente0v1/Crack_Master.git
cd Crack_Master
```
<!--
![Screenshot from 2024-05-27 02-50-05](https://github.com/ente0v1/Crack_Master/assets/156426041/09db3942-0e75-4561-acc7-51bf4e0b5444)
-->

- If you are on Windows, in order to execute Bash, simply download [Git Bash](https://git-scm.com/download/win) or [Kali Linux](https://apps.microsoft.com/detail/9pkr34tncv07?hl=en-us&gl=US) from Microsoft Store.
To begin, clone the repository using `git clone https://github.com/ente0v1/Crack_Master.git` in your $HOME directory, then navigate into the Crack_Master folder by typing `cd Crack_Master`. Proceed to move `hash.txt` in your repo root directory. 

- If you want to set default values, such as wordlists and rules comment `define_default_parameters` and uncomment `define_my_parameters` (in files suffixed with `crack-*`, finally go change variables in function "define_my_parameters" in `functions.sh`.

- To populate Crack_Master with wordlists and such, just execute:
```
cd Crack_Master
git clone https://github.com/ente0v1/hashcat-defaults
cd hashcat-defaults/
mv * ../Crack_Master
```

With these steps completed, you're now ready to run the script by executing `./crackmaster.sh`.

If you want to download new wordlists see [wordlists.txt](./wordlists.txt).

To implement Hashcat for Windows see [Hashcat Build Documentation](https://github.com/hashcat/hashcat/blob/master/BUILD.md) and refer to the [Official Homepage](https://hashcat.net/hashcat/).

## Usage

**Capturing a WPA2 hash**

In order to sniff EAPOL packets in the [4-way-handshake](https://notes.networklessons.com/security-wpa-4-way-handshake) see this [video](https://www.youtube.com/watch?v=WfYxrLaqlN8).
The commands shown in the video has been put in the folder `scripts`.

**Cracking the password**

To start the script log in as non-root user and rename your hash in `hash.txt`, move your hash into `Crack_Master` directory and execute: `./crackmaster.sh`.

At the end of the cracking you will see the results inside `logs`, just open `status.txt` in the session folder.

<!--![Screenshot from 2024-05-27 02-56-37](https://github.com/ente0v1/Crack_Master/assets/156426041/fb8237c0-33b0-42ab-b3ed-2b8f9a1cd20c)
-->
## Attacks

```
- [ Attack Modes ] -

  # | Mode
 ===+======
  0 | Straight
  1 | Combination
  3 | Brute-force
  6 | Hybrid Wordlist + Mask
  7 | Hybrid Mask + Wordlist
  9 | Association

- [ Basic Examples ] -

  Attack-          | Hash- |
  Mode             | Type  | Example command
 ==================+=======+==================================================================
  Wordlist         | $P$   | hashcat -a 0 -m 400 example400.hash example.dict
  Wordlist + Rules | MD5   | hashcat -a 0 -m 0 example0.hash example.dict -r rules/best64.rule
  Brute-Force      | MD5   | hashcat -a 3 -m 0 example0.hash ?a?a?a?a?a?a
  Combinator       | MD5   | hashcat -a 1 -m 0 example0.hash example.dict example.dict
  Association      | $1$   | hashcat -a 9 -m 500 example500.hash 1word.dict -r rules/best64.rule

```

-> from [Hashcat Wiki](https://hashcat.net/wiki/doku.php?id=hashcat)


## Script Breakdown
The `crack-rule.sh` script do password cracking using a combination of a wordlist and a set of rules. Here's a step-by-step breakdown:

**Initialization**
  - Loads functions from a separate file (`functions.sh`), containing reusable functionalities used throughout the script.
  - Sets default values for various parameters like script paths, session names, wordlists, and rules.
  - Checks for existing restore files (potentially from previous cracking sessions) in a designated directory. If any are found, it lists their names.
  - Prompts the user to choose a restore file to resume an earlier session (optional).

**User Interaction**
  - Asks the user to define a name for the current cracking session (with a default option).
  - Prompts the user for the directory containing wordlists (with a default option).
  - Lists available wordlist files within the specified directory.
  - Asks the user to select a specific wordlist from the available ones (with a default option).
  - Prompts the user to choose a rule file containing password cracking rules (with a default option).
  - Optionally asks the user if they want to update screen every 2 seconds during cracking (showing progress updates).

**Command Construction and Display**
  - Constructs the actual hashcat command to be executed based on the user's choices and script defaults. This command defines various parameters for the cracking process.
  - Displays the constructed hashcat command for the user to review the cracking configuration.

**Hashcat Execution**
  - Checks the user's decision about the status timer.
  - If the user opted for a timer ("y"), the script executes hashcat with --status --status-timer=2 options. These options provide real-time updates on the cracking progress.
  - Otherwise, hashcat is executed without the status timer.

**Saving Results**
  - Calls a function named save_settings (defined in `functions.sh`). This function stores details about the successful cracking session, such as the session name, chosen wordlist path and name, rule name, etc.
  - Calls another function named save_logs (defined in `functions.sh`). This function organizes and saves data and logs generated during the cracking process.
<!--
```
- [ Crack Menu ] -

  Option                      | -> Action
 =============================+=============================================================
  1. Crack with Wordlist      | -> Execute crack-wordlist script
  2. Crack with Rules         | -> Execute crack-rule script
  3. Crack with Brute-Force   | -> Execute crack-bruteforce script
  4. Crack with Combinator    | -> Execute crack-combo script
  Q. (Quit)                   | -> Save Successful Settings -> Save Logs -> Exit
  (Invalid Option)            | -> Display Invalid Option Message -> Show Menu again
```
-->

## Cracking options in-depth
**Menu Options workflow**

Here's a detailed explanation on how code is made:
1. Hybrid Wordlist + Mask Cracking:
  - This script specifically handles cracking with a combination of a wordlist and a mask.
  - The mask allows generating variations of words from the wordlist using placeholders like ?a?a?a which represent characters.

2. User Prompts and Inputs:
  - The script retrieves available sessions for potential restoration.
  - It prompts the user for various inputs:
    - Restore file name (optional)
    - Session name (defaults to $default_session)
    - Wordlist path (defaults to $default_wordlists)
    - Wordlist name (defaults to $default_wordlist)
    - Mask (defaults to $default_mask)
    - Whether to use a status timer (prompts for "y" or "n")
    - Minimum password length (defaults to $default_min_length)
    - Maximum password length (defaults to $default_max_length)
  
3. Hashcat Command Construction:
  - The script constructs the hashcat command based on user inputs and default values.
  - Here's a breakdown of the important options:
    - --session="$session": Creates or resumes a session named $session
    - --increment --increment-min="$min_length" --increment-max="$max_length": Enables password length incrementing within the specified range.
    - -m 22000: Specifies the hash mode (for a specific hash type)
    - hash: Path to the hash file containing the password hash
    - -a 6: Sets the attack mode to hybrid wordlist + mask (mode 6)
    - -w 4: Sets workload of cracking devices. See `hashcat -I`
    - --outfile-format=2: Specifies output format for cracked passwords
    - -o plaintext.txt: Output file for cracked passwords
    - "$wordlist_path/$wordlist": Path to the chosen wordlist
    - "mask": The mask string to generate password variations

4. Conditional Hashcat Execution:
  - The script checks the user's choice for a status timer:
    - If "y", it executes hashcat with --status --status-timer=2 options, providing real-time status updates every 2 seconds.
    - Otherwise, it executes hashcat without the status timer.

5. Saving Results:
  - The script calls save_settings to store details about the successful cracking session (session name, wordlist path, wordlist name, mask, etc.).
  - It calls save_logs to organize and store session data and logs.

## Useful one-liners for wordlist manipulation (from [wpa2-wordlists](https://github.com/kennyn510/wpa2-wordlists.git))
Remove duplicates:
```
awk '!(count[$0]++)' old.txt > new.txt
```
Sort by length:
```
awk '{print length, $0}' old.txt | sort -n | cut -d " " -f2- > new.txt
```
Sort by alphabetical order:
```
sort old.txt | uniq > new.txt
```
Merge multiple text files into one:
```
cat file1.txt file2.txt > combined.txt
```
Remove all blank lines:
```
egrep -v "^[[:space:]]*$" old.txt > new.txt
```

## Help
If you want to get more resources take a look at:
  [wpa2-wordlists](https://github.com/kennyn510/wpa2-wordlists.git), [paroleitaliane](https://github.com/napolux/paroleitaliane), [SecLists](https://github.com/danielmiessler/SecLists), [hashcat-rules](https://github.com/Unic0rn28/hashcat-rules).
  
  Also if you want more information about how hashcat's attack methods work, I recommend reading the official [Hashcat Wiki](https://hashcat.net/wiki/), the [Radiotap introduction](https://www.radiotap.org/) and [airdump-ng guide](https://wiki.aircrack-ng.org/doku.php?id=airodump-ng).
