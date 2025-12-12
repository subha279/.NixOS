{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "subha"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "ter-i32b";
    packages = with pkgs; [ terminus_font ];
    useXkbConfig = true;
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.subha = {
    isNormalUser = true;
    description = "Subha";
    extraGroups = [ "networkmanager" "wheel" "storage" ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment.stub-ld.enable = true;

  environment.systemPackages = with pkgs; [
    (runCommandLocal "breeze-cursor-default-theme" { } ''
      mkdir -p $out/share/icons
      ln -s ${pkgs.kdePackages.breeze}/share/icons/breeze_cursors $out/share/icons/default
    '')
    git
    gnumake
    cmake
    libtool
    pkg-config
    kitty
    brave
    waybar
    killall
    copyq
    brightnessctl
    fastfetch
    xfce.thunar-archive-plugin
    gvfs
    android-file-transfer
    curl
    grim
    slurp
    ocamlPackages.gstreamer
    libva
    libva-utils
    mesa
    jellyfin-ffmpeg
    networkmanagerapplet
    playerctl
    rofi
    swww
    wget
    dunst
    vlc
    nwg-look
    unzip
    v4l-utils
    rocmPackages.llvm.clang-unwrapped
    stow
    jq
    bc
    pyright
    bat
    tmux
    spotify
    gimp
    libreoffice-qt-fresh
    fzf
    zoxide
    p7zip
    fontconfig
    vscode
    starship
    neovim
    python310
    nodejs_25
    gcc
    glibc
    linuxHeaders
    vimPlugins.telescope-nvim
    vimPlugins.plenary-nvim
    vimPlugins.harpoon
    vimPlugins.mason-nvim
    vimPlugins.nvim-lspconfig
    vimPlugins.nvim-treesitter
    vimPlugins.luasnip
    vimPlugins.none-ls-nvim
    nixpkgs-fmt
    lua-language-server
    stylua
    ddcutil
    app2unit
    cava
    aubio
    glibc
    material-symbols
    kora-icon-theme
    whitesur-gtk-theme
    swappy
    libqalculate
    bash
    ninja
    qt6.qtbase
    qt6.qtdeclarative
  ];

  fonts.packages = builtins.filter pkgs.lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  qt.enable = true;

  # System-wide environment variables
  environment.variables = {
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __VK_LAYER_NV_optimus = "NVIDIA_only";
    XCURSOR_THEME = "capitaine-cursors"; # Set Breeze cursor theme
    XCURSOR_SIZE = "24"; # Optional: size of the cursor
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  # Thunar + volume plugin
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-volman
  ];

  # For mounting filesystems like exfat/ntfs
  boot.supportedFilesystems = [ "ntfs" "exfat" ];

  # Enable NVIDIA and Intel drivers
  services.xserver.videoDrivers = [ "nvidia" "intel" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };
  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:14:0:0";
  };

  # Services
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.polkit.enable = true; #

  system.stateVersion = "25.11";

}
