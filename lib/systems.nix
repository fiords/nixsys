{ inputs, extraArgs }:
let
  inputs' = import ./inputs.nix { inherit inputs; };
  modules' = import ./modules.nix { inherit extraArgs; };
in
{
  ###
  # nix-darwin.lib.darwinSystem
  ###
  darwin =
    {
      system ? "aarch64-darwin",
      modules ? [ ],
      overlays ? [ ],
      stateVersion,
    }:
    inputs'.nix-darwin.lib.darwinSystem {
      modules = [
        inputs'.home-manager.darwinModules.home-manager
        modules'.homeManager
        modules'.nix
        (modules'.hostPlatform { inherit system; })
        (modules'.nixpkgs { inherit overlays; })
        { system.stateVersion = stateVersion; }
      ] ++ modules;
      specialArgs = extraArgs;
    };

  ###
  # home-manager.lib.homeManagerConfiguration
  ###
  home =
    {
      system ? "x86_64-linux",
      modules ? [ ],
      overlays ? [ ],
      pkgs ? inputs'.nixpkgs.legacyPackages."${system}",
    }:
    inputs'.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = extraArgs;
      modules = [
        modules'.nix
        (modules'.nixpkgs { inherit overlays; })
        { nix.package = pkgs.nix; }
        { programs.home-manager.enable = true; }
      ] ++ modules;
    };

  ###
  # nixpkgs.lib.nixosSystem
  ###
  nixos =
    {
      system ? "x86_64-linux",
      modules ? [ ],
      overlays ? [ ],
      stateVersion,
    }:
    inputs'.nixpkgs.lib.nixosSystem {
      modules = [
        inputs'.home-manager.nixosModules.home-manager
        modules'.homeManager
        modules'.nix
        (modules'.hostPlatform { inherit system; })
        (modules'.nixpkgs { inherit overlays; })
        { system.stateVersion = stateVersion; }
      ] ++ modules;
      specialArgs = extraArgs;
    };
}
