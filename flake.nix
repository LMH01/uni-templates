{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    {
      templates = {
        alpro = {
          path = ./alpro;
          description = "1st Semester Alpro Template";
        };

        dzi = {
          path = ./dzi;
          description = "3rd Semester dzi Template";
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        formatter = pkgs.nixfmt-rfc-style;

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            deadnix
            statix
            just
            nil
            nix-melt
            nixfmt-rfc-style
          ];
        };
      }
    );
}
