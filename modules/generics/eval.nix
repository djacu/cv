let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  pkgs = import nixpkgs {
    config = {};
    overlays = [];
  };

  section = pkgs.lib.evalModules {
    modules = [
      ./section.nix
      ./exampleSection.nix
    ];
  };

  nixcv = pkgs.lib.evalModules {
    modules = [
      ./nixcv.nix
      ./exampleNixcv.nix
    ];
  };

  skill = pkgs.lib.evalModules {
    modules = [
      ./skill.nix
      ./exampleSkill.nix
    ];
  };

  skills = pkgs.lib.evalModules {
    modules = [
      ./skills.nix
      ./exampleSkills.nix
    ];
  };
in {
  inherit
    nixcv
    section
    skill
    skills
    ;
}
