{ pkgs, herdr, ... }:

{
  users.users."cet".packages = with pkgs; [
    kdePackages.kate
    discord
    claude-code
    cloudflared
  ];

  environment.systemPackages = with pkgs; [
    kdePackages.fcitx5-configtool
    vim
    neovim
    wget
    git
    rio
    nushell
    rustup
    fzf
    clang
    nodejs_26
    tree-sitter
    taplo
    floorp-bin
    herdr
    fastfetch
  ];
}
