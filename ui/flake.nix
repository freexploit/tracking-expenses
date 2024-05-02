{
  description = "Elm app for tracking expenses";

  inputs = {
    flake-utils.url = "https://flakehub.com/f/numtide/flake-utils/0.1.92.tar.gz";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem(system: 
        let 
        pkgs = import nixpkgs { inherit system; };
        makeElmPkg = { pkgs, additionalInputs ? [ ], pythonPackages ? (ps: [ ]) }:
        pkgs.stdenv.mkDerivation {
          name = "ui";
          src = ./.;
          buildPhase = pkgs.elmPackages.fetchElmDeps {
            elmPackages = import ./elm-srcs.nix;
            elmVersion = "0.19.1";
            registryDat = ./registry.dat;
          } + ''
            elm-land build
          '';
          installPhase = ''
            mkdir $out
            cp -r dist/* $out
          '';
          buildInputs = with pkgs;
             [
              elmPackages.elm
              elmPackages.elm-land
              elmPackages.elm-optimize-level-2
            ] ++ additionalInputs;
        };

            
        in {
            packages = rec {
                inherit makeElmPkg ;
                ui = makeElmPkg { inherit pkgs; };
                default = ui;
            };
            devShell = pkgs.mkShell {
                packages = with pkgs;[
                    nodejs
                    nodePackages.npm
                    elm2nix
                    elmPackages.elm-format
                    elmPackages.elm-land
                    elmPackages.elm
                    elmPackages.elm-analyse
                    elmPackages.elm-doc-preview
                    elmPackages.elm-format
                    elmPackages.elm-live
                    elmPackages.elm-test
                    elmPackages.elm-upgrade
                    elmPackages.elm-xref
                    elmPackages.elm-language-server
                    elmPackages.elm-verify-examples
                    elmPackages.elmi-to-json
                    elmPackages.elm-optimize-level-2
                ];
            };
    });
}
