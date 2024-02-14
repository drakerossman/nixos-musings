{
  description = "flake for yourHostNameGoesHere with Home Manager enabled featuring a Wayland Sway WM";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosConfigurations = {
      yourHostNameGoesHere = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./greetd.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.theNameOfTheUser = { pkgs, ... }: {
              home.username = "theNameOfTheUser";
              home.homeDirectory = "/home/theNameOfTheUser";
              programs.home-manager.enable = true;
              home.packages = with pkgs; [
                thunderbird
                keepassxc
                mako
                wl-clipboard
                shotman
              ];
              wayland.windowManager.sway = {
                enable = true;
                config = rec {
                  modifier = "Mod4"; # Super key
                  terminal = "alacritty";
                  output = {
                    "Virtual-1" = {
                      mode = "1920x1080@60Hz";
                    };
                  };
                };
                extraConfig = ''
                  bindsym Print               exec shotman -c output
                  bindsym Print+Shift         exec shotman -c region
                  bindsym Print+Shift+Control exec shotman -c window

                  output "*" bg /etc/foggy_forest.jpg fill
                '';
              };
              home.stateVersion = "23.05";
            };
          }
        ];
      };
    };
  };
}
