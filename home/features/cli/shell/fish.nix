{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.features.cli.shell;
in
{
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
        lg = "lazygit";
        gst = "git status";
        glg = "git log --all --graph --oneline --decorate";
        nfe = "cd $NH_OS_FLAKE && nvim .";
        nhs = "nh search";
        nrs = "nh os switch";
        noi = "nh os info";
        ngc = "sudo nh clean all -a --keep-since 15d";
      };

      shellAbbrs = {
        tree = ''eza --icons --color=auto --sort=type --tree --no-filesize --no-git --no-user --no-time --no-permissions --ignore-glob ".git|.devbox|.direnv|.devenv|.terraform"'';
      };

      functions = {
        nlb = ''nix-locate -r "$(printf 'bin/%s$' $argv[1])"'';
        # NOTE: Quickly switch kubeconfig context
        kctx = ''
          set -l _selected_context "$(kubectl config get-contexts -o name | fzf --reverse --height=10 --border --border-label=" $(kubectl config current-context)" --preview="printf 'Cluster: %s\nUser: %s' \"\$(kubectl config view -o jsonpath='{.contexts[?(@.name == \"{r}\")].context.cluster}')\" \"\$(kubectl config view -o jsonpath='{.contexts[?(@.name == \"{r}\")].context.user}')\"" --preview-border=line --preview-window=wrap --highlight-line)"
          if [ -n "$_selected_context" ]
            kubectl config use-context "$_selected_context" >/dev/null
            echo -e "\x1b[38;5;12m󱃾 Switched to Kubernetes context: $_selected_context\x1b[0m"
          end
        '';
        # NOTE: Quickly switch AWS profile
        awsctx = ''
          set -l _selected_profile "$(aws configure list-profiles | fzf --reverse --height=12 --border --border-label="  $AWS_PROFILE" --preview='grep -A 5 "profile {r}" "$HOME/.aws/config"' --preview-border=line --highlight-line)"
          if [ -n "$_selected_profile" ]
            set -x AWS_PROFILE "$_selected_profile"
            echo -e "\x1b[38;5;11m  Switched to AWS profile: $_selected_profile\x1b[0m"
          end
        '';
      };

      interactiveShellInit = ''
        set -U fish_greeting
        fish_vi_key_bindings
      '';
    };
  };
}
