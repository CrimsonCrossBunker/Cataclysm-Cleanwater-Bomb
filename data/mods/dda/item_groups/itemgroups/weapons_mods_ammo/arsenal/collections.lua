local content = require("ccb").content

do
    -- This file provides some milspec loot groups for use in military armament rooms - part is deployed and ready to use (or already used), and part is stored. This was made to make some consistency and order in arsenals.
    -- the list of armament picked from <https://en.wikipedia.org/wiki/List_of_equipment_of_the_United_States_Army#Small_arms>. If you have a better source you're welcome.
    -- i tried to make them flexible enough, so each part can be reused, without making 10 different copies for each using
    -- each file contains (in basic): an ammo can with weapon of one caliber, a gun with its mags, a group of these guns, the group of few gun groups (gun&mags), gun&mags + ammo (gun&ammo), and gun&ammo + empty cans (gun&mags&cans).  Then each of them can be united in group of similar weapons, so we can generate, for example, group from only guns, only ammo or, as the very first idea, the 'deployed' group with a bit of ammo and a few guns of same caliber.
    -- this one contain a group of weapon and ammo that kinda 'deployed', in term 'there is a stuff that common soldier will use in operation'
    local group = content.ItemGroup { id = "milspec_arsenal_weapon&ammo_collection", kind = "collection" }
    group:group("milspec_arsenal_group_armament")
    group:group("arsenal_mics_group", 70)
    group:group("grenade_can_pa120_grenades_part", 5)
    group:group("c4_box_part", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_small_arms_arsenal_weapon&ammo_collection", kind = "collection" }
    group:group("milspec_arsenal_group_guns&mags&cans")
    group:group("arsenal_mics_group", 70)
    group:group("grenade_can_pa120_grenades_part", 5)
    group:group("c4_box_part", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_group_armament", kind = "distribution" }
    group:group("milspec_arsenal_group_guns&mags&cans")
    group:group("milspec_arsenal_group_heavy_guns&mags&cans", 10)
    content.add(group)
end

do
    -- probability is pure wild guess, that rely on <https://www.battleorder.org/usa-rifleco-ibct-2020> and with some own thouhts
    local group = content.ItemGroup { id = "milspec_arsenal_group_guns&mags&cans", kind = "distribution" }
    group:group("milspec_arsenal_9mm_gun&mags&cans", 96)
    group:group("milspec_arsenal_9mm_sub_gun&mags&cans")
    group:group("milspec_arsenal_shot_gun&mags&cans", 15)
    group:group("milspec_arsenal_223_pouch_gun&mags&cans", 1000)
    group:group("milspec_arsenal_223_mg_gun&mags&cans", 260)
    group:group("milspec_arsenal_300_sniper_gun&mags&cans", 95)
    group:group("milspec_arsenal_308_sniper_gun&mags&cans", 95)
    group:group("milspec_arsenal_308_mg_gun&mags&cans", 192)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_group_heavy_guns&mags&cans", kind = "distribution" }
    group:group("milspec_arsenal_50bmg_sniper_gun&mags&cans", 60)
    group:group("milspec_arsenal_50_mg_gun&mags&cans", 192)
    group:group("milspec_arsenal_40x46_gun&mags&cans", 192)
    group:group("milspec_arsenal_40x53_gun&mags&cans", 50)
    group:group("milspec_arsenal_66_gun&mags", 30)
    group:group("milspec_arsenal_84x246_gun&mags&cans", 192)
    group:group("milspec_arsenal_60mm_gun&ammo", 30)
    group:group("milspec_arsenal_atgm_gun", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_group_only_ammo", kind = "distribution" }
    group:group("milspec_arsenal_group_ammo_full")
    group:group("milspec_arsenal_group_ammo_heavy_full", 10)
    content.add(group)
end

do
    -- this one contain a group of ammo that can have a common ammo rack
    -- between the same and double as much as in gun&mags
    local group = content.ItemGroup { id = "milspec_arsenal_group_ammo_full", kind = "distribution" }
    group:entry { group = "ammo_can_9mm_any_full", count = { 3, 6 }, probability = 96 }
    group:entry { group = "ammo_can_shot_any_full", count = { 3, 6 }, probability = 150 }
    group:entry { group = "ammo_can_223_any_full", count = { 3, 6 }, probability = 1000 }
    group:entry { group = "ammo_can_223_mg_any_full", count = { 3, 6 }, probability = 260 }
    group:entry { group = "ammo_can_300_full", count = { 3, 6 }, probability = 95 }
    group:entry { group = "ammo_can_308_any_full", count = { 3, 6 }, probability = 95 }
    group:entry { group = "ammo_can_308_mg_any_full", count = { 3, 6 }, probability = 192 }
    group:entry { group = "ammo_can_50_any_full", count = { 3, 6 }, probability = 30 }
    group:entry { group = "ammo_can_50_mg_any_full", count = { 2, 4 }, probability = 90 }
    group:entry { group = "ammo_can_40x46mm_m433_full", count = { 3, 6 }, probability = 192 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_group_ammo_heavy_full", kind = "distribution" }
    group:entry { group = "ammo_can_belt40mm_full", count = { 2, 4 }, probability = 50 }
    group:entry { group = "ammo_box_84x246mm_any_full", count = { 3, 6 }, probability = 192 }
    group:entry { item = "LAW_Packed", count = { 2, 6 }, probability = 30 }
    group:entry { group = "ammo_can_60mm_any_full", count = { 3, 6 }, probability = 30 }
    group:entry { item = "atgm_heat", count = { 2, 6 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_group_guns", kind = "distribution" }
    group:entry { group = "milspec_arsenal_9mm_gun&mags", count = { 1, 2 }, probability = 96 }
    group:entry { group = "milspec_arsenal_9mm_sub_gun&mags", count = { 1, 2 } }
    group:entry { group = "milspec_arsenal_shot_gun&mags", count = { 1, 2 }, probability = 15 }
    group:entry { group = "milspec_arsenal_223_gun&mags", count = { 1, 2 }, probability = 1000 }
    group:entry { group = "milspec_arsenal_223_mg_gun&mags", count = { 1, 2 }, probability = 260 }
    group:entry { group = "milspec_arsenal_300_sniper_gun&mags", count = { 1, 2 }, probability = 95 }
    group:entry { group = "milspec_arsenal_308_sniper_gun&mags", count = { 1, 2 }, probability = 95 }
    group:entry { group = "milspec_arsenal_308_mg_gun&mags", count = { 1, 2 }, probability = 192 }
    group:entry { group = "milspec_arsenal_50bmg_sniper_gun&mags", count = { 1, 2 }, probability = 30 }
    group:entry { group = "milspec_arsenal_50_mg_gun&mags", count = { 1, 2 }, probability = 90 }
    group:entry { group = "milspec_arsenal_40x46_gun&mags", count = { 1, 2 }, probability = 192 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_group_heavy", kind = "distribution" }
    group:entry { group = "milspec_arsenal_40x53_gun&mags", count = { 1, 2 }, probability = 50 }
    group:entry { group = "milspec_arsenal_66_gun&mags", count = { 1, 2 }, probability = 30 }
    group:entry { group = "milspec_arsenal_84x246_gun&mags", count = { 1, 2 }, probability = 192 }
    group:item("mortar_m224", 30)
    group:entry { group = "milspec_arsenal_atgm_gun", count = { 1, 2 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_only_guns_or_ammo", kind = "distribution" }
    group:group("milspec_arsenal_group_only_guns")
    group:group("milspec_arsenal_group_only_ammo")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_only_guns_or_ammo_or_armor", kind = "distribution" }
    group:group("milspec_arsenal_group_only_guns")
    group:group("arsenal_armor+plates", 70)
    group:group("milspec_arsenal_group_only_ammo", 10)
    content.add(group)
end
