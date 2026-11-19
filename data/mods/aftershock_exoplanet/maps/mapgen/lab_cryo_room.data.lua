local ccb = require("ccb")

-- Aftershock - cryo pod room
ccb.content.define_mapgen {
    kind = "overmap",
    id = { "afs_cryo_room" },
    weight = 120,
    layout = {
        rows = {
            "|--------|....|--------|",
            "|xP-CC-Px|....|xP-CC-Px|",
            "|........|...6|........|",
            "|x......c|....|c......x|",
            "|x......c|-LL-|c......x|",
            "|........|6..&|........|",
            "|......................|",
            "|....cc.........cc.....|",
            "|l...hx.........xh....l|",
            "|....cc.........cc.....|",
            "|......................|",
            "|........C....C........|",
            "|.......CP....PC.......|",
            "|Wh..................hW|",
            "|Rc..................cR|",
            "|Wh..................hW|",
            "|.......CP....PC.......|",
            "|........C....C........|",
            "|l....................l|",
            "|l...cc.........cc....l|",
            "|....hx.........xh.....|",
            "|....cc.........cc.....|",
            "|........rlllr.........|",
            "|----------------------|",
        },
        trap_placements = { { id = "tr_cryo_pod_switch", x = { 5 }, y = { 8 } } },
        monster_group_placements = {
            {
                group = "AFS_GROUP_ROBOT_MODERATE_RISK",
                chance = 2,
                x = { 2, 21 },
                y = { 2, 21 },
                repetitions = { 1, 5 },
            },
        },
        computer_glyphs = {
            ["6"] = {
                name = ccb.content.text("Cryopod Live Specimen Testing"),
                security = 3,
                menu = { { label = ccb.content.text("UNLOCK ENTRANCE"), action = "unlock", security = 5 } },
                failures = { "damage", "shutdown" },
            },
        },
        glyph_mappings = {
            l = { item_groups = { { group = "gear_soldier_sidearm", chance = 10 } } },
            C = { item_groups = { { group = "afs_weapons_rare", chance = 3 } } },
            c = {
                item_groups = {
                    { group = "afs_scrapgroup", chance = 60 },
                    { group = "surgery", chance = 10 },
                    { group = "chem_lab", chance = 10 },
                    { group = "schematics", chance = 5 },
                },
            },
        },
        fill_terrain = "t_thconc_floor",
        palettes = { "lab_palette_aftershock" },
        furniture = {
            ["7"] = "f_console",
            P = "f_cooling_pylon",
            C = "f_cryo_pod",
            ["&"] = "f_trashcan",
            W = "f_workbench",
            R = "f_crispr",
        },
        terrain = { ["*"] = "t_thconc_floor" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "cryo_pod_open",
    layout = {
        nested = {
            {
                x = 9,
                y = 6,
                choices = {
                    { id = "open_cryo_pod1", weight = 5 },
                    { id = "open_cryo_pod2", weight = 50 },
                    { id = "open_cryo_pod3", weight = 5 },
                    { id = "open_cryo_pod4", weight = 5 },
                    { id = "null", weight = 35 },
                },
            },
            {
                x = 14,
                y = 11,
                choices = {
                    { id = "open_cryo_pod1", weight = 5 },
                    { id = "open_cryo_pod2", weight = 50 },
                    { id = "open_cryo_pod3", weight = 5 },
                    { id = "open_cryo_pod4", weight = 5 },
                    { id = "null", weight = 35 },
                },
            },
            {
                x = 8,
                y = 7,
                choices = {
                    { id = "open_cryo_pod1", weight = 5 },
                    { id = "open_cryo_pod2", weight = 50 },
                    { id = "open_cryo_pod3", weight = 10 },
                    { id = "open_cryo_pod4", weight = 5 },
                    { id = "null", weight = 30 },
                },
            },
            {
                x = 15,
                y = 12,
                choices = {
                    { id = "open_cryo_pod1", weight = 5 },
                    { id = "open_cryo_pod2", weight = 50 },
                    { id = "open_cryo_pod3", weight = 5 },
                    { id = "open_cryo_pod4", weight = 10 },
                    { id = "null", weight = 35 },
                },
            },
            {
                x = 8,
                y = 11,
                choices = {
                    { id = "open_cryo_pod1", weight = 5 },
                    { id = "open_cryo_pod2", weight = 50 },
                    { id = "open_cryo_pod3", weight = 5 },
                    { id = "open_cryo_pod4", weight = 5 },
                    { id = "null", weight = 35 },
                },
            },
            {
                x = 15,
                y = 16,
                choices = {
                    { id = "open_cryo_pod1", weight = 5 },
                    { id = "open_cryo_pod2", weight = 50 },
                    { id = "open_cryo_pod3", weight = 5 },
                    { id = "open_cryo_pod4", weight = 5 },
                    { id = "null", weight = 35 },
                },
            },
            {
                x = 9,
                y = 12,
                choices = {
                    { id = "open_cryo_pod1", weight = 5 },
                    { id = "open_cryo_pod2", weight = 50 },
                    { id = "open_cryo_pod3", weight = 5 },
                    { id = "open_cryo_pod4", weight = 5 },
                    { id = "null", weight = 35 },
                },
            },
        },
    },
}

ccb.content.define_overmap_terrain {
    id = "afs_cryo_room",
    name = ccb.content.text("afs_cryo_room"),
    symbol = "a",
    color = "red",
    flags = { "SHOULD_NOT_SPAWN" },
    see_cost = "none",
}
