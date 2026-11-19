local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "construction_supplies",
    layout = {
        size = { width = 1, height = 1 },
        item_group_placements = {
            { group = "SUS_trash_floor", x = 0, y = 0, chance = 50, repetitions = { 1, 3 } },
            { group = "SUS_trash_hardware", x = 0, y = 0, chance = 60, repetitions = { 1, 3 } },
            { group = "tools_construction", x = 0, y = 0, chance = 25 },
            { group = "tools_carpentry", x = 0, y = 0, chance = 25 },
            { group = "power_tools", x = 0, y = 0, chance = 25 },
            { group = "tools_home", x = 0, y = 0, chance = 25 },
            { group = "construction_worker", x = 0, y = 0, chance = 20 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "construction_crate_open",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        furniture = { X = "f_crate_o" },
        item_groups = {
            X = {
                { group = "hardware_bulk", chance = 40, repetitions = { 1, 2 } },
                { group = "wood_workshop", chance = 40, repetitions = { 1, 2 } },
                { group = "plumbing_bulk", chance = 30, repetitions = { 1, 2 } },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "construction_crate_closed",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        furniture = { X = "f_crate_c" },
        item_groups = {
            X = {
                { group = "hardware_bulk", chance = 50, repetitions = { 1, 3 } },
                { group = "wood_workshop", chance = 50, repetitions = { 2, 4 } },
                { group = "plumbing_bulk", chance = 40, repetitions = { 1, 3 } },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "construction_bathroom_plumbing",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "~",
        },
        item_groups = {
            ["~"] = {
                { group = "SUS_trash_hardware", chance = 50 },
                { group = "supplies_plumbing", chance = 25, repetitions = { 1, 2 } },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "construction_paint",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "~",
        },
        item_groups = {
            ["~"] = {
                { group = "SUS_trash_hardware", chance = 25 },
                { group = "paint", chance = 25, repetitions = { 1, 3 } },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "construction_bathroom_tools",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "~",
        },
        item_groups = {
            ["~"] = {
                { group = "SUS_trash_hardware", chance = 50, repetitions = { 1, 2 } },
                { group = "tools_plumbing", chance = 30 },
            },
        },
    },
}
