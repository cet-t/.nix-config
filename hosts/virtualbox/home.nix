{ config, ... }:

let dotfilesDir = "${config.home.homeDirectory}/dotfiles"; in

{
  home.username = "cet";
  home.homeDirectory = "/home/cet";

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/nvim";
  xdg.configFile."nu".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/nushell";
  xdg.configFile."rio".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/rio";
}
