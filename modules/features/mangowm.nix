{ inputs, self, ... }: {
  flake.nixosModules.mango = { pkgs, lib, ... }: {
    programs.mango = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myMango;
    };
  };

  perSystem = { pkgs, lib, config, self', ... }: {
    packages.myMango = inputs.wrapper-modules.wrappers.mangowc.wrap {
      inherit pkgs;

      package = inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.default;

      flags = {
        "-c" = lib.mkForce "~/.config/mango/config.conf";
      };


    };
  };
}
