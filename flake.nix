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
          tracking-expenses =
            final.haskell-nix.project' {
              src = ./.;
              compiler-nix-name = "ghc928";
              # This is used by `nix develop .` to open a shell for use with
              # `cabal`, `hlint` and `haskell-language-server`
              shell.tools = {
                cabal = {};
                hlint = {};
                haskell-language-server = {};
              };
              # Non-Haskell shell tools go here
              shell.buildInputs = with pkgs; [
                nixpkgs-fmt arion 
              ];
              # This adds `js-unknown-ghcjs-cabal` to the shell.
              # shell.crossPlatforms = p: [p.ghcjs];
            };
        })
      ];
      pkgs = import nixpkgs { inherit system overlays; inherit (haskellNix) config; };
      flake = pkgs.tracking-expenses.flake {};

    in flake // {
      # Built by `nix build .`
      packages.default = flake.packages."tracking-expenses:exe:tracking-expenses";
      devShell = pkgs.haskellPackages.shellFor {
        buildInputs = with pkgs.haskellPackages; [ cabal-install ormolu  haskell-language-server ];
        withHoogle = true;
      };
    });
}


