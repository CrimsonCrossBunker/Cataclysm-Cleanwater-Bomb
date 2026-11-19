local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "innawood_ore_vein",
    layout = {
        parameters = {
            ore_type = {
                value_type = "palette",
                default = {
                    weighted = {
                        { id = "innawood_ore_vein_coal", weight = 8 },
                        { id = "innawood_ore_vein_salt", weight = 20 },
                        { id = "innawood_ore_vein_brimstone", weight = 20 },
                        { id = "innawood_ore_vein_copper", weight = 5 },
                        { id = "innawood_ore_vein_cassiterite", weight = 2 },
                        { id = "innawood_ore_vein_iron_galena", weight = 25 },
                        { id = "innawood_ore_vein_iron_hematite", weight = 25 },
                        { id = "innawood_ore_feldspar", weight = 35 },
                        { id = "innawood_ore_graphite", weight = 10 },
                    },
                },
                scope = "overmap_special",
            },
        },
        palettes = { { parameter = "ore_type" } },
    },
}

ccb.content.define_mapgen_palette {
    id = "innawood_ore_vein_coal",
    layout = {
        item_groups = { O = { group = "outcrop_coal", chance = 55 } },
        terrain = {
            ["+"] = "t_rock_coal",
            ["."] = { { id = "t_rock_coal", copies = 2 }, { id = "t_rock", copies = 1 } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "innawood_ore_vein_salt",
    layout = {
        item_groups = { O = { group = "outcrop_hallite", chance = 55 } },
        terrain = {
            ["+"] = "t_rock_halite",
            ["."] = { { id = "t_rock_halite", copies = 2 }, { id = "t_rock", copies = 1 } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "innawood_ore_vein_brimstone",
    layout = {
        item_groups = { O = { group = "outcrop_brimstone", chance = 55 } },
        terrain = {
            ["+"] = "t_rock_brimstone",
            ["."] = { { id = "t_rock_brimstone", copies = 2 }, { id = "t_rock", copies = 1 } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "innawood_ore_vein_copper",
    layout = {
        item_groups = { O = { group = "outcrop_copper", chance = 55 } },
        terrain = {
            ["+"] = "t_rock_copper",
            ["."] = { { id = "t_rock_copper", copies = 2 }, { id = "t_rock", copies = 1 } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "innawood_ore_vein_cassiterite",
    layout = {
        item_groups = { O = { group = "outcrop_cassiterite", chance = 55 } },
        terrain = {
            ["+"] = "t_rock_cassiterite",
            ["."] = { { id = "t_rock_cassiterite", copies = 2 }, { id = "t_rock", copies = 1 } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "innawood_ore_vein_iron_galena",
    layout = {
        item_groups = { O = { group = "outcrop_galena", chance = 55 } },
        terrain = {
            ["+"] = "t_rock_galena",
            ["."] = { { id = "t_rock_galena", copies = 2 }, { id = "t_rock", copies = 1 } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "innawood_ore_vein_iron_hematite",
    layout = {
        item_groups = { O = { group = "outcrop_hematite", chance = 55 } },
        terrain = {
            ["+"] = "t_rock_hematite",
            ["."] = { { id = "t_rock_hematite", copies = 2 }, { id = "t_rock", copies = 1 } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "innawood_ore_feldspar",
    layout = {
        item_groups = { O = { group = "outcrop_feldspar", chance = 55 } },
        terrain = {
            ["+"] = "t_rock_feldspar",
            ["."] = { { id = "t_rock_feldspar", copies = 2 }, { id = "t_rock", copies = 1 } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "innawood_ore_graphite",
    layout = {
        item_groups = { O = { group = "outcrop_graphite", chance = 55 } },
        terrain = {
            ["+"] = "t_rock_graphite",
            ["."] = { { id = "t_rock_graphite", copies = 2 }, { id = "t_rock", copies = 1 } },
        },
    },
}
