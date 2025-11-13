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

        aws = {
          disabled = true;
          symbol = " ";
          format = " [$symbol($profile)(\\($region\\))(\\[$duration\\])]($style)";
        };

        buf.symbol = " ";

        c = {
          symbol = " ";
          format = " [$symbol($version(-$name))]($style)";
        };

        cmake = {
          style = "bold peach";
          format = " [$symbol($version)]($style)";
        };

        conda.symbol = " ";

        container = {
          symbol = "⬢ ";
          format = " [$symbol\\[$name\\]]($style)";
        };

        crystal.symbol = " ";

        cmd_duration = {
          style = "bold yellow";
          format = " [󱦟 $duration]($style)";
        };

        dart.symbol = " ";

        deno = {
          symbol = "🦕";
          format = " [$symbol($version)]($style)";
        };

        directory = {
          read_only = " 󰌾";
          truncation_length = 1;
          style = "bold teal";
        };

        docker_context.symbol = " ";

        elixir.symbol = " ";
        elm.symbol = " ";
        fennel.symbol = " ";
        fossil_branch.symbol = " ";

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

        golang = {
          symbol = " ";
          style = "bold sapphire";
          format = " [$symbol($version)]($style)";
        };

        gradle = {
          symbol = " ";
          style = "bold sky";
          format = " [$symbol($version)]($style)";
        };

        guix_shell.symbol = " ";
        haskell.symbol = " ";
        haxe.symbol = " ";
        hg_branch.symbol = " ";

        helm = {
          symbol = "󰠳 ";
          format = " [$symbol($version )]($style)";
        };

        hostname = {
          ssh_only = true;
          ssh_symbol = " ";
          style = "bold mauve";
          format = " [$ssh_symbol$hostname]($style)";
        };

        java = {
          symbol = " ";
          style = "red";
          format = " [\${symbol}(\${version})]($style)";
        };

        jobs = {
          style = "bold sapphire";
          format = " [$symbol$number]($style)";
        };

        julia.symbol = " ";
        kotlin.symbol = " ";

        kubernetes = {
          disabled = true;
          symbol = "󱃾 ";
          style = "bold blue";
          format = " [$symbol$context( \\($namespace\\))]($style)";
        };

        lua = {
          symbol = " ";
          format = " [$symbol($version)]($style)";
        };

        memory_usage.symbol = "󰍛 ";
        meson.symbol = "󰔷 ";
        nim.symbol = "󰆥 ";

        nix_shell = {
          symbol = " ";
          format = " [$symbol$state(\\($name\\))]($style)";
        };

        nodejs = {
          symbol = " ";
          format = " [$symbol($version)]($style)";
        };

        ocaml.symbol = " ";

        package = {
          symbol = " ";
          format = " [$symbol$version]($style)";
          style = "bold peach";
        };

        perl.symbol = " ";
        php.symbol = " ";
        pijul_channel.symbol = " ";

        python = {
          symbol = " ";
          format = " [\${symbol}\${pyenv_prefix}(\${version})(\\($virtualenv\\))]($style)";
          style = "bold yellow";
        };

        rlang.symbol = "󰟔 ";
        ruby.symbol = " ";
        rust.symbol = " ";
        scala.symbol = " ";
        swift.symbol = " ";

        terraform = {
          symbol = "󱁢 ";
          style = "bold mauve";
          format = " [$symbol$workspace]($style)";
        };

        typst = {
          symbol = "t ";
          style = "bold sapphire";
          format = " [$symbol($version)]($style)";
        };

        username = {
          style_root = "bold red";
          style_user = "bold yellow";
          format = " [ $user]($style)";
        };

        vagrant = {
          symbol = " ";
          style = "bold blue";
          format = " [$symbol($version)]($style)";
        };

        zig.symbol = " ";

        os.symbols = {
          Alpaquita = " ";
          Alpine = " ";
          AlmaLinux = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          Artix = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Kali = " ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          OpenBSD = "󰈺 ";
          openSUSE = " ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          RockyLinux = " ";
          Redox = "󰀘 ";
          Solus = "󰠳 ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Void = " ";
          Windows = "󰍲 ";
        };
      };
    };
  };
}
