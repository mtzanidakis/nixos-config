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

    btop.enable = true;

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
    comma
    dnsutils
    dua
    duf
    exfatprogs
    eza
    fd
    fortune
    gocryptfs
    hl-log-viewer
    htop
    inetutils
    jnv
    jq
    iperf
    lm_sensors
    ncdu
    nmap
    ntfy-sh
    nvd
    pwgen
    rclone
    restic
    ripgrep
    snitch
    sshfs
    tldr
    unzip
    unrar
    wget
    witr
    wol
    zip
    zstd
  ];
}
