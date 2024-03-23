{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
  ];


  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ ];
    };

    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };


  fileSystems."/" =
    { device = "/dev/disk/by-uuid/6d137c42-31f2-43cf-8e51-0fb59b4c383f";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5556-7936";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/66f291d8-955f-44c2-a1f3-e167bfeaa3d6"; }
    ];

  networking.useDHCP = lib.mkDefault true;
  networking.hostname = "jstiverson-desktop";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # GPU Configuration
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };
}
