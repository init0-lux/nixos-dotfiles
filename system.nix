{ config, pkgs, ... }:

{
  # ── Networking ──────────────────────────────────────────────────
  networking.hostName = "zapp";
  networking.firewall.allowedTCPPorts = [
    1883
    3000
    3001
    8081
  ];
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # ── Boot & Kernel ───────────────────────────────────────────────
  boot.loader = {
    systemd-boot.enable = false;
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      gfxmodeEfi = "1920x1200";
      gfxpayloadEfi = "keep";
      theme = pkgs.catppuccin-grub;
    };
    timeout = 5;
    efi.canTouchEfiVariables = true;
  };
  boot.kernelParams = [ "mem_sleep_default=deep" ];
  boot.supportedFilesystems = [ "ntfs" ];
  boot.initrd.network.ssh = {
    port = 2219;
    shell = "/bin/zsh";
  };
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  fileSystems."/home/init0/shared" = {
    device = "/dev/disk/by-uuid/089E-3A65";
    fsType = "exfat";
    options = [
      "rw"
      "uid=1000"
      "gid=100"
      "umask=0022"
    ];
  };

  # ── Nvidia & Graphics ──────────────────────────────────────────
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    prime = {
      offload.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # ── Desktop & GUI ───────────────────────────────────────────────
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
  };
  services.desktopManager.plasma6.enable = true;
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.supergfxd.enable = true;
  services.logind.settings = {
    Login.HandleLidSwitch = "suspend";
    Login.HandleLidSwitchExternalPower = "suspend";
  };

  # Fonts
  fonts.packages = with pkgs; [
    inter
    ibm-plex
    source-sans
    source-serif
    noto-fonts
    noto-fonts-color-emoji
    fira-sans
    poppins
    montserrat
    cantarell-fonts
    jetbrains-mono
    liberation_ttf
    eb-garamond
    meslo-lg
    meslo-lgs-nf
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = [ "JetBrains Mono" ];
    sansSerif = [ "Inter" ];
    serif = [ "Source Serif 4" ];
    emoji = [ "Noto Color Emoji" ];
  };

  # ── System Services ─────────────────────────────────────────────
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;
  services.printing.enable = true;
  services.openssh = {
    enable = true;
    ports = [ 2219 ];
  };
  services.mosquitto = {
    enable = true;
    listeners = [
      {
        port = 1883;
        address = "0.0.0.0";
        settings.allow_anonymous = true;
      }
    ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
    };
  };

  # Virtualization & Support
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };
  virtualisation.libvirtd.enable = true;
  hardware.bluetooth.enable = true;
  security.polkit.enable = true;

  # Performance & Swap
  zramSwap = {
    enable = true;
    memoryPercent = 50;
    priority = 100;
  };
  swapDevices = [
    {
      device = "/swapfile";
      size = 24576;
      priority = 10;
    }
  ];
  nix.settings = {
    max-jobs = 6;
    cores = 0;
    sandbox = true;
  };

  # Global Nix Configuration
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  nixpkgs.config.android_sdk.accept_license = true;
  nixpkgs.config.permittedInsecurePackages = [ "electron-38.8.4" ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
