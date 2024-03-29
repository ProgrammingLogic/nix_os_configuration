# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ 
  inputs,
  outputs,
  config,
  pkgs,
  ...
}: {
  imports = [ 
    # Currently no imports
    # Might want to import ./hardware-configuration.nix at some point?
  ];

  # Configure Nix OS 
  nix = {
    package = pkgs.nixUnstable;

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
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

  # Nix OS Settings
  nix.settings = {
    experimental-features = "nix-command flakes";
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
    # inputs.home-manager.packages.${pkgs.system}.default

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
