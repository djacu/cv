{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  imports = [
    ../components/standardStringOut.nix
    ../components/latexWrapper.nix
    (
      import
      ../components/orderedTaggedContent.nix
      [
        ../sections/personal.nix
        ../sections/section.nix
      ]
    )
    (
      import
      ../components/latexEnvironment.nix
      "document"
    )
  ];
  config = {
    latexWrapper = {
      prefix = ["\\begin{${cfg.latexEnvironment}}"];
      suffix = ["\\end{${cfg.latexEnvironment}}"];
      content = cfg.outOrdered "latex";
      predicate = x: "  " + x;
    };
    _out = {
      plaintext = "";
      latex =
        lib.concatStringsSep
        "\n"
        cfg.latexWrapper.output;
    };
  };
}
