local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_roadblock",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = {
            {
                choices = { "24x24_roadblock_turret", "24x24_roadblock_cops", "24x24_roadblock_crash" },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_roadblock_turret",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "      bbbbb  bbbbb      ",
            "           t            ",
            "                        ",
            "                        ",
            "                        ",
            "  b                 b   ",
            "  b                 b   ",
            "  b                 b   ",
            "  b  x   ssss    @  b   ",
            "   T      Lg   @    x   ",
            " x   @   ssss   x  t x  ",
            "  b                 b   ",
            "  b                 b   ",
            "  b                 b   ",
            "  b                 b   ",
            "                        ",
            "                        ",
            "                        ",
            "            t           ",
            "      bbbbb  bbbbb      ",
            "                        ",
            "                        ",
        },
        furniture = { s = "f_sandbag_half", g = "f_active_backup_generator", b = "f_barricade_road" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        monster_glyphs = {
            T = { id = "mon_feral_cop", chance = 100 },
            t = { id = "mon_feral_cop", chance = 60 },
            L = { id = "mon_turret_searchlight" },
        },
        vehicle_placements = {
            { id = "policecar", x = 12, y = 7, chance = 50, status = 1, rotation = 180 },
            { id = "policecar", x = 11, y = 16, chance = 50, status = 1 },
        },
        item_groups = {
            x = { { group = "corpses_verydead", chance = 75 } },
            ["@"] = {
                { group = "corpses_verydead_no_items", chance = 100 },
                { group = "mon_zombie_cop_death_drops", chance = 75 },
            },
        },
        field_placements = {
            { id = "fd_blood", x = { 2, 4 }, y = { 10, 12 }, repetitions = { 2, 5 } },
            { id = "fd_blood", x = { 17, 21 }, y = { 10, 12 }, repetitions = { 3, 6 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_roadblock_cops",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "       bbbb xbbbbb      ",
            "      b                 ",
            "                        ",
            "                        ",
            "                        ",
            "  b                 b   ",
            "   b   x            b   ",
            "  b x @             b   ",
            "  b     ssss  x     b   ",
            "         gL  @  x       ",
            "        ssss            ",
            "  b          x      b   ",
            "  b                 b   ",
            "  b                  b  ",
            "  b                  b  ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "      bbbbb  bbbbb      ",
            "                        ",
            "                        ",
        },
        furniture = { s = "f_sandbag_half", g = "f_active_backup_generator", b = "f_barricade_road" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        monster_glyphs = { L = { id = "mon_turret_searchlight" } },
        vehicle_placements = {
            { id = "policecar", x = 13, y = 6, chance = 75, status = 1 },
            { id = "policecar", x = 11, y = 17, chance = 75, status = 1, rotation = 180 },
        },
        monster_placements = {
            { group = "GROUP_ZOMBIE_COP", x = { 4, 20 }, y = { 4, 20 }, repetitions = { 2, 4 } },
            { group = "GROUP_ZOMBIE", x = { 4, 20 }, y = { 4, 20 }, repetitions = { 3, 6 } },
        },
        item_groups = {
            x = { { group = "corpses_verydead", chance = 75 } },
            ["@"] = {
                { group = "corpses_verydead_no_items", chance = 100 },
                { group = "mon_zombie_cop_death_drops", chance = 65 },
            },
        },
        item_placements = { { id = "9mm_casing", x = { 7, 14 }, y = { 7, 14 }, chance = 50, repetitions = 40 } },
        field_placements = {
            { id = "fd_blood", x = { 13, 15 }, y = { 11, 13 }, repetitions = { 3, 6 } },
            { id = "fd_blood", x = { 5, 7 }, y = { 7, 9 }, repetitions = { 2, 5 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_roadblock_crash",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "      bbbbb  bbbbb      ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "  b                 b   ",
            "  b                 b   ",
            "  b                 b   ",
            "  b       sssss     b   ",
            "           Lg##         ",
            "          ss#     b     ",
            "  b       ##        b   ",
            "  b                . x  ",
            "  b               . .   ",
            "  b    x            .   ",
            "                  .   . ",
            "          x             ",
            "             . .  .     ",
            "            b    .      ",
            "      bbbbb  b .  .     ",
            "                 .      ",
            "                        ",
        },
        furniture = { s = "f_sandbag_half", g = "f_active_backup_generator", b = "f_barricade_road" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        monster_glyphs = { L = { id = "mon_turret_searchlight" } },
        vehicle_placements = {
            { id = "policecar", x = 12, y = 15, status = 1, rotation = 150 },
            { id = "suv", x = 15, y = 17, status = 1, rotation = 250 },
        },
        monster_placements = {
            { group = "GROUP_ZOMBIE_COP", x = { 4, 20 }, y = { 4, 10 }, repetitions = { 3, 6 } },
            { group = "GROUP_ZOMBIE", x = { 4, 20 }, y = { 4, 10 }, repetitions = { 4, 8 } },
        },
        item_groups = { x = { { group = "corpses_verydead", chance = 75 } } },
        item_spawns = {
            ["#"] = {
                { id = "bag_durasack", amount = { 2, 5 } },
                { id = "material_sand", amount = { 300, 2400 } },
            },
            ["."] = { { id = "splinter", chance = 100, amount = { 1, 3 } }, { id = "2x4", chance = 25 } },
        },
        loot_placements = {
            {
                group = "cop_armory",
                x = { 6, 10 },
                y = { 15, 18 },
                chance = 100,
                repetitions = { 4, 10 },
            },
        },
        field_placements = {
            { id = "fd_blood", x = { 8, 10 }, y = { 16, 18 }, repetitions = { 1, 4 } },
            { id = "fd_blood", x = { 20, 22 }, y = { 14, 17 }, repetitions = { 1, 2 } },
        },
    },
}
