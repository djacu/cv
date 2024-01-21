{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;

  stringsLib = import ../../lib/strings.nix {inherit lib;};
in {
  imports = [
    ../components/format.nix
    ../components/orderedContent.nix
    ../components/standardListStringOut.nix
    ../components/latexWrapper.nix
    (
      import
      ../components/latexEnvironment.nix
      "blockquote"
    )
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["paragraphs"];
      default = "paragraphs";
      description = "Type";
      internal = true;
    };
  };
  config = {
    latexWrapper = {
      prefix = ["\\begin{${cfg.latexEnvironment}}"];
      suffix = ["\\end{${cfg.latexEnvironment}}"];
      content = cfg.contentsOrdered;
      predicate = x: "  " + (stringsLib.escapeLatex x);
    };
    _out = {
      plaintext = "";
      latex = cfg.latexWrapper.output;
    };
  };
}
