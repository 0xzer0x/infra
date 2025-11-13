{ lib, ... }:

with lib;
{
  options.customization.users = mkOption {
    type = types.attrsOf (
      types.submodule (
        { name, ... }:
        {
          options.hashedPasswordFile.enable = mkEnableOption "Enable provided hashed password for the user.";
        }
      )
    );
    default = { };
  };

  imports = [ ./youfathy.nix ];
}
