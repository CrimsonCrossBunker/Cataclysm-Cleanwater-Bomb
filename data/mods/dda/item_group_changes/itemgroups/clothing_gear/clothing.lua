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

do
    local group = content.ItemGroup { id = "allclothes", kind = "distribution" }
    group:item("jeans", 90)
    group:item("jeans_ripped", 10)
    group:item("jeans_skinny", 20)
    group:item("pants_checkered", 5)
    group:item("shorts", 70)
    group:item("shorts_denim", 35)
    group:item("ski_jacket", 40)
    group:item("pants", 75)
    group:item("breeches", 10)
    group:item("leather_belt", 30)
    group:item("suit", 60)
    group:item("waistcoat", 30)
    group:item("tophat", 5)
    group:item("bowhat", 10)
    group:item("cowboy_hat", 10)
    group:item("cowboy_hat", 1, "flag_cowboy_hat")
    group:entry { item = "cowboy_hat", variant = "flag_cowboy_hat", event = "independence_day", probability = 70 }
    group:item("boots_denim", 2)
    group:item("shoes_denim", 5)
    group:item("boots_western", 8)
    group:item("glasses_monocle", 2)
    group:item("pants_leather", 60)
    group:item("pants_cargo", 70)
    group:item("pants_hiking", 5)
    group:item("shorts_cargo", 50)
    group:item("skirt", 75)
    group:item("skirt_long", 55)
    group:item("skirt_denim", 10)
    group:item("skirt_leather", 5)
    group:item("tshirt", 70)
    group:item("longshirt", 80)
    group:item("polo_shirt", 65)
    group:item("dress_shirt", 60)
    group:item("denim_shirt", 30)
    group:item("tank_top", 50)
    group:item("camisole", 30)
    group:item("bra", 30)
    group:item("undershirt", 30)
    group:item("boxer_shorts", 30)
    group:item("boxer_shorts", 2, "flag_boxer_shorts")
    group:entry { item = "boxer_shorts", variant = "flag_boxer_shorts", event = "independence_day" }
    group:item("briefs", 15)
    group:item("boxer_briefs", 20)
    group:item("swim_briefs", 10)
    group:item("speedo", 5)
    group:group("bikini", 10)
    group:item("panties", 30)
    group:item("boy_shorts", 25)
    group:item("boy_shorts", 2, "flag_boy_shorts")
    group:entry { item = "boy_shorts", variant = "flag_boy_shorts", event = "independence_day", probability = 70 }
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
    group:item("vest_jean", 20)
    group:item("blazer", 35)
    group:item("jacket_leather", 30)
    group:item("tacjacket", 30)
    group:item("leather_police_jacket", 10)
    group:item("coat_winter", 50)
    group:item("coat_light_winter", 50)
    group:item("peacoat", 30)
    group:item("greatcoat", 15)
    group:item("gloves_light", 35)
    group:item("mittens", 30)
    group:item("gloves_wool", 33)
    group:item("gloves_wool_fingerless", 10)
    group:item("thermal_socks", 2)
    group:item("thermal_gloves", 2)
    group:item("thermal_suit", 2)
    group:item("thermal_mask", 2)
    group:item("thermal_outfit", 1)
    group:item("thermal_shirt", 1)
    group:item("gloves_winter", 40)
    group:item("gloves_liner", 25)
    group:item("gloves_leather", 45)
    group:item("gloves_work", 5)
    group:item("scarf", 45)
    group:item("hat_golf", 30)
    group:item("knit_scarf", 35)
    group:item("long_knit_scarf", 5)
    group:item("scarf_long", 1)
    group:item("hat_cotton", 45)
    group:item("hat_knit", 25)
    group:item("hat_newsboy", 20)
    group:item("hat_sombrero", 3)
    group:item("hat_fur", 15)
    group:item("hat_faux_fur", 20)
    group:item("under_armor", 20)
    group:item("under_armor_shorts", 20)
    group:item("tights", 20)
    group:item("leggings", 20)
    group:item("garter_belt", 10)
    group:item("stockings", 20)
    group:item("balclava", 15, "black")
    group:item("pants_ski", 60)
    group:item("ski_bib", 40)
    group:item("long_underpants", 40)
    group:item("long_undertop", 40)
    group:item("union_suit", 5)
    group:item("leotard", 3)
    group:item("unitard", 1)
    group:item("arm_warmers", 20)
    group:item("leg_warmers", 20)
    group:item("trenchcoat_leather", 12)
    group:item("trenchcoat_faux_fur", 6)
    group:item("sleeveless_trenchcoat", 2)
    group:item("sleeveless_trenchcoat_leather", 2)
    group:item("sleeveless_trenchcoat_faux_fur", 2)
    group:item("trenchcoat_leather", 12)
    group:item("sleeveless_trenchcoat_fur", 1)
    group:item("duster_leather", 12)
    group:item("duster_faux_fur", 6)
    group:item("sleeveless_duster", 2)
    group:item("sleeveless_duster_leather", 2)
    group:item("sleeveless_duster_faux_fur", 2)
    group:item("sleeveless_duster_fur", 1)
    group:item("cloak", 5)
    group:item("cloak_wool", 5)
    group:item("house_coat", 25)
    group:item("flotation_vest", 1)
    group:item("fishing_waders", 5)
    group:item("rashguard", 15)
    group:item("wetsuit_jacket", 10)
    group:item("wetsuit_top", 10)
    group:item("wetsuit_top_sleeved", 10)
    group:item("wetsuit_pants", 10)
    group:item("wetsuit_shorts", 10)
    group:item("flag_swimsuit", 15)
    group:item("wetsuit", 5)
    group:item("wetsuit_thick", 1)
    group:item("wetsuit_spring", 5)
    group:item("wetsuit_spring_sleeveless", 5)
    group:item("wetsuit_gloves", 10)
    group:item("wetsuit_gloves_thick", 1)
    group:item("wetsuit_booties", 10)
    group:item("wetsuit_booties_thick", 1)
    group:item("wetsuit_hood", 5)
    group:item("wetsuit_hood_thick", 5)
    group:item("swim_cap", 15)
    group:item("dive_bag", 5)
    group:item("dry_bag", 5)
    group:item("dry_duffelbag", 5)
    group:item("dry_bag_large", 3)
    group:item("jedi_cloak", 1)
    group:item("apron_cotton", 30)
    group:item("waist_apron_long", 10)
    group:item("waist_apron_short", 5)
    group:item("apron_leather", 5)
    group:item("apron_plastic", 5)
    group:item("clown_suit", 1)
    group:item("clownshoes", 1)
    group:item("clown_wig", 1)
    group:item("clown_nose", 1)
    group:item("bondage_suit", 1)
    group:item("bondage_mask", 1)
    group:item("zentai", 1)
    group:item("kasaya", 1)
    group:item("antarvasa", 1)
    group:item("uttarasanga", 1)
    group:item("samghati", 1)
    group:item("corset", 10)
    group:item("corset_waist", 10)
    group:item("chestwrap", 5)
    group:item("bellywrap", 2)
    group:item("bellyband", 2)
    group:item("boots_combat", 10)
    group:item("pants_army", 10)
    group:item("jacket_army", 10)
    group:item("jacket_army_modern", 2)
    group:item("combat_shirt", 2)
    group:item("winter_pants_army", 10)
    group:item("winter_jacket_army", 10)
    group:item("winter_gloves_army", 10)
    group:item("tank_top", 20, "tank_top_camo")
    group:item("tux", 1)
    group:item("gown", 1)
    group:item("long_glove_white", 1)
    group:item("veil_wedding", 1)
    group:item("dress_wedding", 1)
    group:item("porkpie", 5)
    group:item("tie_bow", 5)
    group:item("tie_clipon", 5)
    group:item("tie_necktie", 5)
    group:item("tie_skinny", 5)
    group:item("tieclip", 2)
    group:item("collarpin", 2)
    group:item("jersey", 40)
    group:item("postman_shorts", 5)
    group:item("postman_shirt", 5)
    group:item("postman_hat", 5)
    group:item("maid_dress", 1)
    group:item("maid_dress_short", 1)
    group:item("maid_hat", 1)
    group:item("halter_top", 50)
    group:item("kilt", 2)
    group:item("nanoskirt", 10)
    group:item("sleeveless_tunic", 5)
    group:item("ear_spool", 30)
    group:item("fedora", 5)
    group:item("straw_hat", 5)
    group:item("straw_fedora", 5)
    group:item("kufi", 2)
    group:item("kippah", 2)
    group:item("thawb", 1)
    group:item("hijab", 2)
    group:item("niqab", 1)
    group:item("abaya", 1)
    group:item("kittel", 1)
    group:item("cassock", 1)
    group:item("priest_collar", 1)
    group:item("nun_habit", 1)
    group:item("nun_wimple", 1)
    group:item("robe", 5)
    group:item("eboshi", 1)
    group:item("kariginu", 1)
    group:item("geta", 1)
    group:item("kimono", 2)
    group:item("yukata", 4)
    group:item("haori", 1)
    group:item("hakama", 2)
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
    group:item("witch_dress", 1)
    group:item("mummy_dress", 1)
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
    group:item("zombie_mask", 1)
    group:item("cheerleader_skirt", 5)
    group:item("cheerleader_skirt_short", 1)
    group:item("pants", 5, "pants_flag")
    group:item("trousers_ninja", 1)
    group:item("tank_top", 5, "tank_top_cheerleader")
    group:item("cheerleader_top_short", 1)
    group:item("flag_jumpsuit", 2)
    group:item("denim_overalls", 10)
    group:item("jumpsuit_skeleton", 1)
    group:item("mummy_jumpsuit", 1)
    group:item("bodysuit_lycra", 5)
    group:item("flag_swimsuit", 10)
    group:item("cheongsam", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivorzed_extra", kind = "distribution" }
    group:item("daypack", 4)
    group:item("mask_lsurvivor", 10)
    group:item("mask_survivor", 8)
    group:item("mask_hsurvivor", 6)
    group:item("survivor_vest", 8)
    group:item("survivor_runner_pack", 6)
    group:item("survivor_pack", 5)
    group:item("survivor_rucksack", 4)
    group:item("survivor_duffel_bag", 3)
    group:item("dive_bag", 10)
    group:item("dry_bag", 10)
    group:item("dry_duffelbag", 10)
    group:item("dry_bag_large", 5)
    group:item("runner_bag", 20)
    group:item("molle_pack", 12)
    group:item("backpack", 40)
    group:item("backpack_denim", 12)
    group:item("backpack_leather", 32)
    group:item("mbag", 26)
    group:item("purse", 14)
    group:item("slingpack", 12)
    group:item("rucksack", 12)
    group:group("gym_bags", 40)
    group:item("duffelbag", 8)
    group:group("large_duffelbags", 4)
    group:item("quiver_takedown_bow", 1)
    group:item("mask_bal", 14)
    group:item("mask_hockey", 26)
    group:item("throat_guard_nylon", 2)
    group:item("throat_guard_canvas", 2)
    group:item("throat_guard_plastic", 1)
    group:item("throat_guard_cut_resistant", 1)
    group:group("gasmask_bag_full", 24)
    group:entry { item = "mask_gas_half", charges = { 0, 100 }, probability = 24 }
    group:entry { item = "mask_filter", charges = { 0, 100 }, probability = 12 }
    group:item("mask_bunker", 2)
    group:item("mask_fsurvivor", 2)
    group:item("sunglasses", 12)
    group:item("fitover_sunglasses", 8)
    group:item("glasses_bal", 18)
    group:item("glasses_safety", 24)
    group:item("goggles_ski", 14)
    group:entry { item = "goggles_nv", charges = { 0, 100 }, probability = 2 }
    group:entry { item = "goggles_ir", charges = { 0, 100 }, probability = 1 }
    group:item("tacvest", 22)
    group:item("legrig", 22)
    group:item("tool_belt", 16)
    group:item("fanny", 12)
    group:item("dump_pouch", 6)
    group:item("ragpouch", 22)
    group:item("leather_pouch", 16)
    group:group("archery_loaded_quivers", 2)
    group:item("quiver", 10)
    group:item("nylon_quiver", 5)
    group:item("quiver_birchbark", 4)
    group:item("quiver_large", 6)
    group:item("quiver_large_birchbark", 2)
    group:item("javelin_bag", 2)
    group:item("wristwatch", 24)
    group:item("diving_watch", 16)
    group:item("pocketwatch", 14)
    group:item("holster", 6)
    group:item("nylon_holster", 8)
    group:item("bandana", 18)
    group:item("scarf", 26)
    group:item("long_knit_scarf", 15)
    group:entry { item = "mask_gas_xl", charges = { 0, 100 }, probability = 4 }
    group:item("hat_boonie", 16)
    group:item("beret", 18)
    group:item("beret_wool", 14)
    group:item("balclava", 12, "black")
    group:item("mask_survivorxl", 2)
    group:item("combatsaw_off", 1)
    group:item("ashot", 4)
    group:item("pickaxe", 1)
    group:item("makeshift_machete", 4)
    group:item("machete_gimmick", 3)
    group:item("fungicide", 10)
    group:group("insecticide_bag_plastic", 10)
    group:group("antifungal_bottle_plastic_pill_prescription_1_10", 1)
    group:group("antiparasitic_bottle_plastic_pill_prescription_1_10", 5)
    group:group("diazepam_bottle_plastic_pill_prescription_1_10", 1)
    group:item("throw_extinguisher", 2)
    group:entry { item = "small_repairkit", charges = { 0, 500 }, probability = 14 }
    group:item("grapnel", 6)
    group:item("misc_repairkit", 8)
    group:entry {
        distribution = {
            { group = "full_survival_kit" },
            { group = "used_survival_kit" },
        },
        probability = 3,
    }
    group:group("tools_toolbox", 1)
    group:item("survivor_belt_notools", 2)
    group:item("acetylene_cooker", 12)
    group:item("survivor_shavingkit", 3)
    group:item("survivor_hairtrimmer", 1)
    group:item("survivor_scope", 1)
    group:item("survnote", 30)
    group:item("gaiter_boot", 5)
    group:item("gaiter_boot_heavy", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "laundry", kind = "distribution" }
    group:item("basket_laundry", 30)
    group:item("jeans", 90)
    group:item("jeans_ripped", 10)
    group:item("jeans_skinny", 20)
    group:item("pants_checkered", 5)
    group:item("shorts", 70)
    group:item("shorts_denim", 35)
    group:item("pants", 75)
    group:item("breeches", 10)
    group:item("suit", 60)
    group:item("waistcoat", 30)
    group:item("pants_leather", 60)
    group:item("pants_cargo", 70)
    group:item("shorts_cargo", 50)
    group:item("skirt", 75)
    group:item("skirt_long", 60)
    group:item("skirt_denim", 10)
    group:item("skirt_leather", 5)
    group:item("tshirt", 70)
    group:item("tshirt_cropped", 7)
    group:item("longshirt", 80)
    group:item("polo_shirt", 65)
    group:item("dress_shirt", 60)
    group:item("denim_shirt", 30)
    group:item("tank_top", 50)
    group:item("camisole", 30)
    group:item("bra", 30)
    group:item("undershirt", 30)
    group:item("boxer_shorts", 30)
    group:item("boxer_shorts", 2, "flag_boxer_shorts")
    group:entry { item = "boxer_shorts", variant = "flag_boxer_shorts", event = "independence_day" }
    group:item("briefs", 15)
    group:item("boxer_briefs", 20)
    group:item("swim_briefs", 10)
    group:item("speedo", 5)
    group:group("bikini", 20)
    group:item("panties", 30)
    group:item("boy_shorts", 25)
    group:item("boy_shorts", 2, "flag_boy_shorts")
    group:entry { item = "boy_shorts", variant = "flag_boy_shorts", event = "independence_day", probability = 70 }
    group:item("sweatshirt", 75)
    group:item("sweater", 75)
    group:item("turtleneck", 40)
    group:item("turtleneck_shirt", 25)
    group:item("hoodie", 65)
    group:item("hoodie_cropped", 6)
    group:item("jacket_light", 50)
    group:item("jacket_windbreaker", 25)
    group:item("jacket_varsity", 20)
    group:item("jacket_jean", 35)
    group:item("vest_jean", 20)
    group:item("blazer", 35)
    group:item("gloves_light", 35)
    group:item("mittens", 30)
    group:item("thermal_socks", 2)
    group:item("thermal_gloves", 2)
    group:item("gloves_liner", 25)
    group:item("scarf", 45)
    group:item("scarf_long", 1)
    group:item("hat_cotton", 45)
    group:item("hat_knit", 25)
    group:item("hat_newsboy", 20)
    group:item("under_armor", 20)
    group:item("under_armor_shorts", 20)
    group:item("dress", 20)
    group:item("tights", 20)
    group:item("leggings", 20)
    group:item("stockings", 20)
    group:item("garter_belt", 10)
    group:item("long_underpants", 40)
    group:item("long_undertop", 40)
    group:item("union_suit", 20)
    group:item("arm_warmers", 20)
    group:item("leg_warmers", 20)
    group:item("corset", 10)
    group:item("corset_waist", 10)
    group:item("leg_bag", 8)
    group:item("pants_army", 10)
    group:item("tank_top", 20, "tank_top_camo")
    group:item("tux", 1)
    group:item("kasaya", 1)
    group:item("antarvasa", 1)
    group:item("uttarasanga", 1)
    group:item("samghati", 1)
    group:item("jersey", 40)
    group:item("maid_dress", 1)
    group:item("maid_dress_short", 1)
    group:item("halter_top", 50)
    group:item("kilt", 2)
    group:item("nanoskirt", 10)
    group:item("robe", 50)
    group:item("trenchcoat_steampunk", 5)
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
    group:item("witch_dress", 1)
    group:item("mummy_dress", 1)
    group:item("long_dress_sleeved", 1, "witch_black")
    group:item("short_dress_sleeved", 1, "witch_black")
    group:item("nun_habit", 1)
    group:item("nun_wimple", 1)
    group:item("gloves_black", 5)
    group:item("gloves_skeleton", 1)
    group:item("gloves_claws", 1)
    group:item("wizard_hat_costume", 1)
    group:item("pointed_hat", 1)
    group:item("hood_ninja", 1)
    group:item("balclava", 1, "skull")
    group:item("mask_skull", 1)
    group:item("zombie_mask", 1)
    group:item("cheerleader_skirt", 5)
    group:item("cheerleader_skirt_short", 1)
    group:item("pants", 5, "pants_flag")
    group:item("trousers_ninja", 1)
    group:item("tank_top", 5, "tank_top_cheerleader")
    group:item("cheerleader_top_short", 1)
    group:item("flag_jumpsuit", 2)
    group:item("jumpsuit_skeleton", 1)
    group:item("mummy_jumpsuit", 1)
    group:item("bodysuit_lycra", 3)
    group:item("flag_swimsuit", 2)
    group:item("cheongsam", 1)
    content.add(group)
end
