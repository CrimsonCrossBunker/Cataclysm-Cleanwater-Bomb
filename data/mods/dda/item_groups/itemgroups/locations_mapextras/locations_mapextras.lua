local content = require("ccb").content

do
    local group = content.ItemGroup { id = "college_lake", kind = "distribution" }
    group:group("bikini", 120)
    group:item("flag_swimsuit")
    group:item("trunks")
    group:item("rashguard", 30)
    group:item("speedo", 50)
    group:item("swim_briefs", 60)
    group:item("towel")
    group:item("goggles_swim", 30)
    group:item("swim_fins", 20)
    group:item("flotation_vest", 50)
    group:item("swimming_kickboard", 15)
    group:item("diving_watch", 10)
    group:item("sunglasses", 60)
    group:item("fitover_sunglasses", 20)
    group:item("flip_flops", 50)
    group:item("flip_flops_exp", 5)
    group:item("wetsuit_spring", 10)
    group:item("wetsuit_spring_sleeveless", 10)
    group:group("tools_fishingrods_commercial", 30)
    group:item("straw_hat", 80)
    group:item("straw_fedora", 80)
    group:item("silver_ear", 20)
    group:item("bead_ear", 20)
    group:item("silver_necklace", 20)
    group:item("silver_bracelet", 20)
    group:item("silver_locket", 20)
    group:entry { item = "radio", charges = { 0, 100 }, probability = 20 }
    group:group("bottle_otc_painkiller_1_20", 80)
    group:entry { item = "inhaler", charges = { 10, 100 }, probability = 30 }
    group:item("beer", 80)
    group:item("wine_barley", 20)
    group:group("cig_box_cigarette_1_20", 20)
    group:entry { item = "weed", count = { 1, 5 }, probability = 10 }
    group:item("joint", 10)
    group:group("civilian_phones", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "college_camping", kind = "distribution", with_ammo = 50, with_magazine = 100 }
    group:item("daypack", 75)
    group:item("rope_30", 10)
    group:item("hatchet", 50)
    group:item("storage_line", 20)
    group:item("iceaxe", 20)
    group:item("mess_kit")
    group:entry { item = "portable_stove", sealed = false, container = "nylon_bag", probability = 5 }
    group:item("teapot", 50)
    group:item("binoculars", 30)
    group:item("firecracker_pack", 20)
    group:item("knife_hunting", 50)
    group:group("guns_common", 5)
    group:item("backpack")
    group:item("backpack_denim", 10)
    group:item("backpack_leather", 50)
    group:entry { item = "lighter", charges = { 0, 100 } }
    group:entry { item = "ref_lighter", charges = { 0, 50 }, probability = 20 }
    group:entry { item = "matches", charges = { 0, 20 }, probability = 50 }
    group:entry { item = "ref_matches", charges = { 0, 32 }, probability = 50 }
    group:entry { item = "flashlight", charges = { 0, 300 } }
    group:entry { item = "radio", charges = { 0, 100 }, probability = 20 }
    group:entry { item = "small_lighter", charges = { 0, 50 }, probability = 20 }
    group:item("rollmat", 60)
    group:item("tent_kit", 10)
    group:item("hammock", 5)
    group:item("hammock_net", 2)
    group:item("large_tent_kit", 5)
    group:entry {
        distribution = {
            { group = "full_survival_kit" },
            { group = "used_survival_kit" },
        },
        probability = 5,
    }
    group:item("canteen")
    group:item("2lcanteen", 50)
    group:item("camelbak", 25)
    group:item("heatpack")
    group:entry { item = "glowstick", charges = { 1400, 1400 } }
    group:entry { item = "handflare", charges = { 300, 300 }, probability = 30 }
    group:item("emer_blanket", 30)
    group:item("sleeping_bag", 80)
    group:entry { item = "gasoline_lantern", charges = { 40, -1 } }
    group:entry { item = "oil_lamp", charges = { 0, -1 }, probability = 40 }
    group:item("popcan_stove", 10)
    group:item("denat_alcohol", 6)
    group:item("methed_alcohol", 4)
    group:group("pur_tablets_bottle_plastic_small_1_50", 10)
    group:item("water_clean", 50)
    group:item("granola", 60)
    group:item("fruit_leather", 50)
    group:group("licorice_bag_plastic_4", 15)
    group:group("salty_snacks", 130)
    group:group("bottle_otc_painkiller_1_20", 80)
    group:entry { item = "inhaler", charges = { 0, -1 }, probability = 30 }
    group:group("beer_in_container", 80)
    group:item("vodka", 60)
    group:group("cig_box_cigarette_1_20", 20)
    group:item("crackpipe", 10)
    group:entry { item = "weed", count = { 1, 5 }, probability = 10 }
    group:item("joint", 10)
    group:group("civilian_phones", 20)
    group:entry { item = "camera", charges = { 0, 150 }, probability = 15 }
    group:entry { item = "camera", charges = { 0, 150 }, container = "camera_bag", probability = 5 }
    group:item("camera_bag", 10)
    group:item("chem_hexamine", 5)
    group:group("pillbox_any_used", 10)
    content.add(group)
end
