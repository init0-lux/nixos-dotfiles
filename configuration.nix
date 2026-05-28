{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./system.nix
    ./users.nix
    ./bigPrograms.nix
  ];

  environment.systemPackages = with pkgs; [
    # System Utils
    vim
    wget
    gnumake
    file
    tree
    ripgrep
    fd
    git
    pciutils
    lshw
    unzip
    p7zip
    pigz
    busybox
    dust
    pv
    xclip
    imagemagick
    ghostscript
    detox
    inetutils
    beep
    bat
    feh

    # Development
    python3
    go
    cargo
    rustc
    dart
    nodejs_22
    bun
    pnpm
    typescript
    gcc
    libgcc
    clang
    cling
    gdb
    postman
    vscode
    zed-editor
    rstudio
    arduino-ide
    arduino-cli
    docker-compose
    claude-code
    rustup
    air
    golangci-lint
    gotools
    jdk
    jre8

    # Media & Graphics
    vlc
    ffmpeg
    gimp-with-plugins
    darktable
    audacity
    yt-dlp
    qbittorrent
    opencv

    # Productivity & Themes
    gnugrep
    netcat-gnu
    brightnessctl
    anki
    mosquitto
    qrrs
    ngrok
    pgrok
    macchanger
    kdePackages.qtwebengine
    os-prober
    catppuccin-grub
    usbmuxd
    ifuse
    droidcam
    libreoffice-qt
    gparted
    zsh-powerlevel10k
    tor
    tor-browser
    python3Packages.ipython
    openssl
    service-wrapper
    nginx
    android-studio
    android-tools
  ];

  system.stateVersion = "23.11";
}
