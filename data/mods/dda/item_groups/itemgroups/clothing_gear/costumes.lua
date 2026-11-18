local content = require("ccb").content

do
    -- mainly used for places of storage for costumes (like boxes in basements)
    local group = content.ItemGroup { id = "costume_all", kind = "distribution" }
    group:group("costume_all_clothing", 95)
    group:group("costume_misc_items", 5)
    content.add(group)
end

do
    -- mainly used for places for general clothing (like a dresser or a clothing store warehouse)
    local group = content.ItemGroup { id = "costume_all_clothing", kind = "distribution" }
    group:group("costume_accessories", 20)
    group:group("costume_cloacks", 10)
    group:group("costume_coats", 10)
    group:group("costume_dresses", 10)
    group:group("costume_gloves", 5)
    group:group("costume_hats_hoods", 20)
    group:group("costume_jackets", 10)
    group:group("costume_jewelry", 15)
    group:group("costume_masks", 20)
    group:group("costume_pants_skirts", 10)
    group:group("costume_shirts", 10)
    group:group("costume_suits", 10)
    group:group("costume_undergarments_women", 5)
    content.add(group)
end

do
    -- miscellaneous accessories for costumes, cosplay and costume parties
    local group = content.ItemGroup { id = "costume_accessories", kind = "distribution" }
    group:item("vampire_fangs", 40)
    group:item("santa_belt", 30)
    group:item("apron_leather", 25)
    group:item("apron_cotton", 5)
    group:item("waist_apron_long", 5)
    group:item("waist_apron_short", 5)
    group:item("apron_cotton", 10, "camo_apron_cotton")
    group:item("apron_cotton", 15, "maid_apron")
    group:item("apron_cotton", 15, "gothic_apron")
    group:item("waist_apron_short", 5, "camo_apron_cotton")
    group:item("waist_apron_short", 10, "maid_apron")
    group:item("waist_apron_short", 7, "gothic_apron")
    group:item("leg_bag", 10)
    group:item("leg_bag", 15, "steampunk_leg_bag")
    group:item("leg_bag", 15, "skull_leg_bag")
    group:item("clown_nose", 20)
    group:item("plastic_mandible_guard", 5)
    group:item("leg_sheath6", 20)
    group:entry { item = "throwing_knife", count = { 1, 6 }, wrapper = "leg_sheath6", probability = 1 }
    group:entry { item = "punch_dagger", container = "gartersheath1", probability = 1 }
    group:item("gartersheath1", 25)
    group:item("gartersheath2", 10)
    group:item("eyepatch_leather", 20)
    group:item("hakama", 1)
    group:item("devil_tail", 15)
    group:item("angel_wings", 15)
    group:item("cuffs", 25)
    group:item("collar_playboy", 25)
    content.add(group)
end

do
    -- coats and robes for costumes, cosplay and costume parties
    local group = content.ItemGroup { id = "costume_coats", kind = "distribution" }
    group:item("robe_wizard", 30)
    group:item("ghost_robe", 20)
    group:item("ghost_robe_sheet", 10)
    group:item("grim_reaper_robe", 25)
    group:item("coat_lab", 8)
    group:item("coat_straw", 5)
    group:item("robe", 10)
    group:item("samghati", 1)
    group:item("haori", 1)
    group:item("trenchcoat_steampunk", 15)
    group:item("plaguedoctor_robe", 15)
    group:item("nun_habit", 10)
    group:item("blazer", 20, "bostonchan")
    content.add(group)
end

do
    -- jackets for costumes, cosplay and costume parties
    local group = content.ItemGroup { id = "costume_jackets", kind = "distribution" }
    group:item("santa_jacket", 50)
    group:item("santa_jacket_short", 25)
    group:item("jacket_chef", 25)
    group:item("jacket_leather", 40)
    group:item("jacket_army", 25)
    group:item("jacket_ninja", 25)
    content.add(group)
end

do
    -- dresses for costumes, cosplay and costume parties
    local group = content.ItemGroup { id = "costume_dresses", kind = "distribution" }
    group:item("santa_dress", 50)
    group:item("santa_dress_short", 25)
    group:item("santa_dress_long", 5)
    group:item("bee_dress", 25)
    group:item("cheerleader_dress", 30)
    group:item("mummy_dress", 25)
    group:item("ninja_dress", 15)
    group:item("ninja_dress_sleeveless", 15)
    group:item("long_dress_sleeved", 35, "sinister")
    group:item("short_dress", 25, "sinister")
    group:item("gown_sleeved", 15, "sinister")
    group:item("dress_sleeved", 35, "witch_black")
    group:item("long_dress_sleeved", 25, "witch_black")
    group:item("short_dress_sleeved", 20, "witch_black")
    group:item("maid_dress", 25)
    group:item("maid_dress_short", 35)
    group:item("kimono", 5)
    group:item("yukata", 5)
    group:item("gown", 5)
    group:item("dress_wedding", 5)
    group:item("cheongsam", 10)
    content.add(group)
end

do
    -- gloves for costumes, cosplay and costume parties
    local group = content.ItemGroup { id = "costume_gloves", kind = "distribution" }
    group:item("gloves_white", 25)
    group:item("santa_gloves", 15)
    group:item("gloves_leather", 15)
    group:item("gloves_black", 25)
    group:item("gloves_skeleton", 15)
    group:item("gloves_claws", 5)
    group:item("long_glove_white", 15)
    group:item("gloves_fingerless", 15)
    group:item("beekeeping_gloves", 5)
    content.add(group)
end

do
    -- hats and hoods for costumes, cosplay and costume parties
    local group = content.ItemGroup { id = "costume_hats_hoods", kind = "distribution" }
    group:item("santa_hat", 25)
    group:item("hat_sombrero", 20)
    group:item("cowboy_hat", 20)
    group:item("hat_hard", 10)
    group:entry { item = "plastic_mandible_guard", container = "hat_hard", probability = 1 }
    group:item("hat_hard_hooded", 1)
    group:item("hat_hard", 10, "skull_hat_hard")
    group:item("hat_hard_hooded", 1, "skull_hat_hard")
    group:item("hat_hard", 10, "steampunk_hat_hard")
    group:item("hat_hard_hooded", 1, "steampunk_hat_hard")
    group:item("clown_wig", 15)
    group:item("bostonchan_wig", 20)
    group:item("tricorne", 5)
    group:item("wizard_hat_costume", 25)
    group:item("pointed_hat", 20)
    group:item("maid_hat", 15)
    group:item("hood_ninja", 15)
    group:item("postman_hat", 10)
    group:item("hat_chef", 5)
    group:item("tophat", 5)
    group:item("straw_hat", 5)
    group:item("bandana_head", 5)
    group:item("fedora", 10)
    group:item("porkpie", 10)
    group:item("nun_wimple", 12)
    group:item("devil_horn_headband", 15)
    group:item("angel_halo_headband", 15)
    group:item("bunny_ears_black", 25)
    content.add(group)
end

do
    -- jewelry for costumes, cosplay and costume parties
    local group = content.ItemGroup { id = "costume_jewelry", kind = "distribution" }
    group:group("costume_jewelry_dark", 50)
    group:group("costume_jewelry_vampire", 50)
    content.add(group)
end

do
    -- jewelry for costumes, cosplay and costume parties
    local group = content.ItemGroup { id = "costume_jewelry_dark", kind = "distribution" }
    group:item("onyx_silver_cufflinks", 10, "dark_cufflinks")
    group:item("onyx_silver_earring", 25, "dark_earring")
    group:item("onyx_silver_ring", 25, "dark_ring")
    group:item("onyx_silver_bracelet", 10, "dark_bracelet")
    group:item("onyx_silver_pendant_necklace", 15, "dark_necklace")
    group:item("onyx_silver_tiara", 15, "dark_tiara")
    content.add(group)
end

do
    -- jewelry for costumes, cosplay and costume parties
    local group = content.ItemGroup { id = "costume_jewelry_vampire", kind = "distribution" }
    group:item("ruby_silver_cufflinks", 10, "vampire_cufflinks")
    group:item("ruby_silver_earring", 25, "vampire_earring")
    group:item("ruby_silver_ring", 25, "vampire_ring")
    group:item("ruby_silver_bracelet", 10, "vampire_bracelet")
    group:item("ruby_silver_pendant_necklace", 15, "vampire_necklace")
    group:item("ruby_silver_tiara", 15, "vampire_tiara")
    content.add(group)
end

do
    -- masks for costumes, cosplay and costume parties
    local group = content.ItemGroup { id = "costume_masks", kind = "distribution" }
    group:item("santa_beard", 20)
    group:item("mask_skull", 10, "guy_fawkes")
    group:item("mask_hockey", 20)
    group:item("bondage_mask", 5)
    group:item("blindfold", 5)
    group:item("balclava", 25, "skull")
    group:item("mask_skull", 20)
    group:item("scarf_long", 10)
    group:item("mask_dust", 20, "skull_mask_dust")
    group:item("mask_dust", 15, "steampunk_mask_dust")
    group:item("mask_dust", 15, "flag_mask_dust")
    group:item("face_veil", 10)
    group:item("mask_plague", 15)
    group:item("pumpkin_mask", 10)
    group:item("zombie_mask", 10)
    content.add(group)
end

do
    -- pants and skirts for costumes, cosplay and costume parties
    local group = content.ItemGroup { id = "costume_pants_skirts", kind = "distribution" }
    group:group("costume_pants", 70)
    group:group("costume_skirts", 30)
    content.add(group)
end

do
    -- pants for costumes, cosplay and costume parties
    local group = content.ItemGroup { id = "costume_pants", kind = "distribution" }
    group:item("santa_pants", 20)
    group:item("santa_shorts", 10)
    group:item("pants", 15, "pants_flag")
    group:item("trousers_ninja", 10)
    group:item("pants_army", 10)
    group:item("striped_pants", 15)
    group:item("pants_leather", 15)
    group:item("hot_pants_leather", 15)
    group:item("postman_shorts", 10)
    content.add(group)
end

do
    -- skirts for costumes, cosplay and costume parties
    local group = content.ItemGroup { id = "costume_skirts", kind = "distribution" }
    group:item("cheerleader_skirt", 15)
    group:item("cheerleader_skirt_short", 15)
    group:item("nanoskirt", 10)
    group:item("skirt_leather", 15)
    group:item("skirt_bostonchan", 20)
    content.add(group)
end

do
    -- shirts for costumes, cosplay and costume parties
    local group = content.ItemGroup { id = "costume_shirts", kind = "distribution" }
    group:item("tank_top", 25, "tank_top_cheerleader")
    group:item("cheerleader_top_short", 35)
    group:item("rashguard", 10, "lifeguard_rashguard_shirt")
    group:item("rashguard", 10, "skull_rashguard_shirt")
    group:item("rashguard", 10, "gothic_rashguard_shirt")
    group:item("postman_shirt", 10)
    group:item("tshirt", 100, "flag_shirt")
    group:item("dress_shirt", 10)
    group:item("longshirt", 10)
    content.add(group)
end

do
    -- body suits for costumes, cosplay and costume parties
    local group = content.ItemGroup { id = "costume_suits", kind = "distribution" }
    group:item("flag_jumpsuit", 25)
    group:item("jumpsuit_skeleton", 25)
    group:item("mummy_jumpsuit", 25)
    group:item("bodysuit_lycra", 25)
    group:item("suit", 10)
    group:item("tux", 10)
    group:item("fursuit", 15)
    group:item("clown_suit", 10)
    group:item("fursuit", 10, "dragonsuit")
    group:item("fursuit", 10, "felinesuit")
    group:item("fursuit", 10, "dinosuit")
    group:item("fursuit", 10, "sharksuit")
    group:item("bondage_suit", 15)
    group:item("wool_suit_devil", 15)
    group:item("bunny_suit_playboy", 25)
    group:item("beekeeping_suit", 5)
    group:item("zentai", 5)
    group:item("jumpsuit_pocketless", 100, "orange")
    content.add(group)
end

do
    -- undergarments for costumes, cosplay and costume parties
    local group = content.ItemGroup { id = "costume_undergarments_women", kind = "distribution" }
    group:item("flag_swimsuit", 15)
    group:item("wetsuit_spring", 5)
    group:item("wetsuit_spring_sleeveless", 5)
    group:item("corset", 20)
    group:item("corset_waist", 20)
    group:item("leotard", 10)
    group:item("unitard", 5)
    group:item("tights", 25)
    group:item("stockings", 25)
    group:item("garter_belt", 25)
    group:group("bikini", 35)
    group:entry {
        collection = {
            { item = "bikini_top", variant = "maid_bikini_top" },
            { item = "bikini_bottom", variant = "maid_bikini_bottom" },
        },
        probability = 5,
    }
    group:entry {
        collection = {
            { item = "bikini_top", variant = "skull_bikini_top" },
            { item = "bikini_bottom", variant = "skull_bikini_bottom" },
        },
        probability = 5,
    }
    group:item("flag_swimsuit", 10, "lifeguard_swimsuit")
    content.add(group)
end

do
    -- mainly used for places for general clothing (like a dresser or a clothing store warehouse)
    local group = content.ItemGroup { id = "independence_all_clothing", kind = "distribution" }
    group:item("flag_jumpsuit", 25)
    group:item("tshirt", 100, "flag_shirt")
    group:item("pants", 25, "pants_flag")
    group:item("american_flag", 25)
    group:group("costume_independence_undergarments_women", 25)
    group:item("rashguard", 15, "flag_rashguard_shirt")
    group:item("mask_dust", 15, "flag_mask_dust")
    group:item("hat_hard", 10, "flag_hat_hard")
    group:item("hat_hard_hooded", 1, "flag_hat_hard")
    content.add(group)
end

do
    -- women undergarments for independence day
    local group = content.ItemGroup { id = "costume_independence_undergarments_women", kind = "distribution" }
    group:item("bikini_top", 40, "flag_bikini_top")
    group:item("bikini_bottom", 40, "flag_bikini_bottom")
    group:item("bodysuit_lycra", 10, "flag_suit")
    group:item("flag_swimsuit", 10, "flag_swimsuit")
    content.add(group)
end

do
    -- clothing sets for any cheerleader costume/outfit
    local group = content.ItemGroup { id = "costume_cheerleader_set_any", kind = "distribution" }
    group:group("costume_cheerleader_set", 50)
    group:group("costume_cheerleader_short_set", 25)
    group:item("cheerleader_dress", 25)
    content.add(group)
end

do
    -- clothing set for a normal cheerleader outfit
    local group = content.ItemGroup { id = "costume_cheerleader_set", kind = "collection" }
    group:item("tank_top", 100, "tank_top_cheerleader")
    group:item("cheerleader_skirt")
    content.add(group)
end

do
    -- clothing set for a sexy cheerleader costume
    local group = content.ItemGroup { id = "costume_cheerleader_short_set", kind = "collection" }
    group:item("cheerleader_top_short")
    group:item("cheerleader_skirt_short")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "costume_weapons", kind = "distribution" }
    group:item("cutlass_inferior", 1)
    group:item("broadsword_inferior", 1)
    group:item("nodachi_inferior", 1)
    group:item("zweihander_inferior", 1)
    group:item("longsword_inferior", 1)
    group:item("katana_inferior", 1)
    group:item("kris", 1)
    group:item("rapier_fake", 1)
    group:item("cavalry_sabre_fake", 1)
    group:item("glaive", 1)
    group:item("naginata_fake", 5)
    group:item("naginata_inferior", 3)
    group:item("estoc_inferior", 4)
    group:item("estoc_fake", 6)
    group:item("qiang", 3)
    group:item("halberd", 2)
    group:item("halberd_fake", 7)
    group:item("katana_fake", 4)
    group:item("katana_inferior", 8)
    group:item("zweihander_fake", 4)
    group:item("zweihander_inferior", 8)
    group:item("cutlass_fake", 4)
    group:item("cutlass_inferior", 8)
    group:item("jian_fake", 4)
    group:item("jian_inferior", 8)
    group:item("scimitar_fake", 8)
    group:item("arming_sword_fake", 8)
    group:item("broadsword_fake", 4)
    group:item("broadsword_inferior", 8)
    group:item("longsword_fake", 4)
    group:item("longsword_inferior", 8)
    group:item("rapier_fake", 4)
    group:item("cavalry_sabre_fake", 4)
    group:item("wakizashi_fake", 4)
    group:item("wakizashi_inferior", 8)
    group:item("kris_fake", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pet_collars", kind = "distribution" }
    group:item("leather_collar", 2)
    group:item("faux_fur_collar", 1)
    group:item("fur_collar", 1)
    content.add(group)
end
