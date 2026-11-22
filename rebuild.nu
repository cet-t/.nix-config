def main [host: string] {
    (nixos-rebuild switch --flake $"(pwd)#($host)" --sudo)
}
