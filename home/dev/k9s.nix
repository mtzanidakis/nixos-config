{
  programs.k9s = {
    enable = true;

    views = {
      k9s = {
        views = {
          "v1/pods" = {
            columns = [
              "NAME"
              "PF"
              "READY"
              "RESTARTS"
              "STATUS"
              "AGE"
              "CPU"
              "MEM"
              "IP"
            ];
          };
        };
      };
    };

    skins = {
      skin = {
        foreground = "#839495";
        background = "#002833";
        "current_line" = "#003440";
        selection = "#003440";
        comment = "#6272a4";
        cyan = "#2aa197";
        green = "#859901";
        orange = "#cb4a16";
        magenta = "#d33582";
        blue = "#2aa198";
        red = "#dc312e";
        k9s = {
          body = {
            fgColor = "#839495";
            bgColor = "#002833";
            logoColor = "#2aa198";
          };
          prompt = {
            fgColor = "#839495";
            bgColor = "#002833";
            suggestColor = "#cb4a16";
          };
          info = {
            fgColor = "#d33582";
            sectionColor = "#839495";
          };
          dialog = {
            fgColor = "#839495";
            bgColor = "#002833";
            buttonFgColor = "#839495";
            buttonBgColor = "#d33582";
            buttonFocusFgColor = "white";
            buttonFocusBgColor = "#2aa197";
            labelFgColor = "#cb4a16";
            fieldFgColor = "#839495";
          };
          frame = {
            border = {
              fgColor = "#003440";
              focusColor = "#003440";
            };
            menu = {
              fgColor = "#839495";
              keyColor = "#d33582";
              numKeyColor = "#d33582";
            };
            crumbs = {
              fgColor = "#839495";
              bgColor = "#003440";
              activeColor = "#003440";
            };
            status = {
              newColor = "#2aa197";
              modifyColor = "#2aa198";
              addColor = "#859901";
              errorColor = "#dc312e";
              highlightColor = "#cb4a16";
              killColor = "#6272a4";
              completedColor = "#6272a4";
            };
            title = {
              fgColor = "#839495";
              bgColor = "#003440";
              highlightColor = "#cb4a16";
              counterColor = "#2aa198";
              filterColor = "#d33582";
            };
          };
          views = {
            charts = {
              bgColor = "default";
              defaultDialColors = ["#2aa198" "#dc312e"];
              defaultChartColors = ["#2aa198" "#dc312e"];
            };
            table = {
              fgColor = "#839495";
              bgColor = "#002833";
              cursorFgColor = "#003440";
              cursorBgColor = "#003440";
              header = {
                fgColor = "#839495";
                bgColor = "#002833";
                sorterColor = "#2aa197";
              };
            };
            xray = {
              fgColor = "#839495";
              bgColor = "#002833";
              cursorColor = "#003440";
              graphicColor = "#2aa198";
              showIcons = false;
            };
            yaml = {
              keyColor = "#d33582";
              colonColor = "#2aa198";
              valueColor = "#839495";
            };
            logs = {
              fgColor = "#839495";
              bgColor = "#002833";
              indicator = {
                fgColor = "#839495";
                bgColor = "#003440";
                toggleOnColor = "#d33582";
                toggleOffColor = "#2aa198";
              };
            };
          };
        };
      };
    };
  };
}
