{
  description = "example nix-darwin system 🦕";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    nixsys = {
      url = "github:fiords/nixsys";
    };

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{ nixsys, ... }:
    let
      inherit (nixsys.lib { inherit inputs; }) systems users;
    in
    {
      darwinConfigurations."macbook" = systems.darwin {
        stateVersion = 5;
        modules = [
          (users.darwin {
            name = "user";
            home = _: { };
            stateVersion = "24.11";
          })
        ];
      };
    };
}
