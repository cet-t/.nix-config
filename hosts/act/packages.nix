{ pkgs, lib, herdr, antigravity-cli, ... }:

{
  # nixpkgs の claude-code は release ブランチだと数ヶ月遅れるので、
  # 公式リリースの manifest.json を自前で pin して最新版を使う。
  # 更新: ./pkgs/claude-code/update.sh
  nixpkgs.overlays = [
    (final: prev: {
      claude-code = prev.claude-code.override {
        manifest = lib.importJSON ../../pkgs/claude-code/manifest.json;
      };
    })
  ];

  users.users."cet".packages = with pkgs; [
    kdePackages.kate
    discord
    cloudflared
    claude-code
    gh
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
    antigravity-cli
    fastfetch
    ripgrep
    prettier
  ];
}
