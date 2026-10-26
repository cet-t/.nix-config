def main [host: string] {
    (sudo nixos-rebuild switch --flake $"(pwd)#($host)")
}
