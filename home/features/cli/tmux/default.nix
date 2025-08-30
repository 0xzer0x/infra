{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.cli.tmux;
in {
  options.features.cli.tmux.enable = mkEnableOption "Enable TMUX configuration";

  imports = [ ./theme.nix ./sesh.nix ];

  config = mkIf cfg.enable {
    xdg.configFile."tmux/tmux-nerd-font-window-name.yml" = {
      source = ./tmux-nerd-font-window-name.yml;
    };

    programs.tmux = {
      enable = true;
      sensibleOnTop = false;

      plugins = with pkgs; [
        { plugin = extraTmuxPlugins.nerd-font-window-name; }
        {
          plugin = tmuxPlugins.fingers;
          extraConfig = ''
            set -g @fingers-key f
            set -g @fingers-show-copied-notification 0
            set -g @fingers-hint-style      "fg=green,bold"
            set -g @fingers-highlight-style "fg=yellow,underscore"
            set -g @fingers-backdrop-style  "dim"
          '';
        }
      ];

      extraConfig = ''
        # -------------------
        # ╔═╗╔═╗╔╦╗╦╔═╗╔╗╔╔═╗
        # ║ ║╠═╝ ║ ║║ ║║║║╚═╗
        # ╚═╝╩   ╩ ╩╚═╝╝╚╝╚═╝
        # -------------------
        set -g default-terminal "tmux-256color"
        # True color support
        set -ga terminal-features ",*256col*:RGB"
        # Undercurl support
        set -ga terminal-overrides ',*:Smulx=\E[4::%p1%dm'
        # Undercurl colors
        set -ga terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
        # Automatic window renaming
        set -g automatic-rename on
        # Allow programs to change the window name
        set -g allow-rename off
        # Destroy window when program exits
        set -g remain-on-exit off
        # Set the time in milliseconds for which tmux waits after an escape is input to
        # determine if it is part of a function or meta key sequences.
        set -g escape-time 0
        # Enable mouse support
        set -g mouse on
        # Automatic renumbering of windows
        set -g renumber-windows on
        # Initial window index
        set -g base-index 1
        # Copy mode default bindings
        set -g mode-keys vi
        # Status bar position
        set -g status-position bottom
        # Prefix mode keybind
        set -g prefix C-g

        # user options
        set -g @copy_mode_on_scroll 1
        set -g @mouse_drag_enter_copy_mode 1

        # -------------------------------
        # ╦╔═╔═╗╦ ╦  ╔╗ ╦╔╗╔╔╦╗╦╔╗╔╔═╗╔═╗
        # ╠╩╗║╣ ╚╦╝  ╠╩╗║║║║ ║║║║║║║ ╦╚═╗
        # ╩ ╩╚═╝ ╩   ╚═╝╩╝╚╝═╩╝╩╝╚╝╚═╝╚═╝
        # -------------------------------
        unbind -T root -a
        unbind -T prefix -a

        # ---- root key-table ----
        bind -T root -N 'Reload configuration'      M-r source-file ~/.config/tmux/tmux.conf
        bind -T root -N 'Move focus left, changing windows if current pane is leftmost'    M-h if -F '#{?#{>:#{last_window_index},1},#{pane_at_left},}' 'select-window -p' 'select-pane -ZL'
        bind -T root -N 'Move focus right, changing windows if current pane is rightmost'  M-l if -F '#{?#{>:#{last_window_index},1},#{pane_at_right},}' 'select-window -n' 'select-pane -ZR'
        bind -T root -N 'Move focus to down pane'   M-j select-pane -ZD
        bind -T root -N 'Move focus to up pane'     M-k select-pane -ZU
        bind -T root -N 'Spread panes evenly'       M-= select-layout -E
        bind -T root -N 'Switch to previous layout' M-[ select-layout -p
        bind -T root -N 'Switch to next layout'     M-] select-layout -n
        bind -T root -N 'Switch to vi copy mode'              WheelUpPane if -F "#{@copy_mode_on_scroll}" "copy-mode" "send-keys -M WheelUpPane"
        bind -T root -N 'Start a new selection in copy mode'  MouseDrag1Pane if -F "#{@mouse_drag_enter_copy_mode}" "copy-mode -M" "send-keys -M MouseDrag1Pane"

        # ---- prefix key-table ----
        bind -T prefix -N 'Switch to pane mode'      p switchc -T pane-mode \; refresh-client -S
        bind -T prefix -N 'Switch to window mode'    t switchc -T window-mode \; refresh-client -S
        bind -T prefix -N 'Switch to options mode'   o switchc -T options-mode \; refresh-client -S
        bind -T prefix -N 'Switch to session mode'   s switchc -T session-mode \; refresh-client -S
        bind -T prefix -N 'Switch to resize mode'    r switchc -T resize-mode \; refresh-client -S
        bind -T prefix -N 'Switch to vi copy mode'   c copy-mode
        bind -T prefix -N 'Open tmux command prompt' : command-prompt
        bind -T prefix -N 'Go back to root mode'     Escape switchc -T root
        bind -T prefix -N 'Help'                     ! list-keys -T prefix

        # ---- pane-mode key-table ----
        bind -T pane-mode -N 'Create a new pane below the current one'           d split-window -vc "#{pane_current_path}" -l 50%
        bind -T pane-mode -N 'Create a new pane to the right of the current one' r split-window -hc "#{pane_current_path}" -l 50%
        bind -T pane-mode -N 'Swap the active pane with the pane above it'       K if -F "#{!=:#{&&:#{pane_at_bottom},#{pane_at_top}},1}" "swap-pane -Zt '{up-of}' ; select-pane -Zt '{up-of}'" \; switchc -T pane-mode
        bind -T pane-mode -N 'Swap the active pane with the pane below it'       J if -F "#{!=:#{&&:#{pane_at_bottom},#{pane_at_top}},1}" "swap-pane -Zt '{down-of}' ; select-pane -Zt '{down-of}'" \; switchc -T pane-mode
        bind -T pane-mode -N 'Swap the active pane with the pane to its right'   L if -F "#{!=:#{&&:#{pane_at_left},#{pane_at_right}},1}" "swap-pane -Zt '{right-of}' ; select-pane -Zt '{right-of}'" \; switchc -T pane-mode
        bind -T pane-mode -N 'Swap the active pane with the pane to its left'    H if -F "#{!=:#{&&:#{pane_at_left},#{pane_at_right}},1}" "swap-pane -Zt '{left-of}' ; select-pane -Zt '{left-of}'" \; switchc -T pane-mode
        bind -T pane-mode -N 'Toggle zoom into pane'                             f resize-pane -Z
        bind -T pane-mode -N 'Break current pane into new window'                b break-pane -a
        bind -T pane-mode -N 'Kill the current pane'                             x kill-pane
        bind -T pane-mode -N 'Go back to root mode'                              Escape switchc -T root
        bind -T pane-mode -N 'Help'                                              ! list-keys -T pane-mode

        # ---- resize-mode key-table ----
        bind -T resize-mode -N 'Evenly resize all panes'          e select-layout -E \; switchc -T resize-mode
        bind -T resize-mode -N 'Increase the current pane left'   h resize-pane -L 5 \; switchc -T resize-mode
        bind -T resize-mode -N 'Increase the current pane bottom' j resize-pane -D 5 \; switchc -T resize-mode
        bind -T resize-mode -N 'Increase the current pane top'    k resize-pane -U 5 \; switchc -T resize-mode
        bind -T resize-mode -N 'Increase the current pane right'  l resize-pane -R 5 \; switchc -T resize-mode
        bind -T resize-mode -N 'Go back to root mode'             Escape switchc -T root
        bind -T resize-mode -N 'Help'                             ! list-keys -T resize-mode

        # ---- window-mode key-table ----
        bind -T window-mode -N 'Create a new window'                     n new-window -a
        bind -T window-mode -N 'Synchronize panes in the current window' s set -F synchronize-panes "#{?pane_synchronized,off,on}"
        bind -T window-mode -N 'Kill the current window'                 x kill-window
        bind -T window-mode -N 'Go back to root mode'                    Escape switchc -T root
        bind -T window-mode -N 'Help'                                    ! list-keys -T window-mode

        # ---- session-mode key-table ----
        bind -T session-mode -N 'Open sesh session picker' s run "sesh connect \"$(
          sesh list --icons | fzf-tmux -p 80%,70% \
            --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
            --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
            --bind 'tab:down,btab:up' \
            --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
            --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
            --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
            --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
            --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
            --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
            --preview-window 'right:55%' \
            --preview 'sesh preview {}'
        )\""
        bind -T session-mode -N 'Open tmux session tree'         t choose-tree
        bind -T session-mode -N 'Rename session'                 r command-prompt -p 'New session name:' 'rename-session %%'
        bind -T session-mode -N 'Open tmux session tree'         t choose-tree
        bind -T session-mode -N 'Kill all other active sessions' D kill-session -a
        bind -T session-mode -N 'Kill current session'           x kill-session
        bind -T session-mode -N 'Detach from current session'    d detach
        bind -T session-mode -N 'Go back to root mode'           Escape switchc -T root
        bind -T session-mode -N 'Help'                           ! list-keys -T session-mode

        # ---- copy-mode-vi key-table ----
        bind -T copy-mode-vi -N 'Begin selection'                              v send-keys -X begin-selection
        bind -T copy-mode-vi -N 'Select a line'                                V send-keys -X select-line
        bind -T copy-mode-vi -N 'Toggle box selection'                         C-v send-keys -X rectangle-toggle
        bind -T copy-mode-vi -N 'Copy selection to clipboard'                  y send-keys -X copy-pipe
        bind -T copy-mode-vi -N 'Copy from cursor to end of line to clipboard' Y send-keys -X copy-pipe-and-cancel

        bind -T copy-mode-vi -N 'Clear selection'   Escape send-keys -X clear-selection
        bind -T copy-mode-vi -N 'Exit copy mode'    C-c send-keys -X cancel
        bind -T copy-mode-vi -N 'Exit copy mode'    q send-keys -X cancel

        # ---- options-mode key-table ----
        bind -T options-mode -N 'Toggle entering copy mode on mouse scroll'         s set -F @copy_mode_on_scroll "#{?@copy_mode_on_scroll,0,1}"  \; display-message "#{?@copy_mode_on_scroll,Enabled,Disabled} copy mode on scroll"
        bind -T options-mode -N 'Toggle entering copy mode selection on mouse drag' d set -F @mouse_drag_enter_copy_mode "#{?@mouse_drag_enter_copy_mode,0,1}"  \; display-message "#{?@mouse_drag_enter_copy_mode,Enabled,Disabled} mouse drag enters copy mode"
        bind -T options-mode -N 'Go back to root mode'                      Escape switchc -T root
        bind -T options-mode -N 'Help'                                      ! list-keys -T options-mode

        # ---------------
        # ╔╦╗╦ ╦╔═╗╔╦╗╔═╗
        #  ║ ╠═╣║╣ ║║║║╣
        #  ╩ ╩ ╩╚═╝╩ ╩╚═╝
        # ---------------
        # configure search highlight colors
        set -gF copy-mode-match-style "bg=#{@thm_surface_1}"
        set -gF copy-mode-current-match-style "bg=#{@thm_red} fg=#{@thm_bg}"

        # configure status modules
        set -g window-status-separator ""
        set -g status-right ""
        set -g status-left-length 0
        set -g status-left "#[fg=#{@thm_fg} bold] TMUX (#S) "
        set -ga status-left "\
        #{?#{==:#{client_key_table},prefix},#[fg=#{@thm_red} bold]PREFIX,\
        #{?#{==:#{pane_mode},copy-mode},#[fg=#{@thm_yellow} bold]COPY,\
        #{?#{==:#{client_key_table},pane-mode},#[fg=#{@thm_peach} bold]PANE,\
        #{?#{==:#{client_key_table},window-mode},#[fg=#{@thm_mauve} bold]WINDOW,\
        #{?#{==:#{client_key_table},session-mode},#[fg=#{@thm_blue} bold]SESSION,\
        #{?#{==:#{client_key_table},resize-mode},#[fg=#{@thm_rosewater} bold]RESIZE,\
        #{?#{==:#{client_key_table},options-mode},#[fg=#{@thm_rosewater} bold]OPTIONS,\
        #[fg=#{@thm_green} bold]NORMAL}}}}}}} "

        # -------------------
        # ╔═╗╦  ╦ ╦╔═╗╦╔╗╔╔═╗
        # ╠═╝║  ║ ║║ ╦║║║║╚═╗
        # ╩  ╩═╝╚═╝╚═╝╩╝╚╝╚═╝
        # -------------------
        # keyboard-driven url/copy mode
        run-shell '${pkgs.tmuxPlugins.fingers}/share/tmux-plugins/tmux-fingers/tmux-fingers.tmux'
      '';
    };

  };
}

