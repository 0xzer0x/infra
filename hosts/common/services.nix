{ lib, pkgs, ... }:

{
  time.timeZone = "Africa/Cairo";
  zramSwap.enable = true;

  services = {
    # ZRAM
    zram-generator.enable = true;

    # NTP
    timesyncd.enable = true;

    # Enable sound
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      jack.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager)
    libinput.enable = true;

    # Flatpak
    flatpak.enable = true;

    # USB
    udisks2.enable = true;

    # GVFS
    gvfs.enable = true;

    # Tailscale VPN
    tailscale.enable = true;

    # Display manager (greetd + tuigreet)
    greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          command = ''
            ${lib.getExe pkgs.tuigreet} -rtg "Welcome Back" -c start-hyprland
          '';
        };
      };
    };
  };

  # NOTE: Disable auto-start for tailscale
  systemd.services.tailscaled.wantedBy = lib.mkForce [ ];

  # NOTE: Auto-decrypt Gnome keyring on greetd login
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
}
