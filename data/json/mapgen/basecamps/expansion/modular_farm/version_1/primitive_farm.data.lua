local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmf_0",
    layout = {
        size = { width = 6, height = 6 },
        palettes = { "acidia_camp_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_farm_0",
    layout = {
        nested = { { id = "fbmf_0", x = 10, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_farm_long_fields",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "mmmmmm",
            "mmmmmm",
            "      ",
            "      ",
            "      ",
        },
        palettes = { "acidia_camp_palette" },
        flags = { "DISMANTLE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_farm_short_fields",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "mm",
            "mm",
        },
        palettes = { "acidia_camp_palette" },
        flags = { "DISMANTLE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_farm_0",
    layout = {
        size = { width = 13, height = 13 },
        rows = {
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "       U___U ",
            "       _____ ",
            "       _____ ",
            "       _____ ",
            "       _____ ",
            "             ",
        },
        palettes = { "acidia_camp_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_farm_2",
    layout = {
        size = { width = 13, height = 13 },
        rows = {
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "       *,,,* ",
            "       ,''', ",
            "       ,''H, ",
            "       *'HH* ",
            "       ***** ",
            "             ",
        },
        palettes = { "acidia_camp_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_farm_2_roof",
    layout = {
        size = { width = 13, height = 13 },
        rows = {
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "       R   R ",
            "        sss  ",
            "        sss  ",
            "       RsssR ",
            "       RRRRR ",
            "             ",
        },
        palettes = { "acidia_camp_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_farm_3",
    layout = {
        size = { width = 13, height = 13 },
        rows = {
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "        *+*  ",
            "       *   * ",
            "       *   * ",
            "             ",
            "             ",
            "             ",
        },
        palettes = { "acidia_camp_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_farm_3_roof",
    layout = {
        size = { width = 13, height = 13 },
        rows = {
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "        RRR  ",
            "       R   R ",
            "       R   R ",
            "             ",
            "             ",
            "             ",
        },
        palettes = { "acidia_camp_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_farm_4",
    layout = {
        size = { width = 13, height = 13 },
        rows = {
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "  ***+**     ",
            "  *c''u      ",
            "  wc'''      ",
            "  *c'cc      ",
            "  wc'''      ",
            "  *c'cc      ",
            "  ******     ",
        },
        palettes = { "acidia_camp_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_farm_4_roof",
    layout = {
        size = { width = 13, height = 13 },
        rows = {
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "  RRRRRR     ",
            "  Rssss      ",
            "  Vssss      ",
            "  Rssss      ",
            "  Vssss      ",
            "  Rssss      ",
            "  RRRRRR     ",
        },
        palettes = { "acidia_camp_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmf_1",
    layout = {
        nested = { { id = "bc_prim_farm_0", x = 1, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_field_camp_farm_1",
    layout = {
        nested = {
            { id = "bc_prim_farm_long_fields", x = 1, y = 0 },
            { id = "bc_prim_farm_long_fields", x = 9, y = 0 },
            { id = "bc_prim_farm_long_fields", x = 17, y = 0 },
            { id = "bc_prim_farm_long_fields", x = 1, y = 3 },
            { id = "bc_prim_farm_long_fields", x = 9, y = 3 },
            { id = "bc_prim_farm_long_fields", x = 17, y = 3 },
            { id = "bc_prim_farm_long_fields", x = 1, y = 6 },
            { id = "bc_prim_farm_long_fields", x = 9, y = 6 },
            { id = "bc_prim_farm_long_fields", x = 17, y = 6 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_field_camp_farm_2",
    layout = {
        nested = {
            { id = "bc_prim_farm_2", x = 1, y = 10, z = 0 },
            { id = "bc_prim_farm_2_roof", x = 1, y = 10, z = 1 },
            { id = "bc_prim_farm_long_fields", x = 1, y = 6 },
            { id = "bc_prim_farm_long_fields", x = 9, y = 6 },
            { id = "bc_prim_farm_long_fields", x = 17, y = 6 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_field_camp_farm_3",
    layout = {
        nested = {
            { id = "bc_prim_farm_3", x = 1, y = 10, z = 0 },
            { id = "bc_prim_farm_3_roof", x = 1, y = 10, z = 1 },
            { id = "bc_prim_farm_short_fields", x = 15, y = 14 },
            { id = "bc_prim_farm_short_fields", x = 18, y = 14 },
            { id = "bc_prim_farm_short_fields", x = 21, y = 14 },
            { id = "bc_prim_farm_short_fields", x = 15, y = 16 },
            { id = "bc_prim_farm_short_fields", x = 18, y = 16 },
            { id = "bc_prim_farm_short_fields", x = 21, y = 16 },
            { id = "bc_prim_farm_short_fields", x = 15, y = 18 },
            { id = "bc_prim_farm_short_fields", x = 18, y = 18 },
            { id = "bc_prim_farm_short_fields", x = 21, y = 18 },
            { id = "bc_prim_farm_short_fields", x = 15, y = 20 },
            { id = "bc_prim_farm_short_fields", x = 18, y = 20 },
            { id = "bc_prim_farm_short_fields", x = 21, y = 20 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_field_camp_farm_4",
    layout = {
        nested = {
            { id = "bc_prim_farm_4", x = 1, y = 10, z = 0 },
            { id = "bc_prim_farm_4_roof", x = 1, y = 10, z = 1 },
        },
    },
}
