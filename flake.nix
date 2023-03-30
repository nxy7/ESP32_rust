{
  description = "A very basic flake";

  inputs = {
    esp-env.url = "github:mirrexagon/nixpkgs-esp-dev";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, esp-env }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          packages = [ pkgs.hello ];
          inputsFrom = [ esp-env.devShells.${system}.esp32s2-idf ];
        };
      });
}
