{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sof-firmware
    batsignal
    brightnessctl
    nvtopPackages.intel
    bluez
    wireshark
  ];

  programs = {
    wireshark = {
      enable = true;
      dumpcap.enable = true;
    };
  };
}
