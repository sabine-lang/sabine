{ pkgs ? import <nixpkgs> { } }:
let
  lib = pkgs.lib;
in
pkgs.stdenv.mkDerivation rec {
  pname = "sabine-gnu";
  version = "0.0.1";

  src = ./.;

  # Compile time dependencies
  nativeBuildInputs = with pkgs; [ gcc gnumake ];

  # Building scripts
  buildPhase = ''
    # Create the build folder
    mkdir -p ./build

    # Run defaulted "all"
    make
  '';

  installPhase = ''
    # Create the binary output dir
    mkdir -p $out/bin

    # Copy the compiled output
    mv ./build/sabine $out/bin/sabine-gnu
  '';

  NIX_LDFLAGS = "-lstdc++";
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    pkgs.stdenv.cc.cc
  ];

  meta = with lib; {
    homepage = "https://github.com/orzklv/sabine";
    description = ''
      A toy compiler named after Sabine
    '';
    licencse = licenses.wtfpl;
    platforms = with platforms; linux ++ darwin;

    # Developers
    maintainers = [
      {
        name = "Sokhibjon Orzikulov";
        email = "sakhib@orzklv.uz";
        handle = "orzklv";
        github = "orzklv";
        githubId = 54666588;
        keys = [{
          fingerprint = "00D2 7BC6 8707 0683 FBB9  137C 3C35 D3AF 0DA1 D6A8";
        }];
      }
      # Sabine, herself here, possibly...
      # {}
    ];
  };
}
