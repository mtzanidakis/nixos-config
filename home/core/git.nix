{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Manolis Tzanidakis";
        email = "mtzanidakis@gmail.com";
      };
      alias = {
        retag = "!f() { git tag -f -a \"$1\" -m \"$1\" && git push origin \"$1\" -f; }; f";
        deltag = "!f() { git tag -d \"$1\" && git push --delete origin \"$1\"; }; f";
      };
      init = {
        defaultBranch = "main";
      };
      fetch = {
        prune = true;
      };
      log = {
        date = "iso8601";
      };
      pull = {
        rebase = false;
      };
    };
  };

  programs.mergiraf.enable = true;

  programs.difftastic = {
    enable = true;

    git = {
      enable = true;
      diffToolMode = true;
    };

    options = {
      color = "dark";
    };
  };
}
