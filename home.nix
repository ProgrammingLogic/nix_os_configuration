{ config, pkgs, ... };

{
        home.username = "jstiverson";
        home.homeDirectory = "/home/jstiverson";
        home.stateVersion = "23.11";

        home.packages = [
                # Internet
                pkgs.firefox

                # Development
                pkgs.git
                pkgs.nodejs_21
                pkgs.python3
                pkgs.vscode

                # Productivity
                pkgs.libreoffice
                pkgs.obsidian

                # Communication
                pkgs.discord
                pkgs.signal-desktop

                # Privacy & Security
                pkgs.bitwarden

                # Entertainment
                pkgs.spotify
                pkgs.steam

                # System
                pkgs.syncthing
                pkgs.syncthing-tray

                # Audio / video
                vlc 
        ];

        # Configure Packages

        dconf = {
                enable = true;

                # Dark Mode
                settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
        };

        # Firefox Configuration
        programs.firefox = {
                enable = true;

                # https://duckduckgo.com/?q=%22nixos%22+%22firefox%22&ia=web
                # https://discourse.nixos.org/t/best-way-to-configure-firefox-extensions/32600
                # https://github.com/TLATER/dotfiles/blob/b39af91fbd13d338559a05d69f56c5a97f8c905d/home-config/config/graphical-applications/firefox.nix
                # https://github.com/notusknot/dotfiles-nix/blob/main/modules/firefox/default.nix

                profiles.jstiverson = {
                        settings = {
                          # Disable telemetry
                          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
                          "browser.ping-centre.telemetry" = false;
                          "browser.tabs.crashReporting.sendReport" = false;
                          "devtools.onboarding.telemetry.logged" = false;
                          "toolkit.telemetry.enabled" = false;
                          "toolkit.telemetry.unified" = false;
                          "toolkit.telemetry.server" = "";

                          # Disable Pocket
                          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
                          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
                          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
                          "browser.newtabpage.activity-stream.showSponsored" = false;
                          "extensions.pocket.enabled" = false;

                          # Disable JS in PDFs
                          "pdfjs.enableScripting" = false;
                        };
                };


                policies = {
                        ExtensionsSettings = {
                          # Privacy Badger:
                          "jid1-MnnxcxisBPnSXQ@jetpack" = {
                                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
                                    installation_mode = "force_installed";
                          };
                        };
                };
        };

        programs.git = {
                enable = true;
                userName = "Jonathyn Stiverson";
                userEmail = "jlstiverson2002@protonmail.com";
        };

        programs.neovim = {
                enable = true;
                extraConfig = ''
                        set number
                        set expandtab
                '';
        };
}
