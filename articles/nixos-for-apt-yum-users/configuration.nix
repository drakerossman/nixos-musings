{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader = {
    grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  networking = {
    networkmanager.enable = true;
    hostName = "yourHostNameGoesHere"; # edit this to your liking
  };

  # QEMU-specific
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  # locales
  # https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # graphics
  services.xserver = {
    enable = true;
    resolutions = [{ x = 1920; y = 1080; }];
    virtualScreen = { x = 1920; y = 1080; };
    layout = "us"; # keyboard layout
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
    displayManager.defaultSession = "xfce";
    autorun = true; # run on graphic interface startup
    libinput.enable = true; # touchpad support
  };

  # audio
  sound.enable = true;
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = true;

  # user configuration
  users.users = {
    theNameOfTheUser = { # change this to you liking
      createHome = true;
      isNormalUser = true; # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/config/users-groups.nix#L100
      extraGroups = [
        "wheel"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFSKqWM3RBTk/9uw1tAz9SBJqBu6YR9bC6OqS5RywBjJ"
      ];
    };
    root = {
      extraGroups = [
        "wheel"
      ];
    };
  };

  # ssh
  services.openssh = {
    enable = true;
    kexAlgorithms = [ "curve25519-sha256" ];
    ciphers = [ "chacha20-poly1305@openssh.com" ];
    passwordAuthentication = false;
    permitRootLogin = "no"; # do not allow to login as root user
    challengeResponseAuthentication = false;
    kbdInteractiveAuthentication = false;
  };

  nixpkgs.config.allowUnfree = true;

  # installed packages
  environment.systemPackages = with pkgs; [
    # cli utils
    git
    curl
    wget
    vim
    htop

    # browser
    chromium

    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix # syntax highlight for .nix files in vscode
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "search-crates-io";
          publisher = "belfz";
          version = "1.2.1";
          sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        }
      ];
    })
  ];

  programs.chromium = {
    enable = true;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
    ];
  };

  system.stateVersion = "22.05";
}
