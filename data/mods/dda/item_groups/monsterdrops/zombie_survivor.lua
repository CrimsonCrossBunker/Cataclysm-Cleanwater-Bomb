local content = require("ccb").content

do
    local group = content.ItemGroup { id = "operator_headgear", kind = "distribution" }
    group:item("helmet_army", 20)
    group:item("hat_ball", 80)
    group:item("hat_boonie", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "operator_holster", kind = "distribution" }
    group:entry {
        item = "holster",
        contents = {
            { group = "sidearms_operator" },
        },
        probability = 20,
    }
    group:item("holster", 80)
    content.add(group)
end

do
    -- same as above but with the assumption that you have storage for magazines
    local group = content.ItemGroup { id = "operator_holster_field", kind = "distribution" }
    group:entry {
        collection = {
            { item = "holster" },
            { group = "sidearms_operator_in_field" },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "holster" },
            { group = "sidearms_operator_in_field_no_gun" },
        },
        probability = 80,
    }
    content.add(group)
end

do
    -- this group sorts out what the paramilitary has for storage that might influence other stuff
    -- for example if the person doesn't have storage they can't have any additional magazines
    -- an operator like this never loses their long gun, it's on a front sling
    local group = content.ItemGroup { id = "operator_armaments", kind = "distribution" }
    group:entry {
        collection = {
            { group = "contractor_ballistic_vest_light" },
            { group = "longguns_operator_in_field", damage = { 0, 1 }, dirt = { 1500, 7050 } },
            { group = "operator_holster_field", damage = { 1, 4 }, probability = 80 },
        },
        probability = 70,
    }
    group:entry {
        collection = {
            { group = "longguns_operator", damage = { 0, 1 }, dirt = { 1500, 7050 } },
            { group = "operator_holster", damage = { 1, 4 }, probability = 80 },
        },
        probability = 30,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_paramilitary_death_drops", kind = "collection", with_magazine = 100 }
    group:entry { group = "clothing_military", damage = { 1, 4 } }
    group:entry { item = "elbow_pads", damage = { 1, 4 }, probability = 10 }
    group:entry { item = "knee_pads", damage = { 1, 4 }, probability = 85 }
    group:entry { group = "operator_headgear", damage = { 1, 4 }, probability = 80 }
    group:entry { item = "gloves_tactical", damage = { 1, 4 }, probability = 60 }
    group:group("operator_armaments", 90)
    group:entry { group = "bugout_bag", damage = { 1, 4 }, probability = 10 }
    group:entry { group = "clothing_tactical_leg", damage = { 1, 4 }, probability = 15 }
    group:entry {
        distribution = {
            { group = "clothing_glasses", damage = { 1, 4 }, probability = 60 },
            { item = "glasses_bal", damage = { 1, 4 }, probability = 30 },
        },
        probability = 90,
    }
    group:entry { group = "clothing_watch", damage = { 1, 4 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivor_knife", kind = "distribution" }
    group:item("knife_huge", 15, "knife_butcher")
    group:item("knife_large", 15, "knife_chef")
    group:item("knife_large", 15, "knife_carving")
    group:item("knife_folding", 10)
    group:item("makeshift_knife", 1)
    group:item("knife_small", 35, "knife_steak")
    group:group("knife_rambo_cont", 15)
    group:item("knife_hunting", 10)
    group:item("knife_cleaver", 10, "knife_meat_cleaver")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivor_melee", kind = "distribution" }
    group:group("survivor_bashing")
    group:group("survivor_cutting")
    group:group("survivor_stabbing")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivor_grenades", kind = "distribution" }
    group:item("gasbomb_makeshift", 30)
    group:item("molotov")
    group:item("gelled_molotov", 5)
    group:item("pipebomb", 30)
    group:item("small_homemade_grenade", 30)
    group:item("40x46mm_hornets_nest_22lr", 5)
    group:item("40x46mm_hornets_nest_410", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivor_weapons", kind = "distribution" }
    group:group("survivor_knife", 10)
    group:group("survivor_melee", 40)
    group:group("guns_survival", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivor_basic_outfit", kind = "collection", with_magazine = 100 }
    group:group("underwear")
    group:group("survivor_basic_pants")
    group:group("survivor_basic_shirt")
    group:group("survivor_basic_hands", 95)
    group:group("survivor_basic_feet")
    group:group("clothing_glasses", 5)
    group:group("clothing_watch", 5)
    group:entry {
        distribution = {
            { group = "survivor_helmet_plus_mask", probability = 60 },
            { group = "survivor_basic_head_full", probability = 40 },
        },
    }
    group:entry {
        distribution = {
            { group = "survivor_basic_with_jacket", probability = 30 },
            { group = "survivor_basic_individual", probability = 70 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivor_helmet_plus_mask", kind = "collection", with_magazine = 100 }
    group:group("survivor_basic_head_only")
    group:group("survivor_basic_face", 75)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivor_basic_with_jacket", kind = "collection", with_magazine = 100 }
    group:group("survivor_basic_jacket")
    group:group("survivor_basic_legs", 95)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivor_basic_individual", kind = "collection", with_magazine = 100 }
    group:group("survivor_basic_torso")
    group:group("survivor_basic_legs", 95)
    group:group("survivor_basic_arms", 95)
    content.add(group)
end

do
    -- Anything a survivor looted or cobbled together to wear on their head
    local group = content.ItemGroup { id = "survivor_basic_head_only", kind = "distribution" }
    group:item("helmet_ball", 15)
    group:item("helmet_bike", 15)
    group:item("hat_boonie", 10)
    group:item("helmet_skid", 10)
    group:item("airsoft_helmet", 12)
    group:item("helmet_scrap", 5)
    group:item("pot_helmet", 7)
    group:item("helmet_army", 4)
    group:item("hat_hard", 22)
    group:group("hat_hard_flashlight", 9)
    group:item("firehelmet", 10)
    group:item("chainmail_junk_hood", 1)
    group:item("pickelhaube", 1)
    content.add(group)
end

do
    -- Anything a survivor looted or cobbled together to wear on their face
    local group = content.ItemGroup { id = "survivor_basic_face", kind = "distribution" }
    group:item("glasses_safety", 10)
    group:item("goggles_chem", 5)
    group:item("goggles_swim", 5)
    group:item("goggles_ski", 10)
    group:entry { item = "mask_gas", charges = { 0, 100 }, probability = 60 }
    group:entry { item = "mask_gas_half", charges = { 0, 100 }, probability = 60 }
    group:item("mask_hockey", 10)
    group:item("mask_bal", 1)
    group:item("balaclava_cut_resistant", 1)
    group:item("mask_rioter", 5)
    content.add(group)
end

do
    -- Anything a survivor looted or cobbled together to wear on their entire head
    local group = content.ItemGroup { id = "survivor_basic_head_full", kind = "distribution" }
    group:item("helmet_motor", 15)
    group:item("helmet_riot", 4)
    group:item("helmet_football", 10)
    content.add(group)
end

do
    -- Anything a survivor looted to wear on their arms
    local group = content.ItemGroup { id = "survivor_basic_arms", kind = "distribution" }
    group:item("armguard_hard", 10)
    group:item("armguard_tire", 5)
    group:item("2byarm_guard", 5)
    group:item("armor_riot_arm", 8)
    group:item("armguard_paper", 10)
    group:item("armguard_scrap", 7)
    group:item("carpet_armguards", 8)
    group:item("improvised_armguard_tire", 4)
    group:item("elbow_pads", 20)
    group:item("armguard_cut_resistant", 2)
    group:item("chainmail_junk_arms", 1)
    content.add(group)
end

do
    -- Anything a survivor looted or cobbled together to wear on their torso
    local group = content.ItemGroup { id = "survivor_basic_torso", kind = "distribution" }
    group:item("vest_leather", 20)
    group:item("vest_leather_mod", 8)
    group:item("stab_vest", 15)
    group:item("chainmail_junk_vest", 1)
    group:item("chestguard_hard", 10)
    group:item("armor_riot_torso", 10)
    group:item("cuirass_scrap", 8)
    group:item("carpet_cuirass", 7)
    group:item("bookplate", 7)
    group:item("football_armor", 15)
    group:item("ballistic_vest_light_pouches", 15)
    group:item("ballistic_vest_light_operator", 15)
    group:item("ballistic_vest_light", 15)
    group:item("vest_jean", 3)
    group:item("vest_jean_mod", 2)
    group:item("soft_3a_vest", 3)
    group:item("level_3_vest", 3)
    group:item("apron_cut_resistant", 3)
    group:item("lame_foil", 1)
    group:item("sleeveless_trenchcoat_leather", 12)
    group:item("sleeveless_trenchcoat", 12)
    content.add(group)
end

do
    -- Anything a survivor looted or cobbled together to wear on their torso and arms
    local group = content.ItemGroup { id = "survivor_basic_jacket", kind = "distribution" }
    group:item("trenchcoat", 15)
    group:item("trenchcoat_leather", 15)
    group:item("trenchcoat_fur", 5)
    group:item("trenchcoat_faux_fur", 5)
    group:item("duster", 15)
    group:item("duster_leather", 10)
    group:item("duster_fur", 10)
    group:item("duster_faux_fur", 8)
    group:item("jacket_leather", 30)
    group:item("jacket_leather_tire", 15)
    group:item("jacket_leather_mod", 25)
    group:item("jacket_jean", 5)
    group:item("jacket_jean_mod", 5)
    group:item("motorbike_armor", 25)
    group:item("ski_jacket", 10)
    group:item("coat_winter", 10)
    group:item("coat_light_winter", 10)
    group:item("coat_fur", 1)
    group:item("coat_faux_fur", 1)
    content.add(group)
end

do
    -- Anything a survivor looted or cobbled together to wear on their legs
    local group = content.ItemGroup { id = "survivor_basic_legs", kind = "distribution" }
    group:item("knee_pads", 20)
    group:item("armor_riot_leg", 8)
    group:item("legguard_tire", 15)
    group:item("chainmail_junk_legs", 1)
    group:item("legguard_scrap", 10)
    group:item("armor_riot_torso", 10)
    group:item("carpet_legguards", 8)
    group:item("legguard_paper", 7)
    group:item("chaps_leather", 15)
    group:item("chaps_cut_resistant", 10)
    group:item("legguard_hard", 10)
    content.add(group)
end

do
    -- Anything a survivor looted or cobbled together to wear on their hands
    local group = content.ItemGroup { id = "survivor_basic_hands", kind = "distribution" }
    group:item("gloves_work", 20)
    group:item("gloves_fur", 8)
    group:item("gloves_wool", 8)
    group:item("chainmail_junk_hands", 1)
    group:item("gloves_winter", 10)
    group:item("gloves_rubber", 10)
    group:item("gloves_leather", 25)
    group:item("gloves_airsoft", 3)
    group:item("wetsuit_gloves", 5)
    group:item("beekeeping_gloves", 5)
    group:item("gloves_cut_resistant", 10)
    group:item("wetsuit_gloves_thick", 3)
    group:item("gloves_tactical", 10)
    group:item("fire_gauntlets", 5)
    group:item("gauntlet_fencing", 2)
    group:item("gauntlet_fencing_l", 1)
    content.add(group)
end

do
    -- Anything a survivor looted or cobbled together to wear on their hands
    local group = content.ItemGroup { id = "survivor_basic_feet", kind = "distribution" }
    group:item("boots", 20)
    group:item("boots_steel", 15)
    group:item("boots_scrap", 2)
    group:item("boots_hiking", 15)
    group:item("boots_combat", 10)
    group:item("boots_winter", 10)
    group:item("motorbike_boots", 5)
    group:item("knee_high_boots", 5)
    group:item("thigh_high_boots", 3)
    group:item("boots_fur", 10)
    group:item("sneakers_steel", 10)
    group:item("boots_rubber", 5)
    content.add(group)
end

do
    -- Anything a survivor looted or cobbled together to wear on their hands
    local group = content.ItemGroup { id = "survivor_basic_pants", kind = "distribution" }
    group:item("pants_cargo", 15)
    group:item("pants_army", 10)
    group:item("winter_pants_army", 2)
    group:item("technician_pants_gray", 15)
    group:item("jeans", 20)
    group:item("jeans_mod", 10)
    group:item("motorbike_pants", 10)
    group:item("survivor_adhoc_leather_pants", 15)
    group:item("pants_faux_fur", 5)
    group:item("pants_ski", 5)
    group:item("pants", 5)
    content.add(group)
end

do
    -- Anything a survivor looted or cobbled together to wear on their hands
    local group = content.ItemGroup { id = "survivor_basic_shirt", kind = "distribution" }
    group:item("sweatshirt", 15)
    group:item("hoodie", 10)
    group:item("sweater", 10)
    group:item("technician_shirt_gray", 5)
    group:item("rashguard", 15)
    group:item("wetsuit_jacket", 5)
    group:item("survivor_adhoc_leather_shirt", 10)
    group:item("cloth_shirt_padded", 15)
    group:item("combat_shirt", 5)
    group:item("fencing_jacket", 1)
    content.add(group)
end
