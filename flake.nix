{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    helium.url = "github:oxcl/nix-flake-helium-browser";
    freesm.url = "github:FreesmTeam/FreesmLauncher";
    noctalia.url = "github:noctalia-dev/noctalia";
    mangowm.url = "github:mangowm/mango";

  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
