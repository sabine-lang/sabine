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

    # Library of various implementations
    libsabine.url = "github:sabine-lang/libsabine";
  };

  outputs =
    {
      self,
      nixpkgs,
      utils,
      libsabine,
    }@inputs:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        # Nix script formatter
        formatter = pkgs.nixfmt-rfc-style;

        # Development environment
        devShells.default = import ./shell.nix { inherit inputs pkgs; };

        # Output packages
        packages.default = pkgs.callPackage ./. { inherit inputs; };
      }
    )

    # and
    //

      # Possible static attrsets (just in case for the future)
      {
      };
}
