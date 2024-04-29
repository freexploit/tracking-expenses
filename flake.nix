{
  description = "Flake for haskell version tracking-expenses";

  inputs = {
    haskellNix.url = "github:input-output-hk/haskell.nix";
    nixpkgs.follows = "haskellNix/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, haskellNix }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
    let
      overlays = [ haskellNix.overlay
        (final: prev: {
          # This overlay adds our project to pkgs

         extraPkgconfigMappings = prev.haskell-nix.extraPkgconfigMappings // {
            # String pkgconfig-depends names are mapped to lists of Nixpkgs
            # package names
            "z" = [ "zlib" ];
          };

          tracking-expenses =
            final.haskell-nix.project' {
              src = ./.;
              compiler-nix-name = "ghc928";
              # This is used by `nix develop .` to open a shell for use with
              # `cabal`, `hlint` and `haskell-language-server`
              shell.tools = {
                cabal = {};
                haskell-language-server = {};
              };
              # Non-Haskell shell tools go here
              shell.buildInputs = with pkgs; [
                nixpkgs-fmt arion nodePackages.graphqurl zlib pkg-config haskellPackages.morpheus-graphql-code-gen
              ];
              # This adds `js-unknown-ghcjs-cabal` to the shell.
              # shell.crossPlatforms = p: [p.ghcjs];
            };
        })
      ];
      pkgs = import nixpkgs { inherit system overlays; inherit (haskellNix) config; };
      flake = pkgs.tracking-expenses.flake {};
      defaultPackage = flake.packages."tracking-expenses:exe:tracking-expenses";

    in flake // {
      # Built by `nix build .`
      packages = {
          default = defaultPackage;
          container_image = pkgs.dockerTools.buildLayeredImage {
              name = "tracking-expenses";
              tag = "latest";
              created = builtins.substring 0 8 self.lastModifiedDate;
              contents = [
                pkgs.dockerTools.binSh
                pkgs.dockerTools.caCertificates
                pkgs.dockerTools.usrBinEnv
                pkgs.coreutils
                pkgs.fakeNss
                defaultPackage
              ];
              config = { 
                Labels = {
                    "org.opencontainers.image.source"="https://github.com/freexploit/tracking_expenses";
                };
                Cmd = ["${defaultPackage}/bin/tracking-expenses"];
              };
            };
      };

      devShell = pkgs.haskellPackages.shellFor {
        buildInputs = with pkgs.haskellPackages; [ 
            cabal-install ormolu  haskell-language-server pkgs.nodejs pkgs.nodePackages.npm
        ];
        withHoogle = true;
      };
    });
}


