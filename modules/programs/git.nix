{
  flake.homeModules.git = {
    programs.git = {
      enable = true;

      userName = "Mewski";
      userEmail = "mewski813@gmail.com";

      signing = {
        key = "<key>";
        signByDefault = true;
      };
    };

    programs.gh = {
      enable = true;

      hosts = {
        "github.com" = {
          user = "Mewski";
        };
      };

      gitCredentialHelper = {
        enable = true;
      };
    };

    persist.directories = [
      ".config/gh"
    ];
  };
}
