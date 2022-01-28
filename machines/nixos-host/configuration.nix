
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "kvm-intel" ];
  virtualisation.libvirtd.enable = true;

  networking.hostName = "nixos-host"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Pacific/Auckland";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = false;
  networking.interfaces.enp3s0.useDHCP = true;

  networking.bridges.br0.interfaces = [ "enp1s0" ];
  networking.interfaces.br0 = {
    useDHCP = false;
    ipv4.addresses = [{
       "address" = "192.168.1.5";
       "prefixLength" = 24;
    }];
  };
  networking = {
    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     lm_sensors
     virt-manager
     git
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
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";

  users.users.andrew = {
    isNormalUser = true;
    home = "/home/andrew";
    description = "Andrew Bowers";
    extraGroups = [ "wheel" "libvirtd" ];
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCr02eWUXgZTE7YqoglV6fVEztb6VRfCZcb+Z7o82zs+h2HEeOJb1fLOy4VdSO27yUQgxN4TIoAOB6xE8iN9prKd4QfQHGs2L2T/NM68kFqAmmtsCTapSFM2geICGrXTYgwV2UPuH2ywBO/PQVlKmQFkzPtmXjFevUT440Pk2vc8jRQehF9kab5rZAxcaFOFDBM1RDHShTud5D09Nn7X12g7Q9BVxjg9d5+Zh0w2zdF/6qVv83/JjJS0Jw6Fb7bnFvfyc9XdYhJ8rL1YKYpo7lL4GDYq6Hw2bznBbxaQ79vH3chmcNd8z4MCOLOSvQzBZnz7gXjXNjn9JoZsg9EQOf3 andrew@andrew-desktop" ];
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 
    5800
    5900
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
}

