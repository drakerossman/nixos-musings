{
    description = "A sample devshell flake with alejandra4";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
        alejandra4.url = "github:drakerossman/alejandra4";
    };

    outputs = {
        self,
        nixpkgs,
        flake-utils,
        alejandra4,
    }:
        flake-utils.lib.eachDefaultSystem (
            system: let
                pkgs = import nixpkgs {
                    inherit system;
                };
            in
                with pkgs; {
                    devShells.default = pkgs.mkShell {
                        packages = [
                            alejandra4.defaultPackage.${system}
                        ];
                    };
                }
        );
}
