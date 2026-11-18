local content = require("ccb").content

do
    -- pistols with ammo loaded and ready for use but no additional magazines.
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry", kind = "distribution", with_magazine = 100 }
    group:group("guns_pistol_common_everyday_carry_9mm", 92)
    group:group("guns_pistol_common_everyday_carry_22", 73)
    group:group("guns_pistol_common_everyday_carry_45", 21)
    group:group("guns_pistol_common_everyday_carry_380", 28)
    group:group("guns_pistol_common_everyday_carry_40", 13)
    group:group("guns_pistol_common_everyday_carry_357mag", 4)
    group:group("guns_pistol_common_everyday_carry_38", 8)
    group:group("guns_pistol_common_everyday_carry_44", 1)
    group:group("guns_pistol_common_everyday_carry_10mm", 1)
    group:group("guns_pistol_common_everyday_carry_32", 2)
    group:group("guns_pistol_common_everyday_carry_57", 2)
    group:group("guns_pistol_common_everyday_carry_38super", 2)
    content.add(group)
end

do
    -- Handguns used for hunting, anything from bunnies to bison.  Unloaded and without magazines.
    -- These numbers are mostly guesses and some scaled-down numbers.  If there's better info on hunting calibers please change
    local group = content.ItemGroup { id = "guns_pistol_hunting_display", kind = "distribution" }
    group:group("guns_pistol_common_display_22", 20)
    group:group("guns_pistol_common_display_44", 20)
    group:group("guns_pistol_common_display_357mag", 45)
    group:group("guns_pistol_common_display_10mm", 4)
    group:item("bfr", 4)
    group:item("raging_bull", 4)
    group:item("sw_500", 7)
    group:item("460_xvr", 6)
    group:group("modular_deagle_50", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_collectible", kind = "distribution" }
    group:entry {
        item = "mauser_c96",
        contents = {
            { group = "c96_mods" },
        },
        probability = 12,
    }
    group:item("colt_navy", 2)
    group:item("colt_army", 6)
    group:item("colt_saa", 50, "colt_saa")
    group:item("p08", 18)
    group:item("m1911", 65)
    group:item("makarov", 10)
    group:item("model_10_revolver", 20)
    group:item("tokarev", 6)
    content.add(group)
end

do
    -- Fully automatic firearms.  Should not spawn anywhere commonly.
    -- Making the assumption any loaded gun will have additional ammo and mags with it.
    local group = content.ItemGroup { id = "guns_nfa", kind = "distribution" }
    group:group("nested_m2carbine", 4)
    group:group("nested_hk_mp5", 5)
    group:group("nested_tommygun", 5)
    group:group("nested_uzi", 11)
    group:group("nested_mac_10", 9)
    group:group("nested_mac_11", 13)
    content.add(group)
end

do
    -- Rifles that are sought after but with little or no historical value.  Think of AKs, stuff made famous by movies, guns that "look cool".  Should all be unloaded, but with magazines as these are display pieces.
    local group = content.ItemGroup { id = "guns_rifle_display_pieces", kind = "distribution", with_magazine = 100 }
    group:entry { item = "sl8", charges = { 0, 0 }, probability = 20 }
    group:item("win70_458", 15)
    group:entry { item = "sig_assault_rifle", charges = { 0, 0 }, probability = 4 }
    group:entry { item = "aksemi", charges = { 0, 0 } }
    content.add(group)
end

do
    -- Rifles that are sought after, and that have historical value, such as M1 Garand, Mosin Nagant.  These weapons are always unloaded.
    local group = content.ItemGroup { id = "guns_rifle_collectible", kind = "distribution" }
    group:item("type99", 2)
    group:item("type99_sniper", 2)
    group:item("smle_mk3", 16)
    group:item("garand", 80)
    group:item("m1carbine", 50)
    group:item("mosin91_30", 25)
    group:item("mosin44", 20)
    group:item("m1903", 60)
    group:item("number4_mki", 16)
    content.add(group)
end

do
    -- Empty civilian hunting rifles found within hunting supply stores and other related locations.
    -- These numbers are mostly guesses and some scaled-down numbers.  If there's better info on hunting calibers please change
    local group = content.ItemGroup { id = "guns_rifle_hunting_display", kind = "distribution" }
    group:group("guns_rifle_common_display_22", 176)
    group:group("guns_rifle_common_display_223")
    group:group("guns_rifle_common_display_308", 320)
    group:group("guns_rifle_common_display_762", 115)
    group:group("guns_rifle_common_display_3006", 149)
    group:group("guns_rifle_common_display_44", 8)
    group:group("guns_rifle_common_display_3030", 76)
    group:group("guns_rifle_common_display_762R", 70)
    group:group("guns_rifle_common_display_270win", 57)
    group:group("guns_rifle_common_display_300winmag", 32)
    group:group("guns_rifle_common_display_4570", 18)
    group:group("guns_rifle_common_display_303", 16)
    group:group("guns_rifle_common_display_338", 14)
    group:group("guns_rifle_common_display_450", 3)
    group:group("guns_rifle_common_display_50beowulf", 3)
    group:group("guns_rifle_common_display_7mm_arisaka", 2)
    content.add(group)
end

do
    -- Shotguns commonly owned by citizens and found in gun stores.
    -- To-do, add in more 410 shotguns
    local group = content.ItemGroup { id = "guns_shotgun_common_display", kind = "distribution" }
    group:group("12_gauge_semi_display", 48)
    group:group("12_gauge_pump_display", 34)
    group:group("12_gauge_break_display", 18)
    group:group("20_gauge_pump_display", 6)
    group:group("20_gauge_bolt_display", 5)
    group:group("20_gauge_break_display", 2)
    group:item("mossberg_500_410", 5)
    content.add(group)
end

do
    -- Factory manufactured incendiary liquid projectors (excludes improvised weapons)
    local group = content.ItemGroup { id = "guns_launcher_flame_xedra", kind = "distribution" }
    group:entry { item = "flamethrower", charges = { 100, 8000 }, probability = 50 }
    group:entry { item = "rm451_flamethrower", charges = { 100, 9000 }, probability = 40 }
    content.add(group)
end

do
    -- Guns of all types commonly owned by citizens and found exclusively in gun stores.
    local group = content.ItemGroup { id = "guns_common_display", kind = "distribution" }
    group:group("guns_pistol_common_display", 41)
    group:group("guns_rifle_common_display", 58)
    group:group("guns_shotgun_common_display", 1)
    content.add(group)
end

do
    -- guns lost but still have mags
    local group = content.ItemGroup { id = "sidearms_operator_in_field_no_gun", kind = "distribution" }
    group:group("field_glock_19", 15)
    group:group("field_glock_22", 20)
    group:group("field_glock_34", 3)
    group:group("field_m9", 5)
    group:group("field_sig_40", 20)
    group:group("field_usp_45", 10)
    group:group("field_usp_9mm", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_varmint_airgun", kind = "distribution", container = "box_small" }
    group:entry { item = "airgun_pellet_target", charges = { 0, 250 }, probability = 50 }
    group:entry { item = "airgun_pellet_hunting", charges = { 0, 250 }, probability = 50 }
    content.add(group)
end
