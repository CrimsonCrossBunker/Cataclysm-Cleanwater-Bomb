local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "EXODII_FM_UPDATE_PLACE_TENTS",
    layout = {
        nested = { { x = 0, y = 8, id = "EXODII_FM_UPDATE_PLACE_TENTS" } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "EXODII_FM_UPDATE_PLACE_WAREHOUSE",
    layout = {
        nested = { { x = 0, y = 0, id = "EXODII_FM_UPDATE_PLACE_WAREHOUSE" } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "EXODII_FM_UPDATE_PLACE_AUTODOC",
    layout = {
        nested = {
            { x = 23, y = 0, id = "EXODII_FM_UPDATE_PLACE_AUTODOC_1" },
            { x = 23, y = 1, id = "EXODII_FM_UPDATE_PLACE_AUTODOC_2" },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "EXODII_FM_UPDATE_PLACE_AUTODOC_1",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain = { [" "] = "t_floor" },
        furniture = { [" "] = "f_autodoc_couch" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "EXODII_FM_UPDATE_PLACE_AUTODOC_2",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain = { [" "] = "t_floor" },
        furniture = { [" "] = "f_autodoc" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "EXODII_FM_UPDATE_PLACE_TENTS",
    layout = {
        size = { width = 15, height = 15 },
        rows = {
            "               ",
            " ######..o hth ",
            " #x.rrrr..     ",
            " #t.rrrr..     ",
            " #x.rrrr..  F  ",
            " #+++##..o     ",
            " #c.t#.... h   ",
            " #####...   t  ",
            "  o.....o   h  ",
            " ...rrrr###    ",
            "o..rrrr.+c#    ",
            " .rrrr.o###    ",
            "  ..#+#        ",
            "   o#c#        ",
            "    ###        ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { x = 0, y = 0, z = 1, id = "EXODII_FM_UPDATE_PLACE_TENTS_z1" } },
        faction_areas = { { id = "free_merchants", x = { 0, 14 }, y = { 0, 14 } } },
        npc_placements = {
            { id = "exodii_free_merchant", x = 5, y = 3 },
            { id = "guard", x = 11, y = 6 },
            { id = "guard", x = 12, y = 8 },
        },
        item_groups = { c = { group = "bed", chance = 100 } },
        item_spawns = { F = { id = "pot", chance = 100 } },
        zone_placements = {
            { id = "LOOT_UNSORTED", faction = "free_merchants", x = 2, y = { 2, 4 } },
            {
                id = "LOOT_ITEM_GROUP",
                filter = "NC_ROBOFAC_FREE_MERCHANT_misc",
                faction = "free_merchants",
                x = 2,
                y = 2,
            },
            {
                id = "LOOT_ITEM_GROUP",
                filter = "NC_ROBOFAC_FREE_MERCHANT_misc",
                faction = "free_merchants",
                x = 2,
                y = 4,
            },
        },
        terrain = {
            ["."] = "t_dirt",
            r = "t_carpet_red_outdoor",
            ["#"] = "t_dirt",
            x = "t_dirt",
            c = "t_dirt",
            F = "t_pit_shallow",
            o = "t_wood_sunshade_pole",
        },
        furniture = {
            ["#"] = "f_skin_wall",
            ["+"] = "f_skin_door",
            x = "f_crate_o",
            t = "f_table",
            h = "f_chair",
            F = "f_firering",
        },
        traps = { c = "tr_fur_rollmat", v = "tr_funnel" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "EXODII_FM_UPDATE_PLACE_TENTS_z1",
    layout = {
        size = { width = 15, height = 15 },
        rows = {
            "               ",
            " ,,,,,,...     ",
            " ,,,,,,...     ",
            " ,,,,,,...     ",
            " ,,,,,,...     ",
            " ,,,,,,...     ",
            " ,,,,,....     ",
            " ,,,,,...      ",
            "  .......      ",
            " .......,,,    ",
            "........,,,    ",
            " .......,,,    ",
            "  ..,,,        ",
            "   .,,,        ",
            "    ,,,        ",
        },
        rotation = { 0, 3 },
        faction_areas = { { id = "free_merchants", x = { 0, 14 }, y = { 0, 14 } } },
        terrain = { ["."] = "t_canvas_roof", [","] = "t_canvas_roof" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "EXODII_FM_UPDATE_PLACE_WAREHOUSE",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "###                     ",
            "#c#                     ",
            "#+#                     ",
            "                        ",
            "                        ",
            "   o   xxx   xxx   o    ",
            "               x        ",
            "                        ",
            "                        ",
            "       o       o        ",
            "                        ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { x = 0, y = 0, z = 1, id = "EXODII_FM_UPDATE_PLACE_WAREHOUSE_z1" } },
        faction_areas = { { id = "free_merchants", x = { 0, 23 }, y = { 0, 23 } } },
        npc_placements = { { id = "guard", x = 12, y = 12 } },
        item_groups = { c = { group = "bed", chance = 100 } },
        terrain = { ["."] = "t_dirt", ["#"] = "t_dirt", c = "t_dirt", o = "t_wood_sunshade_pole" },
        furniture = { ["#"] = "f_skin_wall", ["+"] = "f_skin_door", x = "f_crate_o" },
        traps = { c = "tr_fur_rollmat", v = "tr_funnel" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "EXODII_FM_UPDATE_PLACE_WAREHOUSE_z1",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "...                     ",
            "...                     ",
            "...                     ",
            "                        ",
            "                        ",
            "   ,,,,,,,,,,,,,,,,,    ",
            "     ,,,,,,,,,,,,,      ",
            "      ,,,,,,,,,,,       ",
            "       ,,,,,,,,,        ",
            "       ,,,,,,,,,        ",
            "                        ",
        },
        rotation = { 0, 3 },
        faction_areas = { { id = "free_merchants", x = { 0, 23 }, y = { 0, 23 } } },
        terrain = { ["."] = "t_canvas_roof", [","] = "t_canvas_roof" },
    },
}
