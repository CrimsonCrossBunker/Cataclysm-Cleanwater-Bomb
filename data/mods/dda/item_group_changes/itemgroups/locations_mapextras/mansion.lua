local content = require("ccb").content

do
    local group = content.ItemGroup { id = "grave_contents", kind = "distribution" }
    group:group("everyday_corpse", 85)
    group:group("grave_cremains", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crate_sports", kind = "collection" }
    group:group("sports_bulk", 90)
    group:group("sports_bulk", 70)
    group:group("sports_bulk", 40)
    group:group("sports_bulk", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "table_wine", kind = "distribution" }
    group:item("glass", 80)
    group:item("towel", 40)
    group:item("ceramic_bowl", 30)
    group:item("bucket", 30)
    group:group("glass_of_wine", 50)
    group:group("wines_worthy", 20)
    group:group("glass_set", 20)
    group:group("tinware", 20)
    group:item("knife_swissarmy", 10)
    group:item("funnel", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clutter_yard", kind = "distribution" }
    group:item("cig_butt", 50)
    group:item("string_6", 50)
    group:item("stick", 50)
    group:item("rock", 50)
    group:item("rock_flaking", 5)
    group:item("flint", 1)
    group:item("rock_large", 5)
    group:item("plastic_shopping_bag", 40)
    group:item("sinew", 40)
    group:item("cotton_patchwork", 40)
    group:item("cup_plastic", 30)
    group:item("can_drink", 30)
    group:item("bottle_plastic", 30)
    group:item("bag_plastic", 30)
    group:item("sharp_rock", 30)
    group:item("box_cigarette", 20)
    group:entry {
        item = "cotton_patchwork",
        flags = {
            "FILTHY",
        },
        probability = 20,
    }
    group:item("9mm_casing", 20)
    group:item("shot_hull", 20)
    group:item("38_casing", 20)
    group:item("45_casing", 20)
    group:item("wrapper", 20)
    group:item("wrapper_foil", 2)
    group:item("bottle_glass", 10)
    group:item("flyer", 10)
    group:item("bone_tainted", 5)
    group:group("corpse_mansion", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clutter_ballroom", kind = "distribution" }
    group:item("ceramic_shard", 40)
    group:item("shot_hull", 40)
    group:item("sinew", 40)
    group:entry { item = "glass_shard", count = { 1, 8 }, probability = 30 }
    group:item("wrapper", 30)
    group:item("wrapper_foil", 3)
    group:item("dance_shoes", 20)
    group:item("dress_shoes", 20)
    group:entry {
        item = "cotton_patchwork",
        flags = {
            "FILTHY",
        },
        probability = 20,
    }
    group:item("9mm_casing", 20)
    group:item("38_casing", 20)
    group:item("45_casing", 20)
    group:item("tieclip", 20)
    group:item("splinter", 20)
    group:item("state_flag", 3)
    group:item("purse", 20)
    group:item("heels", 20)
    group:item("cotton_patchwork", 20)
    group:group("tinware", 20)
    group:item("mask_skull", 10, "guy_fawkes")
    group:item("gold_ear", 10)
    group:item("bone_tainted", 5)
    group:item("silver_ear", 5)
    group:item("bead_ear", 5)
    group:item("platinum_ear", 1)
    group:group("corpse_mansion", 5)
    group:group("neckties", 1)
    content.add(group)
end
