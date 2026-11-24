{ config, pkgs, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
  whatpulseAppImage = "${config.home.homeDirectory}/Applications/WhatPulse.AppImage";
in

{
  home.username = "cet";
  home.homeDirectory = "/home/cet";
  home.stateVersion = "26.05";

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/nvim";
  xdg.configFile."nushell".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/nu";
  xdg.configFile."rio".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/rio";
  # KDE Plasma のフォント設定が通常ファイルで上書きし、Home Manager の有効化が失敗するのを防ぐ
  xdg.configFile."fontconfig/conf.d/10-hm-fonts.conf".force = true;

  home.activation.whatpulse = config.lib.dag.entryBetween [ "reloadSystemd" ] [ "writeBoundary" ] ''
    mkdir -p "${config.home.homeDirectory}/Applications"
    if [ ! -f "${whatpulseAppImage}" ]; then
      ${pkgs.curl}/bin/curl -fsSL -o "${whatpulseAppImage}" \
        "https://releases.whatpulse.org/latest/linux/whatpulse-linux-latest_amd64.AppImage" \
        && chmod +x "${whatpulseAppImage}"
    fi
  '';

  xdg.configFile."autostart/whatpulse.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=WhatPulse
    Exec=${whatpulseAppImage}
    X-GNOME-Autostart-enabled=true
  '';
}
