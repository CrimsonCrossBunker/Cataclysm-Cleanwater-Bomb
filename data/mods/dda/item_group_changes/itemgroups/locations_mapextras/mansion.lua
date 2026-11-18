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

do
    local group = content.ItemGroup { id = "clutter_bedroom", kind = "distribution" }
    group:item("socks", 90)
    group:item("sneakers", 50)
    group:group("ammo_pocket_batteries", 50)
    group:item("sunglasses", 40)
    group:item("socks_wool", 40)
    group:item("towel", 40)
    group:item("can_drink", 30)
    group:item("national_flag", 2)
    group:item("state_flag", 3)
    group:item("shark_plushie", 10)
    group:item("bottle_plastic", 30)
    group:item("leathersandals", 30)
    group:item("espadrilles", 15)
    group:item("leather_belt", 30)
    group:item("bag_plastic", 30)
    group:item("shot_hull", 30)
    group:item("hat_ball", 30)
    group:item("hat_newsboy", 20)
    group:item("house_coat", 20)
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
    group:entry { item = "inhaler", charges = { 10, 100 }, probability = 20 }
    group:item("hairpin", 20)
    group:entry { item = "lighter", charges = { 0, 100 }, probability = 20 }
    group:entry { item = "matches", charges = { 1, 20 }, probability = 20 }
    group:entry { item = "ref_matches", charges = { 1, 32 }, probability = 20 }
    group:item("jersey", 20)
    group:item("fanny", 20)
    group:item("straw_fedora", 10)
    group:item("barrette", 10)
    group:group("box_of_contact_lens_any", 10)
    group:entry { item = "transition_contacts", count = { 6, 6 }, probability = 2 }
    group:item("fedora", 10)
    group:item("firecracker", 5)
    group:item("fc_hairpin", 5)
    group:item("collarpin", 5)
    group:item("mocassins", 5)
    group:item("flask_hip", 5)
    group:item("snuggie", 5)
    group:item("tieclip", 5)
    group:entry { item = "bb", charges = { 1, 500 }, probability = 5 }
    group:item("bone_tainted", 1)
    group:group("corpse_mansion", 1)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "vanity", kind = "distribution" }
    group:item("mirror", 50)
    group:group("softdrugs", 50)
    group:group("box_of_contact_lens_any", 40)
    group:entry { item = "transition_contacts", count = { 6, 6 }, probability = 8 }
    group:item("hairpin", 40)
    group:item("fc_hairpin", 30)
    group:group("jewelry_front", 30)
    group:item("fc_hairpin", 30)
    group:item("barrette", 30)
    group:entry { item = "elec_hairtrimmer", charges = { 0, 50 }, probability = 20 }
    group:item("thread", 20)
    group:item("purse", 20)
    group:item("leg_bag", 1, "purple_leg_bag")
    group:entry { item = "shavingkit", charges = { 0, 10 }, probability = 10 }
    group:entry { item = "sewing_kit", charges = { 0, -1 }, probability = 10 }
    group:item("mag_beauty", 10)
    group:item("mag_glam", 10)
    group:group("harddrugs_residential", 5)
    group:item("hairbrush", 30)
    group:item("comb_pocket", 15)
    group:item("curler_hair", 10)
    group:item("curling_iron", 15)
    group:item("brush_toilet", 15)
    group:group("costume_jewelry_dark", 2)
    group:group("costume_jewelry_vampire", 2)
    content.add(group)
end
