{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    historyLimit = 5000;
    mouse = true;
    terminal = "screen-256color";
    extraConfig = ''
      set-option -g status-style fg=yellow,bg=black
      set-window-option -g window-status-style fg=brightblue,bg=default
      set-window-option -g window-status-current-style fg=brightred,bg=default
      set-option -g pane-border-style fg=black
      set-option -g pane-active-border-style fg=brightgreen
      set-option -g message-style fg=brightred,bg=black
      set-option -g display-panes-active-colour blue
      set-option -g display-panes-colour brightred
      set-window-option -g clock-mode-colour green
      set-window-option -g window-status-bell-style fg=black,bg=red
    '';
  };
}
