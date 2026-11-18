local content = require("ccb").content

do
    local group = content.ItemGroup { id = "fertilizers", kind = "distribution" }
    group:item("fertilizer_liquid", 90)
    group:group("fertilizer_commercial_bag_canvas_60", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "orchard_supplies", kind = "distribution" }
    group:item("fertilizer_liquid", 10)
    group:group("fertilizer_commercial_bag_canvas_60", 10)
    group:group("insecticide_bag_plastic", 10)
    group:item("pot_canning", 5)
    group:entry { item = "jar_3l_glass_sealed", count = { 2, 10 }, probability = 25 }
    group:entry { item = "wooden_barrel", count = { 2, 4 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "orchard_tools", kind = "collection" }
    group:item("shovel", 5)
    group:entry { item = "trimmer_off", charges = { 0, 600 }, probability = 5 }
    group:item("bucket", 5)
    group:item("bucket_5gal", 10)
    group:item("rake", 15)
    group:item("rake_plastic", 5)
    group:item("stepladder", 15)
    group:entry { item = "pointy_stick", count = { 3, 10 }, probability = 20 }
    group:item("hammer", 10)
    group:item("rope_makeshift_6", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stored_pulp", kind = "distribution", with_ammo = 100, with_magazine = 100 }
    group:entry { item = "wooden_barrel", sealed = true }
    group:group("juice_pulp_wooden_barrel_7_77")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sometimes_manure", kind = "distribution" }
    group:item("null", 3)
    group:entry { item = "feces_manure", count = { 4, 4 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "juice_pulp_wooden_barrel_7_77", kind = "collection", container = "wooden_barrel" }
    group:entry { item = "juice_pulp", count = { 7, 77 } }
    content.add(group)
end
