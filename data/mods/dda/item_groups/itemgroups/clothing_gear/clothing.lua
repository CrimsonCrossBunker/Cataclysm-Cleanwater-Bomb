local content = require("ccb").content

do
    -- Clothes that horse riders wear.
    local group = content.ItemGroup { id = "clothing_riding", kind = "distribution" }
    group:item("helmet_riding", 50)
    group:item("helmet_riding_peakless", 50)
    group:item("hat_hunting", 15)
    group:item("knit_scarf", 25)
    group:item("long_knit_scarf", 25)
    group:item("longshirt", 50)
    group:item("jacket_flannel", 50)
    group:item("coat_winter", 20)
    group:item("coat_light_winter", 30)
    group:item("peacoat", 25)
    group:item("gloves_wool", 25)
    group:item("gloves_wool_fingerless", 12)
    group:item("gloves_leather", 25)
    group:item("leather_belt", 25)
    group:item("breeches", 50)
    group:item("pants_hiking", 50)
    group:item("socks_wool", 25)
    group:item("boots_hiking", 50)
    group:item("boots_western", 50)
    group:item("knee_high_boots", 50)
    group:item("boots", 25)
    group:item("boots_winter", 25)
    group:item("boots_steel", 15)
    group:item("boots_denim", 5)
    group:item("sneakers_steel", 15)
    content.add(group)
end

do
    -- used in shooting_range.
    local group = content.ItemGroup { id = "ear_protection", kind = "distribution" }
    group:entry { item = "powered_earmuffs", charges = { 0, 100 }, probability = 10 }
    group:item("ear_plugs", 50)
    group:entry { item = "powered_earplugs", charges = { 0, 100 }, probability = 10 }
    content.add(group)
end

do
    -- Standard (non-winter) shoes suitable for wearing outdoors.
    local group = content.ItemGroup { id = "clothing_outdoor_shoes", kind = "distribution" }
    group:item("boots")
    group:item("boots_combat", 10)
    group:item("boots_hiking", 40)
    group:item("boots_western", 15)
    group:item("knee_high_boots", 20)
    group:item("thigh_high_boots", 20)
    group:item("boots_denim", 2)
    group:item("shoes_denim", 3)
    content.add(group)
end

do
    -- All the footwear that prisoners might wear.
    local group = content.ItemGroup { id = "clothing_prisoner_shoes", kind = "distribution" }
    group:item("sneakers", 80)
    group:item("boots", 70)
    group:item("lowtops", 45)
    group:item("golf_shoes", 20)
    group:item("boots_combat", 10)
    group:item("boots_hiking", 20)
    group:item("shoes_denim", 5)
    content.add(group)
end

do
    -- Tactical gear that can be strapped to the legs
    local group = content.ItemGroup { id = "clothing_tactical_leg", kind = "distribution" }
    group:item("legpouch_large")
    group:item("legrig")
    content.add(group)
end

do
    -- Tactical gear that can be strapped to the torso
    local group = content.ItemGroup { id = "clothing_tactical_torso", kind = "distribution" }
    group:item("ammo_satchel", 40)
    group:item("ammo_pouch", 40)
    group:item("backpack", 20)
    group:item("camelbak", 40)
    group:item("chestpouch", 40)
    group:item("backpack_tactical_large", 20)
    group:item("tacvest", 160)
    group:group("molle_backpacks_and_accessories")
    group:item("rucksack", 80)
    content.add(group)
end

do
    -- Sturdy boots often worn by technicians and tradesmen.
    local group = content.ItemGroup { id = "clothing_work_boots", kind = "distribution" }
    group:item("boots", 60)
    group:item("boots_hiking", 10)
    group:item("boots_steel", 30)
    group:item("toecaps", 30)
    group:item("sneakers_steel", 21)
    content.add(group)
end

do
    -- Eye protection often worn by technicians and tradesmen.
    local group = content.ItemGroup { id = "clothing_work_glasses", kind = "distribution" }
    group:group("clothing_glasses", 10)
    group:item("glasses_safety", 75)
    group:item("goggles_welding", 15)
    content.add(group)
end

do
    -- Protective gloves often worn by technicians and tradesmen.
    local group = content.ItemGroup { id = "clothing_work_gloves", kind = "distribution" }
    group:item("gloves_leather", 30)
    group:item("gloves_rubber", 10)
    group:item("gloves_work", 60)
    group:item("gloves_cut_resistant", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hat_hard_hooded_modified", kind = "collection", container = "hat_hard_hooded" }
    group:group("common_nape_protectors", 50)
    group:item("plastic_chin_guard", 10)
    content.add(group)
end

do
    -- Common nape protectors for a hard hat or helmet.
    local group = content.ItemGroup { id = "common_nape_protectors", kind = "distribution" }
    group:item("nape_protector", 6)
    group:item("mesh_nape_protector", 4)
    content.add(group)
end

do
    -- Common face shields for a hard hat.
    local group = content.ItemGroup { id = "common_face_shields", kind = "distribution" }
    group:item("face_shield_plastic", 75)
    group:item("face_shield", 25)
    content.add(group)
end

do
    -- Protective masks often worn by technicians and tradesmen.
    local group = content.ItemGroup { id = "clothing_work_mask", kind = "distribution" }
    group:item("mask_dust", 90)
    group:entry { item = "mask_filter", charges = { 0, 100 }, probability = 10 }
    group:entry { item = "mask_gas_half", charges = { 0, 100 }, probability = 10 }
    content.add(group)
end

do
    -- Pants often worn by technicians and tradesmen.
    local group = content.ItemGroup { id = "clothing_work_pants", kind = "distribution" }
    group:item("technician_pants_gray", 60)
    group:item("denim_overalls", 40)
    content.add(group)
end

do
    -- Shirts and jackets often worn by technicians and laborers.
    local group = content.ItemGroup { id = "clothing_work_torso", kind = "distribution" }
    group:entry {
        collection = {
            { item = "technician_shirt_gray" },
            {
                distribution = {
                    { item = "coat_rain", probability = 30 },
                    { item = "jacket_jean", probability = 20 },
                    { item = "vest_jean", probability = 10 },
                    { item = "jacket_light", probability = 40 },
                },
                probability = 20,
            },
        },
    }
    content.add(group)
end

do
    -- Set of clothes worn by technicians and laborers including protective gear
    local group = content.ItemGroup { id = "clothing_work_set", kind = "collection" }
    group:group("clothing_work_boots")
    group:group("clothing_work_glasses", 60)
    group:group("clothing_work_gloves", 75)
    group:group("clothing_work_hat", 60)
    group:group("clothing_work_mask", 40)
    group:entry {
        distribution = {
            { item = "ear_plugs" },
            { item = "attached_ear_plugs_off" },
            { item = "attachable_ear_muffs" },
        },
        probability = 60,
    }
    group:item("tool_belt", 25)
    group:entry {
        distribution = {
            {
                collection = {
                    { group = "clothing_work_pants" },
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

do
    -- Protective equipment often worn in professions that make use of chainsaws and other sawing tools.
    local group = content.ItemGroup { id = "clothing_chainsaw_protection", kind = "distribution" }
    group:item("gloves_cut_resistant", 70)
    group:item("armguard_cut_resistant", 60)
    group:item("chaps_cut_resistant", 50)
    group:item("apron_cut_resistant", 45)
    group:item("balaclava_cut_resistant", 10)
    group:item("throat_guard_cut_resistant", 5)
    content.add(group)
end

do
    -- wearable utility or protective gear you can buy in a common hardware store or find on a jobsite
    -- Not intended to be a set of clothing for NPCs or monsters
    local group = content.ItemGroup { id = "plumbing_clothing", kind = "distribution" }
    group:item("tool_belt", 200)
    group:item("knee_pads", 70)
    group:item("gloves_leather", 70)
    group:item("gloves_rubber", 50)
    group:item("boots_rubber", 20)
    group:item("boots", 70)
    group:item("boots_steel", 50)
    group:item("toecaps", 30)
    group:item("sneakers_steel", 28)
    group:item("fishing_waders", 20)
    group:item("denim_overalls", 20)
    group:item("technician_coveralls", 15)
    group:item("technician_coveralls_h", 5)
    group:item("apron_plastic", 30)
    group:item("apron_leather", 10)
    group:entry { item = "mask_filter", charges = { 0, 100 }, probability = 20 }
    group:item("hat_hard", 50)
    group:entry { item = "wearable_light", charges = { 0, 100 } }
    content.add(group)
end

do
    -- wearable utility or protective gear for a plumbing job, includes tools
    -- Intended to be a set of clothing for NPCs or monsters
    local group = content.ItemGroup { id = "prof-plumbing_gear", kind = "collection" }
    group:item("tool_belt", 60)
    group:entry { group = "tools_plumbing", count = { 1, 2 } }
    group:entry { group = "tools_common_small", count = { 1, 2 } }
    group:group("supplies_plumbing")
    group:group("large_bags")
    group:item("knee_pads", 30)
    group:entry {
        distribution = {
            { item = "gloves_leather", probability = 70 },
            { item = "gloves_rubber", probability = 30 },
        },
        probability = 40,
    }
    group:entry {
        distribution = {
            { item = "boots_rubber" },
            { item = "boots" },
            { item = "boots_steel" },
            { item = "sneakers_steel" },
            { item = "fishing_waders" },
        },
    }
    group:entry {
        distribution = {
            { item = "socks" },
            { item = "socks_ankle" },
        },
    }
    group:entry {
        distribution = {
            {
                collection = {
                    { group = "clothing_work_pants" },
                    { group = "clothing_work_torso" },
                },
                probability = 75,
            },
            { item = "technician_coveralls", probability = 20 },
            { item = "technician_coveralls_h", probability = 5 },
        },
    }
    group:item("hat_hard", 50)
    group:entry {
        distribution = {
            { item = "apron_plastic", probability = 30 },
            { item = "apron_leather", probability = 10 },
        },
        probability = 30,
    }
    group:entry { item = "mask_filter", charges = { 0, 100 }, probability = 20 }
    group:entry { item = "wearable_light", charges = { 0, 100 }, probability = 70 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxing_clothes", kind = "distribution" }
    group:item("tank_top", 40)
    group:item("shorts", 40)
    group:item("boxing_gloves", 50)
    group:item("headgear", 50)
    group:item("mouthpiece", 50)
    group:item("jersey", 40, "generic")
    group:item("coat_rain", 15)
    group:item("hood_rain", 15)
    group:item("unitard", 10)
    group:item("gloves_wraps", 45)
    group:item("jeans", 30)
    group:item("jeans_ripped", 5)
    group:item("sports_bra", 25)
    group:item("jacket_leather", 20)
    group:item("jacket_varsity", 10)
    group:group("bottle_otc_painkiller_20", 30)
    group:item("water_clean", 30)
    group:item("sports_drink", 30)
    group:group("used_1st_aid", 20)
    group:item("fitness_band", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "donated_clothes", kind = "collection" }
    group:group("underwear")
    group:group("clothing_outdoor_torso")
    group:group("clothing_outdoor_pants")
    group:item("socks")
    group:item("boots")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "judo_belts", kind = "distribution" }
    group:item("judo_belt_white")
    group:item("judo_belt_yellow", 50)
    group:item("judo_belt_orange", 25)
    group:item("judo_belt_green", 15)
    group:item("judo_belt_blue", 5)
    group:item("judo_belt_brown", 4)
    group:item("judo_belt_black", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gi", kind = "distribution" }
    group:item("karate_gi")
    group:item("tabi_gi", 25)
    group:item("judo_gi", 50)
    group:item("keikogi", 25)
    group:item("zubon_gi", 25)
    group:item("hakama_gi", 10)
    group:item("obi_gi", 10)
    group:item("mouthpiece", 5)
    group:item("jikatabi_sneakers", 5)
    group:item("geta", 1)
    group:item("haori", 1)
    group:item("yukata", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "shirts_summer_womens", kind = "distribution" }
    group:item("camisole", 5)
    group:item("halter_top", 5)
    group:item("tank_top", 1, "tank_top_cheerleader")
    group:item("cheerleader_top_short", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pants_summer_womens", kind = "distribution" }
    group:item("skirt", 5)
    group:item("skirt_denim", 5)
    group:item("skirt_leather", 5)
    group:item("skirt_long", 5)
    group:item("leggings", 3)
    group:item("tights", 4)
    group:item("hot_pants", 4)
    group:item("hot_pants_fur", 1)
    group:item("hot_pants_leather", 1)
    group:item("cheerleader_skirt", 1)
    group:item("cheerleader_skirt_short", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dress_shop", kind = "distribution" }
    group:item("skirt", 40)
    group:item("skirt_long", 40)
    group:item("skirt_denim", 15)
    group:item("skirt_leather", 5)
    group:item("dress", 120)
    group:item("sundress", 50)
    group:item("nanoskirt", 30)
    group:item("camisole", 60)
    group:item("corset", 20)
    group:item("corset_waist", 20)
    group:item("unitard", 5)
    group:item("leotard", 10)
    group:item("stockings", 50)
    group:item("garter_belt", 25)
    group:item("leggings", 20)
    group:item("tights", 50)
    group:item("cheongsam", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wedding_dresses", kind = "distribution" }
    group:item("dress", 50)
    group:item("veil_wedding", 150)
    group:item("dress_wedding", 150)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wedding_suits", kind = "distribution" }
    group:item("tux")
    group:item("suit", 80)
    group:item("waistcoat", 50)
    group:item("dress_shirt")
    group:item("undershirt", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "suits", kind = "distribution" }
    group:item("dress_shirt")
    group:group("neckties", 50)
    group:item("tieclip", 30)
    group:item("collarpin", 30)
    group:item("undershirt")
    group:item("suit")
    group:item("waistcoat", 70)
    group:item("tophat", 30)
    group:item("tux", 50)
    group:item("gown", 50)
    group:item("long_glove_white", 30)
    group:item("breeches", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fur_coats_unisex", kind = "distribution" }
    group:item("trenchcoat_fur", 4)
    group:item("duster_fur", 4)
    group:item("sleeveless_trenchcoat_fur", 2)
    group:item("sleeveless_duster_fur", 2)
    group:item("coat_fur", 4)
    group:item("cloak_fur", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fur_pants_womens", kind = "distribution" }
    group:item("hot_pants_fur")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fur_hats_unisex", kind = "distribution" }
    group:item("hat_fur")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fur_gloves_unisex", kind = "distribution" }
    group:item("gloves_fur", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fur_shoes_unisex", kind = "distribution" }
    group:item("boots_fur")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fancyfurs", kind = "distribution" }
    group:item("hat_fur", 300)
    group:item("hat_faux_fur", 300)
    group:item("sleeveless_trenchcoat_fur", 10)
    group:item("sleeveless_duster_fur", 10)
    group:item("sleeveless_trenchcoat_faux_fur", 10)
    group:item("coat_faux_fur", 300)
    group:item("coat_fur", 400)
    group:item("gloves_fur", 300)
    group:item("boots_fur", 200)
    group:item("trenchcoat_faux_fur", 50)
    group:item("duster_faux_fur", 50)
    group:item("pants_faux_fur", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hatstore_accessories", kind = "distribution" }
    group:item("scarf", 50)
    group:item("knit_scarf", 50)
    group:item("long_knit_scarf", 30)
    group:item("scarf_long", 30)
    group:item("bandana")
    group:item("hairpin", 50)
    group:item("fc_hairpin", 20)
    group:item("barrette", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "shoestore_accessories", kind = "distribution" }
    group:item("socks")
    group:item("socks_ankle", 75)
    group:item("thermal_socks", 25)
    group:item("socks_wool", 50)
    group:item("string_36", 200)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "allclothes_damaged", kind = "distribution" }
    group:entry { group = "allclothes", damage = { 3, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "postman_carried", kind = "collection", container = "mbag", overflow = "spill" }
    group:entry { item = "letter", container = "envelope" }
    group:entry { item = "letter", container = "envelope" }
    group:entry { item = "postcard", container = "envelope" }
    group:entry { item = "letter", count = { 0, 5 } }
    group:entry { item = "postcard", count = { 0, 5 } }
    group:entry { item = "envelope", count = { 0, 5 } }
    group:entry { item = "newest_newspaper", count = { 0, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "postman_gear", kind = "collection" }
    group:entry {
        distribution = {
            { item = "postman_hat", probability = 80 },
            { item = "hat_ball", probability = 20 },
        },
    }
    group:item("postman_shirt")
    group:item("postman_shorts")
    group:group("postman_carried")
    group:item("wristwatch")
    group:item("leather_belt", 70)
    group:entry {
        distribution = {
            {
                distribution = {
                    { item = "briefs" },
                    { item = "boxer_briefs" },
                    { item = "boxer_shorts" },
                },
            },
            {
                collection = {
                    {
                        distribution = {
                            { item = "bra" },
                            { item = "sports_bra" },
                        },
                    },
                    { item = "panties" },
                },
            },
        },
    }
    group:item("socks")
    group:item("sneakers")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fireman_torso", kind = "distribution" }
    group:item("bunker_coat", 80)
    group:item("vest", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fireman_pants", kind = "distribution" }
    group:item("bunker_pants", 80)
    group:item("nomex_suit", 40)
    group:item("pants_cargo", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fireman_boots", kind = "distribution" }
    group:item("boots_bunker", 70)
    group:item("boots_steel", 20)
    group:item("sneakers_steel", 15)
    group:item("boots_combat", 5)
    group:item("boots_rubber", 10)
    group:item("boots_hiking", 5)
    group:item("nomex_socks", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fireman_gloves", kind = "distribution" }
    group:item("fire_gauntlets", 60)
    group:item("gloves_medical", 5)
    group:item("gloves_tactical", 20)
    group:item("gloves_rubber", 10)
    group:item("nomex_gloves", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fireman_head", kind = "distribution" }
    group:item("firehelmet", 60)
    group:item("hat_knit", 5)
    group:item("nomex_hood", 40)
    group:item("hat_hard", 15, "red_hat_hard")
    group:item("hat_hard_hooded", 6, "red_hat_hard")
    group:item("hat_noise_cancelling", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivorzed_suits", kind = "distribution" }
    group:item("survivor_jumpsuit", 8)
    group:item("lsurvivor_jumpsuit", 10)
    group:item("hsurvivor_jumpsuit", 6)
    group:item("wsurvivor_jumpsuit", 6)
    group:item("wsurvivor_jumpsuit_nofur", 4)
    group:item("touring_suit", 16)
    group:item("armor_larmor", 28)
    group:item("armor_blarmor", 14)
    group:item("armor_farmor", 8)
    group:item("armor_plarmor", 2)
    group:item("armor_riot", 10)
    group:item("armor_scrapsuit", 12)
    group:item("armor_tiresuit", 12)
    group:item("armor_chitin", 2)
    group:item("armor_junk_lightplate", 1)
    group:item("cuirass_lightplate", 2)
    group:item("armor_junk_plate", 1)
    group:item("chainmail_junk_hauberk", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivorzed_tops", kind = "distribution" }
    group:item("vest", 40)
    group:item("kevlar", 16)
    group:item("jacket_army", 5)
    group:item("jacket_army_modern", 16)
    group:item("combat_shirt", 5)
    group:item("trenchcoat", 12)
    group:item("trenchcoat_leather", 10)
    group:item("trenchcoat_fur", 5)
    group:item("sleeveless_trenchcoat", 7)
    group:item("sleeveless_trenchcoat_leather", 5)
    group:item("sleeveless_trenchcoat_fur", 2)
    group:item("duster", 12)
    group:item("duster_leather", 10)
    group:item("duster_fur", 5)
    group:item("sleeveless_duster", 7)
    group:item("sleeveless_duster_leather", 5)
    group:item("sleeveless_duster_fur", 2)
    group:item("peacoat", 14)
    group:item("greatcoat", 7)
    group:item("vest_leather", 22)
    group:item("bunker_coat", 6)
    group:item("bookplate", 10)
    group:item("tireplate", 10)
    group:item("ballistic_vest_esapi", 2)
    group:group("military_ballistic_vest", 4)
    group:item("corset", 1)
    group:item("corset_waist", 1)
    group:item("football_armor", 18)
    group:item("jacket_leather", 12)
    group:item("tacjacket", 30)
    group:item("jacket_varsity", 6)
    group:item("leather_police_jacket", 12)
    group:item("jacket_jean", 8)
    group:item("jacket_flannel", 6)
    group:item("cuirass_scrap", 12)
    group:item("cuirass_tire", 12)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivorzed_bottoms", kind = "distribution" }
    group:item("pants_tactical", 15)
    group:item("pants_hiking", 12)
    group:item("pants_cargo", 40)
    group:item("shorts_cargo", 22)
    group:item("pants_army", 28)
    group:item("winter_pants_army", 10)
    group:item("bunker_pants", 14)
    group:item("pants_leather", 18)
    group:item("chaps_leather", 10)
    group:item("legguard_scrap", 12)
    group:item("legguard_tire", 12)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivorzed_gloves", kind = "distribution" }
    group:item("gloves_survivor", 8)
    group:item("gloves_fsurvivor", 2)
    group:item("gloves_fingerless", 28)
    group:item("gloves_fingerless_mod", 20)
    group:item("gloves_tactical", 12)
    group:item("gauntlets_larmor", 14)
    group:item("gauntlets_chitin", 2)
    group:item("armguard_larmor", 7)
    group:item("vambrace_larmor", 6)
    group:item("armguard_chitin", 1)
    group:item("armguard_scrap", 12)
    group:item("armguard_tire", 12)
    group:item("gloves_fur", 4)
    group:item("gloves_leather", 22)
    group:item("gloves_work", 22)
    group:item("gloves_plate", 2)
    group:item("gloves_wraps", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivorzed_boots", kind = "distribution" }
    group:item("boots_survivor", 8)
    group:item("boots_wsurvivor", 4)
    group:item("boots", 20)
    group:item("boots_scrap", 12)
    group:item("boots_steel", 28)
    group:item("sneakers_steel", 20)
    group:item("boots_denim", 2)
    group:item("boots_hiking", 24)
    group:item("boots_combat", 12)
    group:item("boots_larmor", 14)
    group:item("boots_fur", 22)
    group:item("boots_plate", 2)
    group:item("boots_bunker", 8)
    group:item("footrags", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivorzed_head", kind = "distribution" }
    group:item("hood_survivor", 8)
    group:item("hood_wsurvivor", 4)
    group:item("helmet_army", 26)
    group:item("tac_helmet", 22)
    group:item("helmet_riot", 18)
    group:item("tac_fullhelmet", 8)
    group:item("helmet_larmor", 14)
    group:item("pickelhaube", 1)
    group:item("firehelmet", 2)
    group:item("helmet_barbute", 1)
    group:item("helmet_plate", 1)
    group:item("helmet_scrap", 12)
    group:item("survivor_goggles", 10)
    group:item("hood_rain", 14)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "museum_armor", kind = "distribution" }
    group:entry { item = "armor_junk_plate", damage = { 2, 4 }, probability = 60 }
    group:entry { item = "chainmail_junk_hauberk", damage = { 2, 4 }, probability = 60 }
    group:entry { item = "gloves_plate", damage = { 2, 4 }, probability = 60 }
    group:entry { item = "boots_plate", damage = { 2, 4 }, probability = 60 }
    group:entry { item = "armor_junk_lightplate", damage = { 2, 4 }, probability = 45 }
    group:entry { item = "cuirass_lightplate", damage = { 2, 4 }, probability = 45 }
    group:entry { item = "armor_lc_armguard", damage = { 2, 4 }, probability = 30 }
    group:entry { item = "armor_lc_leg_guard", damage = { 2, 4 }, probability = 30 }
    group:entry { item = "helmet_barbute", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "helmet_conical", damage = { 2, 4 }, probability = 30 }
    group:entry { item = "armor_lamellar", damage = { 2, 4 }, probability = 20 }
    group:entry { item = "armor_lorica", damage = { 2, 4 }, probability = 25 }
    group:entry { item = "armor_samurai", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "helmet_kabuto", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "helmet_nasal", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "helmet_galea", damage = { 2, 4 }, probability = 40 }
    group:entry { item = "gambeson", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "gambeson_pants", damage = { 2, 4 }, probability = 40 }
    group:entry { item = "legguard_metal", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "helmet_corinthian", damage = { 2, 4 }, probability = 45 }
    group:entry { item = "armor_cuirass", damage = { 2, 4 }, probability = 25 }
    group:entry { item = "legguard_bronze", damage = { 2, 4 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "museum_armor_torso", kind = "distribution" }
    group:entry { item = "armor_junk_plate", damage = { 2, 4 }, probability = 60 }
    group:entry { item = "chainmail_junk_hauberk", damage = { 2, 4 }, probability = 60 }
    group:entry { item = "armor_junk_lightplate", damage = { 2, 4 }, probability = 45 }
    group:entry { item = "cuirass_lightplate", damage = { 2, 4 }, probability = 45 }
    group:entry { item = "armor_lamellar", damage = { 2, 4 }, probability = 20 }
    group:entry { item = "armor_lorica", damage = { 2, 4 }, probability = 25 }
    group:entry { item = "armor_samurai", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "gambeson", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "armor_cuirass", damage = { 2, 4 }, probability = 25 }
    group:entry { item = "chainmail_junk_suit", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "chainmail_junk_vest", damage = { 2, 4 }, probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "museum_armor_legs", kind = "distribution" }
    group:entry { item = "armor_lc_leg_guard", damage = { 2, 4 }, probability = 30 }
    group:entry { item = "legguard_metal", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "legguard_bronze", damage = { 2, 4 }, probability = 20 }
    group:entry { item = "chainmail_junk_legs", damage = { 2, 4 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "museum_armor_feet", kind = "distribution" }
    group:entry { item = "boots_plate", damage = { 2, 4 }, probability = 60 }
    group:entry { item = "chainmail_junk_feet", damage = { 2, 4 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "museum_armor_head", kind = "distribution" }
    group:entry { item = "helmet_barbute", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "helmet_conical", damage = { 2, 4 }, probability = 30 }
    group:entry { item = "helmet_kabuto", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "helmet_nasal", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "helmet_galea", damage = { 2, 4 }, probability = 40 }
    group:entry { item = "chainmail_junk_hood", damage = { 2, 4 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "museum_armor_arms", kind = "distribution" }
    group:entry { item = "armor_lc_armguard", damage = { 2, 4 }, probability = 30 }
    group:entry { item = "gloves_plate", damage = { 2, 4 }, probability = 60 }
    group:entry { item = "chainmail_junk_arms", damage = { 2, 4 }, probability = 30 }
    group:entry { item = "chainmail_junk_hands", damage = { 2, 4 }, probability = 30 }
    content.add(group)
end

do
    -- clothing found on a coat rack
    local group = content.ItemGroup { id = "unisex_coat_rack", kind = "collection" }
    group:group("scarfs_unisex", 40)
    group:group("bags_unisex", 20)
    group:group("coats_unisex", 70)
    group:group("hats_unisex", 70)
    content.add(group)
end

do
    -- pants and leg coverings for domestic locations.
    local group = content.ItemGroup { id = "pants_unisex", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "hot_pants", probability = 40 },
            { item = "hot_pants_fur", probability = 5 },
            { item = "hot_pants_leather", probability = 35 },
        },
        probability = 10,
    }
    group:entry {
        distribution = {
            { item = "chaps_leather", probability = 30 },
            { item = "motorbike_pants", probability = 35 },
            { item = "breeches", probability = 25 },
            { item = "pants_ski", probability = 45 },
            { item = "pants_checkered", probability = 55 },
            { item = "pants_fur", probability = 5 },
            { item = "pants_faux_fur", probability = 15 },
        },
        probability = 20,
    }
    group:item("jeans", 80)
    group:item("jeans_ripped", 7)
    group:item("jeans_skinny", 15)
    group:item("leg_warmers", 20)
    group:item("leggings", 30)
    group:item("legguard_hard", 3)
    group:item("pants", 70)
    group:item("pants_cargo", 60)
    group:item("pants_leather", 20)
    group:item("shorts", 50)
    group:item("shorts_cargo", 60)
    group:item("shorts_denim", 40)
    group:item("b_shorts", 60)
    content.add(group)
end

do
    -- women's pants and leg coverings for domestic locations.
    local group = content.ItemGroup { id = "pants_womens", kind = "distribution" }
    group:item("nanoskirt", 1)
    group:item("skirt", 50)
    group:item("skirt_long", 40)
    group:item("skirt_denim", 20)
    group:item("skirt_leather", 10)
    content.add(group)
end

do
    -- men's pants and leg coverings for domestic locations.
    local group = content.ItemGroup { id = "pants_mens", kind = "distribution" }
    group:item("kilt", 50)
    group:item("kilt_leather", 25)
    content.add(group)
end

do
    -- women's gloves and mittens for domestic locations.
    local group = content.ItemGroup { id = "gloves_womens", kind = "distribution" }
    group:item("long_glove_white", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "formal_set_mens", kind = "collection" }
    group:entry {
        distribution = {
            {
                collection = {
                    {
                        collection = {
                            { item = "undershirt", probability = 30 },
                            { item = "dress_shirt" },
                            { item = "waistcoat", probability = 20 },
                        },
                    },
                    { item = "breeches" },
                },
            },
            {
                distribution = {
                    { item = "suit", probability = 50 },
                    { item = "tux", probability = 50 },
                },
            },
        },
    }
    group:item("dress_shoes")
    group:entry {
        collection = {
            { item = "tophat", probability = 50 },
            { item = "collarpin", probability = 50 },
        },
    }
    content.add(group)
end

do
    -- suits, full body coverage for men.
    local group = content.ItemGroup { id = "suits_mens", kind = "distribution" }
    group:item("tux", 30)
    group:item("thawb", 10)
    group:item("cassock", 10)
    content.add(group)
end

do
    -- women's only shoes
    local group = content.ItemGroup { id = "shoes_womens", kind = "distribution" }
    group:item("heels")
    content.add(group)
end

do
    -- Standard (non-winter) shirts and jackets suitable for wearing outdoors.
    local group = content.ItemGroup { id = "clothing_outdoor_torso", kind = "distribution" }
    group:entry {
        collection = {
            {
                distribution = {
                    { item = "longshirt", probability = 80 },
                    { item = "polo_shirt", probability = 50 },
                    { item = "denim_shirt", probability = 20 },
                    { item = "tshirt", probability = 80 },
                    { item = "rashguard", probability = 10 },
                },
            },
            {
                distribution = {
                    { item = "coat_rain", probability = 30 },
                    { item = "duster", probability = 30 },
                    { item = "hoodie", probability = 60 },
                    { item = "jacket_jean", probability = 20 },
                    { item = "jacket_leather", probability = 20 },
                    { item = "tacjacket", probability = 30 },
                    { item = "leather_police_jacket", probability = 15 },
                    { item = "jacket_light", probability = 40 },
                    { item = "jacket_army", probability = 25 },
                    { item = "jacket_windbreaker", probability = 20 },
                    { item = "jacket_varsity", probability = 20 },
                    { item = "sweater", probability = 50 },
                    { item = "turtleneck", probability = 30 },
                    { item = "trenchcoat", probability = 10 },
                    { group = "costume_jackets", probability = 1 },
                    { group = "costume_jackets", event = "halloween", probability = 40 },
                    { group = "christmas_jackets", event = "christmas", probability = 15 },
                },
                probability = 30,
            },
        },
    }
    content.add(group)
end

do
    -- Protective helmets or headlamps often worn by technicians and tradesmen.
    local group = content.ItemGroup { id = "clothing_work_hat", kind = "distribution" }
    group:item("hat_hard", 30)
    group:group("hat_hard_modified", 30)
    group:item("hat_hard_hooded", 10)
    group:group("hat_hard_hooded_modified", 5)
    group:group("hat_hard_flashlight", 10)
    group:entry { item = "wearable_light", charges = { 0, 100 }, probability = 15 }
    group:entry { item = "hat_hard", variant = "flag_hat_hard", event = "independence_day", probability = 70 }
    group:entry { item = "hat_hard_hooded", variant = "flag_hat_hard", event = "independence_day", probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hat_hard_flashlight", kind = "collection", container = "hat_hard" }
    group:entry { item = "flashlight", charges = { 0, -1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hat_hard_modified", kind = "collection", container = "hat_hard" }
    group:group("common_nape_protectors", 50)
    group:entry { item = "flashlight", charges = { 0, -1 }, probability = 50 }
    group:group("common_face_shields", 15)
    group:item("plastic_chin_guard", 10)
    group:item("attachable_ear_muffs", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pants_female_child", kind = "distribution" }
    group:group("pants_male", 200)
    group:item("skirt", 75)
    group:item("skirt_long", 25)
    group:item("skirt_denim", 10)
    group:item("skirt_leather", 5)
    group:item("leggings", 15)
    group:item("cheerleader_skirt", 1)
    group:item("cheerleader_skirt_short", 1)
    group:entry { group = "costume_skirts", event = "halloween", probability = 200 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dresser", kind = "distribution", with_ammo = 50, with_magazine = 100 }
    group:item("jeans", 90)
    group:item("jeans_ripped", 10)
    group:item("jeans_skinny", 20)
    group:item("pants_checkered", 5)
    group:item("shorts", 70)
    group:item("shorts_denim", 50)
    group:item("pants", 75)
    group:item("leather_belt", 30)
    group:item("pants_leather", 60)
    group:item("pants_cargo", 70)
    group:item("pants_hiking", 5)
    group:item("pants_tactical", 5)
    group:item("shorts_cargo", 50)
    group:item("motorbike_pants", 5)
    group:item("breeches", 5)
    group:item("skirt", 75)
    group:item("skirt_long", 50)
    group:item("skirt_denim", 10)
    group:item("dress", 70)
    group:item("sundress", 50)
    group:item("camisole", 60)
    group:item("bra", 70)
    group:item("hairpin", 30)
    group:item("fc_hairpin", 5)
    group:item("barrette", 15)
    group:item("tieclip", 10)
    group:item("collarpin", 10)
    group:item("undershirt", 70)
    group:item("boxer_shorts", 50)
    group:item("boxer_shorts", 5, "flag_boxer_shorts")
    group:entry { item = "boxer_shorts", variant = "flag_boxer_shorts", event = "independence_day" }
    group:item("briefs", 40)
    group:item("boxer_briefs", 45)
    group:item("swim_briefs", 10)
    group:item("speedo", 5)
    group:group("bikini", 20)
    group:item("panties", 70)
    group:item("boy_shorts", 25)
    group:item("boy_shorts", 2, "flag_boy_shorts")
    group:entry { item = "boy_shorts", variant = "flag_boy_shorts", event = "independence_day", probability = 70 }
    group:item("long_glove_white", 1)
    group:item("veil_wedding", 1)
    group:item("dress_wedding", 1)
    group:item("gaiter_boot", 1)
    group:item("tshirt", 80)
    group:item("tshirt_cropped", 8)
    group:item("longshirt", 70)
    group:item("polo_shirt", 65)
    group:item("dress_shirt", 60)
    group:item("denim_shirt", 30)
    group:item("tank_top", 50)
    group:item("sweatshirt", 75)
    group:item("sweater", 75)
    group:item("turtleneck", 25)
    group:item("turtleneck_shirt", 25)
    group:item("hoodie", 65)
    group:item("hoodie_cropped", 6)
    group:item("jacket_light", 50)
    group:item("jacket_windbreaker", 25)
    group:item("jacket_varsity", 20)
    group:item("jacket_jean", 35)
    group:item("vest_jean", 15)
    group:item("blazer", 35)
    group:item("towel", 40)
    group:item("jacket_leather", 30)
    group:item("tacjacket", 30)
    group:item("leather_police_jacket", 5)
    group:item("motorbike_armor", 5)
    group:item("poncho", 15)
    group:item("folding_poncho", 5)
    group:item("trenchcoat", 12)
    group:item("sleeveless_trenchcoat", 2)
    group:item("duster", 12)
    group:item("sleeveless_duster", 2)
    group:item("peacoat", 30)
    group:item("greatcoat", 15)
    group:item("vest", 15)
    group:item("mag_porn", 20)
    group:item("photo_album", 10)
    group:entry { item = "lighter", charges = { 0, -1 }, probability = 60 }
    group:entry { item = "ref_lighter", charges = { 0, -1 }, probability = 2 }
    group:entry { item = "sewing_kit", charges = { 0, -1 }, probability = 30 }
    group:item("thread", 40)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 40 }
    group:item("suit", 60)
    group:item("waistcoat", 30)
    group:item("tophat", 10)
    group:item("bowhat", 10)
    group:item("cowboy_hat", 10)
    group:item("cowboy_hat", 2, "flag_cowboy_hat")
    group:entry { item = "cowboy_hat", variant = "flag_cowboy_hat", event = "independence_day", probability = 70 }
    group:item("bullwhip", 1)
    group:item("10gal_hat", 3)
    group:item("glasses_monocle", 2)
    group:group("duct_tape_roll_part", 60)
    group:group("glue_weak_domestic", 20)
    group:item("firecracker_pack", 5)
    group:item("firecracker", 5)
    group:item("fursuit", 5)
    group:item("zentai", 5)
    group:group("sex_accessories_domestic", 5)
    group:entry { item = "condom", count = { 1, 5 }, probability = 30 }
    group:item("snuggie", 5)
    group:item("flyer", 10)
    group:item("socks", 70)
    group:item("socks_ankle", 50)
    group:item("socks_wool", 30)
    group:item("pocketwatch", 5)
    group:item("flask_hip", 2)
    group:item("bholster", 5)
    group:item("bbholster", 4)
    group:item("leg_bag", 8)
    group:item("leg_small_bag", 4)
    group:item("armrig", 8)
    group:item("ankle_wallet_pouch", 2)
    group:item("tux", 1)
    group:item("dress_wedding", 1)
    group:item("kasaya", 1)
    group:item("antarvasa", 1)
    group:item("uttarasanga", 1)
    group:item("samghati", 1)
    group:item("clogs", 2)
    group:item("wristwatch", 15)
    group:item("maid_dress", 1)
    group:item("maid_dress_short", 1)
    group:item("maid_hat", 1)
    group:item("knitting_needles", 1)
    group:item("survnote", 1)
    group:item("b_shorts", 15)
    group:item("halter_top", 30)
    group:item("kilt", 2)
    group:item("nanoskirt", 10)
    group:item("sleeveless_tunic", 5)
    group:item("fedora", 10)
    group:item("straw_hat", 5)
    group:item("straw_fedora", 5)
    group:item("cassock", 1)
    group:item("priest_collar", 1)
    group:item("nun_habit", 1)
    group:item("nun_wimple", 1)
    group:item("holy_symbol", 20)
    group:item("kufi", 5)
    group:item("kippah", 5)
    group:item("tallit_katan", 5)
    group:item("tallit_gadol", 1)
    group:group("tefillin_sets", 1)
    group:item("headscarf", 5)
    group:entry { item = "kirpan", container = "sheath", probability = 1 }
    group:entry { item = "kirpan_cheap", container = "sheath", probability = 3 }
    group:item("leg_sheath6", 1)
    group:item("gartersheath1", 5)
    group:item("gartersheath2", 1)
    group:item("robe", 10)
    group:item("eboshi", 1)
    group:item("kariginu", 1)
    group:item("geta", 1)
    group:item("kimono", 2)
    group:item("yukata", 3)
    group:item("haori", 2)
    group:item("hakama", 2)
    group:item("eclipse_glasses", 1)
    group:item("thermos", 20)
    group:item("camera_bag", 5)
    group:group("archery_quivers", 1)
    group:item("santa_jacket", 1)
    group:item("santa_jacket_short", 1)
    group:item("santa_shorts", 1)
    group:item("santa_pants", 1)
    group:item("santa_gloves", 1)
    group:item("gloves_white", 5)
    group:item("santa_hat", 1)
    group:item("santa_belt", 1)
    group:item("santa_beard", 1)
    group:item("santa_dress", 1)
    group:item("santa_dress_long", 1)
    group:item("santa_dress_short", 1)
    group:item("cloak_vampire", 1)
    group:item("cloak_black", 1)
    group:item("robe_wizard", 1)
    group:item("ghost_robe", 1)
    group:item("grim_reaper_robe", 1)
    group:item("jacket_ninja", 1)
    group:item("bee_dress", 1)
    group:item("cheerleader_dress", 1)
    group:item("mummy_dress", 1)
    group:item("ninja_dress", 1)
    group:item("ninja_dress_sleeveless", 1)
    group:item("long_dress_sleeved", 1, "sinister")
    group:item("short_dress", 1, "sinister")
    group:item("gown_sleeved", 1, "sinister")
    group:item("mummy_dress", 1)
    group:item("dress_sleeved", 1, "witch_black")
    group:item("long_dress_sleeved", 1, "witch_black")
    group:item("short_dress_sleeved", 1, "witch_black")
    group:item("gloves_black", 5)
    group:item("gloves_skeleton", 1)
    group:item("gloves_claws", 1)
    group:item("wizard_hat_costume", 1)
    group:item("pointed_hat", 1)
    group:item("hood_ninja", 1)
    group:item("balclava", 1, "skull")
    group:item("mask_skull", 1)
    group:item("zombie_mask", 2)
    group:item("cheerleader_skirt", 5)
    group:item("cheerleader_skirt_short", 1)
    group:item("trousers_ninja", 1)
    group:item("tank_top", 5, "tank_top_cheerleader")
    group:item("cheerleader_top_short", 1)
    group:item("flag_jumpsuit", 2)
    group:item("denim_overalls", 10)
    group:item("jumpsuit_skeleton", 1)
    group:item("mummy_jumpsuit", 1)
    group:item("flag_swimsuit", 2)
    group:item("pom_poms", 5)
    group:item("sinister_cane", 2)
    group:item("wizard_cane_cheap", 2)
    group:item("wizard_cane", 1)
    group:item("scythe_fake", 2)
    group:item("scythe_toy", 2)
    group:item("bodysuit_lycra", 5)
    group:entry { group = "independence_all_clothing", event = "independence_day" }
    group:entry { group = "christmas_all_clothing", event = "christmas" }
    group:entry { group = "costume_all_clothing", event = "halloween" }
    group:item("cheongsam", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "shoes", kind = "distribution" }
    group:item("sneakers", 80)
    group:item("knee_high_boots", 20)
    group:item("thigh_high_boots", 20)
    group:item("boots", 70)
    group:item("flip_flops", 35)
    group:item("flip_flops_exp", 5)
    group:item("lowtops", 45)
    group:item("dress_shoes", 50)
    group:item("dance_shoes", 5)
    group:item("shoes_denim", 5)
    group:item("heels", 50)
    group:item("golf_shoes", 20)
    group:item("boots_combat", 10)
    group:item("boots_denim", 1)
    group:item("boots_hiking", 20)
    group:item("boots_western", 10)
    group:item("clogs", 1)
    group:item("leathersandals", 10)
    group:item("espadrilles", 5)
    group:item("rollerskates", 1)
    group:item("roller_blades", 5)
    group:item("roller_shoes_off", 1)
    group:item("mocassins", 20)
    group:entry { item = "heels", variant = "heels_flag", event = "independence_day", probability = 70 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "shoestore_shoes", kind = "distribution" }
    group:item("sneakers")
    group:item("knee_high_boots", 40)
    group:item("thigh_high_boots", 40)
    group:item("boots")
    group:item("flip_flops", 50)
    group:item("flip_flops_exp", 5)
    group:item("lowtops")
    group:item("dress_shoes", 50)
    group:item("dance_shoes", 20)
    group:item("shoes_denim", 5)
    group:item("heels")
    group:item("golf_shoes", 40)
    group:item("boots_denim", 5)
    group:item("boots_hiking", 40)
    group:item("boots_western", 60)
    group:item("clogs", 60)
    group:item("leathersandals")
    group:item("espadrilles", 50)
    group:item("rollerskates", 10)
    group:item("roller_blades", 20)
    group:item("roller_shoes_off", 10)
    group:item("boots_rubber", 20)
    group:item("clownshoes", 10)
    group:item("mocassins", 40)
    group:entry { item = "heels", variant = "heels_flag", event = "independence_day", probability = 120 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dresses", kind = "distribution" }
    group:item("dress", 65)
    group:item("sundress", 43)
    group:item("cheongsam", 4)
    group:item("dress_wedding", 2)
    group:group("costume_dresses", 1)
    group:entry { group = "costume_dresses", event = "halloween", probability = 15 }
    group:entry { group = "christmas_dresses", event = "christmas", probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "construction_worker", kind = "distribution" }
    group:item("boots", 70)
    group:item("boots_steel", 50)
    group:item("toecaps", 30)
    group:item("sneakers_steel", 35)
    group:item("boots_hiking", 10)
    group:item("denim_overalls", 15)
    group:item("technician_coveralls", 15)
    group:item("technician_coveralls_h", 5)
    group:item("gloves_rubber", 20)
    group:item("gloves_leather", 45)
    group:item("gloves_work", 45)
    group:entry { item = "mask_filter", charges = { 0, -1 }, probability = 30 }
    group:item("glasses_safety", 40)
    group:item("hat_hard", 25)
    group:group("hat_hard_modified", 25)
    group:item("hat_hard_hooded", 15)
    group:group("hat_hard_hooded_modified", 10)
    group:entry { item = "wearable_light", charges = { 0, 100 }, probability = 5 }
    group:item("ear_plugs", 50)
    group:group("ammo_any_batteries_full", 50)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 40 }
    group:item("boots_rubber", 20)
    group:group("tools_toolbox", 1)
    group:item("apron_leather", 10)
    group:item("apron_cut_resistant", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fireman_mask", kind = "distribution" }
    group:item("mask_bunker", 70)
    group:item("mask_dust", 30)
    group:entry {
        distribution = {
            { item = "mask_gas", charges = { 0, -1 }, probability = 50 },
            {
                item = "mask_gas",
                charges = { 0, -1 },
                contents = {
                    { group = "gasmask_inserts_in_use" },
                },
                probability = 25,
            },
            { group = "gasmask_bag_full", probability = 50 },
        },
        probability = 20,
    }
    group:entry { item = "mask_gas_half", charges = { 0, -1 }, probability = 20 }
    group:entry { item = "mask_filter", charges = { 0, -1 }, probability = 10 }
    group:entry { item = "goggles_nv", charges = { 0, 100 }, probability = 2 }
    group:entry { item = "goggles_ir", charges = { 0, 100 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coat_rack", kind = "distribution" }
    group:item("jacket_light", 50)
    group:item("jacket_windbreaker", 25)
    group:item("jacket_varsity", 20)
    group:item("jacket_jean", 35)
    group:item("blazer", 35)
    group:item("jacket_leather", 30)
    group:item("leather_police_jacket", 10)
    group:item("coat_rain", 50)
    group:item("trenchcoat", 10)
    group:item("duster", 15)
    group:item("peacoat", 30)
    group:item("tophat", 10)
    group:item("hat_ball", 40)
    group:item("fedora", 15)
    group:item("hat_cotton", 30)
    group:item("hat_knit", 20)
    group:group("costume_jackets", 1)
    group:entry { group = "costume_jackets", event = "halloween", probability = 50 }
    group:entry { group = "christmas_jackets", event = "christmas", probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dollar_clothes", kind = "distribution" }
    group:item("bandana", 25)
    group:item("boxer_shorts", 25)
    group:item("boxer_shorts", 5, "flag_boxer_shorts")
    group:entry { item = "boxer_shorts", variant = "flag_boxer_shorts", event = "independence_day" }
    group:item("boxer_briefs", 25)
    group:item("boy_shorts", 25)
    group:item("boy_shorts", 2, "flag_boy_shorts")
    group:entry { item = "boy_shorts", variant = "flag_boy_shorts", event = "independence_day", probability = 70 }
    group:item("bra", 25)
    group:item("socks", 45)
    group:item("socks_ankle", 30)
    group:item("stockings", 20)
    group:item("hat_cotton", 35)
    group:item("copper_bracelet", 10)
    group:item("sunglasses", 25)
    group:item("tieclip", 15)
    group:item("hairpin", 15)
    group:item("santa_beard", 5)
    group:item("santa_hat", 4)
    group:item("vampire_fangs", 5)
    group:item("mask_skull", 4)
    group:item("ankle_wallet_pouch", 5)
    content.add(group)
end

do
    -- unisex hats for domestic locations
    local group = content.ItemGroup { id = "hats_unisex", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "tricorne", probability = 5 },
            { item = "10gal_hat", probability = 30 },
            { item = "tophat", probability = 10 },
            { item = "hat_sombrero", probability = 10 },
        },
        probability = 5,
    }
    group:entry {
        distribution = {
            { item = "kippah", probability = 33 },
            { item = "turban", probability = 33 },
            { item = "kufi", probability = 33 },
        },
        probability = 10,
    }
    group:entry {
        distribution = {
            { item = "helmet_motor", probability = 20 },
            { item = "helmet_bike", probability = 40 },
            { group = "helmet_bike_modified", probability = 10 },
            { item = "headgear", probability = 10 },
            { item = "helmet_ball", probability = 15 },
            { item = "swim_cap", probability = 10 },
            { item = "wetsuit_hood", probability = 5 },
            { item = "wetsuit_hood_thick", probability = 1 },
        },
        probability = 30,
    }
    group:entry {
        distribution = {
            { item = "hat_hunting", probability = 20 },
            { item = "hat_faux_fur", probability = 10 },
            { item = "hat_fur", probability = 5 },
            { item = "hat_boonie", probability = 15 },
            { item = "cowl_wool", probability = 15 },
            { item = "hood_rain", probability = 25 },
        },
        probability = 50,
    }
    group:entry {
        distribution = {
            { item = "bowhat", probability = 10 },
            { item = "fedora", probability = 40 },
            { item = "hat_newsboy", probability = 5 },
            { item = "cowboy_hat", probability = 20 },
            { item = "cowboy_hat", variant = "flag_cowboy_hat", probability = 2 },
            { item = "cowboy_hat", variant = "flag_cowboy_hat", event = "independence_day", probability = 70 },
            { item = "straw_fedora", probability = 5 },
            { item = "hat_golf", probability = 15 },
            { item = "straw_hat", probability = 15 },
            { item = "beret_wool", probability = 5 },
            { item = "beret", probability = 10 },
            { item = "porkpie", probability = 15 },
        },
        probability = 50,
    }
    group:item("hat_knit", 30)
    group:item("hat_cotton", 40)
    group:item("hat_ball", 50)
    group:group("costume_hats_hoods", 1)
    group:entry { group = "costume_hats_hoods", event = "halloween", probability = 80 }
    content.add(group)
end

do
    -- unisex masks for domestic locations
    local group = content.ItemGroup { id = "masks_unisex", kind = "distribution" }
    group:item("bondage_mask", 5)
    group:item("mask_dust", 15)
    group:item("mask_skull", 1, "guy_fawkes")
    group:item("mask_hockey", 10)
    group:item("mouthpiece", 5)
    group:entry { item = "mask_filter", charges = { 0, 100 }, probability = 5 }
    group:group("costume_masks", 5)
    group:entry { group = "costume_masks", event = "halloween", probability = 25 }
    group:entry { item = "mask_dust", variant = "flag_mask_dust", event = "independence_day", probability = 20 }
    content.add(group)
end

do
    -- gloves and mittens for domestic locations.
    local group = content.ItemGroup { id = "gloves_unisex", kind = "distribution" }
    group:item("gloves_leather", 60)
    group:item("gloves_light", 60)
    group:item("gloves_fingerless", 40)
    group:item("gloves_wool", 25)
    group:item("gloves_wool", 10)
    group:item("gloves_winter", 15)
    group:item("mittens", 30)
    group:item("gloves_work", 20)
    group:item("gloves_golf", 10)
    group:item("wetsuit_gloves", 5)
    group:item("wetsuit_gloves_thick", 1)
    group:item("gloves_fur", 5)
    group:item("thermal_gloves", 2)
    group:item("gloves_white", 5)
    group:item("gloves_black", 5)
    group:group("costume_gloves", 1)
    group:entry { group = "costume_gloves", event = "halloween", probability = 70 }
    group:entry { group = "christmas_common_gloves", event = "christmas", probability = 70 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dresses_womens", kind = "distribution" }
    group:item("dress", 14)
    group:item("sundress", 10)
    group:item("cheongsam", 4)
    group:item("dress_wedding", 2)
    group:group("costume_dresses", 1)
    group:entry { group = "costume_dresses", event = "halloween", probability = 15 }
    group:entry { group = "christmas_dresses", event = "christmas", probability = 15 }
    content.add(group)
end

do
    -- suits, full body coverage
    local group = content.ItemGroup { id = "suits_unisex", kind = "distribution" }
    group:item("bondage_suit", 10)
    group:item("bodysuit_lycra", 10)
    group:item("yukata", 20)
    group:item("leotard", 40)
    group:item("motorbike_armor", 15)
    group:item("suit", 70)
    group:item("touring_suit", 20)
    group:item("fursuit", 3)
    group:item("wool_suit", 40)
    group:item("wool_suit_devil", 15)
    group:item("unitard", 60)
    group:item("zentai", 5)
    group:item("wetsuit", 2)
    group:item("wetsuit_thick", 1)
    group:item("union_suit", 40)
    group:item("wetsuit_spring", 2)
    group:item("wetsuit_spring_sleeveless", 2)
    group:entry { item = "flag_jumpsuit", event = "independence_day", probability = 50 }
    group:entry { item = "bodysuit_lycra", variant = "flag_suit", event = "independence_day", probability = 50 }
    group:entry { group = "costume_suits", event = "halloween", probability = 70 }
    content.add(group)
end

do
    -- suits/dresses, full body coverage for women.
    local group = content.ItemGroup { id = "suits_womens", kind = "distribution" }
    group:item("dress_wedding", 5)
    group:item("sundress", 60)
    group:item("cheongsam", 10)
    group:item("dress", 80)
    group:item("veil_wedding", 5)
    group:item("santa_dress_long", 1)
    group:item("long_dress_sleeved", 1, "sinister")
    group:item("gown_sleeved", 1, "sinister")
    group:item("long_dress_sleeved", 1, "witch_black")
    group:entry { group = "costume_dresses", event = "halloween", probability = 50 }
    group:entry { group = "christmas_dresses", event = "christmas", probability = 50 }
    content.add(group)
end

do
    -- Standard (non-winter) set of clothes for wearing outdoors.
    local group = content.ItemGroup { id = "clothing_outdoor_set", kind = "collection" }
    group:group("clothing_outdoor_torso")
    group:group("clothing_outdoor_pants")
    group:group("clothing_outdoor_shoes")
    group:group("underwear")
    group:group("clothing_glasses", 5)
    group:group("clothing_watch", 5)
    content.add(group)
end

do
    -- Standard (non-winter) pants suitable for wearing outdoors.
    local group = content.ItemGroup { id = "clothing_outdoor_pants", kind = "distribution" }
    group:entry {
        collection = {
            {
                distribution = {
                    { item = "jeans", probability = 60 },
                    { item = "jeans_ripped", probability = 5 },
                    { item = "jeans_skinny", probability = 10 },
                    { item = "pants" },
                    { item = "pants_leather", probability = 30 },
                    { item = "pants_tactical", probability = 20 },
                    { item = "pants_cargo", probability = 30 },
                    { item = "shorts_cargo", probability = 60 },
                    { item = "pants", variant = "pants_flag", probability = 1 },
                    { item = "pants", variant = "pants_flag", event = "independence_day", probability = 70 },
                },
            },
            { item = "leather_belt", probability = 30 },
        },
    }
    content.add(group)
end

do
    -- wearable utility or protective gear you can buy in a common hardware store or find on a jobsite
    -- Not intended to be a set of clothing for NPCs or monsters
    local group = content.ItemGroup { id = "hardware_clothing", kind = "distribution" }
    group:item("boots_steel", 40)
    group:item("toecaps", 30)
    group:item("sneakers_steel", 28)
    group:item("hat_hard", 40)
    group:item("mesh_nape_protector", 10)
    group:item("nape_protector", 10)
    group:item("face_shield_plastic", 10)
    group:item("sun_shield", 15)
    group:item("attachable_ear_muffs", 5)
    group:item("mask_dust", 30)
    group:entry { item = "mask_filter", charges = { 0, 100 }, probability = 30 }
    group:entry {
        distribution = {
            { item = "mask_gas", charges = { 0, -1 }, probability = 50 },
            { group = "gasmask_bag_full", probability = 50 },
        },
        probability = 15,
    }
    group:entry { item = "mask_gas_half", charges = { 0, 100 }, probability = 30 }
    group:item("glasses_safety", 30)
    group:item("ear_plugs", 35)
    group:item("apron_cut_resistant", 5)
    group:item("gloves_cut_resistant", 10)
    group:item("chaps_cut_resistant", 5)
    group:item("armguard_cut_resistant", 5)
    group:item("balaclava_cut_resistant", 2)
    group:item("throat_guard_cut_resistant", 2)
    group:item("apron_leather", 10)
    group:item("tool_belt", 30)
    group:item("knee_pads", 20)
    group:item("sheath", 10)
    group:item("bootsheath", 3)
    group:item("gloves_leather", 40)
    group:item("gloves_work", 45)
    group:entry { item = "wearable_light", charges = { 0, 100 }, probability = 10 }
    group:group("hat_hard_flashlight", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dress_shoes", kind = "distribution" }
    group:item("dress_shoes", 50)
    group:item("heels", 50)
    group:item("espadrilles", 20)
    content.add(group)
end
