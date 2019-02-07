# Setup ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#Install autocomplete for zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

# Make ZSH default
chsh -s /bin/zsh

# Configure Vim
echo "set number" > ~/.vimrc
echo "syntax on" >> ~/.vimrc
echo "set tabstop=4" >> ~/.vimrc
echo "colorscheme elflord" >> ~/.vimrc

# Configure tmux
cat <<EOT > ~/.tmux.conf
# change the prefix from 'C-b' to 'C-a'
# (remap capslock to CTRL for easy access)
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# start with window 1 (instead of 0)
set -g base-index 1

# start zsh
set-option -g default-shell /bin/zsh

# start with pane 1
set -g pane-base-index 1

# split panes using | and -, make sure they open in the same path
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

unbind '"'
unbind %

# open new windows in the current path
bind c new-window -c "#{pane_current_path}"

# reload config file
bind r source-file ~/.tmux.conf

unbind p
bind p previous-window

# shorten command delay
set -sg escape-time 1

# don't rename windows automatically
set-option -g allow-rename off

# mouse control (clickable windows, panes, resizable panes)
set -g mouse on

# Use Alt-arrow keys without prefix key to switch panes
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# enable vi mode keys
set-window-option -g mode-keys vi

# set default terminal mode to 256 colors
set -g default-terminal "screen-256color"

# fix pbcopy/pbpaste
if 'command -v reattach-to-user-namespace >/dev/null' \
    'set -gq @osx-pasteboard true'

if 'tmux show -gv @osx-clipboard' \
    'set -g default-command "reattach-to-user-namespace -l $SHELL"'

# present a menu of URLs to open from the visible pane. sweet.
bind-key u capture-pane \;\
    save-buffer /tmp/tmux-buffer \;\
    split-window -l 10 "urlview /tmp/tmux-buffer"


######################
### DESIGN CHANGES ###
######################

# loud or quiet?
set-option -g visual-activity off
set-option -g visual-bell off
set-option -g visual-silence off
set-window-option -g monitor-activity off
set-option -g bell-action none

#  modes
setw -g clock-mode-colour colour5
setw -g mode-attr bold
setw -g mode-fg colour1
setw -g mode-bg colour233

# panes seperators
set -g pane-border-bg colour232
set -g pane-border-fg colour51
set -g pane-active-border-bg colour232
set -g pane-active-border-fg colour243

# statusbar
set -g status-position bottom
set -g status-justify left
set -g status-bg colour233
set -g status-fg colour137
set -g status-attr dim
set -g status-left ''
set -g status-right '#[fg=colour243,bg=colour233,bold] %d/%m #[fg=colour243,bg=colour233,bold] %H:%M:%S '
set -g status-right-length 50
set -g status-left-length 20

setw -g window-status-current-fg colour51
setw -g window-status-current-bg colour233
setw -g window-status-current-attr bold
setw -g window-status-current-format ' #I#[fg=colour249]:#[fg=colour255]#W#[fg=colour249]#F '

setw -g window-status-fg colour243
setw -g window-status-bg colour233
setw -g window-status-attr none
setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '

setw -g window-status-bell-attr bold
setw -g window-status-bell-fg colour255
setw -g window-status-bell-bg colour1

# messages
set -g message-attr bold
set -g message-fg colour243
set -g message-bg colour16
EOT



