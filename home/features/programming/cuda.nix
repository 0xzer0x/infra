{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.features.programming.cuda;
in
{
  options.features.programming.cuda.enable = mkEnableOption "Enable CUDA development libraries";

  config = mkIf cfg.enable {
    home.sessionVariables = {
      CUDA_PATH = pkgs.cudaPackages.cudatoolkit;
    };

    home.packages = with pkgs; [
      cudaPackages.cudatoolkit
    ];
  };
}
