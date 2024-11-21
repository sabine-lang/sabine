{ pkgs ? import <nixpkgs> { } }:
let
  lib = pkgs.lib;
  getLibrary = pkg: "${pkg}/lib";
  getFramework = pkg: "${pkg}/Library/Frameworks";
  darwinOptions =
    if pkgs.stdenv.isDarwin then
      ''
        -F${(getFramework pkgs.darwin.apple_sdk.frameworks.Security)}
        -F${(getFramework pkgs.darwin.apple_sdk.frameworks.CoreFoundation)}
        -F${(getFramework pkgs.darwin.apple_sdk.frameworks.CoreServices)}
        -F${(getFramework pkgs.darwin.apple_sdk.frameworks.SystemConfiguration)}
      ''
    else
      "";
in
pkgs.llvmPackages.stdenv.mkDerivation rec {
  pname = "sabine";
  version = "0.0.1";

  src = ./.;

  nativeBuildInputs = with pkgs; [
    cmake
    llvmPackages.llvm
    llvmPackages.clang-tools
 ];

  cmakeFlags = [
    "-DENABLE_TESTING=OFF"
    "-DENABLE_INSTALL=ON"
  ];

  NIX_LDFLAGS = "-L${(getLibrary pkgs.llvmPackages.llvm)}  ${darwinOptions}";
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    pkgs.llvmPackages.llvm
  ];

  # Some normal fucking detail about the project
  meta = with lib; {
    homepage = "https://github.com/orzklv/sabine";
    description = ''
      A toy compiler named after Sabine
    '';
    licencse = licenses.wtfpl;
    platforms = with platforms; linux ++ darwin;

    # Developers who wasted their time on this shit
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
