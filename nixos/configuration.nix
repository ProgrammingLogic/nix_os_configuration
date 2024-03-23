# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    
  ];

  # User Configuration
  # Might need to be moved to home-manager?
  users.users.jstiverson = {
    isNormalUser = true;
    initialPassword = "changeme22!";
    description = "Jonathyn Stiverson";
    extraGroups = [ "networkmanager" "wheel" ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDyA94BA6rCIb8Zz2/3EbvdYIgG9gS98baoKA3E0s1a5 jstiverson@nixos"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPlXe5keHP0Nj8DWxcppx/3GKn+4GzNarQ44cxKr4eZD jstiverson@nixos"
    ];
  };

  home-manager.users.jstiverson  =  { ... }: {
    imports = [
      ../home-manager/home.nix
    ];
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;


  nix.settings = {
    experimental-features = "nix-command flakes";

    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  # Configure Nix Package Manager
  nixpkgs = {
    overlays = [
      # No overlays to define
    ];

    config = {
      # Allow unfree software
      allowUnfree = true;
    };
  };

  # Bootloader.Configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networkmanager Configuration
  networking.networkmanager.enable = true;

  # Locale Settings
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # X11 / Desktop Environment Configuration
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.libinput.enable = true;

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Audio Configuration w/ Pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  # Which system packages to install
  environment.systemPackages = with pkgs; [
    # Developer Tools
    neovim	

    # Privacy & Security
    protonvpn-gui
    protonvpn-cli

    # System
    tmux
    wget
    lsof
    lshw
    htop
    fd

    # Gnome Extensions
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnome.adwaita-icon-theme
    gnome.gnome-settings-daemon

    # Home Manager
    inputs.home-manager.packages.${pkgs.system}.default

    # TODO
    # Make these packages installed with home-manager
    firefox

    # Development
    git
    nodejs_21
    python3
    vscode

    # Productivity
    libreoffice
    obsidian

    # Communication
    discord
    signal-desktop

    # Privacy & Security
    bitwarden

    # Entertainment
    spotify
    steam

    # System
    syncthing
    syncthing-tray

    # Audio / video
    vlc 
  ];

  # Discord requires this "insecure" package
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # Key manager configuration
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # System service configuration
  # OpenSSH Daeemon
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # Firewall Configuration
  # TODO
  # - Update firewall configuration to only allow inbound from 192.168.86.0/24
  # - Look into having different policies for different networks. Nothing allowed on public,
  #   less restrictive on private (home Wi-Fi).
  networking.firewall.allowedTCPPorts = [
    22
  ];

  # System configuration
  system.stateVersion = "23.11"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
}
