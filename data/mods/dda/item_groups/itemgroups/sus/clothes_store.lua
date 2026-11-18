local content = require("ccb").content

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a mannequin displaying outdoor gear.
    local group = content.ItemGroup { id = "SUS_mannequin_outdoor", kind = "collection" }
    group:group("clothing_outdoor_set")
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a mannequin displaying average clothes.
    local group = content.ItemGroup { id = "SUS_mannequin_general", kind = "distribution" }
    group:entry {
        collection = {
            { group = "shirts_unisex" },
            { group = "pants_unisex" },
            { group = "shoes_unisex", probability = 75 },
        },
        probability = 95,
    }
    group:entry {
        collection = {
            { group = "shirts_womens" },
            { group = "pants_womens" },
            { group = "shoes_womens", probability = 75 },
        },
        probability = 5,
    }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a mannequin displaying fur clothes.
    local group = content.ItemGroup { id = "SUS_mannequin_fur", kind = "collection" }
    group:group("fur_coats_unisex")
    group:entry {
        distribution = {
            { group = "pants_unisex", probability = 80 },
            { group = "fur_pants_womens", probability = 20 },
        },
    }
    group:group("fur_shoes_unisex")
    group:group("fur_gloves_unisex")
    group:group("fur_hats_unisex")
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a mannequin displaying dresses.
    local group = content.ItemGroup { id = "SUS_mannequin_dresses", kind = "collection" }
    group:group("dresses_womens")
    group:group("shoes_womens", 20)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a mannequin displaying formal clothes.
    local group = content.ItemGroup { id = "SUS_mannequin_formal_mens", kind = "collection" }
    group:group("formal_set_mens")
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a container of fasteners for making clothing.
    local group = content.ItemGroup { id = "SUS_tailoring_fasteners", kind = "collection" }
    group:entry { item = "button_plastic", charges = { 4, 20 } }
    group:entry { item = "snapfastener_steel", count = { 1, 5 }, probability = 75 }
    group:entry { item = "zipper_long_plastic", count = { 1, 8 }, probability = 75 }
    group:entry { item = "zipper_short_plastic", count = { 1, 8 }, probability = 75 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a container of tailoring materials.
    local group = content.ItemGroup { id = "SUS_tailoring_materials", kind = "collection" }
    group:entry { item = "thread", count = { 2, 7 }, probability = 75 }
    group:entry { item = "cotton_patchwork", count = { 10, 40 }, probability = 75 }
    group:entry { item = "sheet_cotton", count = { 10, 35 }, probability = 70 }
    group:entry { item = "sheet_felt", count = { 10, 25 }, probability = 40 }
    group:entry { item = "sheet_canvas", count = { 10, 25 }, probability = 35 }
    group:entry { item = "sheet_lycra", count = { 10, 35 }, probability = 20 }
    group:entry { item = "sheet_nylon", count = { 10, 35 }, probability = 20 }
    group:entry { item = "sheet_nomex", count = { 10, 35 }, probability = 5 }
    group:entry { item = "sheet_kevlar", count = { 10, 35 }, probability = 5 }
    group:entry { item = "thread_nomex", count = { 2, 4 }, probability = 10 }
    group:entry { item = "thread_kevlar", count = { 1, 3 }, probability = 5 }
    group:entry { item = "thread_canvas", count = { 2, 5 }, probability = 15 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a container of fur tailoring materials.
    local group = content.ItemGroup { id = "SUS_fur_tailoring_materials", kind = "collection" }
    group:entry { item = "thread", count = { 2, 7 }, probability = 75 }
    group:entry { item = "cotton_patchwork", count = { 5, 15 }, probability = 75 }
    group:entry { item = "sheet_cotton", count = { 10, 25 }, probability = 70 }
    group:entry { item = "tanned_pelt", count = { 5, 35 }, probability = 70 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of tailoring tools.
    local group = content.ItemGroup { id = "SUS_tailoring_tool_drawer", kind = "collection" }
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "awl_steel", probability = 70 },
                    { item = "needle_curved", probability = 75 },
                    { item = "scissors", probability = 90 },
                    { item = "knitting_needles", probability = 20 },
                    { item = "sewing_kit", charges = { 0, -1 }, probability = 85 },
                    { item = "kevlar_shears", probability = 5 },
                },
                probability = 25,
            },
            { item = "tailors_kit", charges = { 0, -1 }, probability = 75 },
            { item = "sewing_machine", probability = 75 },
            { item = "electric_spinwheel", probability = 75 },
        },
    }
    group:entry { item = "thread", count = { 2, 7 }, probability = 75 }
    group:entry { item = "thread_kevlar", count = { 1, 3 }, probability = 6 }
    group:entry { item = "thread_nomex", count = { 2, 5 }, probability = 14 }
    group:entry { item = "thread_canvas", count = { 2, 6 }, probability = 18 }
    content.add(group)
end
