{
  programs.keychain = {
    enable = true;
    keys = [
      "github_ed25519"
      "id_ed25519"
      "id_rsa"
    ];
    extraFlags = [
      "--quiet"
      "--timeout 120"
    ];
  };
}
