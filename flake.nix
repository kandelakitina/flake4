{
  description = "Boticelli's Config 4";

  inputs = {
    # Core
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    # nix-darwin.url = "github:LnL7/nix-darwin";
    # nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };


  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;
      snowfall = {
        metadata = "dotfiles";
        namespace = "dotfiles";
        meta = {
          name = "dotfiles";
          title = "Boticelli's NixOS dotfiles";
        };
      };

      channels-config = {
        allowUnfree = true;
      };

      # systems.modules.nixos = with inputs; [
      #   home-manager.nixosModules.home-manager
      #   disko.nixosModules.disko
      #   lanzaboote.nixosModules.lanzaboote
      #   impermanence.nixosModules.impermanence
      #   sops-nix.nixosModules.sops
      #   nix-ld.nixosModules.nix-ld
      # ];

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
