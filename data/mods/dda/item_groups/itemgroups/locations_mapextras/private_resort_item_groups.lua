local content = require("ccb").content

do
    local group = content.ItemGroup { id = "private_resort_dancer_drop", kind = "collection" }
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "bondage_suit" },
                    { item = "bondage_mask", probability = 50 },
                },
                probability = 10,
            },
            {
                collection = {
                    { item = "bodysuit_lycra", variant = "bondage_suit" },
                    { item = "bondage_mask", probability = 30 },
                },
                probability = 10,
            },
            { item = "bodysuit_lycra", probability = 5 },
            {
                collection = {
                    { group = "private_resort_dancer_torso", probability = 40 },
                    { group = "private_resort_dancer_underwear_top", probability = 60 },
                    { group = "private_resort_dancer_legs", probability = 50 },
                    { group = "private_resort_dancer_underwear_bottom", probability = 90 },
                },
                probability = 85,
            },
        },
        probability = 95,
    }
    group:group("private_resort_dancer_fancy", 50)
    group:entry { group = "accesories_personal_womens", count = { 0, 2 }, probability = 40 }
    group:group("clothing_glasses", 25)
    group:group("shoes_womens", 66)
    group:entry {
        collection = {
            { item = "stockings" },
            { item = "garter_belt", probability = 50 },
        },
        probability = 66,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "private_resort_dancer_fancy", kind = "distribution" }
    group:item("faux_fur_cat_ears", 80)
    group:item("leather_cat_ears", 50)
    group:item("fur_cat_ears", 10)
    group:item("faux_fur_cat_tail", 80)
    group:item("leather_cat_tail", 50)
    group:item("fur_cat_tail", 10)
    group:item("faux_fur_collar", 80)
    group:item("leather_collar", 50)
    group:item("fur_collar", 10)
    group:item("maid_hat", 25)
    group:item("cuffs", 30)
    group:item("collar_playboy", 30)
    group:item("bunny_ears_black", 30)
    content.add(group)
end

do
    -- For the dancer zombie, only torso clothing to be normally worn with underwear.
    local group = content.ItemGroup { id = "private_resort_dancer_torso", kind = "distribution" }
    group:item("corset_loose", 20)
    group:item("corset_waist", 10)
    group:item("apron_leather", 10)
    group:item("apron_cotton", 40, "maid_apron")
    group:item("apron_cotton", 15, "gothic_apron")
    group:item("waist_apron_short", 30, "maid_apron")
    group:item("waist_apron_short", 10, "gothic_apron")
    group:item("cheerleader_top_short", 10)
    group:item("halter_top", 50)
    group:item("bunny_suit_playboy", 30)
    content.add(group)
end

do
    -- For the dancer zombie, only torso underwear.
    local group = content.ItemGroup { id = "private_resort_dancer_underwear_top", kind = "distribution" }
    group:item("bra", 30)
    group:item("bikini_top", 30)
    group:item("bikini_top_leather", 60)
    group:item("bikini_top_fur", 60)
    group:item("bikini_top_short", 30)
    group:item("bikini_top", 15, "maid_bikini_top")
    group:item("corset", 20)
    group:item("corset_waist", 10)
    group:item("rope_6", 10)
    content.add(group)
end

do
    -- For the dancer zombie, only leg clothing to be normally worn with underwear.
    local group = content.ItemGroup { id = "private_resort_dancer_legs", kind = "distribution" }
    group:item("nanoskirt", 90)
    group:item("skirt_leather", 50)
    group:item("cheerleader_skirt_short", 15)
    group:item("skirt", 10)
    group:item("chaps_leather", 15)
    content.add(group)
end

do
    -- For the dancer zombie, only upper legs underwear.
    local group = content.ItemGroup { id = "private_resort_dancer_underwear_bottom", kind = "distribution" }
    group:item("panties", 30)
    group:item("bikini_bottom", 30)
    group:item("bikini_bottom_short", 10)
    group:item("bikini_bottom", 15, "maid_bikini_bottom")
    group:item("hot_pants", 60)
    group:item("hot_pants_leather", 60)
    group:item("hot_pants_fur", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "private_resort_staff_drop", kind = "collection" }
    group:entry {
        distribution = {
            { group = "private_resort_staff_male", probability = 50 },
            { group = "private_resort_staff_female", probability = 50 },
            { group = "private_resort_staff_bartender", probability = 20 },
            { group = "private_resort_staff_office", probability = 10 },
            { group = "clothing_work_set", probability = 10 },
        },
    }
    group:entry { group = "accesories_personal_unisex", count = { 0, 2 }, probability = 40 }
    group:entry { group = "default_zombie_items_pockets", count = { 0, 4 }, probability = 25 }
    group:group("socks_unisex", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "private_resort_staff_male", kind = "collection" }
    group:group("underwear_mens")
    group:item("pants")
    group:item("long_undertop", 25)
    group:item("dress_shoes", 80)
    group:item("tie_skinny", 50)
    group:item("dress_shirt", 95)
    group:entry { item = "knife_rm42", container = "gartersheath1", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "private_resort_staff_female", kind = "collection" }
    group:group("underwear_womens")
    group:entry {
        distribution = {
            { item = "dress_shoes", probability = 10 },
            { group = "shoes_womens", probability = 90 },
        },
        probability = 90,
    }
    group:group("private_resort_maid_dress")
    group:item("maid_hat", 66)
    group:entry { item = "knife_rm42", container = "gartersheath1", probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "private_resort_staff_bartender", kind = "collection" }
    group:group("underwear_mens")
    group:item("pants")
    group:item("long_undertop", 25)
    group:item("dress_shoes", 80)
    group:item("tie_bow", 90)
    group:item("dress_shirt", 95)
    group:item("porkpie", 60)
    group:item("apron_cotton", 30)
    group:item("waist_apron_long", 5)
    group:item("waist_apron_short", 5)
    group:item("apron_leather", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "private_resort_staff_office", kind = "collection" }
    group:group("underwear_mens")
    group:entry {
        distribution = {
            { item = "suit", probability = 90 },
            { item = "wool_suit", probability = 10 },
        },
        probability = 90,
    }
    group:item("long_undertop", 25)
    group:item("dress_shoes", 80)
    group:item("tie_necktie", 66)
    group:item("fedora", 25)
    group:item("suitcase_m", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "private_resort_dancing_clothes", kind = "distribution" }
    group:entry { group = "underwear_womens", count = { 1, 3 }, probability = 95 }
    group:group("accesories_personal_womens", 40)
    group:group("underwear_mens", 15)
    group:item("bondage_mask", 5)
    group:item("bondage_suit", 5)
    group:item("bodysuit_lycra", 1)
    group:group("shoes_womens", 66)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "private_resort_gambling_table", kind = "distribution" }
    group:group("bar_table", 40)
    group:group("bar_alcohol", 20)
    group:group("underwear_mens", 10)
    group:item("money_strap_twenty", 50)
    group:item("money_strap_fifty", 50)
    group:item("money_strap_hundred", 50)
    group:group("decks_of_cards", 90)
    group:item("plastic_six_dice", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "private_resort_instruments", kind = "distribution" }
    group:item("acoustic_guitar", 80)
    group:item("drum_percussion", 40)
    group:item("guitar_electric", 20)
    group:item("saxophone", 50)
    group:item("harmonica_holder", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "private_resort_coffee_table", kind = "distribution" }
    group:item("cup_plastic", 50)
    group:group("cig_box_cigarette_1_20", 50)
    group:entry { group = "cigar_box_opened", count = { 1, 2 }, probability = 15 }
    group:entry { item = "matches", charges = { 1, 20 }, probability = 50 }
    group:entry { item = "ref_matches", charges = { 1, 32 }, probability = 50 }
    group:entry { item = "rolling_paper", charges = { 1, 30 }, probability = 50 }
    group:item("wrapper", 50)
    group:item("wrapper_foil", 5)
    group:item("news_regional", 50)
    group:item("mag_news", 50)
    group:group("stash_drugs", 10)
    group:item("mag_porn", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "private_resort_wardrobe", kind = "distribution" }
    group:group("jackets", 20)
    group:group("suits", 50)
    group:group("hatstore_hats", 25)
    group:group("bags_trip", 15)
    group:entry { group = "mil_accessories", damage = { 0, 4 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "private_resort_sec_weapon", kind = "distribution" }
    group:entry { item = "tazer", charges = { 0, 500 }, damage = { 1, 4 }, probability = 20 }
    group:item("PR24-retracted", 50)
    group:item("shot_beanbag", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "private_resort_maid_dress", kind = "distribution" }
    group:item("maid_dress", 20)
    group:item("maid_dress_short", 65)
    group:item("apron_cotton", 10, "maid_apron")
    group:item("waist_apron_short", 5, "maid_apron")
    group:item("bikini_top", 5, "maid_bikini_top")
    group:item("bikini_bottom", 5, "maid_bikini_bottom")
    content.add(group)
end
