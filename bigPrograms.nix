{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    telegram-desktop
    obs-studio
    google-chrome
  ];
}
