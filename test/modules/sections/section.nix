{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      section = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/sections/section.nix
          [
            "basic"
          ]
        );
      };
    };
  };
  config = {
    test = {
      section = {
        basic = {
          header = "Work Experience";
          order = [
            "nixos-foundation"
            "guix-foundation"
          ];
          content = {
            nixos-foundation = {
              type = "itemlist";
              order = [
                "organization"
                "details"
              ];
              content = {
                organization = {
                  type = "item";
                  content = "The NixOS Foundation";
                  format = {
                    size = "large";
                    bold = true;
                  };
                };
                details = {
                  type = "itemlist";
                  order = [
                    "position"
                    "location"
                    "dates"
                    "nix-dev"
                    "web-dev"
                  ];
                  content = {
                    position = {
                      type = "item";
                      content = "Software Engineer";
                      format = {
                        bold = true;
                      };
                    };
                    location = {
                      type = "item";
                      content = "Remote";
                    };
                    dates = {
                      type = "item";
                      content = "2020 - 2023";
                      format = {
                        italic = true;
                      };
                    };
                    nix-dev = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "Nix Developer";
                        };
                        nix-dev = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              format = {
                                italic = true;
                              };
                              content = [
                                "I make the Nix."
                                "I make the flakes."
                                "I make users cry."
                              ];
                            };
                          };
                        };
                      };
                    };
                    web-dev = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "Web Developer";
                        };
                        nix-dev = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              content = [
                                "I make the Nix site."
                                "I use HTML and CSS only."
                              ];
                            };
                          };
                        };
                      };
                    };
                  };
                };
              };
            };
            guix-foundation = {
              type = "itemlist";
              order = [
                "organization"
                "details"
              ];
              content = {
                organization = {
                  type = "item";
                  content = "The Guix Foundation";
                  format = {
                    size = "large";
                    bold = true;
                  };
                };
                details = {
                  type = "itemlist";
                  order = [
                    "position"
                    "location"
                    "dates"
                    "nix-dev"
                  ];
                  content = {
                    position = {
                      type = "item";
                      content = "Software Engineer";
                      format = {
                        bold = true;
                      };
                    };
                    location = {
                      type = "item";
                      content = "Remote";
                    };
                    dates = {
                      type = "item";
                      content = "2018 - 2020";
                      format = {
                        italic = true;
                      };
                    };
                    nix-dev = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "Nix Developer";
                        };
                        nix-dev = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              format = {
                                italic = true;
                              };
                              content = [
                                "Make new guix things."
                                "Fix old guix things."
                              ];
                            };
                          };
                        };
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
