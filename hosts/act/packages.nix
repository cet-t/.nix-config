{ pkgs, herdr, ... }:

{
  users.users."cet".packages = with pkgs; [
    kdePackages.kate
    discord
    claude-code
  ];

  environment.systemPackages = with pkgs; [
    kdePackages.fcitx5-configtool
    vim
    neovim
    wget
    git
    rio
    nushell
    cargo
    rustc
    rustfmt
    clippy
    rust-analyzer
    fzf
    clang
    nodejs_26
    tree-sitter
    taplo
    floorp-bin
    herdr
  ];
}
