{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./packages.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.networkmanager.ensureProfiles.profiles = {
    "static-ip" = {
      connection = {
        id = "static-ip";
        type = "ethernet";
        interface-name = "enp2s0";
      };
      ipv4 = {
        method = "manual";
        address1 = "192.168.1.114/24,192.168.1.1";
        dns = "1.1.1.1;1.0.0.1;";
      };
      ipv6.method = "auto";
    };
  };
  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "ja_JP.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  services.printing.enable = true;
  services.openssh.enable = true;
  services.cloudflared = {
    enable = true;
    tunnels."act" = {
      credentialsFile = "/home/cet/.cloudflared/act.json";
      default = "http_status:404";
      ingress."ika.oyatsu.party".service = "http://localhost:3001";
    };
  };
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users."cet" = {
    isNormalUser = true;
    description = "cet";
    extraGroups = [ "networkmanager" "wheel" "input" ];
  };

  programs.appimage = {
      enable = true;
      binfmt = true;
  };

  services.udev.extraRules = ''
    KERNEL=="event*", SUBSYSTEM=="input", MODE="0660", GROUP="input"
    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
  '';

  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.localBinInPath = true;
}
