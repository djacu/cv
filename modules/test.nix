{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      date = lib.mkOption {
        description = "A single date.";
        type = types.submodule {
          options = (
            lib.genAttrs
            ["basic" "separator" "order" "userStr" "monthLong" "monthShort" "monthLanguage"]
            (name: lib.mkOption {type = types.submoduleWith {modules = [./date.nix];};})
          );
        };
      };
      dates = lib.mkOption {
        description = "A date range.";
        type = types.submodule {
          options = (
            lib.genAttrs
            ["empty" "basic" "separator"]
            (
              name:
                lib.mkOption {
                  type = types.submoduleWith {
                    modules = [./dateRange.nix];
                  };
                }
            )
          );
        };
      };
      socials = lib.mkOption {
        type = types.submodule {
          options = (
            lib.genAttrs
            ["basic"]
            (name: lib.mkOption {type = types.submoduleWith {modules = [./socials.nix];};})
          );
        };
      };
      address = lib.mkOption {
        type = types.submodule {
          options = (
            lib.genAttrs
            ["basic" "format"]
            (name: lib.mkOption {type = types.submoduleWith {modules = [./address.nix];};})
          );
        };
      };
      education = lib.mkOption {
        description = "An education entry.";
        type = types.submodule {
          options = (
            lib.genAttrs
            ["empty" "basic" "endDate"]
            (
              name:
                lib.mkOption {
                  type = types.submoduleWith {
                    modules = [./education.nix];
                  };
                }
            )
          );
        };
      };
      experience = lib.mkOption {
        description = "An experience entry.";
        type = types.submodule {
          options = (
            lib.genAttrs
            ["empty" "basic"]
            (
              name:
                lib.mkOption {
                  type = types.submoduleWith {
                    modules = [./experience.nix];
                  };
                }
            )
          );
        };
      };
    };
  };
  config = {
    nixcv = {
      date = {
        basic = {
          year = 2021;
          month = 11;
          day = 4;
        };
        separator = {
          year = 2021;
          month = 11;
          day = 4;
          sep = ".";
          order = "dmy";
        };
        order = {
          year = 2021;
          month = 11;
          day = 4;
          order = "dmy";
        };
        userStr = {
          userStr = "I can write anything!";
        };
        monthLong = {
          year = 2021;
          month = 11;
          day = 4;
          monthFormat = "long";
        };
        monthShort = {
          year = 2021;
          month = 11;
          day = 4;
          monthFormat = "short";
        };
        monthLanguage = {
          year = 2023;
          month = 12;
          day = 14;
          monthLanguage = "blah";
          monthFormat = "long";
          _months.blah = {
            short = {
              "1" = "xxx.";
              "2" = "xxx.";
              "3" = "xxx.";
              "4" = "xxx.";
              "5" = "xxx";
              "6" = "xxx.";
              "7" = "xxx.";
              "8" = "xxx.";
              "9" = "xxx.";
              "10" = "xxx.";
              "11" = "xxx.";
              "12" = "xxx.";
            };
            long = {
              "1" = "YYYJanuary";
              "2" = "YYYFebruary";
              "3" = "YYYMarch";
              "4" = "YYYApril";
              "5" = "YYYMay";
              "6" = "YYYJune";
              "7" = "YYYJuly";
              "8" = "YYYAugust";
              "9" = "YYYSeptember";
              "10" = "YYYOctober";
              "11" = "YYYNovember";
              "12" = "YYYDecember";
            };
          };
        };
      };
      dates = {
        empty = {};
        basic = {
          start = {
            year = 2021;
            month = 11;
            day = 4;
          };
          end = {
            year = 2022;
            month = 7;
            day = 16;
          };
        };
        separator = {
          start = {
            year = 2021;
            month = 11;
            day = 4;
          };
          end = {
            year = 2022;
            month = 7;
            day = 16;
          };
          sep = " to ";
        };
      };
      socials = {
        basic = {
          url = "https://djacu.dev/";
        };
      };
      address = {
        basic = {
          street = "123 Nunya Drive Unit 42";
          city = "Clinton";
          state = "MI";
          country = "USA";
          postalCode = "64735";
        };
        format = {
          street = "123 Nunya Drive Unit 42";
          town = "Clinton";
          state = "MI";
          country = "USA";
          postalCode = "64735";
          format = [
            "street"
            "town"
            "state"
            "country"
            "postalCode"
          ];
        };
      };
      education = {
        empty = {};
        basic = {
          organization = "South Hemet Institute of Technology.";
          discipline = "Software Development";
          credential = "Bachelor of Science";
          dates = {
            start = {
              year = 1977;
              month = 7;
              day = 17;
            };
            end = {
              year = 1978;
              month = 8;
              day = 18;
            };
          };
        };
        endDate = {
          organization = "South Hemet Institute of Technology.";
          discipline = "Software Development";
          credential = "Bachelor of Science";
          dates = {
            end = {
              year = 1978;
              month = 8;
              day = 18;
            };
          };
        };
      };
      experience = {
        empty = {};
        basic = {
          organization = "The NixOS Foundation";
          position = "Software Engineer";
          location.userStr = "Remote";
          url = "https://nixos.org/";
          summary = "A did Nix stuff.";
          highlights = "Stabilized flakes.";
          roles = [
            {
              role = "Nix Dev";
              responsibilities = [
                "Make new nix things."
                "Fix old nix things."
              ];
            }
          ];
        };
      };
    };
  };
}
