{ inputs, ... }:
{
    perSystem = { pkgs, ... }: {
        packages.myFreesm = inputs.freesm.packages.${pkgs.stdenv.hostPlatform.system}.default;
        };
}
