# nixsys

convenience functions for nix-darwin, nixos, and home-manager

## install

if your project does not have a flake yet:

```sh
nix flake init -t github:fiords/nixsys#darwin
```

otherwise, add nixsys to your flake inputs / outputs:

```nix
{
    inputs.nixsys = "github:fiords/nixsys";
    outputs =
      inputs@{ nixsys, ... }:
      let
        inherit (nixsys { inherit inputs; }) systems users;
      in
      {
      ...
      };
}
```

see [examples](./examples/).

## contributing

PRs accepted.

## license

[mit © fiords.](LICENSE)