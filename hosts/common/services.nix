{ config, lib, pkgs, inputs, ... }:

{
  imports = [ inputs.agenix.nixosModules.default ];

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
  };

  # NOTE: Disable auto-start for tailscale
  systemd.services.tailscaled.wantedBy = lib.mkForce [ ];

  # NOTE: Auto-decrypt Gnome keyring on greetd login
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  # NOTE: ShadowSocks proxy
  age.secrets."ss-rust.age".file = ./secrets/ss-rust.age;
  environment.systemPackages = [ pkgs.shadowsocks-rust ];
  environment.etc."shadowsocks-rust/config.json" = {
    enable = true;
    source = config.age.secrets."ss-rust.age".path;
  };
  systemd.services.shadowsocks-rust = {
    description = "ShadowSocks Proxy server";
    after = [ "network.target" ];
    path = [ pkgs.shadowsocks-rust ];
    script = "exec sslocal -c /etc/shadowsocks-rust/config.json";
  };
}
