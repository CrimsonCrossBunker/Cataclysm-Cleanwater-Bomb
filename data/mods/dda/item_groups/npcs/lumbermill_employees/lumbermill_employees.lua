local content = require("ccb").content

do
    local group = content.ItemGroup { id = "LUMBERMILL_MERCHANT_trade", kind = "collection" }
    group:entry { item = "2x4", count = { 10, 20 } }
    group:entry { item = "plank_short", count = { 20, 30 } }
    group:entry { item = "plank_long", count = { 5, 10 } }
    group:entry { item = "wooden_post", count = { 5, 10 } }
    group:entry { item = "wooden_post_short", count = { 5, 20 } }
    group:entry { item = "wooden_post_long", count = { 5, 10 } }
    group:entry { item = "wood_panel", count = { 5, 10 } }
    group:entry { item = "wood_sheet", count = { 1, 5 } }
    group:entry { item = "wood_beam", count = { 1, 3 } }
    group:entry { item = "log", count = { 1, 10 } }
    group:entry { item = "long_pole", count = { 1, 2 } }
    group:entry { item = "wood_block", count = { 1, 10 } }
    group:entry { item = "stick_long", count = { 1, 20 } }
    group:entry { item = "stick", count = { 1, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_LUMBERJACK_worn", kind = "collection" }
    group:entry {
        distribution = {
            { group = "clothing_work_boots" },
            { item = "boots_combat" },
            { item = "boots_denim" },
        },
    }
    group:entry {
        distribution = {
            { item = "hat_hard" },
            { group = "hat_hard_modified" },
            { item = "hat_hard_hooded" },
            { group = "hat_hard_hooded_modified" },
            { item = "hat_ball" },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "gloves_leather" },
            { item = "gloves_work" },
            { item = "gloves_cut_resistant" },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { group = "clothing_glasses" },
            { item = "glasses_safety" },
        },
        probability = 70,
    }
    group:group("clothing_watch", 70)
    group:item("tool_belt", 60)
    group:group("underwear")
    group:group("socks_unisex")
    group:entry {
        distribution = {
            { item = "apron_cut_resistant" },
            { item = "apron_leather" },
            { item = "chaps_cut_resistant" },
            { item = "chaps_leather" },
        },
        probability = 60,
    }
    group:entry {
        distribution = {
            {
                collection = {
                    {
                        distribution = {
                            { group = "clothing_work_pants" },
                            { item = "pants_cargo" },
                            { item = "jeans" },
                        },
                    },
                    { group = "clothing_work_torso" },
                },
                probability = 80,
            },
            { item = "technician_coveralls", probability = 15 },
            { item = "technician_coveralls_h", probability = 5 },
        },
    }
    content.add(group)
end
