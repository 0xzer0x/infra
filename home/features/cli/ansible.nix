{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.cli.ansible;
in {
  options.features.cli.ansible.enable =
    mkEnableOption "Enable Ansible CLI utilities";

  config = mkIf cfg.enable {
    # FIX: Updated Ansible package dependencies to contain boto3 for AWS collection modules
    # Nixpkg: https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/development/python-modules/ansible/core.nix
    # Ref: https://nixos.org/manual/nixpkgs/stable/#buildpythonpackage-function
    home.packages = let
      ansible = (pkgs.ansible.overridePythonAttrs (finalAttrs: {
        dependencies = finalAttrs.dependencies
          ++ (with pkgs.python3Packages; [ boto3 ]);
      }));
    in [ ansible ];

    # NOTE: Extra environment variables
    home.sessionVariables = {
      ANISBLE_HOME = "${config.xdg.configHome}/ansible";
      # WARN: Required for ansible-language-server
      ANSIBLE_COLLECTIONS_PATH =
        "${pkgs.python3Packages.ansible}/lib/python${pkgs.python3.pythonVersion}/site-packages";
    };
  };
}
