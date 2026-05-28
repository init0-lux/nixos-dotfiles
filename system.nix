{ config, pkgs, ... }:

{
  # ── Hardware & Boot ─────────────────────────────────────────────
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
  fileSystems."/home/init0/shared" = {
    device = "/dev/disk/by-uuid/089E-3A65";
    fsType = "exfat";
    options = [ "rw" "uid=1000" "gid=100" "umask=0022" ];
  };

  # Nvidia & Graphics
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement = { enable = true; finegrained = true; };
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      offload.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # ── Desktop & GUI ───────────────────────────────────────────────
  services.displayManager.sddm = { enable = true; wayland.enable = false; };
  services.desktopManager.plasma6.enable = true;
  services.xserver.enable = true;
  services.xserver.xkb = { layout = "us"; variant = ""; };
  services.supergfxd.enable = true;
  services.logind.settings = {
    Login.HandleLidSwitch = "suspend";
    Login.HandleLidSwitchExternalPower = "suspend";
  };

  # Fonts
  fonts.packages = with pkgs; [
    inter ibm-plex source-sans source-serif noto-fonts noto-fonts-color-emoji
    fira-sans poppins montserrat cantarell-fonts jetbrains-mono
    liberation_ttf eb-garamond meslo-lg meslo-lgs-nf
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = [ "JetBrains Mono" ]; sansSerif = [ "Inter" ];
    serif = [ "Source Serif 4" ]; emoji = [ "Noto Color Emoji" ];
  };

  # ── System Services ─────────────────────────────────────────────
  services.pipewire = { enable = true; alsa.enable = true; pulse.enable = true; };
  security.rtkit.enable = true;
  services.printing.enable = true;
  services.openssh = { enable = true; ports = [ 2219 ]; };
  services.mosquitto = {
    enable = true;
    listeners = [{ port = 1883; address = "0.0.0.0"; settings.allow_anonymous = true; }];
  };
  services.avahi = {
    enable = true; nssmdns4 = true;
    publish = { enable = true; addresses = true; domain = true; };
  };

  # Virtualization & Support
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host = { enable = true; enableExtensionPack = true; };
  hardware.bluetooth.enable = true;
  security.polkit.enable = true;

  # Performance & Swap
  zramSwap = { enable = true; memoryPercent = 50; priority = 100; };
  swapDevices = [{ device = "/swapfile"; size = 24576; priority = 10; }];
  nix.settings = { max-jobs = 6; cores = 0; sandbox = true; };

  # Global Nix Configuration
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
