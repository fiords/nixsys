let
  import' =
    {
      aliases,
      cname,
      inputs,
    }:
    let
      matched = builtins.filter (i: builtins.elem i aliases) (builtins.attrNames inputs);
    in
    if (builtins.length matched) == 1 then
      inputs."${builtins.head matched}"
    else if (builtins.length matched) > 1 then
      (throw ''
        "duplicate" flake inputs provided for: `${cname}`!
        valid aliases: ${builtins.toJSON aliases}
        matching inputs: ${builtins.toJSON matched}
      '')
    else
      (throw ''
        failed to find required flake input: `${cname}`!
        valid aliases: ${builtins.toJSON aliases}
        provided inputs: ${builtins.toJSON (builtins.attrNames inputs)}
      '');
in
{ inputs }:
{
  home-manager = import' {
    inherit inputs;
    aliases = [
      "home-manager"
      "home"
    ];
    cname = "home-manager";
  };
  nix-darwin = import' {
    inherit inputs;
    aliases = [
      "nix-darwin"
      "darwin"
    ];
    cname = "nix-darwin";
  };
  nixpkgs = import' {
    inherit inputs;
    aliases = [ "nixpkgs" ];
    cname = "nixpkgs";
  };
}
