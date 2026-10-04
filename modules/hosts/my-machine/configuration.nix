{ self, inputs, ...}: {

  flake.nixosModules.myMachineConfiguration = { config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      self.nixosModules.myMachineHardware
      self.nixosModules.niri
      self.nixosModules.mango
    ];
    nix.settings.experimental-features = ["nix-command" "flakes"];

     # 1. Limit the boot menu to show only the last 5 versions
  boot.loader.systemd-boot.configurationLimit = 5;

  # 2. Automatically clean up older files periodically
  nix.gc = {
    automatic = true;
    dates = "weekly"; # Runs once a week
    options = "--delete-older-than 14d"; # Cleans up files older than 2 weeks
  };

  programs.dconf.enable = true;
  nix.settings.auto-optimise-store = true;


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Addis_Ababa";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  #services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  #services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = lib.mkForce "mango";
  #services.desktopmanager.plasma6.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.flatpak.enable = true;


  services.displayManager.sessionPackages = with pkgs; [
    mango
  ];


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."miki" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "miki";
    extraGroups = [ "networkmanager" "wheel" "video" "input"];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.zsh.enable = true;
  programs.gamemode.enable = true;


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     git
     curl
     btop
     fastfetch
     ghostty
     neovim
     self.packages.${pkgs.stdenv.hostPlatform.system}.myHelium
     self.packages.${pkgs.stdenv.hostPlatform.system}.myFreesm
     hicolor-icon-theme
     adwaita-icon-theme
     xwayland-satellite
     obsidian
     pkgs.telegram-desktop
     pkgs.discord
     zip
     unzip
     mpv
     cava
     cmatrix
     unrar
     localsend
     pkgs.starship
     gcc
     tree-sitter
     gnutar
     self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
     slurp
     libnotify
     psmisc
     pkgs.proton-vpn
     gnome-extension-manager
     pkgs.bazaar
     pkgs.gnome-tweaks
     grim
     wl-clipboard
     libnotify
     yazi
     rclone
     pkgs.gnomeExtensions.gsconnect
     lazygit
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  fonts.packages = with pkgs; [
  # Popular UI / Interface Fonts
  #inter
  #roboto
  #liberation_ttf

  # Coding / Monospace Fonts
  #fira-code
  #fira-code-symbols
  jetbrains-mono

  # Nerd Fonts (For icons in terminal/Neovim)
  nerd-fonts.jetbrains-mono
  #nerd-fonts.fira-code
  #nerd-fonts.symbols-only

  # Emoji & Math Support
  #noto-fonts-color-emoji
  #twemoji-color-font
];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

};

  }
