{
  inputs,
  extraArgs ? {
    inherit inputs;
  },
}:
{
  systems = import ./systems.nix { inherit inputs extraArgs; };
  users = import ./users.nix;
}
