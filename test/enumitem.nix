{lib}: (
  lib.mapAttrs
  (
    moduleName: moduleValue: (
      lib.mapAttrs
      (
        testName: testValue: (
          testValue._out
        )
      )
      moduleValue
    )
  )
  (
    (lib.evalModules {
      modules = [
        ./modules/enumitem/newlist.nix
        ./modules/enumitem/setlist.nix
      ];
    })
    .config
    .test
  )
)
