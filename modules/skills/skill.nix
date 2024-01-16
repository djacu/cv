{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  imports = [
    (
      import
      ../components/latexEnvironment.nix
      "skills"
    )
    ../components/standardListStringOut.nix
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["skill"];
      default = "skill";
      internal = true;
      description = "Type";
    };
    category = lib.mkOption {
      description = "A category name for the skills.";
      type = types.str;
      example = "Web Development";
    };
    keywords = lib.mkOption {
      description = "The skills for this category.";
      type = types.listOf types.str;
      example = ''
        [
          "HTML"
          "CSS"
          "JavaScript"
        ]
      '';
    };
  };
  config = let
    wrapLatex = input: (
      lib.flatten
      [
        "\\begin{${cfg.latexEnvironment}}"
        (
          builtins.map
          (x: "  " + x)
          input
        )
        "\\end{${cfg.latexEnvironment}}"
      ]
    );
  in {
    _out = {
      plaintext = "";
      latex = wrapLatex (
        ["\\skillsCategory{${cfg.category}}"]
        ++ (
          builtins.map
          (x: "\\skillsKeyword{${x}}")
          cfg.keywords
        )
      );
    };
  };
}
