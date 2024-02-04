{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;

  modulesLib = import ../../lib/modules.nix {inherit lib;};
in {
  options = {
    templates = lib.mkOption {
      description = "FIXME";
      visible = "shallow";
      type = types.submodule ../templates/templates.nix;
    };

    _out = {
      templates = lib.mkOption {
        description = "This modules template output.";
        type = types.str;
        visible = false;
        internal = true;
        readOnly = true;
      };
    };
  };

  config = {
    _out = {
      templates =
        if (! builtins.isNull cfg.templates.templateFile)
        then builtins.readFile cfg.templates.templateFile
        else
          (
            lib.concatStringsSep
            "\n\n"
            [
              cfg.templates.layout._out.latex
              cfg.templates.enumitem._out.latex
              (
                lib.concatStringsSep
                "\n\n"
                (
                  []
                  ++ (cfg.templates.environmentsOutOrdered "latex")
                  ++ (cfg.templates.titlesecOutOrdered "latex")
                  ++ (cfg.templates.latexOutOrdered "latex")
                )
              )
            ]
          );
    };
  };
}
