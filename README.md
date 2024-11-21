# Sabine, A Toy Compiler

Just a project where I'm trying things & writing a compiler.

## Motivation

![The Xeet](./.github/assets/xeet.png)

The idea actually sparked after this xeet: [Source](https://x.com/sabine_s_/status/1859272820720537970?s=61).
I was just havin' a good day doin' my job and spamming shit at X. Well, saw this post and I was like: "Aight,
we ballin' :ball:!".

## Development

The project primarily utilizes Nix package manager for development. You need to have Nix package manager installed on your machine. Lowkey, you migth try running project with your distro's coreutils dev toolchain but I'm not going to guarantee you anything.

```shell
# This will use your current NixOS'es nixpkgs
nix-shell

# Utilize flake's locked nixpkgs version
nix develop -c $SHELL
```

## Compiling

The project supports 2 most popular build systems like cmake and gnumake. LLVM is set to default, you have to pass params for gnu. So, assuming whatever we have, you have 2 options:

### nix run / nix build

```shell
# For defaulted LLVM
nix build .

# For GNU
nix build .#gnu
```

### Manual

```shell
# GNU / Make
mkdir -p ./build
make
./sabine

# LLVM / CMake
mkdir -p ./build
cd ./build
cmake ..
cmake --build .
./sabine
```

## License

This project is licensed under WTFPL license which grants you what the fuckever you want. Just don't roast me
posting shit on X. I'm not that nerd of geek as you may think.
