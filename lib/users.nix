{
  darwin =
    {
      name,
      home,
      stateVersion,
    }:
    {
      home-manager.users."${name}" =
        { ... }:
        {
          imports = [ home ];
          home.stateVersion = stateVersion;
        };
      users.users."${name}".home = "/Users/${name}";
    };

  home =
    { name, stateVersion }:
    {
      home = {
        inherit stateVersion;
        username = "${name}";
        homeDirectory = if (name == "root") then "/root" else "/home/${name}";
      };
    };

  nixos =
    {
      name,
      home,
      stateVersion,
    }:
    {
      home-manager.users."${name}" =
        { ... }:
        {
          imports = [ home ];
          home.stateVersion = stateVersion;
        };
      users.users."${name}".home = if (name == "root") then "/root" else "/home/${name}";
    };
}
