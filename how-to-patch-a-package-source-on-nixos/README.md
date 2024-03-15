# How to Patch a Package Source on NixOS

Originally published at [drakerossman.com - How to Patch a Package Source on NixOS](https://drakerossman.com//blog/how-to-patch-a-package-source-on-nixos).

This is the supplementary code for the article describing how to patch the sources of `alejandra` nix code formatter, so it uses 4-space indent instead of 2-space. The resulting application is named `alejandra4`.

`alejandra` is a nix code formatter written in Rust by Kevin Amado (kamadorueda). The source code is available at [https://github.com/kamadorueda/alejandra](https://github.com/kamadorueda/alejandra/).

This folder contains:
- `flake.nix`, which provides the layout to expose a patched package as flake. The canonical location of the flake with `alejanrda4` is at its own repo - [https://github.com/drakerossman/alejandra4](https://github.com/drakerossman/alejandra4);
- `example-devshell-flake.nix`, which demonstrates how to incorporate `alejandra4` into a local devShell.
