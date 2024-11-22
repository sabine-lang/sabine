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

  # Some dev env bootstrap scripts # yellow = 3; blue = 4
  shellHook = ''
    echo "$(tput bold)$(tput setaf 4)Time to muse my musy musy!$(tput sgr0)"
    echo "$(tput rev)$(tput setaf 4)You're in LLVM nix shell environment...$(tput sgr0)"

    # log () {
    #   local _type="3" # 4, trace by default, 3 for warning
    #   local _kind="warning:" # warning message by default

    #   if [ $# -eq 0 ]; then
    #     echo "$(tput bold)$(tput setaf $_type)no type either message was supplied to log function!$(tput sgr0)"
    #     return 1
    #   fi

    #   if [ $# -eq 0 ]; then
    #     if [ "$1" -eq "warn" ]; then
    #       _type="3"
    #       _kind="warning:"
    #     elif [ "$1" -eq "trace" ]; then
    #       _type="4"
    #       _kind="trace:"
    #     fi
    #   fi

    #   echo "$(tput bold)$(tput setaf $_type)$_kind$(tput sgr0)$(tput bold) $2.$(tput sgr0)"

    #   unset _type
    #   unset _kind
    # }

    # bootstrap () {
    #   local _build="$(pwd)/build"

    #   if [ ! -d "$(pwd)/build" ]; then
    #     log "warn" "boostrapping build directory..."
    #     mkdir -p $(pwd)/build
    #     cwp="$(pwd)"
    #     cd $
    #   fi
    # }

    # _build="$(pwd)/build"
    # if [ -d $_build ]; then
    #   log "trace" "build folder exists, checking toolchain type"

    #   _file="$_build/toolchain"
    #   if [ -f $_file ] then
    #     content="`cat $_file`"
    #   else
    #     echo "$(tput bold)$(tput setaf 3)warning:$(tput sgr0)$(tput bold) unknown toolchain type, cleaning up$(tput sgr0)"
    #     rm -rf $_build
    #   fi
    # fi

    # echo "LLVM" > $(pwd)/buid/toolchain
  '';
}
