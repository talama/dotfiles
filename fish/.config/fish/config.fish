# disabled fish's default greeting message
set fish_greeting

# PATH
fish_add_path ~/.local/bin/
fish_add_path ~/bin/
fish_add_path /home/talama/.spicetify
fish_add_path /home/talama/.cargo/bin

# VULKAN SDK
setenv VULKAN_SDK ~/vulkan/1.3.239.0/x86_64/
fish_add_path VULKAN_SDK/bin
setenv LD_LIBRARY_PATH $VULKAN_SDK/lib
setenv VK_LAYER_PATH $VULKAN_SDK/etc/vulkan/explicit_layer.d

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
alias .tmux="nvim ~/.tmux.conf"

# aliases
alias nv="nvim"
alias g="git"

alias ls "ls -p -G"
alias la "ls -A"
alias ll "exa -l -g --icons"
alias lla "ll -a"

alias tm "~/.tmux/tmux-sessionizer.sh"

#auto launch ssh-agent
setenv SSH_ENV $HOME/.ssh/environment

function start_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' >$SSH_ENV
    echo succeeded
    chmod 600 $SSH_ENV
    . $SSH_ENV >/dev/null
    ssh-add
end

function test_identities
    ssh-add -l | grep "The agent has no identities" >/dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

if [ -n "$SSH_AGENT_PID" ]
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent >/dev/null
    if [ $status -eq 0 ]
        test_identities
    end
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV >/dev/null
    end
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent >/dev/null
    if [ $status -eq 0 ]
        test_identities
    else
        start_agent
    end
end
