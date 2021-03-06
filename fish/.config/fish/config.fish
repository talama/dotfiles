# disabled fish's default greeting message
set fish_greeting

# PATH
fish_add_path ~/.local/bin/
fish_add_path /home/talama/.spicetify
fish_add_path /home/talama/.cargo/bin

#ALIASES
alias .rl=". ~/.config/fish/config.fish" #source fish config.
alias ak='ANKI_NOHIGHDPI=1 anki'
alias cl='clear'

# Exa
if type -q exa
  alias ll "exa -l --git --icons" 
  alias lla "ll -a"
end

# dotfiles
alias .dot="cd ~/.dotfiles"
alias .fish="cd ~/.config/fish && nvim config.fish"
alias .nvim="cd ~/.config/nvim && nvim lua/talama/plugins.lua"
alias .kitty="cd ~/.config/kitty && nvim kitty.conf"
alias .i3="cd ~/.config/i3 && nvim config"
alias .picom="cd ~/.config/picom && nvim picom.conf"
# vim
alias nv="nvim"
alias g="git"
