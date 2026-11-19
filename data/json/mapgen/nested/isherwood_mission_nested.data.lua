local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "isherwood_barry_firing_wall",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "^^^^^^^^^^",
            "^^^^^^^^^^",
            "^^^^^^^^^^",
            "----------",
            "tttttttttt",
            "t        t",
            "          ",
            "          ",
            "          ",
            "          ",
        },
        traps = { ["-"] = "tr_beartrap", ["^"] = "tr_nailboard" },
        furniture = { t = "f_earthbag_half" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "nest_Isherwood_chris_add",
    layout = {
        nested = { { id = "isherwood_barry_chris_spawn", x = 12, y = 18 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "nest_Isherwood_chris_swat_add",
    layout = {
        nested = { { id = "isherwood_barry_chris_swat_spawn", x = 12, y = 18 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "nest_Isherwood_lisa_add",
    layout = {
        nested = { { id = "isherwood_barry_lisa_spawn", x = 12, y = 18 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "nest_Isherwood_lisa_swat_add",
    layout = {
        nested = { { id = "isherwood_barry_lisa_swat_spawn", x = 7, y = 18 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "nest_Isherwood_firing_line_add",
    layout = {
        nested = { { id = "isherwood_barry_firing_line", x = 10, y = 12 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "nest_Isherwood_firing_line_swat_add",
    layout = {
        nested = { { id = "isherwood_barry_firing_line_swat", x = 10, y = 12 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "nest_Isherwood_firing_wall_add",
    layout = {
        nested = { { id = "isherwood_barry_firing_wall", x = 10, y = 12 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "isherwood_barry_riot_drop",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "/",
        },
        item_groups = {
            ["/"] = {
                { group = "armor_riot", chance = 100, repetitions = 5 },
                { group = "helmet_riot", chance = 100, repetitions = 5 },
                { group = "armor_riot_arm", chance = 100, repetitions = 5 },
                { group = "armor_riot_leg", chance = 100, repetitions = 5 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "truck_bomb_spawn",
    layout = {
        item_placements = { { id = "fake_dynamite_50lbs", x = 17, y = 18, flags = { "ACTIVATE_ON_PLACE" } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "isherwood_barry_firing_line",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "          ",
            "          ",
            "          ",
            "          ",
            "          ",
            " . p q l  ",
            "          ",
            "          ",
            "          ",
            "         *",
        },
        terrain = {
            ["."] = "t_dirt",
            p = "t_dirt",
            q = "t_dirt",
            l = "t_dirt",
            ["*"] = "t_dirt_isherwood_player_spawnpoint",
        },
        npc_placements = {
            { id = "isherwood_carlos_copy", x = 2, y = 6 },
            { id = "isherwood_eddie_copy", x = 4, y = 6 },
            { id = "isherwood_luke_copy", x = 6, y = 6 },
            { id = "isherwood_jesse_copy", x = 8, y = 6 },
        },
        vehicle_placements = {
            {
                id = "extended_pickup",
                fuel = 99,
                rotation = 0,
                faction = "isherwood_family",
                x = { 5 },
                y = { 8 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "isherwood_barry_firing_line_swat",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "          ",
            "          ",
            "          ",
            "          ",
            "          ",
            " . p q l  ",
            "          ",
            "          ",
            "          ",
            "         *",
        },
        terrain = {
            ["."] = "t_dirt",
            p = "t_dirt",
            q = "t_dirt",
            l = "t_dirt",
            ["*"] = "t_dirt_isherwood_player_spawnpoint",
        },
        npc_placements = {
            { id = "isherwood_carlos_swat_copy", x = 2, y = 6 },
            { id = "isherwood_eddie_swat_copy", x = 4, y = 6 },
            { id = "isherwood_luke_swat_copy", x = 6, y = 6 },
            { id = "isherwood_jesse_swat_copy", x = 8, y = 6 },
        },
        vehicle_placements = {
            {
                id = "extended_pickup",
                fuel = 99,
                rotation = 0,
                faction = "isherwood_family",
                x = { 5 },
                y = { 8 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "isherwood_barry_chris_spawn",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "isherwood_chris_copy", unique_id = "CHRIS_MISSION", x = 1, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "isherwood_barry_chris_swat_spawn",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "isherwood_chris_swat_copy", unique_id = "CHRIS_MISSION", x = 1, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "isherwood_barry_lisa_spawn",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "isherwood_lisa_copy", unique_id = "LISA_MISSION", x = 1, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "isherwood_barry_lisa_swat_spawn",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "isherwood_lisa_swat_copy", unique_id = "LISA_MISSION", x = 1, y = 1 } },
    },
}
