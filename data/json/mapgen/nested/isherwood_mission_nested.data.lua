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
