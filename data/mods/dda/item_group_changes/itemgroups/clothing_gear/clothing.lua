local content = require("ccb").content

do
    -- Protective clothing for motorbike riding.
    local group = content.ItemGroup { id = "clothing_biker", kind = "collection" }
    group:item("helmet_motor")
    group:item("motorbike_boots", 80)
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "motorbike_armor" },
                    { item = "motorbike_pants", probability = 30 },
                },
                probability = 40,
            },
            {
                collection = {
                    { item = "leather_police_jacket" },
                    { item = "motorbike_pants", probability = 30 },
                },
                probability = 40,
            },
            { item = "touring_suit", probability = 40 },
        },
        probability = 80,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clothing_glasses", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "sunglasses_eye", probability = 15 },
            { item = "sunglasses_reading", probability = 10 },
            { item = "sunglasses_bifocal", probability = 5 },
            { item = "sunglasses", probability = 20 },
            {
                collection = {
                    {
                        distribution = {
                            { item = "glasses_eye", probability = 45 },
                            { item = "glasses_reading", probability = 30 },
                            { item = "glasses_bifocal", probability = 20 },
                        },
                    },
                    { item = "fitover_sunglasses" },
                },
                probability = 50,
            },
            { item = "glasses_monocle", probability = 2 },
        },
    }
    content.add(group)
end

do
    -- Clothes that hunters take on hunting trips.
    local group = content.ItemGroup { id = "clothing_hunting", kind = "distribution" }
    group:item("balclava", 50, "black")
    group:item("hat_cotton", 50)
    group:item("hat_faux_fur", 25)
    group:item("hat_fur", 50)
    group:item("hat_hunting", 75)
    group:item("hat_knit", 25)
    group:item("tank_top", 50, "tank_top_camo")
    group:item("long_underpants", 50)
    group:item("long_undertop", 50)
    group:item("gloves_liner", 50)
    group:item("gloves_wool", 50)
    group:item("gloves_wool_fingerless", 25)
    group:item("knit_scarf", 50)
    group:item("pants_cargo", 75)
    group:item("tacjacket", 75)
    group:item("jacket_army", 40)
    group:item("socks_wool", 50)
    group:item("coat_winter", 35)
    group:item("coat_light_winter", 45)
    group:item("ski_bib", 5)
    group:item("greatcoat", 25)
    group:item("jacket_flannel", 75)
    group:item("peacoat", 25)
    group:item("trenchcoat", 25)
    group:item("boots", 75)
    group:item("boots_winter", 50)
    group:item("boots_hiking", 50)
    group:item("boots_steel", 25)
    group:item("sneakers_steel", 18)
    group:item("fishing_waders", 25)
    group:item("leg_bag", 15)
    group:item("leg_small_bag", 10)
    group:item("armrig", 10)
    group:item("ankle_wallet_pouch", 5)
    group:entry {
        distribution = {
            { item = "pants", variant = "pants_woodland", probability = 15 },
            { item = "pants", variant = "pants_jungle", probability = 15 },
            { item = "pants", variant = "pants_marshland", probability = 15 },
            { item = "pants", variant = "pants_alpine", probability = 15 },
            { item = "pants", variant = "pants_urban", probability = 15 },
            { item = "pants", variant = "pants_black_camo", probability = 15 },
        },
        probability = 65,
    }
    group:item("pants_tactical", 20)
    group:item("pants_hiking", 10)
    group:item("gaiter_boot", 10)
    group:item("gaiter_boot_heavy", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pants_male", kind = "distribution" }
    group:item("jeans", 90)
    group:item("jeans_ripped", 10)
    group:item("jeans_skinny", 20)
    group:item("shorts", 70)
    group:item("shorts_denim", 35)
    group:item("b_shorts", 30)
    group:item("shorts_cargo", 50)
    group:item("postman_shorts", 12)
    group:item("under_armor_shorts", 5)
    group:item("pants", 75)
    group:item("pants_leather", 60)
    group:item("pants_cargo", 70)
    group:item("pants_checkered", 55)
    group:item("pants_ski", 45)
    group:item("pants_tactical", 40)
    group:item("pants_fur", 5)
    group:item("pants_faux_fur", 15)
    group:item("hot_pants", 30)
    group:item("hot_pants_fur", 5)
    group:item("hot_pants_leather", 25)
    group:item("breeches", 25)
    group:item("pants", 10, "pants_flag")
    group:item("trousers_ninja", 1)
    group:group("pants_mens", 10)
    group:entry { item = "pants", variant = "pants_flag", event = "independence_day", probability = 70 }
    group:entry { group = "christmas_pants_male", event = "christmas", probability = 150 }
    group:entry { group = "costume_pants", event = "halloween", probability = 150 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pants_female", kind = "distribution" }
    group:item("nanoskirt", 10)
    group:group("pants_female_child", 290)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "shirts", kind = "distribution" }
    group:item("tshirt", 90)
    group:item("tshirt_cropped", 8)
    group:item("longshirt", 80)
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
    group:item("under_armor", 20)
    group:item("jersey", 40)
    group:item("camisole", 60)
    group:item("tie_clipon", 10)
    group:item("tie_necktie", 10)
    group:item("tie_skinny", 10)
    group:item("tieclip", 5)
    group:item("collarpin", 5)
    group:item("postman_shirt", 5)
    group:item("halter_top", 50)
    group:item("rashguard", 10)
    group:item("sleeveless_tunic", 5)
    group:item("poncho", 20)
    group:entry { item = "tshirt", variant = "flag_shirt", event = "independence_day", probability = 50 }
    group:entry { group = "costume_shirts", event = "halloween", probability = 70 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "jackets", kind = "distribution" }
    group:item("jacket_light", 50)
    group:item("jacket_windbreaker", 25)
    group:item("jacket_varsity", 20)
    group:item("jacket_jean", 35)
    group:item("blazer", 35)
    group:item("jacket_leather", 30)
    group:item("tacjacket", 30)
    group:item("leather_police_jacket", 8)
    group:item("coat_rain", 50)
    group:item("trenchcoat", 12)
    group:item("trenchcoat_steampunk", 1)
    group:item("duster", 12)
    group:group("neckties", 5)
    group:item("tieclip", 2)
    group:item("collarpin", 2)
    group:item("apron_cotton", 5)
    group:item("apron_leather", 1)
    group:item("apron_plastic", 1)
    group:group("costume_jackets", 1)
    group:entry { group = "costume_jackets", event = "halloween", probability = 50 }
    group:entry { group = "christmas_jackets", event = "christmas", probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hatstore_hats", kind = "distribution" }
    group:item("hat_cotton", 30)
    group:item("hat_knit", 40)
    group:item("hat_faux_fur", 30)
    group:item("hat_fur", 20)
    group:item("hat_newsboy", 20)
    group:item("hat_sombrero", 10)
    group:item("fedora")
    group:item("straw_hat")
    group:item("straw_fedora")
    group:item("hat_chef", 10)
    group:item("maid_hat", 5)
    group:item("hat_golf", 50)
    group:item("hat_ball")
    group:item("postman_hat", 10)
    group:item("tophat", 50)
    group:item("bowhat", 50)
    group:item("cowboy_hat")
    group:item("cowboy_hat", 5, "flag_cowboy_hat")
    group:entry { item = "cowboy_hat", variant = "flag_cowboy_hat", event = "independence_day", probability = 150 }
    group:item("10gal_hat", 10)
    group:item("kufi", 10)
    group:item("kippah", 30)
    group:item("eboshi", 10)
    group:item("balclava", 20, "black")
    group:item("porkpie", 30)
    group:entry { group = "costume_hats_hoods", event = "halloween", probability = 450 }
    group:entry { group = "christmas_hats", event = "christmas", probability = 450 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "common_gloves", kind = "distribution" }
    group:item("gloves_light", 15)
    group:item("gloves_leather", 15)
    group:item("gloves_golf", 15)
    group:item("gloves_wool", 15)
    group:item("gloves_wool_fingerless", 5)
    group:item("gloves_winter", 10)
    group:item("gloves_fingerless", 15)
    group:item("gloves_liner", 15)
    group:item("gloves_white", 10)
    group:item("gloves_black", 10)
    group:item("mittens", 5)
    group:item("thermal_gloves", 2)
    group:group("costume_gloves", 1)
    group:entry { group = "costume_gloves", event = "halloween", probability = 70 }
    group:entry { group = "christmas_common_gloves", event = "christmas", probability = 70 }
    content.add(group)
end

do
    -- unisex scarfs and fabric coverings
    local group = content.ItemGroup { id = "scarfs_unisex", kind = "distribution" }
    group:item("bandana", 90)
    group:item("balclava", 50, "black")
    group:item("headscarf", 50)
    group:item("scarf_fur_long", 10)
    group:item("scarf_fur", 20)
    group:item("scarf", 80)
    group:item("scarf_long", 40)
    group:item("long_knit_scarf", 40)
    group:item("knit_scarf", 80)
    group:item("keffiyeh", 30)
    group:item("mask_ski", 30)
    group:item("thermal_mask", 5)
    content.add(group)
end

do
    -- unisex shirts
    local group = content.ItemGroup { id = "shirts_unisex", kind = "distribution" }
    group:item("longshirt", 70)
    group:item("arm_warmers", 20)
    group:item("armguard_soft", 10)
    group:item("armguard_hard", 3)
    group:item("dress_shirt", 50)
    group:item("denim_shirt", 15)
    group:item("jersey", 30)
    group:item("polo_shirt", 30)
    group:item("thermal_shirt", 20)
    group:item("sleeveless_tunic", 10)
    group:item("sweater", 40)
    group:item("turtleneck", 15)
    group:item("turtleneck_shirt", 15)
    group:item("sweatshirt", 50)
    group:item("tank_top", 30)
    group:item("tshirt", 85)
    group:item("rashguard", 20)
    group:item("tunic", 10)
    group:item("waistcoat", 10)
    group:item("wool_hoodie", 10)
    group:item("hoodie", 40)
    group:item("hoodie_cropped", 4)
    group:entry { item = "tshirt", variant = "flag_shirt", event = "independence_day", probability = 50 }
    group:entry { group = "costume_shirts", event = "halloween", probability = 50 }
    content.add(group)
end

do
    -- women's shirts
    local group = content.ItemGroup { id = "shirts_womens", kind = "distribution" }
    group:item("halter_top", 30)
    group:item("tank_top", 15)
    group:item("camisole", 15)
    content.add(group)
end

do
    -- unisex coats, jackets, cloaks, etc.
    local group = content.ItemGroup { id = "coats_unisex", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "cloak", probability = 80 },
            { item = "cloak_wool", probability = 40 },
            { item = "cloak_leather", probability = 20 },
            { item = "cloak_fur", probability = 10 },
            { item = "jedi_cloak", probability = 1 },
            { group = "costume_cloacks", probability = 1 },
            { item = "american_flag", event = "independence_day" },
            { group = "costume_cloacks", event = "halloween" },
        },
        probability = 20,
    }
    group:entry {
        distribution = {
            { item = "duster", probability = 80 },
            { item = "duster_leather", probability = 60 },
            { item = "duster_faux_fur", probability = 30 },
            { item = "duster_fur", probability = 5 },
            { item = "sleeveless_duster", probability = 70 },
            { item = "sleeveless_duster_leather", probability = 50 },
            { item = "sleeveless_duster_fur", probability = 20 },
            { item = "sleeveless_duster_faux_fur", probability = 10 },
        },
        probability = 60,
    }
    group:entry {
        distribution = {
            { item = "trenchcoat", probability = 80 },
            { item = "trenchcoat_leather", probability = 60 },
            { item = "trenchcoat_faux_fur", probability = 30 },
            { item = "trenchcoat_fur", probability = 5 },
            { item = "sleeveless_trenchcoat", probability = 40 },
            { item = "sleeveless_trenchcoat_leather", probability = 30 },
            { item = "sleeveless_trenchcoat_fur", probability = 10 },
            { item = "sleeveless_trenchcoat_faux_fur", probability = 20 },
        },
        probability = 40,
    }
    group:entry {
        distribution = {
            { item = "coat_rain", probability = 80 },
            { item = "coat_winter", probability = 50 },
            { item = "peacoat", probability = 50 },
            { item = "greatcoat", probability = 35 },
            { item = "coat_faux_fur", probability = 20 },
            { item = "coat_fur", probability = 15 },
            { group = "costume_coats", probability = 1 },
            { group = "costume_coats", event = "halloween" },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { item = "jacket_jean", probability = 80 },
            { item = "jacket_flannel", probability = 50 },
            { item = "jacket_leather", probability = 50 },
            { item = "tacjacket", probability = 50 },
            { item = "jacket_army", probability = 30 },
            { item = "leather_police_jacket", probability = 10 },
            { item = "jacket_light", probability = 60 },
            { item = "jacket_windbreaker", probability = 70 },
            { item = "jacket_varsity", probability = 30 },
            { item = "poncho", probability = 30 },
            { item = "ski_jacket", probability = 25 },
            { group = "costume_jackets", probability = 1 },
            { group = "costume_jackets", event = "halloween" },
            { group = "christmas_jackets", event = "christmas", probability = 50 },
        },
        probability = 60,
    }
    group:entry {
        distribution = {
            { item = "kimono", probability = 20 },
            { item = "robe", probability = 10 },
        },
        probability = 5,
    }
    group:entry {
        distribution = {
            { item = "vest", probability = 80 },
            { item = "vest_leather", probability = 20 },
            { item = "vest_jean", probability = 25 },
            { item = "tank_top", variant = "tank_top_camo", probability = 40 },
            { item = "blazer", probability = 70 },
        },
        probability = 40,
    }
    group:entry {
        distribution = {
            { item = "soft_3a_vest", probability = 50 },
            { item = "stab_vest", probability = 50 },
        },
        probability = 5,
    }
    group:entry { group = "christmas_coats_unisex", event = "christmas", probability = 40 }
    content.add(group)
end

do
    -- unisex shoes (there are no men's only shoes)
    local group = content.ItemGroup { id = "shoes_unisex", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "sneakers", probability = 3 },
            { item = "boots", probability = 2 },
            { item = "dress_shoes", probability = 1 },
        },
        probability = 90,
    }
    group:entry {
        distribution = {
            { item = "slippers", probability = 8 },
            { item = "flip_flops", probability = 8 },
            { item = "flip_flops_exp", probability = 3 },
            { item = "straw_sandals", probability = 3 },
            { item = "bastsandals", probability = 3 },
            { item = "leathersandals", probability = 3 },
            { item = "espadrilles", probability = 3 },
            { item = "mocassins", probability = 3 },
            { item = "clogs", probability = 1 },
            { item = "geta", probability = 1 },
        },
        probability = 50,
    }
    group:entry {
        distribution = {
            { item = "boots_steel", probability = 4 },
            { item = "sneakers_steel", probability = 3 },
            { item = "boots_rubber", probability = 1 },
        },
        probability = 30,
    }
    group:entry {
        distribution = {
            { item = "boots_hiking", probability = 5 },
            { item = "motorbike_boots", probability = 3 },
            { item = "boots_combat", probability = 2 },
        },
        probability = 30,
    }
    group:entry {
        distribution = {
            { item = "lowtops", probability = 3 },
            { item = "golf_shoes", probability = 3 },
            { item = "dance_shoes", probability = 3 },
            { item = "cleats", probability = 2 },
            { item = "rollerskates", probability = 4 },
            { item = "roller_shoes_off", probability = 4 },
            { item = "roller_blades", probability = 2 },
        },
        probability = 20,
    }
    group:entry {
        distribution = {
            { item = "boots_fur", probability = 1 },
            { item = "boots_faux_fur", probability = 1 },
            { item = "boots_winter", probability = 2 },
        },
        probability = 20,
    }
    group:entry {
        distribution = {
            { item = "knee_high_boots", probability = 5 },
            { item = "thigh_high_boots", probability = 1 },
            { item = "boots_western", probability = 3 },
            { item = "shoes_denim", probability = 2 },
            { item = "boots_denim", probability = 2 },
        },
        probability = 10,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clothing_watch", kind = "distribution" }
    group:item("wristwatch", 90)
    group:item("silver_watch", 70)
    group:item("gold_watch", 40)
    group:item("platinum_watch", 10)
    group:item("sf_watch", 5)
    group:item("pocketwatch", 5)
    group:item("diving_watch", 20)
    group:entry { item = "game_watch", charges = { 0, 50 }, probability = 5 }
    group:item("fitness_band", 35)
    group:entry { item = "smart_watch", charges = { 0, 80 }, probability = 50 }
    group:entry { item = "smart_watch_adv", charges = { 0, 40 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pants", kind = "distribution" }
    group:item("jeans", 90)
    group:item("jeans_ripped", 10)
    group:item("jeans_skinny", 20)
    group:item("pants_checkered", 5)
    group:item("shorts", 70)
    group:item("shorts_denim", 35)
    group:item("pants_hiking", 5)
    group:item("pants_tactical", 5)
    group:item("pants", 75)
    group:item("leather_belt", 30)
    group:item("pants_leather", 60)
    group:item("pants_cargo", 70)
    group:item("shorts_cargo", 50)
    group:item("skirt", 75)
    group:item("skirt_long", 55)
    group:item("skirt_denim", 10)
    group:item("skirt_leather", 5)
    group:item("leggings", 15)
    group:item("under_armor_shorts", 20)
    group:item("dress", 70)
    group:item("sundress", 50)
    group:item("dress_wedding", 1)
    group:item("postman_shorts", 5)
    group:item("b_shorts", 15)
    group:item("kilt", 2)
    group:item("nanoskirt", 10)
    group:item("pants", 5, "pants_flag")
    group:group("costume_pants_skirts", 1)
    group:entry { item = "pants", variant = "pants_flag", event = "independence_day" }
    group:entry { group = "christmas_pants_male", event = "christmas" }
    group:entry { group = "costume_pants_skirts", event = "halloween" }
    group:item("cheongsam", 1)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "winter", kind = "distribution", with_ammo = 50, with_magazine = 100 }
    group:item("coat_winter", 50)
    group:item("peacoat", 30)
    group:item("ski_jacket", 40)
    group:item("greatcoat", 15)
    group:item("gloves_light", 35)
    group:item("mittens", 30)
    group:item("gloves_wool", 33)
    group:item("gloves_wool_fingerless", 15)
    group:item("thermal_socks", 10)
    group:item("thermal_gloves", 10)
    group:item("thermal_suit", 10)
    group:item("thermal_mask", 10)
    group:item("thermal_outfit", 5)
    group:item("gloves_winter", 40)
    group:item("gloves_liner", 25)
    group:item("gloves_leather", 45)
    group:item("bellyband", 10)
    group:item("scarf", 45)
    group:item("knit_scarf", 35)
    group:item("long_knit_scarf", 15)
    group:item("scarf_long", 2)
    group:item("hat_cotton", 45)
    group:item("hat_newsboy", 20)
    group:item("hat_knit", 25)
    group:item("hat_fur", 15)
    group:item("hat_faux_fur", 20)
    group:item("pants_ski", 60)
    group:item("ski_bib", 40)
    group:item("mask_ski", 15)
    group:item("long_underpants", 40)
    group:item("long_undertop", 40)
    group:item("union_suit", 40)
    group:item("tights", 20)
    group:item("arm_warmers", 20)
    group:item("leg_warmers", 20)
    group:item("balclava", 15, "black")
    group:item("santa_jacket", 1)
    group:item("santa_jacket_short", 1)
    group:item("santa_shorts", 1)
    group:item("santa_pants", 1)
    group:item("santa_gloves", 1)
    group:item("gloves_white", 1)
    group:item("santa_hat", 1)
    group:item("santa_belt", 1)
    group:item("santa_beard", 1)
    group:item("santa_dress", 1)
    group:item("santa_dress_long", 1)
    group:item("santa_dress_short", 1)
    content.add(group)
end
