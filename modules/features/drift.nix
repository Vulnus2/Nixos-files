{ inputs, ... }:
{
    perSystem = { pkgs, ... }: {
        packages.myDrift = inputs.drift.packages.${pkgs.stdenv.hostPlatform.system}.default;
        };
}
