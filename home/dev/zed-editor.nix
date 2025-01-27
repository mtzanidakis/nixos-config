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
      load_direnv = "shell_hook";
      show_whitespaces = "all";
      ui_font_size = 18;
      buffer_font_size = 16;
      buffer_font_family = "JetBrainsMono Nerd Font";
      hour_format = "hour24";
      assistant = {
        default_model = {
          # provider = "ollama";
          # model = "qwen2.5-coder:latest";
          provider = "copilot_chat";
          #model = "gpt-4o";
          model = "claude-3-5-sonnet";
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
      terminal = {
        blinking = "off";
        env = {
          TERM = "alacritty";
        };
        detect_venv = {
          on = {
            directories = [".env" "env" ".venv" "venv"];
            activate_script = "default";
          };
        };
      };
    };
  };
}
