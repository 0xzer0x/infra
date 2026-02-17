{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.features.desktop.apps;
  inherit (lib) mkIf;
in
{
  imports = [ inputs.zen-browser.homeModules.default ];

  config = mkIf cfg.enable {
    home.sessionVariables.MOZ_LEGACY_PROFILES = 1;

    programs.zen-browser = {
      enable = true;

      policies =
        let
          mkLockedAttrs = builtins.mapAttrs (
            _: value: {
              Value = value;
              Status = "locked";
            }
          );

          mkPluginUrl = id: "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";

          mkExtensionEntry =
            {
              id,
              pinned ? false,
            }:
            let
              base = {
                install_url = mkPluginUrl id;
                installation_mode = "force_installed";
              };
            in
            if pinned then base // { default_area = "navbar"; } else base;

          mkExtensionSettings = builtins.mapAttrs (
            _: entry: if builtins.isAttrs entry then entry else mkExtensionEntry { id = entry; }
          );
        in
        {
          AutofillAddressEnabled = false;
          AutofillCreditCardEnabled = false;
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          OfferToSaveLogins = false;
          HardwareAcceleration = true;
          SearchEngines.Default = "DuckDuckGo";

          ExtensionSettings = mkExtensionSettings {
            "uBlock0@raymondhill.net" = "ublock-origin";
            "leechblockng@proginosko.com" = "leechblock-ng";
            "extension@tabliss.io" = "tabliss";
            "markdown-viewer@outofindex.com" = "markdown-viewer-chrome";
            "youtube-custom-speed@niziolek.dev" = "youtube-custom-speed";
            "{3c6bf0cc-3ae2-42fb-9993-0d33104fdcaf}" = "youtube-addon";
            "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = "vimium-ff";
            "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = "styl-us";
            "{bbb880ce-43c9-47ae-b746-c3e0096c5b76}" = "catppuccin-web-file-icons";
            "addon@darkreader.org" = mkExtensionEntry {
              id = "darkreader";
              pinned = true;
            };
          };

          Preferences = mkLockedAttrs {
            "browser.aboutConfig.showWarning" = false;
            "browser.newtab.extensionControlled" = true;
            "privacy.resistFingerprinting" = true;
            "privacy.firstparty.isolate" = true;
            "gfx.webrender.all" = true;
          };
        };

      profiles.default = {
        id = 0;
        isDefault = true;
        settings = {
          "browser.tabs.closeWindowWithLastTab" = false;
          "zen.welcome-screen.seen" = true;
          "zen.theme.accent-color" = "#181825";
          "zen.theme.gradient.show-custom-colors" = true;
          "zen.theme.content-element-separation" = 6;
          "zen.urlbar.behavior" = "normal";
          "zen.urlbar.replace-newtab" = false;
          "zen.view.experimental-no-window-controls" = true;
          "zen.workspaces.open-new-tab-if-last-unpinned-tab-is-closed" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };

        spaces = {
          Space = {
            id = "f1b6fb21-0b09-42c9-8850-9c5598917783";
            theme.colors = [
              {
                red = 24;
                green = 24;
                blue = 37;
              }
            ];
          };
        };
        search = {
          default = "duckduckgo";
          engines =
            let
              nixSnowflakeIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            in
            {
              "Nix Packages" = {
                icon = nixSnowflakeIcon;
                definedAliases = [ "@np" ];
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };
              "Nix Options" = {
                icon = nixSnowflakeIcon;
                definedAliases = [ "@nop" ];
                urls = [
                  {
                    template = "https://search.nixos.org/options";
                    params = [
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };
              "Home Manager Options" = {
                icon = nixSnowflakeIcon;
                definedAliases = [ "@hmop" ];
                urls = [
                  {
                    template = "https://home-manager-options.extranix.com/";
                    params = [
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                      {
                        name = "release";
                        value = "master";
                      }
                    ];
                  }
                ];
              };
            };
        };

        userContent = ''
          /* Catppuccin Mocha Blue userContent.css*/
          @media (prefers-color-scheme: dark) {

            /* Common variables affecting all pages */
            @-moz-document url-prefix("about:") {
              :root {
                --in-content-page-color: #cdd6f4 !important;
                --color-accent-primary: #89b4fa !important;
                --color-accent-primary-hover: rgb(163, 197, 251) !important;
                --color-accent-primary-active: rgb(138, 153, 250) !important;
                background-color: #1e1e2e !important;
                --in-content-page-background: #1e1e2e !important;
              }

            }

            /* Variables and styles specific to about:newtab and about:home */
            @-moz-document url("about:newtab"), url("about:home") {

              :root {
                --newtab-background-color: #1e1e2e !important;
                --newtab-background-color-secondary: #313244 !important;
                --newtab-element-hover-color: #313244 !important;
                --newtab-text-primary-color: #cdd6f4 !important;
                --newtab-wordmark-color: #cdd6f4 !important;
                --newtab-primary-action-background: #89b4fa !important;
              }

              .icon {
                color: #89b4fa !important;
              }

              .search-wrapper .logo-and-wordmark .logo {
                background: url("zen-logo-mocha.svg"), url("https://raw.githubusercontent.com/IAmJafeth/zen-browser/main/themes/Mocha/Blue/zen-logo-mocha.svg") no-repeat center !important;
                display: inline-block !important;
                height: 82px !important;
                width: 82px !important;
                background-size: 82px !important;
              }

              @media (max-width: 609px) {
                .search-wrapper .logo-and-wordmark .logo {
                  background-size: 64px !important;
                  height: 64px !important;
                  width: 64px !important;
                }
              }

              .card-outer:is(:hover, :focus, .active):not(.placeholder) .card-title {
                color: #89b4fa !important;
              }

              .top-site-outer .search-topsite {
                background-color: #89b4fa !important;
              }

              .compact-cards .card-outer .card-context .card-context-icon.icon-download {
                fill: #a6e3a1 !important;
              }
            }

            /* Variables and styles specific to about:preferences */
            @-moz-document url-prefix("about:preferences") {
              :root {
                --zen-colors-tertiary: #181825 !important;
                --in-content-text-color: #cdd6f4 !important;
                --link-color: #89b4fa !important;
                --link-color-hover: rgb(163, 197, 251) !important;
                --zen-colors-primary: #313244 !important;
                --in-content-box-background: #313244 !important;
                --zen-primary-color: #89b4fa !important;
              }

              groupbox , moz-card{
                background: #1e1e2e !important;
              }

              button,
              groupbox menulist {
                background: #313244 !important;
                color: #cdd6f4 !important;
              }

              .main-content {
                background-color: #11111b !important;
              }

              .identity-color-blue {
                --identity-tab-color: #8aadf4 !important;
                --identity-icon-color: #8aadf4 !important;
              }

              .identity-color-turquoise {
                --identity-tab-color: #8bd5ca !important;
                --identity-icon-color: #8bd5ca !important;
              }

              .identity-color-green {
                --identity-tab-color: #a6da95 !important;
                --identity-icon-color: #a6da95 !important;
              }

              .identity-color-yellow {
                --identity-tab-color: #eed49f !important;
                --identity-icon-color: #eed49f !important;
              }

              .identity-color-orange {
                --identity-tab-color: #f5a97f !important;
                --identity-icon-color: #f5a97f !important;
              }

              .identity-color-red {
                --identity-tab-color: #ed8796 !important;
                --identity-icon-color: #ed8796 !important;
              }

              .identity-color-pink {
                --identity-tab-color: #f5bde6 !important;
                --identity-icon-color: #f5bde6 !important;
              }

              .identity-color-purple {
                --identity-tab-color: #c6a0f6 !important;
                --identity-icon-color: #c6a0f6 !important;
              }
            }

            /* Variables and styles specific to about:addons */
            @-moz-document url-prefix("about:addons") {
              :root {
                --zen-dark-color-mix-base: #181825 !important;
                --background-color-box: #1e1e2e !important;
              }
            }

            /* Variables and styles specific to about:protections */
            @-moz-document url-prefix("about:protections") {
              :root {
                --zen-primary-color: #1e1e2e !important;
                --social-color: #cba6f7 !important;
                --coockie-color: #89dceb !important;
                --fingerprinter-color: #f9e2af !important;
                --cryptominer-color: #b4befe !important;
                --tracker-color: #a6e3a1 !important;
                --in-content-primary-button-background-hover: rgb(81, 83, 105) !important;
                --in-content-primary-button-text-color-hover: #cdd6f4 !important;
                --in-content-primary-button-background: #45475a !important;
                --in-content-primary-button-text-color: #cdd6f4 !important;
              }

              .card {
                background-color: #313244 !important;
              }
            }
          }
        '';

        userChrome = ''
          /* Catppuccin Mocha Blue userChrome.css*/
          @media (prefers-color-scheme: dark) {
            :root {
              --zen-colors-primary: #313244 !important;
              --zen-primary-color: #89b4fa !important;
              --zen-colors-secondary: #313244 !important;
              --zen-colors-tertiary: #181825 !important;
              --zen-colors-border: #89b4fa !important;
              --toolbarbutton-icon-fill: #89b4fa !important;
              --lwt-text-color: #cdd6f4 !important;
              --toolbar-field-color: #cdd6f4 !important;
              --tab-selected-textcolor: rgb(171, 197, 247) !important;
              --toolbar-field-focus-color: #cdd6f4 !important;
              --toolbar-color: #cdd6f4 !important;
              --newtab-text-primary-color: #cdd6f4 !important;
              --arrowpanel-color: #cdd6f4 !important;
              --arrowpanel-background: #1e1e2e !important;
              --sidebar-text-color: #cdd6f4 !important;
              --lwt-sidebar-text-color: #cdd6f4 !important;
              --lwt-sidebar-background-color: #11111b !important;
              --toolbar-bgcolor: #313244 !important;
              --newtab-background-color: #1e1e2e !important;
              --zen-themed-toolbar-bg: #181825 !important;
              --zen-main-browser-background: #181825 !important;
              --toolbox-bgcolor-inactive: #181825 !important;
            }

            .sidebar-placesTree {
              background-color: #1e1e2e !important;
            }

            #zen-workspaces-button {
              background-color: #1e1e2e !important;
            }

            #TabsToolbar {
              background-color: #181825 !important;
            }

            .urlbar-background {
              background-color: #1e1e2e !important;
            }

            .content-shortcuts {
              background-color: #1e1e2e !important;
              border-color: #89b4fa !important;
            }

            .urlbarView-url {
              color: #89b4fa !important;
            }

            #zenEditBookmarkPanelFaviconContainer {
              background: #11111b !important;
            }

            #zen-media-controls-toolbar {
              & #zen-media-progress-bar {
                &::-moz-range-track {
                  background: #313244 !important;
                }
              }
            }

            toolbar .toolbarbutton-1 {
              &:not([disabled]) {
                &:is([open], [checked])
                  > :is(
                    .toolbarbutton-icon,
                    .toolbarbutton-text,
                    .toolbarbutton-badge-stack
                  ) {
                  fill: #11111b;
                }
              }
            }

            .identity-color-blue {
              --identity-tab-color: #89b4fa !important;
              --identity-icon-color: #89b4fa !important;
            }

            .identity-color-turquoise {
              --identity-tab-color: #94e2d5 !important;
              --identity-icon-color: #94e2d5 !important;
            }

            .identity-color-green {
              --identity-tab-color: #a6e3a1 !important;
              --identity-icon-color: #a6e3a1 !important;
            }

            .identity-color-yellow {
              --identity-tab-color: #f9e2af !important;
              --identity-icon-color: #f9e2af !important;
            }

            .identity-color-orange {
              --identity-tab-color: #fab387 !important;
              --identity-icon-color: #fab387 !important;
            }

            .identity-color-red {
              --identity-tab-color: #f38ba8 !important;
              --identity-icon-color: #f38ba8 !important;
            }

            .identity-color-pink {
              --identity-tab-color: #f5c2e7 !important;
              --identity-icon-color: #f5c2e7 !important;
            }

            .identity-color-purple {
              --identity-tab-color: #cba6f7 !important;
              --identity-icon-color: #cba6f7 !important;
            }

            #zen-appcontent-navbar-container {
              background-color: #181825 !important;
            }

            #commonDialog {
              background-color: #181825 !important;
            }
          }
        '';

      };
    };
  };
}
