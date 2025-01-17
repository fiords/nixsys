{
  description = "example nixos system 🦕";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    nixsys = {
      url = "github:fiords/nixsys";
    };
  };

  outputs =
    inputs@{ nixsys, ... }:
    let
      inherit (nixsys.lib { inherit inputs; }) systems users;
    in
    {
      nixosConfigurations."server" = systems.nixos {
        stateVersion = "24.11";
        modules = [
          (users.nixos {
            name = "user";
            home = _: { };
            stateVersion = "24.11";
          })
        ];
      };
    };
}
