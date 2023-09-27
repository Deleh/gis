{
  description = "Show a status summary of multiple Git repositories";
  outputs = { self, nixpkgs }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix;

      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit system;
      });
    in
      {
        packages = forAllSystems (system:
          let pkgs = nixpkgsFor.${system}; in
          {
            gis = pkgs.stdenv.mkDerivation {
              name = "gis";
              src = self;
              installPhase = ''
                install -m 755 -D gis $out/bin/gis
                install -m 644 -D gis_completion.bash $out/share/bash-completion/completions/gis
              '';
            };
            default = self.packages.${system}.gis;
        });
      };
}
