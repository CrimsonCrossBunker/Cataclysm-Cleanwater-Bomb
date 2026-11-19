local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_2",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "            ; ;;;;;;    ",
            "            ; ;;;;;;    ",
            "            ; ;;;;;;    ",
            "              ;;;;;;    ",
            "              ;;;;;;    ",
            "                        ",
            "                        ",
            ";;;;;;                  ",
            ";;;;;;                  ",
            ";;;;;;                  ",
            ";;;;;;                  ",
            ";;;;;;                  ",
            "                        ",
            "     ;                  ",
            "                ;;;;    ",
            "    ;;;         ;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            "                        ",
        },
        palettes = { "fbmw_2_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_workshop_2_0",
    layout = {
        nested = { { id = "fbmw_2", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_2_common_tanner",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " t r",
            " h B",
            "   r",
            "    ",
        },
        palettes = { "fbmw_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_common_tanner",
    layout = {
        nested = { { id = "fbmw_2_common_tanner", x = 15, y = 1 } },
    },
}
