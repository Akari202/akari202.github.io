{
  description = "My website";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f (import nixpkgs {inherit system;}));
  in {
    packages = forAllSystems (pkgs: {
      default = pkgs.writeShellApplication {
        name = "didactic";

        runtimeInputs = with pkgs; [
          grass-sass
          # typst
        ];

        text = builtins.readFile ./didactic/didactic.sh;
      };
    });

    apps = forAllSystems (pkgs: {
      default = {
        type = "app";
        program = "${self.packages.${pkgs.system}.default}/bin/didactic";
      };
    });

    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        inputsFrom = [self.packages.${pkgs.system}.default];

        shellHook = ''
          echo "Didactic development shell"
        '';
      };
    });
  };
}
