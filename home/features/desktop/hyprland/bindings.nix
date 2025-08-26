{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.hyprland;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.extraConfig = ''
      # =============== Variables =============== #
      $term = ${pkgs.kitty.outPath}/bin/kitty --single-instance
      $menu = ${config.xdg.configHome}/rofi/launcher/launcher
      $passmenu = ${config.xdg.configHome}/rofi/gopass/gopass
      $clipboard = ${config.xdg.configHome}/rofi/clipboard/clipboard
      $powermenu = ${config.xdg.configHome}/rofi/powermenu/powermenu
      $screenshot = ${config.xdg.configHome}/rofi/screenshot/screenshot
      $screenrec = ${config.xdg.configHome}/rofi/screenrec/screenrec
      $volup = ${home.homeDirectory}/.local/usr/bin/audioctl sink inc
      $voldown = ${home.homeDirectory}/.local/usr/bin/audioctl sink dec
      $voltoggle = ${home.homeDirectory}/.local/usr/bin/audioctl sink toggle
      $mictoggle = ${home.homeDirectory}/.local/usr/bin/audioctl source toggle
      $files = $term tmux new yazi
      $code = $term tmux new nvim
      $codium = codium --enable-features=WaylandWindowDecorations
      $notes = obsidian --enable-features=WaylandWindowDecorations
      $browser = flatpak run app.zen_browser.zen
      $mainMod = SUPER
      # ========================================= #

      # ============== Navigation =============== #
      # Move focus with mainMod + arrow keys
      bind = $mainMod, H, movefocus, l
      bind = $mainMod, L, movefocus, r
      bind = $mainMod, K, movefocus, u
      bind = $mainMod, J, movefocus, d
      bind = $mainMod SHIFT, H, movewindow, l
      bind = $mainMod SHIFT, L, movewindow, r
      bind = $mainMod SHIFT, K, movewindow, u
      bind = $mainMod SHIFT, J, movewindow, d
      binde = $mainMod, bracketleft, cyclenext, prev
      binde = $mainMod, bracketright, cyclenext, next

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Example special workspace (scratchpad)
      bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
      # ========================================= #

      # ============== Essentials =============== #
      # terminal
      bind = $mainMod SHIFT, Return, exec, $term

      # restart waybar
      bind = $mainMod SHIFT, W, exec, ${config.xdg.configHome}/waybar/relaunch.sh

      # file manager
      bind = $mainMod, T, exec, $files

      # floating
      bind = $mainMod, space, togglefloating,

      # clipboard manager
      bind = $mainMod, V, exec, $clipboard

      # fullscreen
      bind = $mainMod, F, fullscreenstate,3 3
      bind = $mainMod SHIFT, F, fullscreenstate,0 3

      # lauchers
      bind = $mainMod, P, exec, $menu
      bind = $mainMod SHIFT, backspace, exec, $powermenu

      # screenshot and screenrecording
      bind=,Print, exec, $screenshot
      bind=$mainMod,Print, exec, $screenrec

      # password manager
      bind=$mainMod, menu, exec, $passmenu

      # quick password generator
      bind=$mainMod SHIFT, P, exec, ${home.homeDirectory}/.local/usr/bin/pass-gen

      # quit
      bind = $mainMod, Q, killactive,
      bind = CTRLALT, Delete, exit,
      # ========================================= #

      # ============== Resize Mode ============== #
      # equal tile sizes
      bind = CTRL_$mainMod, E, splitratio, exact 0.5
      # resize in each direction
      binde = CTRL_$mainMod, L, resizeactive, 10 0
      binde = CTRL_$mainMod, H, resizeactive, -10 0
      binde = CTRL_$mainMod, K, resizeactive, 0 -10
      binde = CTRL_$mainMod, J, resizeactive, 0 10
      # ========================================= #

      # ============== Launch Mode ============== #
      bind = $mainMod, O, submap, launch  
      submap = launch  

      bind =, B, exec, $browser
      bind =, B, submap, reset
      bind =, T, exec, flatpak run org.telegram.desktop
      bind =, T, submap, reset
      bind =, C, exec, $code
      bind =, C, submap, reset
      bind =, S, exec, env XDG_CURRENT_DESKTOP=sway flameshot
      bind =, S, submap, reset
      bind =, M, exec, mousepad
      bind =, M, submap, reset
      bind =, N, exec, $notes
      bind =, N, submap, reset
      bind =, Z, exec, zathura
      bind =, Z, submap, reset

      bind = $mainMod, O, submap, reset
      bind =, escape, submap, reset
      submap = reset
      # ========================================= #

      # ================= Extras ================ #
      # Multimedia keys
      binde = $mainMod, F10, exec, $voldown
      binde = $mainMod, F11, exec, $volup
      binde =, XF86AudioRaiseVolume, exec, $volup
      binde =, XF86AudioLowerVolume, exec, $voldown
      bind =, XF86AudioMute, exec, $voltoggle
      bind =, XF86AudioMicMute, exec, $mictoggle
      bind = $mainMod, F9, exec, $voltoggle
      # ========================================= #
    '';
  };
}
