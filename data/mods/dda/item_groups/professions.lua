local content = require("ccb").content

do
    local group = content.ItemGroup { id = "holster_glock19_fed", kind = "collection" }
    group:entry {
        item = "glock_19",
        charges = { 15, 15 },
        variant = "glock_19_cop",
        contents = {
            { item = "red_dot_sight" },
            { item = "sights_mount_pistol" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "army_grenades_40x46", kind = "collection" }
    group:entry { item = "40x46mm_m433", charges = { 4, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_cell_phone", kind = "collection" }
    group:entry { item = "cell_phone", charges = { 150, 150 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_laptop", kind = "collection" }
    group:entry { item = "laptop", charges = { 600, 600 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_soldering_iron", kind = "collection" }
    group:entry { item = "soldering_iron_portable", charges = { 150, 150 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_flashlight", kind = "collection" }
    group:entry { item = "flashlight", charges = { 300, 300 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_heavy_flashlight", kind = "collection" }
    group:entry { item = "heavy_flashlight", charges = { 300, 300 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_mp3", kind = "collection" }
    group:entry { item = "mp3", charges = { 150, 150 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_ref_lighter", kind = "collection" }
    group:entry { item = "ref_lighter", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_cigs", kind = "collection" }
    group:entry { item = "cig", count = { 20, 20 }, wrapper = "box_cigarette", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "rolling_cigs", kind = "collection" }
    group:entry { item = "tobacco", count = { 20, 20 }, wrapper = "bag_plastic", container = "null" }
    group:entry { item = "rolling_paper", count = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pipe_smoke", kind = "collection" }
    group:entry { item = "tobacco", count = { 20, 20 }, wrapper = "bag_plastic", container = "null" }
    group:item("pipe_tobacco")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "weed_pack", kind = "collection" }
    group:entry { item = "weed", count = { 5, 5 }, wrapper = "bag_zipper", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "can_o_beans", kind = "collection" }
    group:entry { item = "can_beans", count = { 2, 2 }, wrapper = "can_medium", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_aspirin", kind = "collection" }
    group:entry { item = "aspirin", count = { 20, 20 }, wrapper = "bottle_plastic_pill_painkiller", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_antibiotic", kind = "collection" }
    group:entry { item = "antibiotics", count = { 10, 10 }, wrapper = "bottle_plastic_pill_prescription", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_matches", kind = "collection" }
    group:entry { item = "matches", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "quiver_modern_archer", kind = "collection" }
    group:entry { item = "arrow_cf", count = { 16, 16 } }
    group:item("bow_sight")
    group:item("bow_stabilizer_set")
    group:item("manual_archery")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bandolier_shotgun_hunter", kind = "collection" }
    group:entry { item = "shot_00", charges = { 18, 18 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bandolier_rifle_hunter", kind = "collection" }
    group:entry { item = "270win_jsp", charges = { 16, 16 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bandolier_swat_cqc1", kind = "collection" }
    group:entry { item = "shot_00", charges = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bandolier_swat_cqc2", kind = "collection" }
    group:entry { item = "shot_slug", charges = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "quiver_naturalist", kind = "collection" }
    group:entry { item = "arrow_wood", count = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bandolier_ww_gunslinger", kind = "collection" }
    group:entry { item = "45colt_jhp", charges = { 18, 18 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bandolier_cowboy", kind = "collection" }
    group:entry { item = "357mag_jhp", charges = { 18, 18 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dog_lover_bag", kind = "collection" }
    group:item("rubber_harness_dog")
    group:item("rubber_harness_dog")
    group:item("dog_whistle")
    group:entry { item = "dogfood_dry", count = { 4, 4 }, wrapper = "bag_plastic", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ninja_grenade_pouch", kind = "collection" }
    group:item("flashbang")
    group:item("flashbang")
    group:item("smokebomb")
    group:item("smokebomb")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "leg_sheath6_throwing_knives", kind = "collection" }
    group:item("throwing_knife")
    group:item("throwing_knife")
    group:item("throwing_knife")
    group:item("throwing_knife")
    group:item("throwing_knife")
    group:item("throwing_knife")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flintlock_pouch_skyfarer", kind = "collection" }
    group:entry { item = "36navy", charges = { 14, 14 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "holster_supp_MEU", kind = "collection" }
    group:entry {
        item = "m1911",
        charges = { 7, 7 },
        variant = "m1911_MEU",
        ammo = { item = "45_acp" },
        contents = {
            { item = "suppressor" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "holster_supp_usp9", kind = "collection" }
    group:entry {
        item = "usp_9mm",
        charges = { 15, 15 },
        ammo = { item = "9mmfmj" },
        contents = {
            { item = "suppressor_compact" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glock17_mags", kind = "collection" }
    group:entry { item = "glockmag", charges = { 15, 15 }, ammo = { item = "9mm" } }
    group:entry { item = "glockmag", charges = { 15, 15 }, ammo = { item = "9mm" } }
    group:entry { item = "glockmag", charges = { 15, 15 }, ammo = { item = "9mm" } }
    group:entry { item = "glockmag", charges = { 15, 15 }, ammo = { item = "9mm" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "army_mags_1911", kind = "collection" }
    group:entry { item = "m1911mag", charges = { 7, 7 }, ammo = { item = "45_acp" } }
    group:entry { item = "m1911mag", charges = { 7, 7 }, ammo = { item = "45_acp" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "army_mags_m17", kind = "collection" }
    group:entry { item = "p320mag_17rd_9x19mm", charges = { 17, 17 }, ammo = { item = "9mmfmj" } }
    group:entry { item = "p320mag_17rd_9x19mm", charges = { 17, 17 }, ammo = { item = "9mmfmj" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "holster_supp_57", kind = "collection" }
    group:entry { item = "fn57", charges = { 20, 20 }, ammo = { item = "57mm" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "army_mags_57", kind = "collection" }
    group:entry { item = "fn57mag", charges = { 20, 20 }, ammo = { item = "57mm" } }
    group:entry { item = "fn57mag", charges = { 20, 20 }, ammo = { item = "57mm" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "army_mags_m14", kind = "collection" }
    group:entry { item = "m14mag", charges = { 20, 20 }, ammo = { item = "762_51" } }
    group:entry { item = "m14mag", charges = { 20, 20 }, ammo = { item = "762_51" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "army_mags_mp5", kind = "collection" }
    group:entry { item = "mp5mag", charges = { 30, 30 }, ammo = { item = "9mm" } }
    group:entry { item = "mp5mag", charges = { 30, 30 }, ammo = { item = "9mm" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ranger_mags", kind = "collection" }
    group:entry { item = "p320mag_13rd_357sig", charges = { 13, 13 }, ammo = { item = "357sig_fmj" } }
    group:entry { item = "p320mag_13rd_357sig", charges = { 13, 13 }, ammo = { item = "357sig_fmj" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_electrical_measuring", kind = "collection" }
    group:item("voltmeter")
    group:entry {
        item = "light_battery_cell",
        charges = { 100, 100 },
        container = "multimeter",
        ammo = { item = "battery" },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_smart_phone", kind = "collection" }
    group:entry { item = "smart_phone", charges = { 120, 120 }, ammo = { item = "battery" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_smart_watch", kind = "collection" }
    group:entry { item = "smart_watch", charges = { 20, 20 }, ammo = { item = "battery" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_smart_watch_adv", kind = "collection" }
    group:entry { item = "smart_watch_adv", charges = { 30, 30 }, ammo = { item = "battery" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_two_way_radio", kind = "collection" }
    group:entry {
        item = "light_battery_cell",
        charges = { 300, 300 },
        container = "two_way_radio",
        ammo = { item = "battery" },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_powered_earmuffs", kind = "collection" }
    group:entry {
        item = "light_minus_battery_cell",
        charges = { 50, 50 },
        container = "powered_earmuffs",
        ammo = { item = "battery" },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_tazer", kind = "collection" }
    group:entry { item = "medium_battery_cell", charges = { 1200, 1200 }, container = "tazer", ammo = { item = "battery" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_penblack", kind = "collection" }
    group:entry { item = "pen", charges = { 100, 100 }, ammo = { item = "black_pen_ink" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "full_rebreather_mask", kind = "collection" }
    group:entry { item = "rebreather", charges = { 180, 180 }, ammo = { item = "rebreather_cartridge_o2" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "full_gasmask", kind = "collection" }
    group:entry { item = "mask_gas", charges = { 100, 100 }, ammo = { item = "gasfilter_med" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "army_mags_m2010", kind = "collection" }
    group:entry { item = "m2010mag", charges = { 5, 5 }, ammo = { item = "300_winmag" } }
    group:entry { item = "m2010mag", charges = { 5, 5 }, ammo = { item = "300_winmag" } }
    group:entry { item = "m2010mag", charges = { 5, 5 }, ammo = { item = "300_winmag" } }
    group:entry { item = "m2010mag", charges = { 5, 5 }, ammo = { item = "300_winmag" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "army_mags_tac338", kind = "collection" }
    group:entry { item = "ai_338mag", charges = { 5, 5 }, ammo = { item = "338lapua_fmjbt" } }
    group:entry { item = "ai_338mag", charges = { 5, 5 }, ammo = { item = "338lapua_fmjbt" } }
    group:entry { item = "ai_338mag", charges = { 5, 5 }, ammo = { item = "338lapua_fmjbt" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_50beowulf_ar15", kind = "collection" }
    group:entry { item = "50beowulf_ar15mag", charges = { 10, 10 }, ammo = { item = "50beowulf_xtp" } }
    group:entry { item = "50beowulf_ar15mag", charges = { 10, 10 }, ammo = { item = "50beowulf_xtp" } }
    group:entry { item = "50beowulf_ar15mag", charges = { 10, 10 }, ammo = { item = "50beowulf_xtp" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_ruger_arr", kind = "collection" }
    group:entry { item = "ruger_arr_mag", charges = { 3, 3 }, ammo = { item = "450_ftx" } }
    group:entry { item = "ruger_arr_mag", charges = { 3, 3 }, ammo = { item = "450_ftx" } }
    group:entry { item = "ruger_arr_mag", charges = { 3, 3 }, ammo = { item = "450_ftx" } }
    group:entry { item = "ruger_arr_mag", charges = { 3, 3 }, ammo = { item = "450_ftx" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "army_mags_m110", kind = "collection" }
    group:entry { item = "hk417mag_20rd", charges = { 20, 20 }, ammo = { item = "762_51" } }
    group:entry { item = "hk417mag_20rd", charges = { 20, 20 }, ammo = { item = "762_51" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "army_mags_usp45", kind = "collection" }
    group:entry { item = "usp45mag", charges = { 12, 12 }, ammo = { item = "45_acp" } }
    group:entry { item = "usp45mag", charges = { 12, 12 }, ammo = { item = "45_acp" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "army_mags_usp9", kind = "collection" }
    group:entry { item = "usp9mag", charges = { 15, 15 }, ammo = { item = "9mmfmj" } }
    group:entry { item = "usp9mag", charges = { 15, 15 }, ammo = { item = "9mmfmj" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "army_mags_glock17", kind = "collection" }
    group:entry { item = "glock17_22", charges = { 22, 22 }, ammo = { item = "9mmfmj" } }
    group:entry { item = "glock17_22", charges = { 22, 22 }, ammo = { item = "9mmfmj" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "speedloaders_s&w619_special", kind = "collection" }
    group:entry { item = "38_speedloader", charges = { 7, 7 }, ammo = { item = "38_special" } }
    group:entry { item = "38_speedloader", charges = { 7, 7 }, ammo = { item = "38_special" } }
    group:entry { item = "38_speedloader", charges = { 7, 7 }, ammo = { item = "38_special" } }
    group:entry { item = "38_speedloader", charges = { 7, 7 }, ammo = { item = "38_special" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "speedloaders_s&w619_magnum", kind = "collection" }
    group:entry { item = "38_speedloader", charges = { 7, 7 }, ammo = { item = "357mag_fmj" } }
    group:entry { item = "38_speedloader", charges = { 7, 7 }, ammo = { item = "357mag_fmj" } }
    group:entry { item = "38_speedloader", charges = { 7, 7 }, ammo = { item = "357mag_fmj" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_skyfarer", kind = "collection" }
    group:entry { item = "glock42_mag", charges = { 6, 6 }, ammo = { item = "380_p" } }
    group:entry { item = "glock42_mag", charges = { 6, 6 }, ammo = { item = "380_p" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_rifle_skyfarer", kind = "collection" }
    group:entry { item = "762R_clip", charges = { 5, 5 }, ammo = { item = "762_54R" } }
    group:entry { item = "762R_clip", charges = { 5, 5 }, ammo = { item = "762_54R" } }
    content.add(group)
end
