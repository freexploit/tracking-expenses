{
  description = "Elm app for tracking expenses";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem(system: 
        let 
        pkgs = import nixpkgs { inherit system; };
        makeElmPkg = { pkgs, additionalInputs ? [ ] }:
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
                    elmPackages.elm-format
                    elmPackages.elm-language-server
                ];
            };
    });
}
