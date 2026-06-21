# disabled fish's default greeting message
set fish_greeting

# PATH
fish_add_path ~/.local/bin/
fish_add_path ~/bin/
fish_add_path /home/talama/.spicetify
fish_add_path /home/talama/go/bin
fish_add_path /home/talama/.cargo/bin
fish_add_path /home/talama/.local/share/JetBrains/Toolbox/scripts

#ALIASES
alias .rl=". ~/.config/fish/config.fish" #source fish config.
alias ak='ANKI_NOHIGHDPI=1 anki'
alias cl='clear'

# dotfiles
alias .dot="cd ~/.dotfiles"
alias .fish="cd ~/.config/fish && nvim config.fish"
alias .nvim="cd ~/.config/nvim && nvim lua/config/lazy.lua"
alias .kitty="cd ~/.config/kitty && nvim kitty.conf"
alias .i3="cd ~/.config/i3 && nvim config"
alias .picom="cd ~/.config/picom && nvim picom.conf"
alias .rofi="cd ~/.config/rofi && nvim cofig.rasi"
alias .tmux="nvim ~/.tmux.conf"

# aliases
alias nv="nvim"
alias ff='set selected $(fzf --preview="bat --color=always {}") && [ -n "$selected" ] && nvim "$selected"'
alias ls "ls -p -G"
alias la "ls -A"
alias ll "eza -l -g --icons=always"
alias lla "ll -a"

alias tm "~/.tmux/tmux-sessionizer.sh"

#auto launch ssh-agent
keychain id_github --quiet --eval | source

# pnpm
set -gx PNPM_HOME "/home/talama/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

function starship_transient_prompt_func
    starship module character
end
starship init fish | source
enable_transience

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish

# uv
fish_add_path "/home/talama/.local/bin"
