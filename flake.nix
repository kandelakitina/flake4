{
  description = "Boticelli's Config 4";

  inputs = {
    # Core
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";
    
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    # nix-darwin.url = "github:LnL7/nix-darwin";
    # nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    persist-retro.url = "github:Geometer1729/persist-retro";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:IogaMaster/nix-colors";
    prism.url = "github:IogaMaster/prism";

  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;
      snowfall = {
        # metadata = "dotfiles";
        namespace = "custom";
        meta = {
          name = "dotfiles";
          title = "Boticelli's NixOS dotfiles";
        };
      };

      channels-config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "electron-24.8.6"
        ];
      };
      
      overlays = with inputs; [
        # neovim.overlays.x86_64-linux.neovim
      ];

      systems.modules.nixos = with inputs; [
        # home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        # lanzaboote.nixosModules.lanzaboote
        
        impermanence.nixosModules.impermanence
        persist-retro.nixosModules.persist-retro
        {
          # Required for impermanence
          fileSystems."/persist".neededForBoot = true;
        }

        # sops-nix.nixosModules.sops
        # nix-ld.nixosModules.nix-ld
      ];

      # systems.hosts.thinkpad.modules = with inputs; [
      #   hardware.nixosModules.lenovo-thinkpad-x1-7th-gen
      # ];

      # TODO: move to relevant files
      # homes.modules = with inputs; [
      #   impermanence.nixosModules.home-manager.impermanence
      # ];

      # overlays = with inputs; [
      #   nixgl.overlay
      # ];
    };

}
