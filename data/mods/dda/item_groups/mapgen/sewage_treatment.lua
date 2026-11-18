local content = require("ccb").content

do
    local group = content.ItemGroup { id = "treatment_chemicals", kind = "distribution" }
    group:entry { item = "bleach", charges = { 10, 126 }, container = "55gal_drum", probability = 50 }
    group:entry { item = "chem_sulphuric_acid", charges = { 2, 50 }, container = "55gal_drum", probability = 20 }
    group:entry {
        collection = {
            { group = "quicklime_barrel", count = { 1, 2 }, probability = 40 },
            { group = "quicklime_barrel_part" },
        },
        probability = 60,
    }
    group:item("55gal_drum", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sewage_samples", kind = "distribution" }
    group:entry { item = "water_sewage", charges = { 1, 1 }, container = "flask_glass", probability = 50 }
    group:entry { item = "water", charges = { 1, 1 }, container = "flask_glass", probability = 50 }
    group:entry { item = "water_clean", charges = { 1, 1 }, container = "flask_glass", probability = 30 }
    group:group("slime_scrap_flask_glass_1", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cannibal_corpse", kind = "collection" }
    group:group("clothing_work_set", 40)
    group:group("supplies_plumbing", 20)
    group:item("corpse")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "slime_scrap_flask_glass_1", kind = "collection", container = "flask_glass" }
    group:item("slime_scrap")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "human_remains", kind = "collection" }
    group:entry { item = "human_flesh", count = { 1, 10 }, probability = 70 }
    group:item("hstomach_large", 60)
    group:item("hstomach", 60)
    group:entry { item = "bone_human", count = { 1, 5 }, probability = 90 }
    group:entry {
        item = "cotton_patchwork",
        count = { 1, 4 },
        flags = {
            "FILTHY",
        },
        probability = 90,
    }
    content.add(group)
end
