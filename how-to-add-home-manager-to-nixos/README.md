# How to Convert Default NixOS to NixOS with Flakes

Originally published at [drakerossman.com - How to Convert Default NixOS to NixOS with Flakes](https://drakerossman.com/blog/how-to-add-home-manager-to-nixos).

This is the supplementary code for the article describing how to add home manager into flake-enabled NixOS system.

This folder contains `flake.nix`, `configuration.nix` and `hardware-configuration.nix` which are then to be found under `/etc/nixos` on your freshly installed NixOS system. Note, that your autogenerated `hardware-configuration.nix` may differ from the one in this folder, so you should better be using the one you've got already.

You can also find the overview of shell scripts used for the installation inside `installation-scripts.sh`, which are not meant to be copy-pasted, but to be read carefully and adjusted to your configuration.
