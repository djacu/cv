{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;

  contentName = "misc";
in {
  imports = [
    (
      import
      ../components/taggedName.nix
      {
        name = contentName;
        submodules = [
          ../templates/newenvironment.nix
          ../titlesec/titleformat.nix
          ../enumitem/enumitem.nix
          ../components/rawlatex.nix
        ];
        ordered = false;
      }
    )
  ];

  options = {
    _out = {
      template = lib.mkOption {
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
      template = (
        lib.concatStringsSep
        "\n\n"
        (cfg."${contentName}OutOrdered" "latex")
      );
    };
  };
}
