local ccb = require("ccb")

-- Rubik's store in the Exodii main base
ccb.content.define_mapgen {
    kind = "nested",
    id = "rubik_store_base",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "T__c_",
            "1__cc",
            "L____",
            "1111T",
            "     ",
        },
        terrain = { _ = "t_metal_floor", ["|"] = "t_junk_wall", T = "t_metal_floor" },
        npc_placements = { { id = "exodii_merchant", x = 2, y = 1 } },
        zone_placements = {
            { id = "LOOT_UNSORTED", faction = "exodii", x = { 0, 0 }, y = { 1, 1 } },
            { id = "LOOT_BIONICS", faction = "exodii", x = { 0, 0 }, y = { 3, 3 } },
            { id = "LOOT_ARMOR", faction = "exodii", x = { 1, 1 }, y = { 3, 3 } },
            { id = "LOOT_AMMO", faction = "exodii", x = { 2, 2 }, y = { 3, 3 } },
            { id = "LOOT_GUNS", faction = "exodii", x = { 3, 3 }, y = { 3, 3 } },
        },
        monster_glyphs = { T = { id = "mon_exodii_turret" } },
        glyph_mappings = {
            ["1"] = { terrain = "t_metal_floor", furniture = "f_locker" },
            c = { terrain = "t_metal_floor", furniture = "f_metal_table" },
            L = { terrain = "t_metal_floor", furniture = "f_exodii_lamp" },
        },
    },
}

-- Luliya's area in the Exodii main base
ccb.content.define_mapgen {
    kind = "nested",
    id = "luliya_base",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "T_1__",
            "1___c",
            "L____",
            "_____",
            "_____",
        },
        terrain = { _ = "t_metal_floor", ["|"] = "t_junk_wall", T = "t_metal_floor" },
        npc_placements = { { id = "exodii_materials", x = 2, y = 1 } },
        item_spawns = { T = { id = "broken_exodii_quad" } },
        glyph_mappings = {
            ["1"] = { terrain = "t_metal_floor", furniture = "f_locker" },
            c = { terrain = "t_metal_floor", furniture = "f_metal_table" },
            L = { terrain = "t_metal_floor", furniture = "f_exodii_lamp" },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "weaponmaster_workshop_base",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "b_L__",
            "S_C_c",
            "S_C@c",
            "S_Cbc",
            "|_Lcc",
        },
        item_placements = {
            { id = "brogyeki", x = 0, y = 1, chance = 100 },
            { id = "sapra", x = 0, y = 2, chance = 100 },
            { id = "spear_dory", x = 0, y = 3, chance = 100 },
            { id = "khuunaofaai", x = 0, y = 1, chance = 100 },
            { id = "pamd71z", x = 0, y = 2, chance = 100 },
            { id = "exodii_plasma_projectile", x = 0, y = 3, chance = 100 },
            { id = "ree_33", x = 0, y = 2, chance = 100 },
        },
        item_groups = { b = { group = "EXODII_Workshop_Damaged", chance = 100, repetitions = { 3, 12 } } },
        glyph_mappings = {
            ["|"] = { terrain = "t_scrap_wall" },
            _ = { terrain = "t_scrap_floor" },
            S = { terrain = "t_scrap_floor", furniture = "f_rack_l" },
            C = { terrain = "t_scrap_floor", furniture = "f_workbench" },
            c = { terrain = "t_scrap_floor", furniture = "f_metal_table" },
            L = { terrain = "t_scrap_floor", furniture = "f_exodii_lamp" },
            b = { terrain = "t_scrap_floor", furniture = "f_metal_crate_o" },
            ["@"] = {
                terrain = "t_scrap_floor",
                furniture = "f_metal_bench",
                npcs = { id = "exodii_weaponmaster" },
            },
        },
    },
}
