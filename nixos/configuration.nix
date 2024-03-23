# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, pkgs, ... }:
{
  # nix.nixPath = ["/etc/nix/path"];
  nix.settings = {
    experimental-features = "nix-command flakes";

    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  # System configuration
  system =  {
    stateVersion = "23.11";
    autoUpgrade.enable = true;

    # TODO
    # - Check if auto reboots can be set to only occur at certain times, 
    #   or if the system is idle. 
    autoUpgrade.allowReboot = false;
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


  # Audio Configuration w/ Pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # System  programs
  ## Installs
  environment.systemPackages = with pkgs; [
    # Developer Tools
    neovim	
    git

    # Privacy & Security
    protonvpn-gui
    protonvpn-cli

    # System
    zsh
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
    home-manager
  ];

  ## Configuration
  programs = {
    zsh = {
      enable = true;
    };

    # Key manager configuration
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # System services
  services = {
    # X11 / Desktop Environment Configuration
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      libinput.enable = true;

      layout = "us";
      xkbVariant = "";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    openssh = {
      enable = true;

      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };

  # TODO
  # - Update firewall configuration to only allow inbound from 192.168.86.0/24
  # - Look into having different policies for different networks. Nothing allowed on public,
  #   less restrictive on private (home Wi-Fi).
  networking.firewall = {
    allowedTCPPorts = [
      22
    ];
  };

  # Primary account configuration
  users.users.jstiverson = {
    isNormalUser = true;
    initialPassword = "changeme22!";
    description = "Jonathyn Stiverson";
    extraGroups = [ "networkmanager" "wheel" "power"];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDyA94BA6rCIb8Zz2/3EbvdYIgG9gS98baoKA3E0s1a5 jstiverson@nixos"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPlXe5keHP0Nj8DWxcppx/3GKn+4GzNarQ44cxKr4eZD jstiverson@nixos"
      "sh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFJb0myLAr6C7AEuxOZ7G+/zeN4SjRJ09EwgD0C7x7J/ jstiverson@jstiverson-desktop"
    ];
  };
}
