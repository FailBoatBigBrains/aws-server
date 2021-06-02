{
  description = "Flake";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            sublime3
            awscli
            terraform
          ];
          shellHook = ''
            export DISPLAY=:0            
          '';
        };
      }
    );
}
