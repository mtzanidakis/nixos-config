{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../common.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  zramSwap.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  networking.hostName = "monstro";
  networking.networkmanager.enable = true; 
  networking.networkmanager.wifi.powersave = false;

  time.timeZone = "Europe/Athens";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";
  services.xserver.layout = "us,gr";
  services.xserver.xkbOptions = "grp:alt_shift_toggle,ctrl:nocaps,grp_led:caps,terminate:ctrl_alt_bksp";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  users.users.manolis.extraGroups = [ "docker" "wheel" ];

  environment.systemPackages = with pkgs; [
    cups-brother-hl1210w
    docker-compose
    firefox
    sddm-kcm
  ];

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
