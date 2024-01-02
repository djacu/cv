{
  lib,
  config,
  options,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  utils = import ../../lib/utils.nix {inherit lib;};
in {
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["education"];
      default = "education";
      internal = true;
      description = "Type";
    };
    organization = lib.mkOption {
      description = "The name of the organization.";
      type = types.nullOr types.str;
      default = null;
      example = "South Hemet Institute of Technology";
    };
    location = lib.mkOption {
      description = "The organization location or place where you studied.";
      type = types.nullOr (types.submoduleWith {
        modules = [
          ../components/address.nix
        ];
      });
      default = null;
    };
    url = lib.mkOption {
      description = "The organization website.";
      type = types.nullOr types.str;
      default = null;
      example = "https://www.southhemetit.edu/";
    };
    discipline = lib.mkOption {
      description = "Your area of study or major.";
      type = types.nullOr types.str;
      default = null;
      example = "Software Development";
    };
    credential = lib.mkOption {
      description = "The degree/certificate/etc you received.";
      type = types.nullOr types.str;
      default = null;
      example = "Bachelor";
    };
    dates = lib.mkOption {
      description = "The dates at this organization.";
      type = types.nullOr (types.submoduleWith {
        modules = [
          ../components/dateRange.nix
        ];
      });
      default = null;
      example = "September 2000";
    };
    score = lib.mkOption {
      description = "Your grade point average.";
      type = types.nullOr types.str;
      default = null;
      example = "4.0";
    };
    courses = lib.mkOption {
      description = "Courses you took.";
      type = types.nullOr (types.listOf types.str);
      default = null;
      example = ''
        [
          "DB1101 - Basic SQL"
        ]
      '';
    };

    _latexDedicatedFields = lib.mkOption {
      description = "LaTeX fields with dedication commands.";
      type = types.listOf types.str;
      default = [
        "organization"
        "_title"
        "dates"
      ];
      visible = false;
      internal = true;
    };
    _latexIgnoredFields = lib.mkOption {
      description = "LaTeX fields with dedication commands.";
      type = types.listOf types.str;
      default =
        [
          "discipline"
          "credential"
          "_module"
        ]
        ++ (
          lib.attrNames (
            lib.filterAttrs
            (name: value: ! (value.visible or true) || (value.internal or false))
            options
          )
        );
      visible = false;
      internal = true;
    };

    _title = lib.mkOption {
      description = "The credential and discipline.";
      type = types.nullOr types.str;
      default =
        if (builtins.isNull cfg.credential)
        then cfg.discipline
        else if (builtins.isNull cfg.discipline)
        then cfg.credential
        else if (builtins.isNull cfg.credential && builtins.isNull cfg.discipline)
        then null
        else cfg.credential + " in " + cfg.discipline;
      visible = false;
      readOnly = true;
    };

    _outPlaintext = lib.mkOption {
      description = "This modules plaintext output.";
      type = types.str;
      visible = false;
      readOnly = true;
    };
    _outLatex = lib.mkOption {
      description = "This modules plaintext output.";
      type = types.str;
      visible = false;
      readOnly = true;
    };
  };
  config = let
    miscFields =
      builtins.removeAttrs
      cfg
      (cfg._latexIgnoredFields ++ cfg._latexDedicatedFields);
  in {
    _outPlaintext =
      utils.concatNewlineFiltered
      null
      [
        cfg.organization
        cfg._title
        (cfg.location._outPlaintext or null)
        (cfg.dates._outPlaintext or null)
        cfg.url
        # FIXME: add scores and courses
      ];

    _outLatex = (
      utils.concatStringsSepFiltered
      "\n"
      ""
      [
        "\\begin{education}"
        (lib.optionalString (! builtins.isNull cfg.organization) "\\educationOrg{${cfg.organization}}")
        "\\begin{education}"
        (lib.optionalString (! builtins.isNull cfg._title) "\\educationTitle{${cfg._title}}")
        (lib.optionalString (! builtins.isNull cfg.location) "\\educationLocation{${cfg.location._outPlaintext}}")
        (lib.optionalString (! builtins.isNull cfg.dates) "\\educationDates{${cfg.dates._outPlaintext}}")
        "\\end{education}"
        "\\end{education}"
      ]
    );
    # FIXME: loop over the miscFields (url, scores, and courses). need to figure out how to parse courses
  };
}
