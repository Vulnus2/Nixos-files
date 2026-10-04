{ inputs, ... }:
{
    perSystem = { pkgs, ... }: {
        packages.myHelium = inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default;
        };
}
