{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;

    extensions = [
      "dockerfile"
      "docker-compose"
      "git-firefly"
      "golangci_lint"
      "helm"
      "html"
      "make"
      "nix"
      "php"
    ];

    extraPackages = with pkgs; [
      alejandra
      nil
    ];

    userSettings = {
      vim_mode = true;
      ui_font_size = 18;
      buffer_font_size = 16;
      buffer_font_family = "JetBrainsMono Nerd Font";
      assistant = {
        default_model = {
          provider = "ollama";
          model = "qwen2.5-coder:latest";
        };
        version = "2";
      };
      theme = {
        mode = "system";
        light = "Solarized Light";
        dark = "Solarized Dark";
      };
      languages = {
        Nix = {
          language_servers = [
            "nil"
            "!nixd"
          ];
          formatter = {
            external = {
              command = "alejandra";
            };
          };
        };
      };
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
    };
  };
}
