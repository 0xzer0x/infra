{ config, lib, ... }:

with lib;
let
  cfg = config.features.cli.tmux;
  fallbackIcon = "";
  icons = {
    alacritty = "";
    ansible = "󱂚";
    aws = "";
    bash = "";
    bat = "󰦨";
    btop = "";
    cargo = "";
    clang = "";
    cmake = "";
    crontab = "";
    curl = "󰖟";
    docker = "";
    fdisk = "";
    fish = "";
    gcc = "";
    gcloud = "";
    gdb = "";
    gh = "";
    ghostty = "";
    git = "";
    gitlab = "";
    gnome-terminal = "";
    go = "";
    gpg = "";
    helm = "󱃾";
    htop = "";
    k9s = "󱃾";
    kubectl = "󱃾";
    lazydocker = "";
    lazygit = "󰊢";
    lf = "";
    lfcd = "";
    lldb = "";
    lvim = "";
    make = "";
    mongo = "";
    mysql = "";
    nano = "";
    nginx = "";
    node = "";
    npm = "";
    nvim = "";
    openssl = "";
    parted = "";
    ping = "";
    pip = "";
    pip3 = "";
    psql = "";
    python = "";
    python3 = "";
    "python3.14" = "";
    redis = "";
    rsync = "";
    rustc = "";
    rustup = "";
    sqlite = "";
    ssh = "󰣀";
    scp = "󰣀";
    sudo = "󰒘";
    sudoedit = "󱆠";
    systemctl = "";
    terraform = "󱁢";
    tmux = "";
    top = "";
    unzip = "";
    vi = "";
    vim = "";
    virtualbox = "";
    wget = "";
    yarn = "";
    yazi = "";
    zip = "";
    zsh = "";
    podman = "";
    nvtop = "";
    kubecolor = "󱃾";
    chezmoi = "";
    man = "󰈙";
    buildah = "";
    flatpak = "󰏗";
    cat = "󰦨";
    task = "";
    watch = "󰈈";
    ffmpeg = "󱜀";
    ttyper = "󰌌";
    find = "";
    fd = "";
    fastfetch = "";
    nix = "";
    nom = "";
    nvd = "";
    dix = "";
    nh = "";
    nix-collect-garbage = "";
    nixos-rebuild = "󱑞";
    nix-locate = "";
    uv = "";
    kind = "󱃾";
    limactl = "";
    gopass = "󰟵";
    opencode = "";
  };
  iconTable = concatStringsSep "" (
    mapAttrsToList (cmd: icon: "#{?#{==:#{pane_current_command},${cmd}},${icon},}") icons
  );
in
{
  config = mkIf cfg.enable {
    catppuccin.tmux.extraConfig = ''
      # NOTE: Prepend window name with nerd font icon
      set -g automatic-rename on
      set -g automatic-rename-format "#{?pane_in_mode,[tmux],#{?${iconTable},${iconTable},${fallbackIcon}} #{pane_current_command}}#{?pane_dead,[dead],}"

      set -g @catppuccin_directory_icon "󰝰 "
      set -g @catppuccin_date_time_text "%H:%M"

      set -g @catppuccin_gitmux_icon " "
      set -g @catppuccin_gitmux_text "#(gitmux -cfg ${config.xdg.configHome}/tmux/gitmux.conf \"#{pane_current_path}\")"

      set -g @catppuccin_window_text ""
      set -g @catppuccin_window_number "#W(###I) "
      set -g @catppuccin_window_current_text ""
      set -g @catppuccin_window_current_number "#W(###I#{?window_zoomed_flag,#, ,}#{?pane_synchronized,#, ,}) "
      set -g @catppuccin_window_number_position "right"
      set -g @catppuccin_window_current_number_color "#{@thm_green}"

      # NOTE: Powerline-style separators
      set -g @catppuccin_window_status_style "custom"
      set -g @catppuccin_window_right_separator "#[fg=#{@_ctp_status_bg},reverse]#[none]"
      set -g @catppuccin_window_left_separator "#[fg=#{@_ctp_status_bg}]#[none]"
      set -g @catppuccin_window_middle_separator "#[bg=#{@catppuccin_window_number_color},fg=#{@catppuccin_window_text_color}]"
      set -g @catppuccin_window_current_middle_separator "#[bg=#{@catppuccin_window_current_number_color},fg=#{@catppuccin_window_current_text_color}]"
    '';
  };
}
