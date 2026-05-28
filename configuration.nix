{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./system.nix
    ./users.nix
    <home-manager/nixos>
  ];

  home-manager.users.init0 = import ./home.nix;

  environment.systemPackages = with pkgs; [
    # System Utils
    vim wget gnumake file tree ripgrep fd git pciutils lshw
    unzip p7zip pigz busybox dust pv xclip imagemagick ghostscript detox
    # Development
    python3 go cargo rustc dart nodejs_22 bun pnpm typescript
    gcc libgcc clang cling gdb postman vscode zed-editor rstudio
    arduino-ide arduino-cli docker-compose claude-code rustup air
    # Media & Graphics
    vlc ffmpeg gimp-with-plugins darktable audacity yt-dlp qbittorrent
    # Productivity & Themes
    gnugrep netcat-gnu brightnessctl anki mosquitto qrrs ngrok pgrok macchanger
    kdePackages.qtwebengine os-prober catppuccin-grub usbmuxd ifuse droidcam
    libreoffice-qt gparted zsh-powerlevel10k
  ];

  system.stateVersion = "23.11";
}
