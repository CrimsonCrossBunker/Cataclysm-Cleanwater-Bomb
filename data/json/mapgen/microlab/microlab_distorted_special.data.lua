local ccb = require("ccb")

-- distorted science lab nano_fabricator room
ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_final_special_tile",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "   hdh  dd|  |||||||||||",
            "   hdh    2  2     hddh|",
            "    Y     |  |cccc     |",
            "cccccc  |||22||||||||22|",
            "||||||  ||-  -------|  |",
            " +  @|  ||-  --K rr-|  |",
            " | D@|  ||-  -- Y  -|  |",
            " |||||  ||-  --K rr-|  |",
            " +  @|  ||-55G--2---|  |",
            " | D@|  ||-       C-|  |",
            "||||||  ||-  Y  Y C-|22|",
            "   Y    c|-  T  T C-|YY2",
            "   Y   cc|-(((22(((-|YY2",
            "|||2||||||-   YY  A-|22|",
            "|dh    cc|- hh    A-|  |",
            "|dh     c|- dd   AA-|  |",
            "|||||   c|- dd   //-|  |",
            "|cc    cc|- hh  `//-|  |",
            "|c   |||||-   YY //-|  |",
            "|c   Y hd|----------|  |",
            "|cc    hd||||||||||||22|",
            "||||||2||||            |",
            " dd    ccc|  |ccc   ccc|",
            " hh      c|  |||||||||||",
        },
        palettes = { "microlab" },
        furniture = { K = "f_rack", C = "f_machinery_electronic", A = "f_machinery_heavy" },
        terrain = { G = "t_card_science", ["`"] = "t_nanofab", ["/"] = "t_nanofab_body" },
        item_spawns = {
            r = { id = "standard_template_construct" },
            K = { id = "nanomaterial", repetitions = { 25, 75 } },
        },
        monster_glyphs = { T = { id = "mon_turret_rifle", ammunition = { { id = "556", quantity = { 30, 90 } } } } },
        monster_group_placements = {
            {
                group = "GROUP_LAB",
                chance = 2,
                x = { 2, 21 },
                y = { 2, 21 },
                repetitions = { 1, 5 },
            },
        },
        monster_placements = { { id = "mon_mech_lifter", x = 17, y = 13, chance = 75 } },
    },
}

-- distorted science lab nano_forge room
ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_final_special_tile",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "   hdh  dd|  |||||||||||",
            "   hdh    2  2     hddh|",
            "    Y     |  |cccc     |",
            "cccccc  |||22||||||||22|",
            "||||||  ||-  -------|  |",
            " +  @|  ||-  --K rr-|  |",
            " | D@|  ||-  -- Y  -|  |",
            " |||||  ||-  --K rr-|  |",
            " +  @|  ||-55G--2---|  |",
            " | D@|  ||-       C-|  |",
            "||||||  ||-  Y  Y C-|22|",
            "   Y    c|-  T  T C-|YY2",
            "   Y   cc|-(((22(((-|YY2",
            "|||2||||||-   YY  A-|22|",
            "|dh    cc|- hh    A-|  |",
            "|dh     c|- dd   AA-|  |",
            "|||||   c|- dd   //-|  |",
            "|cc    cc|- hh  `//-|  |",
            "|c   |||||-   YY //-|  |",
            "|c   Y hd|----------|  |",
            "|cc    hd||||||||||||22|",
            "||||||2||||            |",
            " dd    ccc|  |ccc   ccc|",
            " hh      c|  |||||||||||",
        },
        palettes = { "microlab" },
        furniture = { K = "f_rack", C = "f_machinery_electronic", A = "f_machinery_heavy" },
        terrain = { G = "t_card_science", ["`"] = "t_nanoforge", ["/"] = "t_nanoforge_body" },
        item_groups = { r = { group = "alloy_sheet_storage", chance = 100, repetitions = { 1, 2 } } },
        item_spawns = { K = { id = "nanomaterial", repetitions = { 25, 75 } } },
        monster_glyphs = { T = { id = "mon_turret_rifle", ammunition = { { id = "556", quantity = { 30, 90 } } } } },
        monster_group_placements = {
            {
                group = "GROUP_LAB",
                chance = 2,
                x = { 2, 21 },
                y = { 2, 21 },
                repetitions = { 1, 5 },
            },
        },
        monster_placements = { { id = "mon_mech_lifter", x = 17, y = 13, chance = 75 } },
    },
}

-- distorted science lab cvdmachin room
ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_final_special_tile",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "   hdh  dd|  |||||||||||",
            "   hdh    2  2     hddh|",
            "    Y     |  |cccc     |",
            "cccccc  |||22||||||||22|",
            "||||||  ||-  -------|  |",
            " +  @|  ||-  --K rr-|  |",
            " | D@|  ||-  -- Y  -|  |",
            " |||||  ||-  --K rr-|  |",
            " +  @|  ||-55G--2---|  |",
            " | D@|  ||-       C-|  |",
            "||||||  ||-  Y  Y C-|22|",
            "   Y    c|-  T  T C-|YY2",
            "   Y   cc|-(((22(((-|YY2",
            "|||2||||||-   YY  A-|22|",
            "|dh    cc|- hh    A-|  |",
            "|dh     c|- dd   AA-|  |",
            "|||||   c|- dd   //-|  |",
            "|cc    cc|- hh  `//-|  |",
            "|c   |||||-   YY //-|  |",
            "|c   Y hd|----------|  |",
            "|cc    hd||||||||||||22|",
            "||||||2||||            |",
            " dd    ccc|  |ccc   ccc|",
            " hh      c|  |||||||||||",
        },
        palettes = { "microlab" },
        furniture = { K = "f_rack", C = "f_machinery_electronic", A = "f_machinery_heavy" },
        terrain = { G = "t_card_science", ["`"] = "t_cvdmachine", ["/"] = "t_cvdbody" },
        item_spawns = { r = { id = "nanomaterial" }, K = { id = "plasma", repetitions = { 1, 3 } } },
        monster_glyphs = { T = { id = "mon_turret_rifle", ammunition = { { id = "556", quantity = { 30, 90 } } } } },
        monster_group_placements = {
            {
                group = "GROUP_LAB",
                chance = 2,
                x = { 2, 21 },
                y = { 2, 21 },
                repetitions = { 1, 5 },
            },
        },
        monster_placements = { { id = "mon_mech_lifter", x = 17, y = 13, chance = 75 } },
    },
}

-- These chunks spawn theme-specific monsters.
ccb.content.define_mapgen {
    kind = "overmap",
    id = { "microlab_generic_special_room" },
    layout = {
        nested = {
            { x = 0, y = 0, id = "microlab_final_special_tile" },
            {
                x = 0,
                y = 0,
                id = {
                    select = { parameter = "labtype", fallback = "microlab_generic" },
                    cases = {
                        microlab_meat = "micolab_meat_pools",
                        microlab_serum = "null",
                        microlab_generic = "null",
                    },
                },
            },
            {
                x = 0,
                y = 0,
                id = {
                    select = { parameter = "labtype", fallback = "microlab_generic" },
                    cases = {
                        microlab_meat = "microlab_meat_unique_foe",
                        microlab_serum = "microlab_serum_unique_foe",
                        microlab_generic = "microlab_unique_foe",
                    },
                },
            },
            {
                x = 0,
                y = 0,
                neighbors = { north_west = "microlab" },
                otherwise = { "concrete_corner" },
            },
            {
                x = 23,
                y = 0,
                neighbors = { north_east = "microlab" },
                otherwise = { "concrete_corner" },
            },
            {
                x = 23,
                y = 23,
                neighbors = { south_east = "microlab" },
                otherwise = { "concrete_corner" },
            },
            {
                x = 0,
                y = 23,
                neighbors = { south_west = "microlab" },
                otherwise = { "concrete_corner" },
            },
        },
        monster_placements = {
            {
                group = {
                    select = { parameter = "labtype", fallback = "microlab_generic" },
                    cases = {
                        microlab_meat = "GROUP_MEATLAB",
                        microlab_serum = "GROUP_SERUM_LAB",
                        microlab_generic = "GROUP_MICROLAB",
                    },
                },
                chance = 80,
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 2, 7 },
            },
        },
        fill_terrain = "t_strconc_floor",
    },
}
