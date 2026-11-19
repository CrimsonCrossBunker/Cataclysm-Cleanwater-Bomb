local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_0",
    layout = {
        size = { width = 6, height = 6 },
        palettes = { "fbml_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_livestock_0",
    layout = {
        nested = { { id = "fbml_0", x = 10, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_coop_yard_chickenwire_east",
    layout = {
        nested = { { id = "fbml_coop_yard_chickenwire", x = 15, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_pasture0_splitrail_north",
    layout = {
        nested = { { id = "fbml_pasture0_splitrail", x = 9, y = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_pasture1_splitrail_center",
    layout = {
        nested = { { id = "fbml_pasture1_splitrail", x = 9, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_pasture2_splitrail_south",
    layout = {
        nested = { { id = "fbml_pasture2_splitrail", x = 9, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_coop_yard_chickenwire",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "f    f",
            "f    f",
            "f    f",
            "f    f",
            "f    f",
            "fdffff",
        },
        palettes = { "fbml_common_palette" },
        zone_placements = { { id = "NPC_NO_INVESTIGATE", faction = "your_followers", x = { 0, 5 }, y = { 0, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_pasture0_splitrail",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "FFDFFF",
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        palettes = { "fbml_common_palette" },
        zone_placements = { { id = "NPC_NO_INVESTIGATE", faction = "your_followers", x = { 0, 5 }, y = { 0, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_pasture1_splitrail",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
            "    FF",
        },
        palettes = { "fbml_common_palette" },
        zone_placements = { { id = "NPC_NO_INVESTIGATE", faction = "your_followers", x = { 0, 5 }, y = { 0, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_pasture2_splitrail",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "    F ",
            "    F ",
            "    D ",
            "    F ",
            "    F ",
            "FFDFF ",
        },
        palettes = { "fbml_common_palette" },
        zone_placements = { { id = "NPC_NO_INVESTIGATE", faction = "your_followers", x = { 0, 5 }, y = { 0, 5 } } },
    },
}
