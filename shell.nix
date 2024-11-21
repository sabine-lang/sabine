{ pkgs ? import <nixpkgs> { } }:
let
  # Extract the lib folder from a package
  getLibrary = pkg: "${pkg}/lib";

  # Extract framework path from pkg
  getFramework = pkg: "${pkg}/Library/Frameworks";

  # Frameworks for building on MacOS Beta Sequioa
  darwinOptions =
    if pkgs.stdenv.isDarwin then ''
      -F${(getFramework pkgs.darwin.apple_sdk.frameworks.Security)}
      -F${(getFramework pkgs.darwin.apple_sdk.frameworks.CoreFoundation)}
      -F${(getFramework pkgs.darwin.apple_sdk.frameworks.CoreServices)}
      -F${(getFramework pkgs.darwin.apple_sdk.frameworks.SystemConfiguration)}
    '' else "";
in
pkgs.stdenv.mkDerivation {
  name = "sabine-shell";

  nativeBuildInputs = with pkgs; [
    # GNU Toolchain
    gcc
    gnumake
    pkg-config

    # LLVM & Clang toolchain
    cmake
    llvmPackages.llvm
    llvmPackages.clang-tools

    # Hail the Nix
    nixd
    nixpkgs-fmt

    # Launch scripts
    just
  ];

  # Necessary Environment Variables
  NIX_LDFLAGS = "-L${(getLibrary pkgs.llvmPackages.llvm)}  ${darwinOptions}";
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    pkgs.llvmPackages.llvm
  ];

  # Some dev env bootstrap scripts
  shellHook = ''
    echo "$(tput bold)$(tput setaf 3)Time to muse my musy musy!$(tput sgr0)"
  '';
}
