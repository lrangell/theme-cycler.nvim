(import-macros {: import : def} :config.macros)
(def default-themes [:blue
                     :darkblue
                     :default
                     :delek
                     :desert
                     :elflord
                     :evening
                     :habamax
                     :industry
                     :koehler
                     :lunaperche
                     :morning
                     :murphy
                     :pablo
                     :peachpuff
                     :quiet
                     :ron
                     :shine
                     :slate
                     :torte
                     :zellner])

(def popup-options {:relative :cursor
                    :width 20
                    :row 5
                    :col 5
                    :style :minimal
                    :border :shadow})

(def file-path (.. (vim.fn.stdpath :data) :/themeCycler.txt))

{: default-themes : popup-options : file-path}
