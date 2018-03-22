(require 'boot.repl)

(deftask cider "CIDER profile"
  []
  (with-pass-thru [_]
    (swap! boot.repl/*default-dependencies*
           concat '[[org.clojure/tools.nrepl "0.2.12"]
                    [cider/cider-nrepl "0.15.0-SNAPSHOT"]
                    [refactor-nrepl "2.3.0-SNAPSHOT"]])
    (swap! boot.repl/*default-middleware*
           concat '[cider.nrepl/cider-middleware
                    refactor-nrepl.middleware/wrap-refactor])))
