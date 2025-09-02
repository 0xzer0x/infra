{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.cli.zsh;
in {
  options.features.cli.zsh = {
    enable = mkEnableOption "Enable extended ZSH configuration";
  };

  config = mkIf cfg.enable {
    home.shell.enableZshIntegration = true;

    programs.zsh = {
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      # NOTE: Shell history
      history = {
        size = 5000;
        save = 5000;
      };

      sessionVariables = {
        # NOTE: ZSH VI mode configuration
        ZVM_VI_HIGHLIGHT_FOREGROUND = "#cdd6f4";
        ZVM_VI_HIGHLIGHT_BACKGROUND = "#45475a";
        # NOTE: Use system-wide QEMU - virsh(1)
        LIBVIRT_DEFAULT_URI = "qemu:///system";
      };

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
        nfe = "cd \${NIXOS_SYSTEM_FLAKE} && nvim .";
        nps = "nix search nixpkgs";
        nrs = "sudo nixos-rebuild switch --flake \${NIXOS_SYSTEM_FLAKE}";
        ngc = "sudo nix-collect-garbage";
        ngd = "sudo nix-collect-garbage -d";
        nsg =
          "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      };

      # NOTE: ZSH plugins
      plugins = [{
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }];

      completionInit = ''
        autoload bashcompinit && bashcompinit
        autoload -Uz compinit && compinit
        complete -C '${pkgs.awscli2}/bin/aws_completer' aws
      '';

      initContent = mkOrder 1500 ''
        # ------- custom functions ------- #
        # zsh-vi-mode copy to clipboard
        my_zvm_vi_yank() {
          zvm_vi_yank
          echo -en "''${CUTBUFFER}" | wl-copy
        }
        my_zvm_vi_delete() {
          zvm_vi_delete
          echo -en "''${CUTBUFFER}" | wl-copy
        }
        my_zvm_vi_change() {
          zvm_vi_change
          echo -en "''${CUTBUFFER}" | wl-copy
        }
        my_zvm_vi_change_eol() {
          zvm_vi_change_eol
          echo -en "''${CUTBUFFER}" | wl-copy
        }
        my_zvm_vi_put_after() {
          CUTBUFFER="$(wl-paste)"
          zvm_vi_put_after
          zvm_highlight clear
        }
        my_zvm_vi_put_before() {
          CUTBUFFER="$(wl-paste)"
          zvm_vi_put_before
          zvm_highlight clear
        }
        zvm_after_lazy_keybindings() {
          zvm_define_widget my_zvm_vi_yank
          zvm_define_widget my_zvm_vi_delete
          zvm_define_widget my_zvm_vi_change
          zvm_define_widget my_zvm_vi_change_eol
          zvm_define_widget my_zvm_vi_put_after
          zvm_define_widget my_zvm_vi_put_before

          zvm_bindkey visual 'y' my_zvm_vi_yank
          zvm_bindkey visual 'd' my_zvm_vi_delete
          zvm_bindkey visual 'x' my_zvm_vi_delete
          zvm_bindkey vicmd  'C' my_zvm_vi_change_eol
          zvm_bindkey visual 'c' my_zvm_vi_change
          zvm_bindkey vicmd  'p' my_zvm_vi_put_after
          zvm_bindkey vicmd  'P' my_zvm_vi_put_before
        }
        # -------------------------------- #
      '';
    };
  };
}
