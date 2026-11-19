local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "cave_rat" },
    layout = {
        rows = {
            "........................",
            ".........%%%%%%%........",
            "........%%%%%%%%%.......",
            ".......%%%.....%%%......",
            "......%%%%.lll.%%%%.....",
            ".....%%%%%.l l.%%%%%....",
            "....%%%%%%.l l.%%%%%%...",
            "...%%%||||.. ..||||%%%..",
            "..%%%||||||. .||||||%%%.",
            ".%%%%||||rr   rr||||%%%.",
            ".%%%%||||rr   rr||||%%%.",
            ".%%%%||||       ||||%%%.",
            ".%%%%||||   K   ||||%%%.",
            ".%%%%||||       ||||%%%.",
            ".%%%%||||rr   rr||||%%%.",
            "..%%%||||rr   rr||||%%%.",
            "...%%%|||||   |||||%%%..",
            "....%%%||||   ||||%%%...",
            ".....%%%%%%   %%%%%%....",
            "......%%%%%%<%%%%%%.....",
            ".......%%%%%%%%%%%......",
            "........%%%%%%%%%.......",
            ".........%%%%%%%........",
            "........................",
        },
        terrain = {
            [" "] = "t_rock_floor",
            ["."] = "t_rock",
            ["|"] = { { id = "t_rock", copies = 20 }, { id = "t_rock_floor", copies = 80 } },
            ["%"] = { { id = "t_rock" }, { id = "t_rock_floor" } },
            ["<"] = "t_slope_up",
        },
        furniture = {},
        fill_terrain = "t_rock_floor",
        rotation = { 0, 3 },
        monster_glyphs = { K = { id = "mon_rat_king" }, r = { id = "mon_sewer_rat" } },
        item_groups = { l = { group = "bugout_bag", chance = 75 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "cave_underground" },
    weight = 800,
    layout = {
        rows = {
            "........................",
            "..........         .....",
            "...    ... .......  ....",
            "... ..  ..  ..   ..  ...",
            "... ..W  ..   111 ..  ..",
            "... ....  ... 1C1  .W ..",
            "...  ....  .. 111  .. ..",
            "....  ....  ..    ..  ..",
            ".....  ....  ......  ...",
            "......  ....        ....",
            "......W  ...............",
            ".......           ......",
            "....     ... ....  .....",
            ".... ......111....  ....",
            ".... ......1C1.....  ...",
            "..    .....111...... ...",
            ".. ..  ..... ....... ...",
            ".. ...  W     ...... ...",
            ".. ..........  ....  ...",
            "..  ..........      ....",
            "...  ........  ....W....",
            "....          ..........",
            "........W... ...........",
            "............>...........",
        },
        terrain = { ["."] = "t_soil", [" "] = "t_dirt_underground", [">"] = "t_slope_up" },
        fill_terrain = "t_dirt_underground",
        rotation = { 0, 3 },
        nested_glyphs = { C = { id = "goblin_spider_cocoon" } },
        field_glyphs = {
            W = { id = "fd_web", intensity = 2, age_turns = 10 },
            ["1"] = { id = "fd_web", intensity = 3, age_turns = 1 },
        },
        monster_group_glyphs = { W = { group = "GROUP_GOBLIN_SPIDER", chance = 2, density = 0.01 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_spider_cocoon",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "xe_captured_dreamer", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_spider_cocoon",
    layout = {
        size = { width = 1, height = 1 },
        monster_placements = { { id = "mon_redcap_aspirant", x = { 0 }, y = { 0 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_spider_cocoon",
    layout = {
        size = { width = 1, height = 1 },
        monster_placements = { { id = "mon_pooka_aspirant", x = { 0 }, y = { 0 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_spider_cocoon",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "xe_spider_victim", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_spider_cocoon",
    layout = {
        size = { width = 1, height = 1 },
        item_placements = { { id = "corpse", x = 0, y = 0 } },
    },
}
