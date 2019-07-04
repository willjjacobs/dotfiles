#!/usr/bin/env bash

source ~/.bash_prompt;
source ~/.aliases;

# Environment Exports

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

#TODO: call vim if inside terminal
# Make sublime-text the default editor if available, otherwise vim.
if dpkg -l sublime-text >/dev/null; then
  export EDITOR='subl';
else
  export EDITOR='vim';
fi;

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';
# Save each command to the history before displaying the subsequent prompt
export PROMPT_COMMAND="history -a"
# Patterns matched against commands to be excluded from saving
export HISTIGNORE="clear:exit:history"

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Try to autocorrect typos during directory completion
shopt -s dirspell;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Try and save multi-line commands as a single entry
shopt -s cmdhist;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# TODO: fix for linux
# Add `killall` tab completion for common apps
# complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;
