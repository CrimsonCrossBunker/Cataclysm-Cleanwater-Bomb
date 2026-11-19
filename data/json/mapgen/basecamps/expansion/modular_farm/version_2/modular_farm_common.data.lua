local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmf_2",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            ";;;;;;;;;;;;;;;;;;;;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            ";                  ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            ";                  ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            ";                  ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            ";                  ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            ";                 ;;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            ";                  ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            ";                  ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            "                        ",
        },
        palettes = { "fbmf_2_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_farm_2_0",
    layout = {
        nested = { { id = "fbmf_2", x = 0, y = 0 } },
    },
}

-- Dummy map to add recipes to preexisting farm extensions as a fallback
ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmf_2_fallback_recipe_1",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        palettes = { "fbmf_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmf_2_fallback_recipe_1",
    layout = {
        nested = { { id = "fbmf_2_fallback_recipe_1", x = 0, y = 0 } },
    },
}
