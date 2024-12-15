{ extraArgs, ... }:
{
  # home-manager
  homeManager = {
    home-manager = {
      extraSpecialArgs = extraArgs;
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };

  # nixpkgs
  nixpkgs =
    { overlays }:
    {
      nixpkgs.config.allowUnfree = true;
      nixpkgs.overlays = overlays;
    };

  # nixpkgs.hostPlatform
  # option is invalid for home-manager.lib.homeManagerConfiguration
  hostPlatform =
    { system }:
    {
      nixpkgs.hostPlatform = system;
    };

  # nix cli
  nix =
    { lib, pkgs, ... }:
    {
      nix.settings =
        {
          experimental-features = [
            "flakes"
            "nix-command"
          ];
          use-xdg-base-directories = true;
        }
        // lib.optionalAttrs (pkgs.stdenv.isDarwin && pkgs.stdenv.isAarch64) {
          extra-platforms = "x86_64-darwin";
        };
    };
}
