{
  programs.git = {
    enable = true;
    userName = "Manolis Tzanidakis";
    userEmail = "mtzanidakis@gmail.com";
    aliases = {
      retag = "!f() { git tag -f -a \"$1\" -m \"$1\" && git push origin \"$1\" -f; }; f";
      deltag = "!f() { git tag -d \"$1\" && git push --delete origin \"$1\"; }; f";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      diff = {
        colorMoved = "zebra";
        tool = "nvim -d";
      };
      fetch = {
        prune = true;
      };
      log = {
        date = "iso8601";
      };
      merge = {
        tool = "nvimdiff";
      };
      pull = {
        rebase = false;
      };
    };
  };
}
