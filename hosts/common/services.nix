{ config, pkgs, ... }:

{
  # Set your time zone.
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

    # Secrets service
    gnome.gnome-keyring.enable = true;
  };

  # NOTE: Auto-decrypt on greetd login
  security.pam.services.greetd.enableGnomeKeyring = true;
}
