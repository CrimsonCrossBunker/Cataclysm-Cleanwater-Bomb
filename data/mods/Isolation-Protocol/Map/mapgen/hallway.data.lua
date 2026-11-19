local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "iso_hallway_isolated",
    layout = {
        fill_terrain = "t_strconc_floor",
        nested = {
            { id = "microlab_generic_hallway_straight_isolated_tile", x = 0, y = 0 },
            {
                otherwise = { "concrete_corner" },
                x = 0,
                y = 0,
                neighbors = { north_west = "microlab" },
            },
            {
                otherwise = { "concrete_corner" },
                x = 23,
                y = 0,
                neighbors = { north_east = "microlab" },
            },
            {
                otherwise = { "concrete_corner" },
                x = 23,
                y = 23,
                neighbors = { south_east = "microlab" },
            },
            {
                otherwise = { "concrete_corner" },
                x = 0,
                y = 23,
                neighbors = { south_west = "microlab" },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "iso_hallway_safe",
    layout = {
        fill_terrain = "t_strconc_floor",
        nested = {
            { id = "microlab_generic_hallway_safe_tile", x = 0, y = 0 },
            {
                otherwise = { "concrete_corner" },
                x = 0,
                y = 0,
                neighbors = { north_west = "microlab" },
            },
            {
                otherwise = { "concrete_corner" },
                x = 23,
                y = 0,
                neighbors = { north_east = "microlab" },
            },
            {
                otherwise = { "concrete_corner" },
                x = 23,
                y = 23,
                neighbors = { south_east = "microlab" },
            },
            {
                otherwise = { "concrete_corner" },
                x = 0,
                y = 23,
                neighbors = { south_west = "microlab" },
            },
        },
    },
}

-- Plants variant
ccb.content.define_mapgen {
    kind = "nested",
    id = "safe_tile_center",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "====",
            "XXXX",
            "XXXX",
            "====",
        },
        palettes = { "microlab_generic" },
    },
}

-- Autodoc variant
ccb.content.define_mapgen {
    kind = "nested",
    id = "safe_tile_center",
    weight = 500,
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "====",
            "PĀɃP",
            "PPPP",
            "=55=",
        },
        palettes = { "microlab_generic" },
        terrain = {
            ["5"] = "t_door_metal_c",
            ["Ā"] = "t_carpet_concrete_red",
            ["Ƀ"] = "t_carpet_concrete_red",
        },
        furniture = { A = "f_xedra_antenna", ["Ā"] = "f_autodoc_couch", ["Ƀ"] = "f_autodoc_super" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_generic_hallway_straight_tile",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            " cc  | PP  PP  PP |     ",
            " cc  | PP      PP |     ",
            "     | PP ==== PP |cci  ",
            "  |||| PP =XX= PP ||||  ",
            " F|XX= PP =XX= PP =XX|  ",
            "|||XX==[[==XX==[[==XX|||",
            " F|XX= PP =XX= PP =XX|c ",
            " F|XX= PP =XX= PP =XX|c ",
            " F|XX= PP =XX= PP =XX|c ",
            "  |XX= PP =XX= PP =XX|c ",
            "|5|XX= PP =XX= PP =XX|||",
            "  |XX= PP =XX= PP =XX|  ",
            "  |XX= PP =XX= PP =XX|  ",
            "|2|XX= PP =XX= PP =XX|2|",
            "  |XX= PP =XX= PP =XX|  ",
            "c |XX= PP =XX= PP =XX|  ",
            "c |XX= PP =XX= PP =XX|  ",
            "  |XX= PP =XX= PP =XX|cc",
            "|2|XX= PP =XX= PP ||||||",
            "  |XX=YPP =XX= PPY5 í|c ",
            "  |||| PP =XX= PP é|||c ",
            "  icc| PP ==== PP || cc ",
            "    F| PP      PP |F c  ",
            "    F| PP  PP  PP |     ",
        },
        palettes = { "microlab" },
        terrain = { ["é"] = "t_card_science_security_black" },
        furniture = { ["í"] = "f_rack" },
        item_groups = { ["í"] = { group = "iso_remediator_cache", chance = 100 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_generic_hallway_straight_isolated_tile",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "|####| PP  PP  PP |####|",
            "|#|||é PP      PP |####|",
            "|#|í 5 PP ==== PP |####|",
            "|#|||| PP =XX= PP ||||#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX==[[==XX==[[==XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX=YPP =XX= PPY=XX|#|",
            "|#|||| PP =XX= PP ||||#|",
            "|####| PP ==== PP |####|",
            "|####| PP      PP |####|",
            "|||||| PP  PP  PP ||||||",
        },
        palettes = { "microlab" },
        terrain = { ["é"] = "t_card_science_security_black" },
        furniture = { ["í"] = "f_rack" },
        item_groups = { ["í"] = { group = "iso_remediator_cache", chance = 100 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_generic_hallway_straight_tile",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            " cc c| PP  PP  PP |c c  ",
            " cc c| PP  PP  PP |c    ",
            "    c| PP  PP  PP |cci  ",
            "  |||| PP  PP  PP ||||F ",
            " F|XX= PP  PP  PP =XX|F ",
            "|||XX= PP  PP  PP =XX|||",
            " F|XX= PP  PP  PP =XX|c ",
            " F|XX= PP  PP  PP =XX|c ",
            " F|||é PP      PP =XX|i ",
            "  |í 5            =XX|c ",
            "|5||||            ||||||",
            "   2  Y          Y 2    ",
            "   2  Y          Y 2    ",
            "|2||||            ||2|||",
            "   hc|            |c    ",
            "cc  c| PP      PP |6    ",
            "cc  6| PP  PP  PP |c c  ",
            "     | PP  PP  PP |ciccc",
            "|2|||| PP  PP  PP ||||||",
            "  ch | PP  PP  PP |     ",
            "  cc | PP  PP  PP |F i  ",
            "  ch | PP  PP  PP |F c  ",
            "  cc | PP  PP  PP |F i  ",
            "     | PP  PP  PP |     ",
        },
        palettes = { "microlab" },
        terrain = { ["é"] = "t_card_science_security_black" },
        furniture = { ["í"] = "f_rack" },
        item_groups = { ["í"] = { group = "iso_remediator_cache", chance = 100 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_generic_hallway_safe_tile",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "|####| YY    A YY |####|",
            "|####||55||SS||55||####|",
            "|####|YPPY||||YPPY|####|",
            "|#|||||55||||||55|||||#|",
            "|#|b@@|  b bb b  |@@b|#|",
            "|#|b  5YYb bb bYY5  b|#|",
            "|#|b@@|   ms A   |@@b|#|",
            "|#|||||          |||||#|",
            "|#|iY PPPPPPPPPPPP Yi|#|",
            "|#|iY PPPPPPPPPPPP Yi|#|",
            "|#||| PP ====== PP |||#|",
            "|#|Y2 PPY=XXXX=YPP |;|#|",
            "|#|;| PPY=XXXX=YPP 2Y|#|",
            "|#||| PP ====== PP |||#|",
            "|#|úY PPPÃãÃÃÃÃPPP Yú|#|",
            "|#|úY PPPPPPPPPPPP Yú|#|",
            "|#||||| A   s    |||||#|",
            "|#|b@@|    m    A|@@b|#|",
            "|#|b  5YYb bb bYY5  b|#|",
            "|#|b@@|  b bb b  |@@b|#|",
            "|#|||||55||||||55|||||#|",
            "|####|Y  Y||||Y  Y|####|",
            "|####||55||SS||55||####|",
            "|||||| YY      YY ||||||",
        },
        palettes = { "microlab_generic" },
        terrain = { ["5"] = "t_door_metal_c" },
        furniture = {
            A = "f_xedra_antenna",
            ["Ã"] = "f_experimental_crafter",
            ["ã"] = "f_experimental_crafter_terminal",
        },
        nested = { { id = "safe_tile_center", x = 10, y = 10 } },
        item_spawns = {
            m = { id = "xedra_microphone", chance = 90 },
            s = { id = "xedra_seismograph", chance = 90 },
        },
        item_groups = { ["ú"] = { group = "SUS_evac_shelter_locker_used", chance = 95 } },
        sign_glyphs = { S = { text = ccb.content.text("\nNRE-SAFEPOINT\nStatus: ACTIVE") } },
    },
}
