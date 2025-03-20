{pkgs, ...}: {
  imports = [
    ./fzf.nix
    ./git.nix
    ./keychain.nix
    ./starship.nix
    ./tmux.nix
    ./zsh.nix
  ];

  programs = {
    atuin = {
      enable = true;
      settings = {
        enter_accept = false;
      };
      flags = [
        "--disable-up-arrow"
      ];
    };
    nix-index.enable = true;
    zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
    };
  };

  home.packages = with pkgs; [
    bat
    btop
    comma
    dnsutils
    dogdns
    dua
    exfatprogs
    eza
    fd
    fortune
    gocryptfs
    htop
    inetutils
    jnv
    jq
    iperf
    lm_sensors
    ncdu
    nmap
    nvd
    pwgen
    rclone
    restic
    ripgrep
    sshfs
    tldr
    unzip
    unrar
    wget
    wol
    zip
    zstd
  ];
}
