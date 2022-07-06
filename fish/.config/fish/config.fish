# disabled fish's default greeting message
set fish_greeting

# Exa
if type -q exa
  alias ll "exa -l --git --icons" 
  alias lla "ll -a"
end

#ALIASES
alias .rl=". ~/.config/fish/config.fish" #source fish config.
alias ak='ANKI_NOHIGHDPI=1 anki'

# dotfiles
alias .dot="cd ~/.dotfiles"
alias .fish="cd ~/.config/fish && nvim config.fish"
alias .nvim="cd ~/.config/nvim && nvim lua/talama/plugins.lua"
alias .kitty="cd ~/.config/kitty && nvim kitty.conf"

# vim
alias nv="nvim"
alias g="git"
