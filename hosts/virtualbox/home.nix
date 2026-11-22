{ config, ... }:

let dotfilesDir = "${config.home.homeDirectory}/dotfiles"; in

{
  home.username = "cet";
  home.homeDirectory = "/home/cet";
  home.stateVersion = "26.05";

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/nvim";
  xdg.configFile."nushell".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/nu";
  xdg.configFile."rio".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/rio";
}
