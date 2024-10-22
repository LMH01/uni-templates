{
  description = "RDB Project 1";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake
      {
        inherit inputs;
      }
      {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ];
        perSystem =
          { config
          , pkgs
          , system
          , self
          , ...
          }:
          {
            devShells.default = pkgs.mkShell {
              buildInputs = with pkgs; [
                xorg.libXtst
                xorg.libXxf86vm
                libGL
                maven
                openjdk21
                scenebuilder
              ];

              LD_LIBRARY_PATH = "${pkgs.xorg.libXtst}/lib/:${pkgs.xorg.libXxf86vm}/lib/:${pkgs.libGL}/lib/";
            };
          };

      };
}
