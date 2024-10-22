{
  description = "Nix flake for dzi dev";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          venvDir = ".venv";
          packages = with pkgs; [
            just
            (python3.withPackages (
              ps: with ps; [
                jupyter
                conda
                pip
                venvShellHook
                numpy
                pandas
                # Doesn't compile for now
                # tensorflow
                toolz
              ]
            ))
          ];
        };
      }
    );
}
