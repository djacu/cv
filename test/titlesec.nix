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
        ./modules/titlesec/titleformat.nix
      ];
    })
    .config
    .test
  )
)
