{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sof-firmware
    batsignal
    brightnessctl
  ];
}
