{pkgs, ...}: {
  users = {
    groups = {
      anthi = {
        gid = 1001;
      };

      aris = {
        gid = 1002;
      };
    };

    users = {
      anthi = {
        isNormalUser = true;
        uid = 1001;
        group = "anthi";
        createHome = true;
        home = "/home/anthi";
        initialPassword = "password";
        shell = pkgs.zsh;
      };

      aris = {
        isNormalUser = true;
        uid = 1002;
        group = "aris";
        createHome = true;
        home = "/home/aris";
        initialPassword = "password";
        shell = pkgs.zsh;
      };
    };
  };
}
