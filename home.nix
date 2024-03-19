{ config, pkgs, ... };

{
        home.username = "jstiverson";
        home.homeDirectory = "/home/jstiverson";

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
}
