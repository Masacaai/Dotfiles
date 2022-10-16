# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];
  
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [ "ntfs"  ];
  };

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Set your time zone.
  time = {
    timeZone = "America/Chicago";
    # timeZone = "Asia/Dubai";
    hardwareClockInLocalTime = true;
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;  # Enables wireless support via wpa_supplicantr

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.wlp2s0.useDHCP = true;

    # Configure network proxy if necessary
    # proxy = {
    #   default = "http://user:password@proxy:port/";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # };

    # Open ports in the firewall.
    # firewall = {
    #   allowedTCPPorts = [ ... ];
    #   allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    #   enable = false;
    # };  

  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      wacom.enable = true;
           
      # Enable touchpad support (enabled default in most desktopManager).
      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };

      # Enable the Plasma 5 Desktop Environment.
      displayManager = {
        defaultSession = "none+awesome";
        lightdm.greeters.mini = {
          enable = true;
          user = "masacaai";
          extraConfig = ''
            [greeter]
	    show-password-label = false

            [greeter-theme]
            background-image = "/etc/lightdm/image.png"
	    password-background-color = "#020013"
	  '';
        };
      };	

      windowManager = {
	awesome = {
	  enable = true;
	  luaModules = with pkgs.luaPackages; [
            luarocks
	    luadbi-mysql
	  ];
	};

      };
      videoDrivers = [ "modesetting" ];

      # Configure keymap in X11
      layout = "us";
      # xkbOptions = "eurosign:e";
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable the OpenSSH daemon.
    # openssh.enable = true;
  };

  # Enable sound.
  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;
  }; 
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.masacaai = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio"]; # Enable ‘sudo’ for the user.
  };

  home-manager = {
    users.masacaai = { pkgs, ... }: {
      home.stateVersion = "22.11";
      home.packages = with pkgs; [
	xournalpp
	zathura
	mpv
	qbittorrent
	feh
	coq_8_15
	gcc
	pavucontrol
	arandr
	libreoffice
	jetbrains-mono
	udiskie
	clipit
        efibootmgr
	maim
	zettlr
	pamixer
	playerctl
	wget
	source-code-pro
        git
	alacritty
        picom
        rofi
	rofi-file-browser
        xarchiver
        neofetch
	firefox
	openconnect
	lxappearance
	jflap
	gnome.adwaita-icon-theme
	networkmanagerapplet
	brave
	texlive.combined.scheme-small
      ];

      programs = {
        neovim = {
          enable = true;
	  extraConfig = ''
	    syntax on
	    set number
	  '';
	  plugins = with pkgs.vimPlugins; [
	    nerdtree
	    vim-airline
	    vim-airline-themes
	  ];
	};
#        vscode = {
#          enable = true;
#	  extensions = with pkgs.vscode-extensions; [
#            vscodevim.vim
#	    ms-vscode.cpptools
#	    xaver.clang-format
#	  ];
#        };
      };
    };

    useUserPackages = true;
    useGlobalPkgs = true;
  };


  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ 
    xss-lock
    (pkgs.buildFHSUserEnv {
    	name = "pyfhs";
	runScript = "bash";
	targetPkgs = pkgs: with pkgs; [
	    python310
	    python310Packages.pip
	    python310Packages.virtualenv
	    python310Packages.pygame
	    SDL2
	    zlib
	];
    })
    (pkgs.buildFHSUserEnv {
        name = "cppfhs";
        runScript = "bash";
        targetPkgs = pkgs: with pkgs; [
            clang_8 gdb cmake gnumake llvm_8 valgrind
        ]; 
    }) 
	
  ];

  programs = {
        zsh.enable = true;
	kdeconnect.enable = true;
      };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
 
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}


