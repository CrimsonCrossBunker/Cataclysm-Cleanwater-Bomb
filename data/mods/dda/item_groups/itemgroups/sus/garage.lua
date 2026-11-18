local content = require("ccb").content

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a rack of welding gear.
    local group = content.ItemGroup { id = "SUS_welding_gear", kind = "collection" }
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "oxy_torch" },
                    { item = "weldtank", count = { 1, 3 }, probability = 95 },
                    { item = "smallweldtank", count = { 1, 3 }, probability = 95 },
                    { item = "tinyweldtank", count = { 1, 3 }, probability = 95 },
                    { item = "oxygen_cylinder", count = { 1, 2 }, probability = 95 },
                    {
                        distribution = {
                            { item = "brazing_rod_bronze", charges = { 1000, 2000 }, wrapper = "tube_welding_rod" },
                            { item = "brazing_rod_alloy", count = { 500, 1500 }, wrapper = "tube_welding_rod", probability = 70 },
                        },
                    },
                },
                probability = 25,
            },
            { item = "welder" },
        },
    }
    group:entry {
        distribution = {
            { item = "welding_mask", probability = 70 },
            { item = "goggles_welding", probability = 70 },
        },
    }
    group:entry {
        distribution = {
            { item = "welding_rod_steel", charges = { 1000, 1600 }, wrapper = "tube_welding_rod", probability = 90 },
            { item = "welding_rod_alloy", charges = { 1000, 1600 }, wrapper = "tube_welding_rod", probability = 40 },
            { item = "welding_wire_steel", charges = { 1000, 1600 }, wrapper = "spool_welding", probability = 90 },
            { item = "welding_wire_alloy", charges = { 1000, 1600 }, wrapper = "spool_welding", probability = 40 },
            { item = "brazing_rod_bronze", charges = { 500, 1500 }, wrapper = "tube_welding_rod", probability = 80 },
            { item = "brazing_rod_alloy", charges = { 400, 1200 }, wrapper = "tube_welding_rod", probability = 30 },
            { item = "welding_blanket", count = { 0, 1 }, probability = 20 },
            { item = "throat_guard_cut_resistant", count = { 0, 1 }, probability = 10 },
        },
    }
    content.add(group)
end
