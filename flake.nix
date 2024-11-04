{
  description = "convenience functions for nix-darwin, nixos, and home-manager";
  outputs = _: {
    lib = import ./lib;

    templates = {
      darwin = {
        path = ./examples/darwin;
        description = "a minimal nix-darwin flake";
      };

      home = {
        path = ./examples/home;
        description = "a minimal home-manager flake";
      };

      nixos = {
        path = ./examples/nixos;
        description = "a minimal nixos flake";
      };
    };
  };
}
