{
  programs.fzf = {
    enable = true;
    defaultCommand = "rg --files --no-ignore-vcs --hidden";
    # disable ctrl+r; use atuin instead
    historyWidget.command = "";
  };
}
