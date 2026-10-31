{
  config,
  lib,
  ...
}:

let
  mcpCfg = config.features.cli.mcp;
in
{
  imports = [
    ./opencode.nix
    ./pi.nix
  ];

  options.features.cli = {
    mcp.enable = lib.mkEnableOption "Enable MCP servers configuration";
  };

  config.programs.mcp = lib.mkIf mcpCfg.enable {
    enable = true;
    servers = {
      context7 = {
        url = "https://mcp.context7.com/mcp";
      };
    };
  };
}
