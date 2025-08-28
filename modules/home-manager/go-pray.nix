{ config, lib, pkgs, ... }:

with lib;
let cfg = config.services.go-pray;
in {
  options = {
    services.go-pray = {
      enable = mkEnableOption "Prayer times notification daemon";

      package = mkOption {
        type = types.package;
        default = pkgs.go-pray;
        defaultText = literalExpression "pkgs.go-pray";
        description = "Package providing {command}`go-pray`.";
      };

      settings = mkOption {
        description = "YAML settings content for go-pray";
        type = types.lines;
        default = "";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile."go-pray/config.yml" = { text = cfg.settings; };

    # NOTE: Create systemd user unit to autostart daemon
    systemd.user.services.go-pray = {
      Unit = {
        Description = "Prayer times notification daemon";
        Documentaiton = "https://github.com/0xzer0x/go-pray";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = let configFile = "${config.xdg.configHome}/go-pray/config.yml";
      in {
        Type = "exec";
        Environment = [ "PATH=${config.home.profileDirectory}/bin" ];
        ExecCondition = [ "test -f ${configFile}" ];
        ExecStart = [ "${cfg.package}/bin/go-pray daemon" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };
    };
  };
}
