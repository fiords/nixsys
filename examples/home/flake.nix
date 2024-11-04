{
  description = "example home-manager system 🦕";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixsys.url = "github:fiords/nixsys";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{ nixsys, ... }:
    let
      inherit (nixsys { inherit inputs; }) systems users;
    in
    {
      homeConfigurations."home" = systems.home {
        modules = [
          (users.home {
            name = "user";
            stateVersion = "24.11";
          })
        ];
      };
    };
}
