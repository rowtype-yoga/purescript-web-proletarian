let conf = ./spago.dhall

in conf // {
    sources = conf.sources # [ "test/**/*.purs" ],
    dependencies = conf.dependencies #
      [ "spec"
      , "spec-discovery"
      , "foreign-object"
      , "web-dom"
      , "arrays"
      , "strings"
      , "debug"
      , "tailrec"
      ,"datetime",
      "either",
      "foldable-traversable",
      "newtype",
      "transformers",
      "node-fs-aff"
      ]
}
