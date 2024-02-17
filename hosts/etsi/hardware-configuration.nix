# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { 
      #device = "/dev/disk/by-label/NIXOS";
      device = "/dev/nvme0n1p3";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
    };

  fileSystems."/boot" =
    { 
      #device = "/dev/disk/by-label/NIXBOOT";
      device = "/dev/nvme0n1p1";
      fsType = "vfat";
    };

  fileSystems."/mnt/pool/slot1" =
    { device = "/dev/disk/by-label/ICY_SLOT1";
      fsType = "ext4";
      options = [ "noatime" "noexec" "nosuid" ];
    };

  fileSystems."/mnt/pool/slot2" =
    { device = "/dev/disk/by-label/ICY_SLOT2";
      fsType = "ext4";
      options = [ "noatime" "noexec" "nosuid" ];
    };

  fileSystems."/mnt/pool/slot3" =
    { device = "/dev/disk/by-label/ICY_SLOT3";
      fsType = "ext4";
      options = [ "discard" "noatime" "noexec" "nosuid" ];
    };

  fileSystems."/mnt/parity" =
    { device = "/dev/disk/by-label/ICY_SLOT4";
      fsType = "ext4";
      options = [ "noatime" "noexec" "nosuid" ];
    };

  fileSystems."/mnt/storage" = {
    fsType = "fuse.mergerfs";
    device = "/mnt/pool/*";
    noCheck = true;
    options = [
      "cache.files=partial"
      "dropcacheonclose=true"
      "category.create=mfs"
      "minfreespace=100G"
    ];
    depends = [
      "/mnt/pool/slot1"
      "/mnt/pool/slot2"
      "/mnt/pool/slot3"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-label/NIXSWAP"; }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp6s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp5s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
