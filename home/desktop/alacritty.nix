{
  programs.alacritty = {
    enable = true;
    settings = {
      keyboard.bindings = [
        {
          key = "Return";
          mods = "Shift";
          chars = "\\u001b[13;2u";
        }
      ];
    };
  };
}
