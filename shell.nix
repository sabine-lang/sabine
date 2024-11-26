{
  inputs,
  pkgs ? import <nixpkgs> { },
}:
let
  # Extract the lib folder from a package
  getLibrary = pkg: "${pkg}/lib";

  # Libsabine library for extra implementations
  libsabine = inputs.libsabine.packages.${pkgs.stdenv.hostPlatform.system}.default;
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
  NIX_LIBSABINE_HEADER="${libsabine}/include";
  NIX_LDFLAGS = "-L${(getLibrary pkgs.llvmPackages.llvm)} -L${getLibrary libsabine}";
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    pkgs.llvmPackages.llvm
    libsabine
  ];

  # Some dev env bootstrap scripts # yellow = 3; blue = 4
  shellHook = ''
    echo "$(tput bold)$(tput setaf 4)Time to muse my musy musy!$(tput sgr0)"
    echo "$(tput rev)$(tput setaf 4)You're in LLVM nix shell environment...$(tput sgr0)"

    source ${./.github/scripts/log.sh}

    bootstrap () {
      local _cwp="$(pwd)"
      local _build="$(pwd)/build"

      log "warn" "let's see if build folder is fine..."

      if [ -d "$_build" ]; then
        log "trace" "seems like everything lookin' fine here..."

        return
      fi

      if [ ! -d "$_build" ]; then
        log "warn" "boostrapping build directory..."
        mkdir -p $_build

        # Enter build folder
        cd $_build

        # Bootstrap cmake
        cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..

        # Return back
        cd $_cwp
      fi

      return
    }

    bootstrap
  '';
}
