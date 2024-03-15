{
    description = "Flake for Alejandra4 Package";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = {
        self,
        nixpkgs,
        flake-utils,
        ...
    }:
        flake-utils.lib.eachDefaultSystem
        (
            system: let
                pkgs = import nixpkgs {inherit system;};
                packageName = "alejandra4";
            in
                with pkgs; {
                    packages.${packageName} = pkgs.callPackage ./alejandra4 {};
                    defaultPackage = self.packages.${system}.${packageName};
                }
        );
}
