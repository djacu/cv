{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  utils = import ../../lib/utils.nix {inherit lib;};
in {
  imports = [
    (
      import
      ../components/latexEnvironment.nix
      "skillsEnv"
    )
    ../components/standardListStringOut.nix
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["skills"];
      default = "skills";
      internal = true;
      description = "Type";
    };
    content = lib.mkOption {
      description = "Your skills.";
      type = (
        types.attrsOf (types.submoduleWith {
          modules = [
            ./skill.nix
          ];
        })
      );
    };

    order = lib.mkOption {
      description = "The order the skills are written.";
      type = types.nullOr (types.listOf types.str);
      default = null;
    };
  };
  config = {
    _out = let
      contentsOrdered =
        if builtins.isNull cfg.order
        then builtins.attrValues cfg.content
        else
          (
            builtins.map
            (elem: cfg.content.${elem})
            cfg.order
          );
      outOrdered = out: (
        builtins.map
        (x: x._out.${out})
        contentsOrdered
      );
      wrapLatex = input:
        lib.flatten (
          builtins.map
          (
            group:
              [
                "" # the skills environment needs an empty newline between environments for the formatting to look correct
                "\\begin{${cfg.latexEnvironment}}"
              ]
              ++ group
              ++ [
                "\\end{${cfg.latexEnvironment}}"
              ]
          )
          (
            builtins.map
            (
              group:
                builtins.map
                (
                  inner:
                    builtins.map
                    (elem: "  " + elem)
                    inner
                )
                (lib.intersperse ["\\columnbreak"] group)
            )
            (utils.reshape 2 input)
          )
        );
    in {
      plaintext = "";
      latex = wrapLatex (outOrdered "latex");
    };
  };
}
