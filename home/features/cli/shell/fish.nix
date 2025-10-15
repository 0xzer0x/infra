{ config, lib, ... }:

let cfg = config.features.cli.shell;
in {
  options.features.cli.shell.fish = {
    enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enable extended fish configuration";
      default = cfg.default == "fish";
    };
  };

  config = lib.mkIf cfg.fish.enable {
    home.shell.enableFishIntegration = true;

    programs.fish = {
      enable = true;

      shellAliases = {
        cat = "bat";
        ip = "ip -color";
        grep = "grep --color=auto";
        ls = "ls --color=auto -l";
        ll = "eza --icons --sort=type --color=auto";
        v = "nvim";
        se = "sudoedit";
        lg = "lazygit";
        gst = "git status";
        glg = "git log --all --graph --oneline --decorate";
        nfe = "cd $NH_OS_FLAKE && nvim .";
        nhs = "nh search";
        nrs = "nh os switch";
        noi = "nh os info";
        ngc = "sudo nh clean all -a --keep-since 15d";
      };

      functions = { nlb = ''nix-locate -r "$(printf 'bin/%s$' $argv[1])"''; };

      interactiveShellInit = ''
        set -U fish_greeting
        fish_vi_key_bindings
      '';
    };
  };
}
