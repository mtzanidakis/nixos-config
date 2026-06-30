{pkgs, ...}: {
  imports = [
    ../../nixos
    ../../nixos/amd_gpu.nix
    ../../nixos/bluetooth.nix
    ../../nixos/docker.nix
    ../../nixos/devenv.nix
    ../../nixos/extrahosts.nix
    ../../nixos/flatpak.nix
    ../../nixos/fonts.nix
    ../../nixos/fprintd.nix
    ../../nixos/kde.nix
    ../../nixos/nix-ld.nix
    ../../nixos/pipewire.nix
    ../../nixos/printing.nix
    ../../nixos/steam.nix
    ../../nixos/systemd-boot.nix
    ../../nixos/virt-manager.nix
    ../../nixos/zramswap.nix

    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "gizu";
    networkmanager = {
      enable = true;
      unmanaged = [
        "interface-name:veth*"
        "interface-name:br-*"
        "interface-name:docker*"
      ];
    };
  };

  virtualisation.docker = {
    storageDriver = "btrfs";
    daemon.settings = {
      ipv6 = true;
      fixed-cidr-v6 = "fd00::/80";
    };
  };

  services.btrfs.autoScrub.enable = true;

  services.udev = {
    # logi bolt breaks suspend
    extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c52b|c548", ATTR{power/wakeup}="disabled"
      '';

    packages = with pkgs; [
      trezor-udev-rules
    ];
  };

  # llama-server -hf deepreinforce-ai/Ornith-1.0-9B-GGUF --port 8000 -c 262144
  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp-vulkan;
    settings.port = 8000;
    settings.models-preset = (pkgs.formats.ini { }).generate "models-preset.ini" {
      "Ornith-1.0-9B" = {
        hf-repo = "deepreinforce-ai/Ornith-1.0-9B-GGUF";
        alias = "deepreinforce-ai/Ornith-1.0-9B";
        ctx-size = 262144;
      };
    };
  };

  systemd.services.llama-cpp = {
    environment = {
      XDG_CACHE_HOME = "/var/cache/llama-cpp";
      MESA_SHADER_CACHE_DIR = "/var/cache/llama-cpp";
    };
  };

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  environment.systemPackages = with pkgs; [
    framework-tool
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
