{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ sof-firmware upower batsignal ];
}
