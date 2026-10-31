{
  config,
  lib,
  ...
}:

let
  cfg = config.features.cli.pi;
in
{
  options.features.cli.pi.enable = lib.mkEnableOption "Enable Pi coding agent configuration";

  config = lib.mkIf cfg.enable {
    programs.pi-coding-agent = {
      enable = true;

      models = {
        providers = {
          sovereigneg = {
            name = "SovereignEG";
            api = "openai-completions";
            baseUrl = "https://backend.sovereigneg.com/v1";
            apiKey = "\${SOVEREIGNEG_API_KEY}";
            models = [
              {
                id = "kimi-k2.6";
                name = "Kimi K2.6 (EG)";
                contextWindow = 262000;
              }
              {
                id = "kimi-k3.1-pro";
                name = "Kimi K3.1 Pro (EG)";
                contextWindow = 1000000;
              }
              {
                id = "deepseek-v4-flash";
                name = "DeepSeek v4 Flash (EG)";
                contextWindow = 1000000;
              }
              {
                id = "SovereignEG/Qwen3.8-27B-FP8";
                name = "Qwen3.8-27B-FP8 (EG)";
                contextWindow = 32768;
              }
            ];
          };
        };
      };

      settings = {
        theme = "catppuccin-mocha";
        defaultProvider = "sovereigneg";
        defaultModel = "kimi-k2.6";
        extensions = [
          "-builtin:mcp"
        ];
        packages = [
          "npm:pi-vim"
          "npm:pi-mcp-adapter"
          "npm:pi-web-access"
          "npm:@adeildo/pi-ask-permission"
          "npm:@firstpick/pi-themes-bundle"
        ];
        piVim = {
          clipboardMirror = "all";
          exCommand.piDispatch = true;
        };
      };

      keybindings = {
        # NOTE: Escape is used for pi-vim mode switching
        "app.interrupt" = "ctrl+c";
        # NOTE: Shift+tab conflicts with claude permissions plugin
        "app.thinking.cycle" = "ctrl+shift+tab";
        # NOTE: Use ctrl+e to open in editor
        "tui.editor.cursorLineEnd" = "";
        "app.editor.external" = "ctrl+e";
        # NOTE: Easier transcript navigation
        "tui.altScreen.halfPageUp" = "ctrl+alt+u";
        "tui.altScreen.halfPageDown" = "ctrl+alt+d";
      };
    };
  };
}
