{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      treefmt-nix,
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
        
        rdb = {
          path = ./rdb;
          description = "rdb Template";
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        treefmt = (treefmt-nix.lib.evalModule pkgs ./treefmt.nix).config.build;
      in
      {
        formatter = treefmt.wrapper;
        checks.formatting = treefmt.check self;

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
