def main [host: string] {
    (sudo nixos-rebuild switch --flake $"($env.HOME)/repo/.nix-config#($host)")
}
