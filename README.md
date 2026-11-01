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

File is loaded from `~/.local/share/ie/Lab.md` unless `IE_FILE` or `-f` changes it. The original `Lab.md` remains untouched. By default, the viewer removes Markdown-only punctuation escaping for clean copy/paste output and collapses blank lines inside shell continuation commands. Use `ie --raw skipfish` to inspect the original text. Commands are never executed.

## Organization

Notes are grouped by topic category using Markdown headings. Every original non-heading line, including all commands, parameters, addresses, and escaped characters, is preserved in its original order. `ie -h` lists the categories and topics.

## Safe display conversion

`ie skipfish` displays `\~` as `~`, `\_` as `_`, and Markdown-escaped `\\` as one literal backslash. Actual escapes such as `\n` and Windows paths remain intact. The source `Lab.md` is not rewritten.
