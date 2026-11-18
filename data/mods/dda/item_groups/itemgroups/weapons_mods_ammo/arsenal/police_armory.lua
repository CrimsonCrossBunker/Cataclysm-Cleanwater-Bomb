local content = require("ccb").content

do
    -- Weighted list of all police-type pistol groups (9mm, .40, .45, 5.7) and their ammo.
    -- This is the final list that spawns somewhere in a police locker.
    local group = content.ItemGroup { id = "police_armory_any_pistol", kind = "distribution" }
    group:group("police_armory_any_9mm", 60)
    group:group("police_armory_any_357sig", 5)
    group:group("police_armory_any_40", 30)
    group:group("police_armory_any_45", 20)
    group:group("police_armory_five7", 1)
    content.add(group)
end

do
    -- Weighted list of short-to-medium-range longarms used by police that aren't shotguns.  Submachine guns are included here.  Weighted heavily towards .223/556 and AR-15s.
    -- This is the final list that spawns somewhere in a police locker.
    local group = content.ItemGroup { id = "police_armory_any_assaultrifle", kind = "distribution" }
    group:group("police_armory_patrolrifle_stanag", 80)
    group:group("police_armory_any_smg", 20)
    group:group("police_armory_mini14", 5)
    group:group("police_armory_m1a", 5)
    group:group("police_armory_aug", 1)
    group:group("police_armory_hk417", 1)
    content.add(group)
end

do
    -- Weighted list of submachine guns for police and their ammo.  Though largely replaced by 5.56 carbines, these still have a presence in police lockers.  Weighted towards 9mm MP5 variants and UMP variants.
    -- This is a semifinal list that applies to the item group above.
    local group = content.ItemGroup { id = "police_armory_any_smg", kind = "distribution" }
    group:group("police_armory_any_9mm_smg", 50)
    group:group("police_armory_ump40", 30)
    group:group("police_armory_ump45", 25)
    group:group("police_armory_p90", 3)
    content.add(group)
end

do
    -- Weighted list of sniper rifles for police and their ammo.  Weighted heavily towards .308 and the M24 (standing in for the Remington 700 Police in .308), but also rarely includes some modern and powerful rifles.
    -- This is the final list that spawns somewhere in a police locker.
    local group = content.ItemGroup { id = "police_armory_any_sniperrifle", kind = "distribution" }
    group:group("police_armory_any_308sniper", 85)
    group:group("police_armory_ar15sniper", 10)
    group:group("police_armory_remington_700", 5)
    group:group("police_armory_axmc_300", 5)
    group:group("police_armory_any_338sniper", 4)
    group:group("police_armory_any_50sniper", 1)
    content.add(group)
end

do
    -- One or more shotguns and ammo (mostly beanbag).
    -- This is the final list that spawns somewhere in a police locker.
    local group = content.ItemGroup { id = "police_armory_any_shotgun", kind = "collection" }
    group:group("police_armory_shotgun_pick1")
    group:group("police_armory_shotgun_pick1", 50)
    group:group("police_armory_shotgun_pick1", 25)
    group:group("police_armory_boxes_shotshells")
    content.add(group)
end

do
    -- Pick one of multiple interchangeable 9mm variants and its ammo.
    local group = content.ItemGroup { id = "police_armory_any_9mm", kind = "distribution" }
    group:group("police_armory_usp_9mm", 5)
    group:group("police_armory_glock_19", 30)
    group:group("police_armory_glock_17", 45)
    group:group("police_armory_m9", 5)
    group:group("police_armory_sp2022", 10)
    group:group("police_armory_px4_9mm", 5)
    content.add(group)
end

do
    -- Pick one of multiple interchangeable 9mm smg variants and its ammo.
    local group = content.ItemGroup { id = "police_armory_any_9mm_smg", kind = "distribution" }
    group:group("police_armory_mp5", 80)
    group:group("police_armory_coltsmg", 10)
    group:group("police_armory_apc9", 5)
    group:group("police_armory_ump9", 5)
    content.add(group)
end

do
    -- One or more USP 9mm pistols, empty mags, full mags, JHP and FMJ ammo with a chance of +P and +P+ ammo.
    local group = content.ItemGroup { id = "police_armory_usp_9mm", kind = "collection" }
    group:item("usp_9mm")
    group:item("usp_9mm", 50)
    group:item("usp_9mm", 25)
    group:entry { item = "usp9mag", count = { 1, 4 } }
    group:entry { group = "police_armory_full_usp9mag_9mm", count = { 0, 4 } }
    group:entry { group = "police_armory_full_usp9mag_9mmfmj", count = { 0, 4 } }
    group:group("police_armory_boxes_9mm")
    group:group("police_armory_boxes_9mmfmj")
    group:group("police_armory_boxes_9mmP", 25)
    group:group("police_armory_boxes_9mmP2", 10)
    content.add(group)
end

do
    -- One or more Glock 19 pistols, empty mags, full mags, JHP and FMJ ammo with a chance of +P and +P+ ammo.
    local group = content.ItemGroup { id = "police_armory_glock_19", kind = "collection" }
    group:item("glock_19")
    group:item("glock_19", 50)
    group:item("glock_19", 25)
    group:entry {
        item = "glock_19",
        variant = "glock_19_cop",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 15,
    }
    group:entry { item = "glockmag", count = { 1, 4 } }
    group:entry { group = "police_armory_full_glockmag_9mm", count = { 0, 4 } }
    group:entry { group = "police_armory_full_glockmag_9mmfmj", count = { 0, 4 } }
    group:group("police_armory_boxes_9mm")
    group:group("police_armory_boxes_9mmfmj")
    group:group("police_armory_boxes_9mmP", 25)
    group:group("police_armory_boxes_9mmP2", 10)
    content.add(group)
end

do
    -- One or more Glock 17 pistols, empty mags, full mags, JHP and FMJ ammo with a chance of +P and +P+ ammo.
    local group = content.ItemGroup { id = "police_armory_glock_17", kind = "collection" }
    group:item("glock_17")
    group:item("glock_17", 50)
    group:item("glock_17", 25)
    group:entry { item = "glock17_17", count = { 1, 4 } }
    group:entry { group = "police_armory_full_glock17mag_9mm", count = { 0, 4 } }
    group:entry { group = "police_armory_full_glock17mag_9mmfmj", count = { 0, 4 } }
    group:group("police_armory_boxes_9mm")
    group:group("police_armory_boxes_9mmfmj")
    group:group("police_armory_boxes_9mmP", 25)
    group:group("police_armory_boxes_9mmP2", 10)
    content.add(group)
end

do
    -- One or more Beretta 9mm pistols, empty mags, full mags, JHP and FMJ ammo with a chance of +P and +P+ ammo.
    local group = content.ItemGroup { id = "police_armory_m9", kind = "collection" }
    group:item("m9", 100, "m9")
    group:item("m9", 50, "m9")
    group:item("m9", 25, "m9")
    group:entry { item = "m9mag", count = { 1, 4 } }
    group:entry { group = "police_armory_full_m9mag_9mm", count = { 0, 4 } }
    group:entry { group = "police_armory_full_m9mag_9mmfmj", count = { 0, 4 } }
    group:group("police_armory_boxes_9mm")
    group:group("police_armory_boxes_9mmfmj")
    group:group("police_armory_boxes_9mmP", 25)
    group:group("police_armory_boxes_9mmP2", 10)
    content.add(group)
end

do
    -- One or more SIG SP2022 9mm pistols, empty mags, full mags, JHP and FMJ ammo with a chance of +P and +P+ ammo.
    local group = content.ItemGroup { id = "police_armory_sp2022", kind = "collection" }
    group:item("sp2022")
    group:item("sp2022", 50)
    group:item("sp2022", 25)
    group:entry { item = "sp2022mag_15rd_9mm", count = { 1, 4 } }
    group:entry { group = "police_armory_full_sp2022mag_9mm", count = { 0, 4 } }
    group:entry { group = "police_armory_full_sp2022mag_9mmfmj", count = { 0, 4 } }
    group:group("police_armory_boxes_9mm")
    group:group("police_armory_boxes_9mmfmj")
    group:group("police_armory_boxes_9mmP", 25)
    group:group("police_armory_boxes_9mmP2", 10)
    content.add(group)
end

do
    -- One or more Px4 9mm pistols, empty mags, full mags, JHP and FMJ ammo with a chance of +P and +P+ ammo.
    local group = content.ItemGroup { id = "police_armory_px4_9mm", kind = "collection" }
    group:item("px4")
    group:item("px4", 50)
    group:item("px4", 25)
    group:entry { item = "px4mag", count = { 1, 4 } }
    group:entry { group = "police_armory_full_px4mag_9mm", count = { 0, 4 } }
    group:entry { group = "police_armory_full_px4mag_9mmfmj", count = { 0, 4 } }
    group:group("police_armory_boxes_9mm")
    group:group("police_armory_boxes_9mmfmj")
    group:group("police_armory_boxes_9mmP", 25)
    group:group("police_armory_boxes_9mmP2", 10)
    content.add(group)
end

do
    -- One or more mp5-type submachine guns, empty mags, full mags, JHP and FMJ ammo with a chance of +P and +P+ ammo.
    local group = content.ItemGroup { id = "police_armory_mp5", kind = "collection" }
    group:group("police_armory_mp5_pick")
    group:entry { item = "mp5mag", count = { 1, 7 } }
    group:entry { group = "police_armory_full_mp5mag_9mm", count = { 0, 2 } }
    group:entry { group = "police_armory_full_mp5mag_9mmfmj", count = { 0, 3 } }
    group:group("police_armory_boxes_9mm")
    group:group("police_armory_boxes_9mmfmj")
    group:group("police_armory_boxes_9mmP", 25)
    group:group("police_armory_boxes_9mmP2", 10)
    content.add(group)
end

do
    -- Chooses the MP5 type that will spawn in the above group.
    local group = content.ItemGroup { id = "police_armory_mp5_pick", kind = "distribution" }
    group:group("police_armory_mp5standard_pick", 85)
    group:group("police_armory_mp5sd_pick", 10)
    group:group("police_armory_mp5k_pick", 5)
    content.add(group)
end

do
    -- 1-3 guns of the same type
    local group = content.ItemGroup { id = "police_armory_mp5standard_pick", kind = "collection" }
    group:entry {
        item = "hk_mp5",
        contents = {
            { item = "sights_mount" },
            { item = "red_dot_sight" },
        },
    }
    group:entry {
        item = "hk_mp5",
        contents = {
            { item = "sights_mount" },
            { item = "red_dot_sight" },
        },
        probability = 50,
    }
    group:entry {
        item = "hk_mp5",
        contents = {
            { item = "sights_mount" },
            { item = "red_dot_sight" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    -- 1-3 guns of the same type
    local group = content.ItemGroup { id = "police_armory_mp5sd_pick", kind = "collection" }
    group:entry {
        item = "hk_mp5sd",
        contents = {
            { item = "sights_mount" },
            { item = "red_dot_sight" },
        },
    }
    group:entry {
        item = "hk_mp5sd",
        contents = {
            { item = "sights_mount" },
            { item = "red_dot_sight" },
        },
        probability = 50,
    }
    group:entry {
        item = "hk_mp5sd",
        contents = {
            { item = "sights_mount" },
            { item = "red_dot_sight" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    -- 1-3 guns of the same type
    local group = content.ItemGroup { id = "police_armory_mp5k_pick", kind = "collection" }
    group:entry {
        item = "hk_mp5k",
        contents = {
            { item = "sights_mount" },
            { item = "red_dot_sight" },
        },
    }
    group:entry {
        item = "hk_mp5k",
        contents = {
            { item = "sights_mount" },
            { item = "red_dot_sight" },
        },
        probability = 50,
    }
    group:entry {
        item = "hk_mp5k",
        contents = {
            { item = "sights_mount" },
            { item = "red_dot_sight" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    -- One or more Colt 635 submachine guns, empty mags, full mags, JHP and FMJ ammo with a chance of +P and +P+ ammo.
    local group = content.ItemGroup { id = "police_armory_coltsmg", kind = "collection" }
    group:item("colt_ro635")
    group:item("colt_ro635", 50)
    group:item("colt_ro635", 25)
    group:entry { item = "uzimag", count = { 1, 7 } }
    group:entry { group = "police_armory_full_uzimag_9mm", count = { 0, 2 } }
    group:entry { group = "police_armory_full_uzimag_9mmfmj", count = { 0, 3 } }
    group:group("police_armory_boxes_9mm")
    group:group("police_armory_boxes_9mmfmj")
    group:group("police_armory_boxes_9mmP", 25)
    group:group("police_armory_boxes_9mmP2", 10)
    content.add(group)
end

do
    -- One or more APC9k submachine guns, empty mags, full mags, JHP and FMJ ammo with a chance of +P and +P+ ammo.
    local group = content.ItemGroup { id = "police_armory_apc9", kind = "collection" }
    group:item("bt_apc9k")
    group:item("bt_apc9k", 50)
    group:item("bt_apc9k", 25)
    group:entry { item = "btmp9mag_9x19mm_30", count = { 1, 7 } }
    group:entry { group = "police_armory_full_mp9mag_9mm", count = { 0, 2 } }
    group:entry { group = "police_armory_full_mp9mag_9mmfmj", count = { 0, 3 } }
    group:group("police_armory_boxes_9mm")
    group:group("police_armory_boxes_9mmfmj")
    group:group("police_armory_boxes_9mmP", 25)
    group:group("police_armory_boxes_9mmP2", 10)
    content.add(group)
end

do
    -- One or more UMP-9 submachine guns, empty mags, full mags, JHP and FMJ ammo with a chance of +P and +P+ ammo.
    local group = content.ItemGroup { id = "police_armory_ump9", kind = "collection" }
    group:entry {
        group = "modular_ump_9",
        contents = {
            { item = "red_dot_sight" },
        },
    }
    group:entry {
        group = "modular_ump_9",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 50,
    }
    group:entry {
        group = "modular_ump_9",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 25,
    }
    group:entry { item = "ump9mag", count = { 1, 7 } }
    group:entry { group = "police_armory_full_ump9mag_9mm", count = { 0, 2 } }
    group:entry { group = "police_armory_full_ump9mag_9mmfmj", count = { 0, 3 } }
    group:group("police_armory_boxes_9mm")
    group:group("police_armory_boxes_9mmfmj")
    group:group("police_armory_boxes_9mmP", 25)
    group:group("police_armory_boxes_9mmP2", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_usp9mag_9mm", kind = "collection", container = "usp9mag" }
    group:entry { item = "9mm", charges = { 15, 15 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_usp9mag_9mmfmj", kind = "collection", container = "usp9mag" }
    group:entry { item = "9mmfmj", charges = { 15, 15 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_glockmag_9mm", kind = "collection", container = "glockmag" }
    group:entry { item = "9mm", charges = { 15, 15 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_glockmag_9mmfmj", kind = "collection", container = "glockmag" }
    group:entry { item = "9mmfmj", charges = { 15, 15 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_glock17mag_9mm", kind = "collection", container = "glock17_17" }
    group:entry { item = "9mm", charges = { 17, 17 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_glock17mag_9mmfmj", kind = "collection", container = "glock17_17" }
    group:entry { item = "9mmfmj", charges = { 17, 17 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_m9mag_9mm", kind = "collection", container = "m9mag" }
    group:entry { item = "9mm", charges = { 15, 15 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_m9mag_9mmfmj", kind = "collection", container = "m9mag" }
    group:entry { item = "9mmfmj", charges = { 15, 15 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_full_sp2022mag_9mm",
        kind = "collection",
        container = "sp2022mag_15rd_9mm",
    }
    group:entry { item = "9mm", charges = { 15, 15 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_full_sp2022mag_9mmfmj",
        kind = "collection",
        container = "sp2022mag_15rd_9mm",
    }
    group:entry { item = "9mmfmj", charges = { 15, 15 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_px4mag_9mm", kind = "collection", container = "px4mag" }
    group:entry { item = "9mm", charges = { 17, 17 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_px4mag_9mmfmj", kind = "collection", container = "px4mag" }
    group:entry { item = "9mmfmj", charges = { 17, 17 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_mp5mag_9mm", kind = "collection", container = "mp5mag" }
    group:entry { item = "9mm", charges = { 30, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_mp5mag_9mmfmj", kind = "collection", container = "mp5mag" }
    group:entry { item = "9mmfmj", charges = { 30, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_uzimag_9mm", kind = "collection", container = "uzimag" }
    group:entry { item = "9mm", charges = { 32, 32 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_uzimag_9mmfmj", kind = "collection", container = "uzimag" }
    group:entry { item = "9mmfmj", charges = { 32, 32 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_full_mp9mag_9mm",
        kind = "collection",
        container = "btmp9mag_9x19mm_30",
    }
    group:entry { item = "9mm", charges = { 30, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_full_mp9mag_9mmfmj",
        kind = "collection",
        container = "btmp9mag_9x19mm_30",
    }
    group:entry { item = "9mmfmj", charges = { 30, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_ump9mag_9mm", kind = "collection", container = "ump9mag" }
    group:entry { item = "9mm", charges = { 30, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_ump9mag_9mmfmj", kind = "collection", container = "ump9mag" }
    group:entry { item = "9mmfmj", charges = { 30, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_9mm", kind = "collection" }
    group:group("police_armory_box_some_9mm")
    group:group("police_armory_box_some_9mm", 75)
    group:entry { item = "9mm_ammo_box_50", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_9mm", count = { 0, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_9mmfmj", kind = "collection" }
    group:group("police_armory_box_some_9mmfmj")
    group:group("police_armory_box_some_9mmfmj", 75)
    group:entry { item = "9mm_ammo_box_50", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_9mmfmj", count = { 0, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_9mmP", kind = "collection" }
    group:group("police_armory_box_some_9mmP")
    group:group("police_armory_box_some_9mmP", 50)
    group:entry { item = "9mm_ammo_box_50", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_9mmP", count = { 0, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_9mmP2", kind = "collection" }
    group:group("police_armory_box_some_9mmP2")
    group:group("police_armory_box_some_9mmP2", 50)
    group:entry { item = "9mm_ammo_box_50", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_9mmP2", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_full_9mm", kind = "collection", container = "9mm_ammo_box_50" }
    group:entry { item = "9mm", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_full_9mmfmj", kind = "collection", container = "9mm_ammo_box_50" }
    group:entry { item = "9mmfmj", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_full_9mmP", kind = "collection", container = "9mm_ammo_box_50" }
    group:entry { item = "9mmP", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_full_9mmP2", kind = "collection", container = "9mm_ammo_box_50" }
    group:entry { item = "9mmP2", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_some_9mm", kind = "collection", container = "9mm_ammo_box_50" }
    group:entry { item = "9mm", charges = { 1, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_some_9mmfmj", kind = "collection", container = "9mm_ammo_box_50" }
    group:entry { item = "9mmfmj", charges = { 1, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_some_9mmP", kind = "collection", container = "9mm_ammo_box_50" }
    group:entry { item = "9mmP", charges = { 1, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_some_9mmP2", kind = "collection", container = "9mm_ammo_box_50" }
    group:entry { item = "9mmP2", charges = { 1, 50 } }
    content.add(group)
end

do
    -- One or more FiveSeveN pistols, empty mags, full mags, SS190 ammo and a chance of extra ammo.
    local group = content.ItemGroup { id = "police_armory_five7", kind = "collection" }
    group:item("fn57")
    group:item("fn57", 50)
    group:item("fn57", 25)
    group:entry { item = "fn57mag", count = { 1, 4 } }
    group:entry { group = "police_armory_full_fn57mag_57mm", count = { 1, 4 } }
    group:group("police_armory_boxes_57mm")
    group:group("police_armory_boxes_57mm", 15)
    content.add(group)
end

do
    -- One or more P90 'submachine guns', empty mags, full mags, SS190 ammo and a chance of extra ammo.
    local group = content.ItemGroup { id = "police_armory_p90", kind = "collection" }
    group:entry {
        item = "fn_p90",
        contents = {
            { item = "red_dot_sight" },
        },
    }
    group:entry {
        item = "fn_p90",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 50,
    }
    group:entry {
        item = "fn_p90",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 25,
    }
    group:entry { item = "fnp90mag", count = { 1, 7 } }
    group:entry { group = "police_armory_full_p90mag_57mm", count = { 1, 4 } }
    group:group("police_armory_boxes_57mm")
    group:group("police_armory_boxes_57mm", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_fn57mag_57mm", kind = "collection", container = "fn57mag" }
    group:entry { item = "57mm", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_p90mag_57mm", kind = "collection", container = "fnp90mag" }
    group:entry { item = "57mm", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_57mm", kind = "collection" }
    group:group("police_armory_box_some_57mm")
    group:group("police_armory_box_some_57mm", 60)
    group:entry { item = "57_ammo_box_50", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_57mm", count = { 0, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_full_57mm", kind = "collection", container = "57_ammo_box_50" }
    group:entry { item = "57mm", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_some_57mm", kind = "collection", container = "57_ammo_box_50" }
    group:entry { item = "57mm", charges = { 1, 50 } }
    content.add(group)
end

do
    -- Pick one of multiple interchangeable .357 SIG variants.
    local group = content.ItemGroup { id = "police_armory_any_357sig", kind = "distribution" }
    group:group("police_armory_p226_357", 30)
    group:group("police_armory_p320_357", 10)
    content.add(group)
end

do
    -- One or more Sig P226 .357 pistols, empty mags, full mags, JHP and FMJ ammo with a chance of extra for each.
    local group = content.ItemGroup { id = "police_armory_p226_357", kind = "collection" }
    group:item("p226_357sig")
    group:item("p226_357sig", 50)
    group:item("p226_357sig", 25)
    group:entry { item = "p226mag_12rd_357sig", count = { 1, 4 } }
    group:entry { group = "police_armory_full_p226mag_357sigjhp", count = { 0, 4 } }
    group:entry { group = "police_armory_full_p226mag_357sigfmj", count = { 0, 4 } }
    group:group("police_armory_boxes_357sigjhp")
    group:group("police_armory_boxes_357sigfmj")
    group:group("police_armory_boxes_357sigjhp", 15)
    group:group("police_armory_boxes_357sigfmj", 15)
    content.add(group)
end

do
    -- One or more SIG P320 .357 pistols, empty mags, full mags, JHP and FMJ ammo with a chance of extra for each.
    local group = content.ItemGroup { id = "police_armory_p320_357", kind = "collection" }
    group:item("p320_357sig")
    group:item("p320_357sig", 50)
    group:item("p320_357sig", 25)
    group:entry { item = "p320mag_13rd_357sig", count = { 1, 4 } }
    group:entry { group = "police_armory_full_p320mag_357sigjhp", count = { 0, 4 } }
    group:entry { group = "police_armory_full_p320mag_357sigfmj", count = { 0, 4 } }
    group:group("police_armory_boxes_357sigjhp")
    group:group("police_armory_boxes_357sigfmj")
    group:group("police_armory_boxes_357sigjhp", 15)
    group:group("police_armory_boxes_357sigfmj", 15)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_full_p226mag_357sigjhp",
        kind = "collection",
        container = "p226mag_12rd_357sig",
    }
    group:entry { item = "357sig_jhp", charges = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_full_p226mag_357sigfmj",
        kind = "collection",
        container = "p226mag_12rd_357sig",
    }
    group:entry { item = "357sig_fmj", charges = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_full_p320mag_357sigjhp",
        kind = "collection",
        container = "p320mag_13rd_357sig",
    }
    group:entry { item = "357sig_jhp", charges = { 13, 13 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_full_p320mag_357sigfmj",
        kind = "collection",
        container = "p320mag_13rd_357sig",
    }
    group:entry { item = "357sig_fmj", charges = { 13, 13 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_357sigjhp", kind = "collection" }
    group:group("police_armory_box_some_357sigjhp")
    group:group("police_armory_box_some_357sigjhp", 75)
    group:entry { item = "357sig_ammo_box_50", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_357sigjhp", count = { 0, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_357sigfmj", kind = "collection" }
    group:group("police_armory_box_some_357sigfmj")
    group:group("police_armory_box_some_357sigfmj", 75)
    group:entry { item = "357sig_ammo_box_50", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_357sigfmj", count = { 0, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_box_full_357sigjhp",
        kind = "collection",
        container = "357sig_ammo_box_50",
    }
    group:entry { item = "357sig_jhp", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_box_full_357sigfmj",
        kind = "collection",
        container = "357sig_ammo_box_50",
    }
    group:entry { item = "357sig_fmj", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_box_some_357sigjhp",
        kind = "collection",
        container = "357sig_ammo_box_50",
    }
    group:entry { item = "357sig_jhp", charges = { 1, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_box_some_357sigfmj",
        kind = "collection",
        container = "357sig_ammo_box_50",
    }
    group:entry { item = "357sig_fmj", charges = { 1, 50 } }
    content.add(group)
end

do
    -- Pick one of multiple interchangeable .40 variants.
    local group = content.ItemGroup { id = "police_armory_any_40", kind = "distribution" }
    group:group("police_armory_sig_40", 20)
    group:group("police_armory_glock_22", 70)
    group:group("police_armory_px4_40", 10)
    content.add(group)
end

do
    -- One or more Sig Pro .40 pistols, empty mags, full mags, JHP and FMJ ammo with a chance of extra for each.
    local group = content.ItemGroup { id = "police_armory_sig_40", kind = "collection" }
    group:item("sig_40")
    group:item("sig_40", 50)
    group:item("sig_40", 25)
    group:entry { item = "sig40mag", count = { 1, 4 } }
    group:entry { group = "police_armory_full_sig40mag_40sw", count = { 0, 4 } }
    group:entry { group = "police_armory_full_sig40mag_40fmj", count = { 0, 4 } }
    group:group("police_armory_boxes_40sw")
    group:group("police_armory_boxes_40fmj")
    group:group("police_armory_boxes_40sw", 15)
    group:group("police_armory_boxes_40fmj", 15)
    content.add(group)
end

do
    -- One or more Glock 22 pistols, empty mags, full mags, JHP and FMJ ammo with a chance of extra for each.
    local group = content.ItemGroup { id = "police_armory_glock_22", kind = "collection" }
    group:item("glock_22")
    group:item("glock_22", 50)
    group:item("glock_22", 25)
    group:entry { item = "glock40mag", count = { 1, 4 } }
    group:entry { group = "police_armory_full_glock40mag_40sw", count = { 0, 4 } }
    group:entry { group = "police_armory_full_glock40mag_40fmj", count = { 0, 4 } }
    group:group("police_armory_boxes_40sw")
    group:group("police_armory_boxes_40fmj")
    group:group("police_armory_boxes_40sw", 15)
    group:group("police_armory_boxes_40fmj", 15)
    content.add(group)
end

do
    -- One or more Px4 .40 pistols, empty mags, full mags, JHP and FMJ ammo with a chance of extra for each.
    local group = content.ItemGroup { id = "police_armory_px4_40", kind = "collection" }
    group:item("px4_40")
    group:item("px4_40", 50)
    group:item("px4_40", 25)
    group:entry { item = "px4_40mag", count = { 1, 4 } }
    group:entry { group = "police_armory_full_px4_40mag_40sw", count = { 0, 4 } }
    group:entry { group = "police_armory_full_px4_40mag_40fmj", count = { 0, 4 } }
    group:group("police_armory_boxes_40sw")
    group:group("police_armory_boxes_40fmj")
    group:group("police_armory_boxes_40sw", 15)
    group:group("police_armory_boxes_40fmj", 15)
    content.add(group)
end

do
    -- One or more UMP 40 submachine guns, empty mags, full mags, JHP and FMJ ammo with a chance of extra for each.
    local group = content.ItemGroup { id = "police_armory_ump40", kind = "collection" }
    group:entry {
        group = "modular_ump_40",
        contents = {
            { item = "red_dot_sight" },
        },
    }
    group:entry {
        group = "modular_ump_40",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 50,
    }
    group:entry {
        group = "modular_ump_40",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 25,
    }
    group:entry { item = "ump40mag", count = { 1, 7 } }
    group:entry { group = "police_armory_full_ump40mag_40sw", count = { 0, 2 } }
    group:entry { group = "police_armory_full_ump40mag_40fmj", count = { 0, 3 } }
    group:group("police_armory_boxes_40sw")
    group:group("police_armory_boxes_40fmj")
    group:group("police_armory_boxes_40sw", 15)
    group:group("police_armory_boxes_40fmj", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_sig40mag_40sw", kind = "collection", container = "sig40mag" }
    group:entry { item = "40sw", charges = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_sig40mag_40fmj", kind = "collection", container = "sig40mag" }
    group:entry { item = "40fmj", charges = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_glock40mag_40sw", kind = "collection", container = "glock40mag" }
    group:entry { item = "40sw", charges = { 15, 15 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_glock40mag_40fmj", kind = "collection", container = "glock40mag" }
    group:entry { item = "40fmj", charges = { 15, 15 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_px4_40mag_40sw", kind = "collection", container = "px4_40mag" }
    group:entry { item = "40sw", charges = { 14, 14 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_px4_40mag_40fmj", kind = "collection", container = "px4_40mag" }
    group:entry { item = "40fmj", charges = { 14, 14 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_ump40mag_40sw", kind = "collection", container = "ump40mag" }
    group:entry { item = "40sw", charges = { 30, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_ump40mag_40fmj", kind = "collection", container = "ump40mag" }
    group:entry { item = "40fmj", charges = { 30, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_40sw", kind = "collection" }
    group:group("police_armory_box_some_40sw")
    group:group("police_armory_box_some_40sw", 75)
    group:entry { item = "40_ammo_box_50", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_40sw", count = { 0, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_40fmj", kind = "collection" }
    group:group("police_armory_box_some_40fmj")
    group:group("police_armory_box_some_40fmj", 75)
    group:entry { item = "40_ammo_box_50", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_40fmj", count = { 0, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_full_40sw", kind = "collection", container = "40_ammo_box_50" }
    group:entry { item = "40sw", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_full_40fmj", kind = "collection", container = "40_ammo_box_50" }
    group:entry { item = "40fmj", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_some_40sw", kind = "collection", container = "40_ammo_box_50" }
    group:entry { item = "40sw", charges = { 1, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_some_40fmj", kind = "collection", container = "40_ammo_box_50" }
    group:entry { item = "40fmj", charges = { 1, 50 } }
    content.add(group)
end

do
    -- Pick one of multiple interchangeable .45 pistol variants and its ammo.
    local group = content.ItemGroup { id = "police_armory_any_45", kind = "distribution" }
    group:group("police_armory_glock_21", 90)
    group:group("police_armory_usp_45", 10)
    content.add(group)
end

do
    -- One or more USP 45 pistols, empty mags, full mags, JHP and FMJ ammo with a chance of +P ammo.
    local group = content.ItemGroup { id = "police_armory_usp_45", kind = "collection" }
    group:item("usp_45", 100, "usp_45")
    group:item("usp_45", 50, "usp_45")
    group:item("usp_45", 25, "usp_45")
    group:entry { item = "usp45mag", count = { 1, 4 } }
    group:entry { group = "police_armory_full_usp45mag_45_acp", count = { 0, 4 } }
    group:entry { group = "police_armory_full_usp45mag_45_jhp", count = { 0, 4 } }
    group:group("police_armory_boxes_45_acp")
    group:group("police_armory_boxes_45_jhp")
    group:group("police_armory_boxes_45_super", 30)
    content.add(group)
end

do
    -- One or more Glock 21 pistols, empty mags, full mags, JHP and FMJ ammo with a chance of +P ammo.
    local group = content.ItemGroup { id = "police_armory_glock_21", kind = "collection" }
    group:item("glock_21")
    group:item("glock_21", 50)
    group:item("glock_21", 25)
    group:entry { item = "glock_21mag", count = { 1, 4 } }
    group:entry { group = "police_armory_full_glock_21mag_45_acp", count = { 0, 4 } }
    group:entry { group = "police_armory_full_glock_21mag_45_jhp", count = { 0, 4 } }
    group:group("police_armory_boxes_45_acp")
    group:group("police_armory_boxes_45_jhp")
    group:group("police_armory_boxes_45_super", 30)
    content.add(group)
end

do
    -- One or more UMP 45 submachine guns, empty mags, full mags, JHP and FMJ ammo with a chance of +P ammo.
    local group = content.ItemGroup { id = "police_armory_ump45", kind = "collection" }
    group:entry {
        group = "modular_ump_45",
        contents = {
            { item = "red_dot_sight" },
        },
    }
    group:entry {
        group = "modular_ump_45",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 50,
    }
    group:entry {
        group = "modular_ump_45",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 25,
    }
    group:entry { item = "ump45mag", count = { 1, 7 } }
    group:entry { group = "police_armory_full_ump45_45_acp", count = { 0, 2 } }
    group:entry { group = "police_armory_full_ump45_45_jhp", count = { 0, 3 } }
    group:group("police_armory_boxes_45_acp")
    group:group("police_armory_boxes_45_jhp")
    group:group("police_armory_boxes_45_super", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_usp45mag_45_acp", kind = "collection", container = "usp45mag" }
    group:entry { item = "45_acp", charges = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_usp45mag_45_jhp", kind = "collection", container = "usp45mag" }
    group:entry { item = "45_jhp", charges = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_full_glock_21mag_45_acp",
        kind = "collection",
        container = "glock_21mag",
    }
    group:entry { item = "45_acp", charges = { 13, 13 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_full_glock_21mag_45_jhp",
        kind = "collection",
        container = "glock_21mag",
    }
    group:entry { item = "45_jhp", charges = { 13, 13 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_ump45_45_acp", kind = "collection", container = "ump45mag" }
    group:entry { item = "45_acp", charges = { 25, 25 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_ump45_45_jhp", kind = "collection", container = "ump45mag" }
    group:entry { item = "45_jhp", charges = { 25, 25 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_45_jhp", kind = "collection" }
    group:group("police_armory_box_some_45_jhp")
    group:group("police_armory_box_some_45_jhp", 75)
    group:entry { item = "45_ammo_box_50", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_45_jhp", count = { 0, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_45_acp", kind = "collection" }
    group:group("police_armory_box_some_45_acp")
    group:group("police_armory_box_some_45_acp", 75)
    group:entry { item = "45_ammo_box_50", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_45_acp", count = { 0, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_45_super", kind = "collection" }
    group:group("police_armory_box_some_45_super")
    group:group("police_armory_box_some_45_super", 60)
    group:entry { item = "45_ammo_box_50", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_45_super", count = { 0, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_full_45_acp", kind = "collection", container = "45_ammo_box_50" }
    group:entry { item = "45_acp", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_full_45_jhp", kind = "collection", container = "45_ammo_box_50" }
    group:entry { item = "45_jhp", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_full_45_super", kind = "collection", container = "45_ammo_box_50" }
    group:entry { item = "45_super", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_some_45_acp", kind = "collection", container = "45_ammo_box_50" }
    group:entry { item = "45_acp", charges = { 1, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_some_45_jhp", kind = "collection", container = "45_ammo_box_50" }
    group:entry { item = "45_jhp", charges = { 1, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_some_45_super", kind = "collection", container = "45_ammo_box_50" }
    group:entry { item = "45_super", charges = { 1, 50 } }
    content.add(group)
end

do
    -- One or more STANAG-compatible 5.56 rifles, empty mags, full mags, 223 remington training ammo and mk318-type duty ammo.
    local group = content.ItemGroup { id = "police_armory_patrolrifle_stanag", kind = "collection" }
    group:group("police_armory_patrolrifle_anystanag")
    group:entry { item = "stanag30", count = { 1, 7 } }
    group:entry { group = "police_armory_full_stanag30_223", count = { 1, 3 } }
    group:entry { group = "police_armory_full_stanag30_556_mk318", count = { 1, 2 } }
    group:group("police_armory_boxes_223")
    group:group("police_armory_boxes_556_mk318")
    content.add(group)
end

do
    -- Chooses the STANAG-compatible 5.56 rifle type that will spawn in the above group.
    local group = content.ItemGroup { id = "police_armory_patrolrifle_anystanag", kind = "distribution" }
    group:group("police_armory_ar15short_pick", 24)
    group:group("police_armory_ar15medium_pick", 50)
    group:group("police_armory_ar15long_pick", 10)
    group:group("police_armory_m4_pick", 10)
    group:group("police_armory_m4cqbr_pick", 5)
    group:group("police_armory_hk416_pick", 1)
    content.add(group)
end

do
    -- 1-3 rifles of one type
    local group = content.ItemGroup { id = "police_armory_ar15short_pick", kind = "collection" }
    group:entry {
        group = "ar15_223short",
        contents = {
            { item = "red_dot_sight" },
        },
    }
    group:entry {
        group = "ar15_223short",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 50,
    }
    group:entry {
        group = "ar15_223short",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    -- 1-3 rifles of one type
    local group = content.ItemGroup { id = "police_armory_ar15medium_pick", kind = "collection" }
    group:entry {
        group = "ar15_223medium",
        contents = {
            { item = "red_dot_sight" },
        },
    }
    group:entry {
        group = "ar15_223medium",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 50,
    }
    group:entry {
        group = "ar15_223medium",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    -- 1-3 rifles weighted of one type
    local group = content.ItemGroup { id = "police_armory_ar15long_pick", kind = "collection" }
    group:group("ar15_223long")
    group:group("ar15_223long", 50)
    group:group("ar15_223long", 25)
    content.add(group)
end

do
    -- 1-3 rifles of one type
    local group = content.ItemGroup { id = "police_armory_m4_pick", kind = "collection" }
    group:entry {
        group = "modular_m4a1",
        contents = {
            { item = "red_dot_sight" },
        },
    }
    group:entry {
        group = "modular_m4a1",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 50,
    }
    group:entry {
        group = "modular_m4a1",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    -- 1-3 rifles of one type
    local group = content.ItemGroup { id = "police_armory_m4cqbr_pick", kind = "collection" }
    group:entry {
        group = "m4_cqbr",
        contents = {
            { item = "red_dot_sight" },
        },
    }
    group:entry {
        group = "m4_cqbr",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 50,
    }
    group:entry {
        group = "m4_cqbr",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    -- 1-3 rifles weighted towards 1 rifle
    local group = content.ItemGroup { id = "police_armory_hk416_pick", kind = "collection" }
    group:entry {
        group = "h&k416a5_default_or_short",
        contents = {
            { item = "holo_sight" },
        },
    }
    group:entry {
        group = "h&k416a5_default_or_short",
        contents = {
            { item = "holo_sight" },
        },
        probability = 50,
    }
    group:entry {
        group = "h&k416a5_default_or_short",
        contents = {
            { item = "holo_sight" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    -- One or more Mini-14 rifles, empty mags, full mags, and 223 remington ammo.  Any PD still issuing this probably doesn't believe in modern ammo.
    local group = content.ItemGroup { id = "police_armory_mini14", kind = "collection" }
    group:item("ruger_mini")
    group:item("ruger_mini", 50)
    group:item("ruger_mini", 25)
    group:entry { item = "ruger20", count = { 1, 3 } }
    group:entry { item = "ruger30", count = { 1, 3 } }
    group:entry { group = "police_armory_full_rugermag_223", count = { 1, 5 } }
    group:group("police_armory_boxes_223")
    content.add(group)
end

do
    -- One or more Steyr AUG rifles, empty mags, full mags, 223 remington training ammo and mk318-type duty ammo.
    local group = content.ItemGroup { id = "police_armory_aug", kind = "collection" }
    group:entry {
        item = "steyr_aug",
        contents = {
            { item = "holo_sight" },
        },
    }
    group:entry {
        item = "steyr_aug",
        contents = {
            { item = "holo_sight" },
        },
        probability = 50,
    }
    group:entry {
        item = "steyr_aug",
        contents = {
            { item = "holo_sight" },
        },
        probability = 25,
    }
    group:entry { item = "augmag_30rd", count = { 1, 7 } }
    group:entry { group = "police_armory_full_augmag_223", count = { 1, 3 } }
    group:entry { group = "police_armory_full_augmag_556_mk318", count = { 1, 2 } }
    group:group("police_armory_boxes_223")
    group:group("police_armory_boxes_556_mk318")
    content.add(group)
end

do
    -- One or more HK417 rifles, empty mags, full mags, 308 ammo and 7.62x51 ammo.
    local group = content.ItemGroup { id = "police_armory_hk417", kind = "collection" }
    group:entry {
        item = "hk417_13",
        contents = {
            { item = "holo_sight" },
        },
    }
    group:entry {
        item = "hk417_13",
        contents = {
            { item = "holo_sight" },
        },
        probability = 50,
    }
    group:entry {
        item = "hk417_13",
        contents = {
            { item = "holo_sight" },
        },
        probability = 25,
    }
    group:entry { item = "hk417mag_20rd", count = { 1, 7 } }
    group:entry { group = "police_armory_full_hk417mag_308", count = { 0, 3 } }
    group:entry { group = "police_armory_full_hk417mag_762_51", count = { 0, 3 } }
    group:group("police_armory_boxes_308")
    group:group("police_armory_boxes_762_51", 25)
    content.add(group)
end

do
    -- One or more M1A rifles, empty mags, full mags, 308 ammo and 7.62x51 ammo.  This is standing in for M-14 rifles acquired through the 1033 DoD program.
    local group = content.ItemGroup { id = "police_armory_m1a", kind = "collection" }
    group:item("m1a")
    group:item("m1a", 50)
    group:item("m1a", 25)
    group:entry { item = "m14mag", count = { 1, 7 } }
    group:entry { group = "police_armory_full_m14mag_308", count = { 0, 3 } }
    group:entry { group = "police_armory_full_m14mag_762_51", count = { 0, 3 } }
    group:group("police_armory_boxes_308")
    group:group("police_armory_boxes_762_51", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_stanag30_223", kind = "collection", container = "stanag30" }
    group:entry { item = "223", charges = { 30, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_stanag30_556_mk262", kind = "collection", container = "stanag30" }
    group:entry { item = "556_mk262", charges = { 30, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_stanag30_556_mk318", kind = "collection", container = "stanag30" }
    group:entry { item = "556_mk318", charges = { 30, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_rugermag_223", kind = "collection", container = "ruger20" }
    group:entry { item = "223", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_augmag_223", kind = "collection", container = "augmag_30rd" }
    group:entry { item = "223", charges = { 30, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_augmag_556_mk318", kind = "collection", container = "augmag_30rd" }
    group:entry { item = "556_mk318", charges = { 30, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_hk417mag_308", kind = "collection", container = "hk417mag_20rd" }
    group:entry { item = "308", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_full_hk417mag_762_51",
        kind = "collection",
        container = "hk417mag_20rd",
    }
    group:entry { item = "762_51", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_m14mag_308", kind = "collection", container = "m14mag" }
    group:entry { item = "308", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_m14mag_762_51", kind = "collection", container = "m14mag" }
    group:entry { item = "762_51", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_223", kind = "collection" }
    group:group("police_armory_box_some_223")
    group:group("police_armory_box_some_223", 50)
    group:entry { item = "223_ammo_box_20", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_223", count = { 0, 7 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_box_full_223",
        kind = "collection",
        container = "223_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "223", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_box_some_223",
        kind = "collection",
        container = "223_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "223", charges = { 1, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_556_mk262", kind = "collection" }
    group:group("police_armory_box_some_556_mk262")
    group:group("police_armory_box_some_556_mk262", 50)
    group:entry { item = "223_ammo_box_20", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_556_mk262", count = { 0, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_box_full_556_mk262",
        kind = "collection",
        container = "223_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "556_mk262", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_box_some_556_mk262",
        kind = "collection",
        container = "223_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "556_mk262", charges = { 1, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_556_mk318", kind = "collection" }
    group:group("police_armory_box_some_556_mk318")
    group:group("police_armory_box_some_556_mk318", 50)
    group:entry { item = "223_ammo_box_20", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_556_mk318", count = { 0, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_box_full_556_mk318",
        kind = "collection",
        container = "223_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "556_mk318", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_box_some_556_mk318",
        kind = "collection",
        container = "223_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "556_mk318", charges = { 1, 20 } }
    content.add(group)
end

do
    -- One or more scoped, rifle-length AR-15 rifles, empty mags, full mags, and boxes of 5.56 Mk262.
    local group = content.ItemGroup { id = "police_armory_ar15sniper", kind = "collection" }
    group:entry {
        group = "ar15_223long",
        contents = {
            { item = "rifle_scope" },
            { item = "bipod" },
        },
    }
    group:entry {
        group = "ar15_223long",
        contents = {
            { item = "rifle_scope" },
            { item = "bipod" },
        },
        probability = 50,
    }
    group:entry { item = "stanag20", count = { 0, 2 } }
    group:entry { item = "stanag30", count = { 0, 2 } }
    group:entry { group = "police_armory_full_stanag30_556_mk262", count = { 0, 3 } }
    group:group("police_armory_boxes_556_mk262")
    content.add(group)
end

do
    -- Pick one of multiple interchangeable 308 sniper variants and its ammo.
    local group = content.ItemGroup { id = "police_armory_any_308sniper", kind = "distribution" }
    group:group("police_armory_M24", 70)
    group:group("police_armory_ar10", 20)
    group:group("police_armory_axmc_308", 10)
    content.add(group)
end

do
    -- One or more m24 rifles, boxes of 308 and 762.
    local group = content.ItemGroup { id = "police_armory_M24", kind = "collection" }
    group:item("M24")
    group:item("M24", 50)
    group:group("police_armory_boxes_308")
    group:group("police_armory_boxes_762_51", 25)
    content.add(group)
end

do
    -- One or more scoped AR-10 rifles, empty mags, full mags, and boxes of 308 and 762.
    local group = content.ItemGroup { id = "police_armory_ar10", kind = "collection" }
    group:entry {
        item = "ar10",
        contents = {
            { item = "rifle_scope" },
            { item = "bipod" },
        },
    }
    group:entry {
        item = "ar10",
        contents = {
            { item = "rifle_scope" },
            { item = "bipod" },
        },
        probability = 50,
    }
    group:entry { item = "ar10mag_10rd", count = { 0, 2 } }
    group:entry { item = "ar10mag_20rd", count = { 0, 2 } }
    group:entry { group = "police_armory_full_ar10mag_308", count = { 0, 3 } }
    group:entry { group = "police_armory_full_ar10mag_762_51", count = { 0, 3 } }
    group:group("police_armory_boxes_308")
    group:group("police_armory_boxes_762_51", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_ar10mag_308", kind = "collection", container = "ar10mag_20rd" }
    group:entry { item = "308", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_ar10mag_762_51", kind = "collection", container = "ar10mag_20rd" }
    group:entry { item = "762_51", charges = { 20, 20 } }
    content.add(group)
end

do
    -- One or more scoped AXMC rifles in 308, empty mags, full mags, and boxes of 308 and 762.
    local group = content.ItemGroup { id = "police_armory_axmc_308", kind = "collection" }
    group:entry {
        group = "axmc_308",
        contents = {
            { item = "rifle_scope" },
            { item = "bipod" },
        },
    }
    group:entry {
        group = "axmc_308",
        contents = {
            { item = "rifle_scope" },
            { item = "bipod" },
        },
        probability = 25,
    }
    group:entry { item = "ai_308mag_10", count = { 0, 2 } }
    group:entry { group = "police_armory_full_ai_mag_308", count = { 0, 3 } }
    group:entry { group = "police_armory_full_ai_mag_762_51", count = { 0, 3 } }
    group:group("police_armory_boxes_308")
    group:group("police_armory_boxes_762_51", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_ai_mag_308", kind = "collection", container = "ai_308mag_10" }
    group:entry { item = "308", charges = { 10, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_ai_mag_762_51", kind = "collection", container = "ai_308mag_10" }
    group:entry { item = "762_51", charges = { 10, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_308", kind = "collection" }
    group:group("police_armory_box_some_308")
    group:group("police_armory_box_some_308", 50)
    group:entry { item = "308_ammo_box_20", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_308", count = { 0, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_full_308", kind = "collection", container = "308_ammo_box_20" }
    group:entry { item = "308", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_some_308", kind = "collection", container = "308_ammo_box_20" }
    group:entry { item = "308", charges = { 1, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_762_51", kind = "collection" }
    group:group("police_armory_box_some_762_51")
    group:group("police_armory_box_some_762_51", 50)
    group:entry { item = "308_ammo_box_20", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_762_51", count = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_full_762_51", kind = "collection", container = "308_ammo_box_20" }
    group:entry { item = "762_51", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_some_762_51", kind = "collection", container = "308_ammo_box_20" }
    group:entry { item = "762_51", charges = { 1, 20 } }
    content.add(group)
end

do
    -- One or more Rem700 rifles, boxes of 30-06.
    local group = content.ItemGroup { id = "police_armory_remington_700", kind = "collection" }
    group:entry {
        item = "remington_700",
        contents = {
            { item = "rifle_scope" },
        },
    }
    group:entry {
        item = "remington_700",
        contents = {
            { item = "rifle_scope" },
        },
        probability = 50,
    }
    group:group("police_armory_boxes_3006")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_3006", kind = "collection" }
    group:group("police_armory_box_some_3006")
    group:group("police_armory_box_some_3006", 50)
    group:entry { item = "3006_ammo_box_20", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_3006", count = { 0, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_full_3006", kind = "collection", container = "3006_ammo_box_20" }
    group:entry { item = "3006", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_some_3006", kind = "collection", container = "3006_ammo_box_20" }
    group:entry { item = "3006", charges = { 1, 20 } }
    content.add(group)
end

do
    -- One or more AXMC rifles in 300 win mag, empty mags, full mags, and boxes of 300 win mag
    local group = content.ItemGroup { id = "police_armory_axmc_300", kind = "collection" }
    group:entry {
        group = "axmc_300",
        contents = {
            { item = "rifle_scope" },
            { item = "bipod" },
        },
    }
    group:entry {
        group = "axmc_300",
        contents = {
            { item = "rifle_scope" },
            { item = "bipod" },
        },
        probability = 10,
    }
    group:entry { item = "ai_338mag", count = { 0, 3 } }
    group:entry { item = "ai_338mag_10", count = { 0, 1 } }
    group:entry { group = "police_armory_full_ai_mag_300", count = { 0, 2 } }
    group:group("police_armory_boxes_300")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_ai_mag_300", kind = "collection", container = "ai_338mag" }
    group:entry { item = "300_winmag", charges = { 5, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_300", kind = "collection" }
    group:group("police_armory_box_some_300")
    group:group("police_armory_box_some_300", 50)
    group:entry { item = "300_ammo_box_20", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_300", count = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_full_300", kind = "collection", container = "300_ammo_box_20" }
    group:entry { item = "300_winmag", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_some_300", kind = "collection", container = "300_ammo_box_20" }
    group:entry { item = "300_winmag", charges = { 1, 20 } }
    content.add(group)
end

do
    -- Pick one of multiple interchangeable .338 sniper variants and its ammo.
    local group = content.ItemGroup { id = "police_armory_any_338sniper", kind = "distribution" }
    group:group("police_armory_axmc", 30)
    group:group("police_armory_tac338", 30)
    group:group("police_armory_mrad", 40)
    content.add(group)
end

do
    -- One or more AXMC rifles in 338 lapua, empty mags, full mags, and boxes of 338 hpbt
    local group = content.ItemGroup { id = "police_armory_axmc", kind = "collection" }
    group:entry {
        group = "axmc",
        contents = {
            { item = "rifle_scope" },
            { item = "bipod" },
        },
    }
    group:entry {
        group = "axmc",
        contents = {
            { item = "rifle_scope" },
            { item = "bipod" },
        },
        probability = 10,
    }
    group:entry { item = "ai_338mag", count = { 0, 3 } }
    group:entry { item = "ai_338mag_10", count = { 0, 1 } }
    group:entry { group = "police_armory_full_ai_mag_338", count = { 0, 2 } }
    group:group("police_armory_boxes_338")
    content.add(group)
end

do
    -- One or more TAC-338 rifles in 338 lapua, empty mags, full mags, and boxes of 338 hpbt
    local group = content.ItemGroup { id = "police_armory_tac338", kind = "collection" }
    group:item("tac338")
    group:item("tac338", 10)
    group:entry { item = "ai_338mag", count = { 0, 3 } }
    group:entry { item = "ai_338mag_10", count = { 0, 1 } }
    group:entry { group = "police_armory_full_ai_mag_338", count = { 0, 2 } }
    group:group("police_armory_boxes_338")
    content.add(group)
end

do
    -- One or more MRAD rifles in 338 lapua, empty mags, full mags, and boxes of 338 hpbt
    local group = content.ItemGroup { id = "police_armory_mrad", kind = "collection" }
    group:entry {
        item = "mrad_smr",
        contents = {
            { item = "rifle_scope" },
            { item = "bipod" },
        },
    }
    group:entry {
        item = "mrad_smr",
        contents = {
            { item = "rifle_scope" },
            { item = "bipod" },
        },
        probability = 10,
    }
    group:entry { item = "mrad_338lapua_mag", count = { 0, 3 } }
    group:entry { group = "police_armory_full_mradmag_338", count = { 0, 2 } }
    group:group("police_armory_boxes_338")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_ai_mag_338", kind = "collection", container = "ai_338mag" }
    group:entry { item = "338lapua_hpbt", charges = { 5, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_full_mradmag_338",
        kind = "collection",
        container = "mrad_338lapua_mag",
    }
    group:entry { item = "338lapua_hpbt", charges = { 10, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_338", kind = "collection" }
    group:group("police_armory_box_some_338")
    group:group("police_armory_box_some_338", 50)
    group:entry { item = "4570_ammo_box_20", count = { 5, 20 }, variant = "ammo_box_army_10_338" }
    group:entry { group = "police_armory_box_full_338", count = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_box_full_338",
        kind = "collection",
        container = "4570_ammo_box_20",
        container_variant = "ammo_box_army_10_338",
    }
    group:entry { item = "338lapua_hpbt", charges = { 10, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_box_some_338",
        kind = "collection",
        container = "4570_ammo_box_20",
        container_variant = "ammo_box_army_10_338",
    }
    group:entry { item = "338lapua_hpbt", charges = { 1, 10 } }
    content.add(group)
end

do
    -- Pick one of multiple interchangeable .50 BMG sniper variants and its ammo.
    local group = content.ItemGroup { id = "police_armory_any_50sniper", kind = "distribution" }
    group:group("police_armory_as50", 20)
    group:group("police_armory_tac50", 80)
    content.add(group)
end

do
    -- One or more AS-50 rifles, empty mags, full mags, and boxes of match 50 BMG.
    local group = content.ItemGroup { id = "police_armory_as50", kind = "collection" }
    group:item("as50")
    group:item("as50", 10)
    group:entry { item = "as50mag", count = { 0, 3 } }
    group:entry { group = "police_armory_full_as50mag", count = { 0, 2 } }
    group:group("police_armory_boxes_50")
    content.add(group)
end

do
    -- One or more TAC-50 rifles, empty mags, full mags, and boxes of match 50 BMG.
    local group = content.ItemGroup { id = "police_armory_tac50", kind = "collection" }
    group:item("tac50")
    group:item("tac50", 10)
    group:entry { item = "tac50mag", count = { 0, 3 } }
    group:entry { group = "police_armory_full_tac50mag", count = { 0, 2 } }
    group:group("police_armory_boxes_50")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_as50mag", kind = "collection", container = "as50mag" }
    group:entry { item = "50match", charges = { 5, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_full_tac50mag", kind = "collection", container = "tac50mag" }
    group:entry { item = "50match", charges = { 5, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_50", kind = "collection" }
    group:group("police_armory_box_some_50")
    group:group("police_armory_box_some_50", 50)
    group:entry { item = "12_ammo_box_25", count = { 0, 3 }, variant = "ammo_box_army_10_50bmg" }
    group:entry { group = "police_armory_box_full_50", count = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_box_full_50",
        kind = "collection",
        container = "12_ammo_box_25",
        container_variant = "ammo_box_army_10_50bmg",
    }
    group:entry { item = "50match", charges = { 10, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_box_some_50",
        kind = "collection",
        container = "12_ammo_box_25",
        container_variant = "ammo_box_army_10_50bmg",
    }
    group:entry { item = "50match", charges = { 1, 10 } }
    content.add(group)
end

do
    -- Pick a random police shotgun.
    local group = content.ItemGroup { id = "police_armory_shotgun_pick1", kind = "distribution" }
    group:item("benelli_tsa", 30)
    group:item("remington_870_express", 35)
    group:item("mossberg_590", 23)
    group:item("mossberg_930", 8)
    group:item("m1014", 1)
    group:item("benelli_m4", 1)
    group:item("mossberg_590_shockwave", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_boxes_shotshells", kind = "collection" }
    group:group("police_armory_box_some_shot_beanbag")
    group:group("police_armory_box_some_shot_beanbag", 50)
    group:group("police_armory_box_some_shot_00", 75)
    group:entry { item = "12_ammo_box_10", count = { 0, 3 } }
    group:entry { group = "police_armory_box_full_shot_beanbag", count = { 0, 16 } }
    group:entry { group = "police_armory_box_full_shot_00", count = { 0, 4 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_box_full_shot_beanbag",
        kind = "collection",
        container = "12_ammo_box_10",
    }
    group:entry { item = "shot_beanbag", charges = { 10, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "police_armory_box_some_shot_beanbag",
        kind = "collection",
        container = "12_ammo_box_10",
    }
    group:entry { item = "shot_beanbag", charges = { 1, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_full_shot_00", kind = "collection", container = "12_ammo_box_10" }
    group:entry { item = "shot_00", charges = { 10, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_box_some_shot_00", kind = "collection", container = "12_ammo_box_10" }
    group:entry { item = "shot_00", charges = { 1, 10 } }
    content.add(group)
end
