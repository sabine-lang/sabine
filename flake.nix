{
  #    _____       __    _               ______                      _ __
  #   / ___/____ _/ /_  (_)___  ___     / ____/___  ____ ___  ____  (_) /__  _____
  #   \__ \/ __ `/ __ \/ / __ \/ _ \   / /   / __ \/ __ `__ \/ __ \/ / / _ \/ ___/
  #  ___/ / /_/ / /_/ / / / / /  __/  / /___/ /_/ / / / / / / /_/ / / /  __/ /
  # /____/\__,_/_.___/_/_/ /_/\___/   \____/\____/_/ /_/ /_/ .___/_/_/\___/_/
  #                                                     /_/
  #                  A toy compiler written from scratch on C
  description = "Building a compiler named Sabine";

  # Repos
  inputs = {
    # If you want something stable
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";

    # If you want fresh deps out of oven
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # A few useful nix functions for painless flake management
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , utils
    } @ inputs:
    utils.lib.eachDefaultSystem
      (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # There will be llvm hosted binary
        # LLVM will be default (I <3 LLVM)
        llvm = pkgs.callPackage ./. { };

        # Also, there will be GNU hosted binary
        # To at least have it as option
        gnu = pkgs.callPackage ./default-gnu.nix { };
      in
      {
        # Nix script formatter
        formatter = pkgs.nixpkgs-fmt;

        # Development environment
        devShells = {
          gnu = import ./shell-gnu.nix { inherit pkgs; };
          default = import ./shell.nix { inherit pkgs; };
        };

        # Output packages
        packages = {
          inherit gnu;
          default = llvm;
        };
      })

    // # and

    # Possible static attrsets (just in case for the future)
    { };
}
