{lib}: rec {
  /*
  Return the permutations of the input.
  All possible orderings, no repeated elements.

  Type: permutations :: [a] -> [[a]]

  Example:
    permutations [1 2 3]
    => [ [ 1 2 3 ] [ 1 3 2 ] [ 2 1 3 ] [ 2 3 1 ] [ 3 1 2 ] [ 3 2 1 ] ]
  */
  permutations = xs:
    if lib.length xs == 0
    then [[]]
    else
      lib.concatMap (
        x: (
          builtins.map
          (p: [x] ++ p)
          (permutations (lib.filter (y: y != x) xs))
        )
      )
      xs;

  /*
  Return the concatenated permutations of the input.
  All possible orderings, no repeated elements.

  Type: permutations :: [a] -> [a]

  Example:
    permutationsConcat ["a" "b" "c"]
    => [ "abc" "acb" "bac" "bca" "cab" "cba" ]
  */
  permutationsConcat = xs:
    builtins.map
    lib.concatStrings
    (permutations xs);

  /*
  Given a submodule options, return all the parent configuration names.
  Return as a string with each name delimited by a period.

  Type: getSubmoduleParents :: AttrSet -> String

  Example:
    # Given a submodule, date, defined in a config as `nixcv.startDate.date`.
    getSubmoduleParents options
    => "nixcv.startDate"
  */

  getSubmoduleParents = opt:
    lib.concatStringsSep
    "."
    (
      lib.subtractLists
      ["_module" "args"]
      opt._module.args.loc
    );
}