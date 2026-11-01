# ie : Linux lab command reference

A read-only offline viewer for `Lab.md`. It never runs any commands.

## Install or upgrade

```bash
chmod +x install.sh
./install.sh
```

The installer keeps your existing notes by default. To replace the installed notes with the bundled copy (after backing up the current copy to `Lab.md.backup`):

```bash
./install.sh --update-notes
```

Ensure `~/.local/bin` is on your `PATH`. On Kali with zsh:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## Usage

```bash
ie -h                  # numbered headings
ie bettercap           # view a heading
ie 42                  # view topic 42 (see ie -h for current numbers)
ie -s net.sniff        # find sections containing text
ie -i                  # interactive selection, type ? for list, q to quit
ie --help              # options
ie -f ~/Lab.md sqlmap  # use another file
```

File is loaded from `~/.local/share/ie/Lab.md` unless `IE_FILE` or `-f` changes it. Source lines are displayed verbatim (except heading banners); commands are not reformatted, validated, or executed.

## Organization

Notes are grouped by topic category using Markdown headings. Every original non-heading line, including all commands, parameters, addresses, and escaped characters, is preserved in its original order. `ie -h` lists the categories and topics.
