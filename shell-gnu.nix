{ pkgs ? import <nixpkgs> { } }:
let
  # Extract the lib folder from a package
  # getLibrary = pkg: "${pkg}/lib";
in
pkgs.stdenv.mkDerivation {
  name = "sabine-shell-gnu";

  nativeBuildInputs = with pkgs; [
    # GNU Toolchain
    gcc
    gnumake
    pkg-config

    # Hail the Nix
    nixd
    nixpkgs-fmt

    # Launch scripts
    just
  ];

  # Necessary Environment Variables
  NIX_LDFLAGS = "-lstdc++";
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    pkgs.stdenv.cc.cc
  ];

  # Some dev env bootstrap scripts # yellow = 3; blue = 4
  shellHook = ''
    echo "$(tput bold)$(tput setaf 3)Time to muse my musy musy!$(tput sgr0)"
    echo "$(tput rev)$(tput setaf 3)You're in GNU nix shell environment...$(tput sgr0)"
    # echo ""

    # if [ ! -d "$(pwd)/build" ]; then
    #   echo "$(tput bold)$(tput setaf 3)warning:$(tput sgr0)$(tput bold) boostrapping build directory...$(tput sgr0)"
    #   mkdir -p $(pwd)/build
    # fi
  '';
}
