# maildirarchive.sh
Very simple Maildir archiver. Solves the task of moving an entire Maildir to a subfolder of another Maildir. Useful e.g. if an employee leaves the organization and you want to copy his/her Maildir to your archive.

## Configuration
Some configuration options are available in the script. In most cases, you probably want to customize other parts of the script as well.

## Usage

Copy script, customize options and further parts of the script to meet your needs.

```bash
maildirarchive.sh <username>
```

## Features
- Removes `.` in original Maildir name. E.g. if you used `<firstname>.<lastname>` as folder name.
- Only moves non-empty folders
- Skips a list of mostly worthless folders, e.g. `Trash, Junk, ...` (needs customization)
- Deletes(!) the old folder if `enable_cleanup=1`
- Sets the owner and group of the newly created folders (needs customization)

## Things that might be useful in the future
- Update subscription file, subscribe to new folders