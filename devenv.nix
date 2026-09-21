{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  packages = [
    pkgs.grass-sass
  ];

  languages = {
    typst.enable = true;
  };

  scripts = {
    didactic = {
      exec = ./didactic/didactic.sh;
      description = "Build or watch the website (usage: didactic [watch])";
    };

    clean = {
      exec = ''
        rm -rf dist
      '';
      description = "Clean build artifacts";
    };
  };

  processes = {
    serve = {
      exec = "./didactic/didactic.sh watch";
    };
  };
}
