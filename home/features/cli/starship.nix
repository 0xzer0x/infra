{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.features.cli.starship;
in
{
  options.features.cli.starship.enable =
    mkEnableOption "Enable extended Starship prompt configuration";

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {
        format = "$directory$character";
        right_format = "$all";
        add_newline = false;
        command_timeout = 1000;

        docker_context.symbol = " ";
        rust.symbol = " ";
        os.symbols.NixOS = " ";

        aws = {
          disabled = true;
          symbol = " ";
          format = " [$symbol($profile)( \\($region\\))]($style)";
        };

        c = {
          symbol = " ";
          format = " [$symbol($version(-$name))]($style)";
        };

        cmake = {
          style = "bold peach";
          format = " [$symbol($version)]($style)";
        };

        container = {
          symbol = "⬢ ";
          format = " [$symbol\\[$name\\]]($style)";
        };

        cmd_duration = {
          style = "bold yellow";
          format = " [󱦟 $duration]($style)";
        };

        deno = {
          symbol = "🦕";
          format = " [$symbol($version)]($style)";
        };

        directory = {
          read_only = " 󰌾";
          truncation_length = 1;
          style = "bold teal";
        };

        git_branch = {
          symbol = " ";
          style = "bold green";
          format = " [$symbol$branch(:$remote_branch)]($style)";
        };

        git_status = {
          disabled = false;
          up_to_date = "";
          conflicted = " ";
          ahead = "[󰶣\${count}](bold green)";
          behind = "[󰶡\${count}](bold green)";
          diverged = " 󰶣\${ahead_count}󰶡\${behind_count}";
          untracked = "[?\${count}](bold yellow)";
          stashed = "[\\$\${count}](bold green)";
          modified = "[!\${count}](bold peach)";
          staged = "[+\${count}](bold blue)";
          renamed = "[»\${count}](bold maroon)";
          deleted = "[-\${count}](bold red)";
          typechanged = "[ \${count}](bold teal)";
          style = "bold green";
          format = "([\\($all_status$ahead_behind\\)]($style))";
        };

        gcloud = {
          disabled = true;
          symbol = " ";
          style = "bold blue";
          format = " [$symbol$account(@$domain)(\\($region\\))]($style)";
        };

        golang = {
          symbol = " ";
          style = "bold sapphire";
          format = " [$symbol($version)]($style)";
        };

        helm = {
          symbol = "󰠳 ";
          format = " [$symbol($version)]($style)";
        };

        hostname = {
          ssh_only = true;
          ssh_symbol = " ";
          style = "bold mauve";
          format = " [$ssh_symbol$hostname]($style)";
        };

        jobs = {
          style = "bold sapphire";
          format = " [$symbol$number]($style)";
        };

        kubernetes = {
          disabled = false;
          symbol = "󱃾 ";
          style = "bold blue";
          format = " [$symbol$context( \\($namespace\\))]($style)";
        };

        lua = {
          symbol = " ";
          format = " [$symbol($version)]($style)";
        };

        nix_shell = {
          symbol = " ";
          format = " [$symbol$state(\\($name\\))]($style)";
        };

        nodejs = {
          symbol = " ";
          format = " [$symbol($version)]($style)";
        };

        package = {
          symbol = " ";
          format = " [$symbol$version]($style)";
          style = "bold peach";
        };

        python = {
          symbol = " ";
          format = " [\${symbol}\${pyenv_prefix}(\${version})(\\($virtualenv\\))]($style)";
          style = "bold yellow";
        };

        terraform = {
          symbol = "󱁢 ";
          style = "bold mauve";
          format = " [$symbol$workspace]($style)";
        };

        username = {
          style_root = "bold red";
          style_user = "bold yellow";
          format = " [ $user]($style)";
        };
      };
    };
  };
}
