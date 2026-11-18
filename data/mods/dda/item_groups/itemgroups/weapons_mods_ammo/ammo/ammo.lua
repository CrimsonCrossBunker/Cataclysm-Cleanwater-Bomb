local content = require("ccb").content

do
    -- Loose rounds of ammunition, stuff you'd expect on the floors of looted gunstores.
    local group = content.ItemGroup { id = "ammo_common_loose", kind = "distribution" }
    group:group("9mm_loose", 209)
    group:entry { item = "22_lr", charges = { 1, 20 }, probability = 204 }
    group:group("223_loose", 125)
    group:group("45_loose", 49)
    group:group("380_loose", 48)
    group:group("40_loose", 40)
    group:group("762_loose", 34)
    group:group("357_loose", 34)
    group:group("12_loose", 26)
    group:group("308_loose", 25)
    group:group("38_loose", 19)
    group:group("44_loose", 15)
    group:group("3006_loose", 8)
    group:group("45colt_loose", 8)
    group:entry { item = "3030", charges = { 1, 10 }, probability = 5 }
    group:entry { item = "762_54R", charges = { 1, 10 }, probability = 4 }
    group:entry { item = "270win_jsp", charges = { 1, 10 }, probability = 3 }
    group:group("410_loose", 3)
    group:group("10mm_loose", 1)
    group:entry { item = "300_winmag", charges = { 1, 10 }, probability = 1 }
    group:group("303_loose", 1)
    group:group("30carbine_loose", 1)
    group:group("32_loose", 1)
    group:entry { item = "338lapua_hpbt", charges = { 1, 10 }, probability = 1 }
    group:group("357sig_loose", 1)
    group:group("38super_loose", 1)
    group:entry { item = "450_ftx", charges = { 1, 10 }, probability = 1 }
    group:entry { item = "454_Casull", charges = { 1, 10 }, probability = 1 }
    group:group("4570_loose", 1)
    group:entry { item = "500_Magnum", charges = { 1, 10 }, probability = 1 }
    group:entry { item = "545", charges = { 1, 10 }, probability = 1 }
    group:entry { item = "57mm_lf", charges = { 1, 10 }, probability = 1 }
    group:entry { item = "762_25", charges = { 1, 10 }, probability = 1 }
    group:entry { item = "300blk", charges = { 1, 10 }, probability = 1 }
    group:entry { item = "9x18mm", charges = { 1, 10 }, probability = 1 }
    group:group("50beowulf_loose", 1)
    group:entry { item = "77mm_arisaka_jsp", charges = { 1, 10 }, probability = 1 }
    group:group("50AE_loose", 1)
    group:entry { item = "458wm", charges = { 1, 10 }, probability = 1 }
    content.add(group)
end

do
    -- Ammo for hunting purposes.
    local group = content.ItemGroup { id = "ammo_hunting", kind = "distribution" }
    group:group("boxed_22lr", 1487)
    group:group("boxed_223", 969)
    group:group("boxed_762", 390)
    group:group("boxed_357", 1719)
    group:group("boxed_12", 4065)
    group:group("boxed_308", 742)
    group:group("boxed_44", 993)
    group:group("boxed_3006", 378)
    group:group("boxed_3030", 334)
    group:group("boxed_762R", 175)
    group:group("boxed_270", 167)
    group:group("boxed_20", 1000)
    group:group("boxed_410", 678)
    group:group("boxed_10mm", 31)
    group:group("boxed_300", 72)
    group:group("boxed_303", 72)
    group:group("boxed_338", 64)
    group:group("boxed_450", 15)
    group:group("boxed_454", 125)
    group:group("boxed_4570", 84)
    group:group("boxed_500", 137)
    group:group("boxed_50beowulf", 14)
    group:group("boxed_77x58", 11)
    group:group("boxed_50AE", 10)
    group:group("boxed_458", 5)
    content.add(group)
end

do
    -- Military specification SMG ammo found at military sites.
    local group = content.ItemGroup { id = "ammo_smg_milspec", kind = "distribution" }
    group:group("ammo_pistol_milspec")
    content.add(group)
end

do
    -- Less common shotgun ammo including that only used by police/paramilitary forces.
    local group = content.ItemGroup { id = "ammo_shotgun_rare_collection", kind = "collection" }
    group:item("shot_dragon", 20)
    group:item("shot_beanbag", 40)
    content.add(group)
end

do
    -- Reloaded shotgun ammo balanced according to rarity.
    local group = content.ItemGroup { id = "ammo_shotgun_reloaded", kind = "distribution" }
    group:item("reloaded_shot_00", 200)
    group:item("reloaded_shot_bird", 30)
    group:item("reloaded_shot_dragon", 20)
    group:item("reloaded_shot_flechette", 5)
    group:item("reloaded_shot_slug", 30)
    group:item("shot_scrap", 80)
    content.add(group)
end

do
    -- Adapters for firing multiples of civilian legal ammo from a greneade launcher
    local group = content.ItemGroup { id = "ammo_launcher_grenade_adapter", kind = "distribution" }
    group:item("40x46mm_hornets_nest_22lr", 50)
    group:item("40x46mm_hornets_nest_410", 50)
    content.add(group)
end

do
    -- Military specification ammo found at military sites.
    local group = content.ItemGroup { id = "ammo_milspec", kind = "distribution" }
    group:group("ammo_pistol_milspec", 50)
    group:group("ammo_rifle_milspec", 200)
    group:group("ammo_shotgun_milspec", 30)
    group:group("ammo_launcher_grenade", 30)
    content.add(group)
end

do
    -- Raw materials for assembling ammo excluding casings.
    local group = content.ItemGroup { id = "ammo_parts", kind = "distribution" }
    group:entry { item = "gunpowder_shotgun", charges = { 200, 4540 }, wrapper = "bottle_plastic", probability = 20 }
    group:entry { item = "gunpowder_pistol", charges = { 200, 4540 }, wrapper = "bottle_plastic", probability = 105 }
    group:entry { item = "gunpowder_magnum_pistol", charges = { 200, 4540 }, wrapper = "bottle_plastic", probability = 60 }
    group:entry { item = "gunpowder_rifle", charges = { 200, 4540 }, wrapper = "bottle_plastic", probability = 85 }
    group:entry { item = "gunpowder_large_rifle", charges = { 200, 4540 }, wrapper = "bottle_plastic", probability = 40 }
    group:entry { item = "gunpowder_artillery", charges = { 200, 4540 }, wrapper = "bottle_plastic", probability = 5 }
    group:item("incendiary", 20)
    group:item("copper", 160)
    group:item("lead", 160)
    group:group("boxed_primers_full", 320)
    content.add(group)
end

do
    -- Ammo for police issue firearms.
    local group = content.ItemGroup { id = "ammo_cop", kind = "distribution" }
    group:entry { item = "223", charges = { 1, 30 }, probability = 30 }
    group:entry { item = "3006", charges = { 1, 20 }, probability = 10 }
    group:entry { item = "40sw", charges = { 1, 40 }, probability = 50 }
    group:entry { item = "45_acp", charges = { 1, 30 }, probability = 20 }
    group:entry { item = "57mm", charges = { 1, 40 }, probability = 80 }
    group:entry { item = "57mm_ss", charges = { 1, 40 }, probability = 25 }
    group:entry { item = "9mm", charges = { 1, 50 } }
    group:entry { item = "shot_00", charges = { 1, 20 }, probability = 40 }
    group:entry { item = "shot_beanbag", charges = { 1, 10 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_light_batteries", kind = "distribution" }
    group:entry { item = "light_battery_cell", charges = { 0, 100 }, probability = 25 }
    group:entry { item = "light_minus_battery_cell", charges = { 0, 50 }, probability = 12 }
    group:entry { item = "light_battery_cell", charges = { 0, 150 }, probability = 9 }
    group:entry { item = "light_battery_cell", charges = { 0, 300 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_light_batteries_full", kind = "distribution" }
    group:entry { item = "light_battery_cell", charges = { 100, 100 }, probability = 25 }
    group:entry { item = "light_minus_battery_cell", charges = { 50, 50 }, probability = 12 }
    group:entry { item = "light_battery_cell", charges = { 150, 150 }, probability = 9 }
    group:entry { item = "light_battery_cell", charges = { 300, 300 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_medium_batteries", kind = "distribution" }
    group:entry { item = "medium_battery_cell", charges = { 0, 500 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_medium_batteries_full", kind = "distribution" }
    group:entry { item = "medium_battery_cell", charges = { 500, 500 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_heavy_batteries_full", kind = "distribution" }
    group:entry { item = "heavy_battery_cell", charges = { 1000, 1000 }, probability = 40 }
    group:entry { item = "heavy_plus_battery_cell", charges = { 2500, 2500 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_any_batteries", kind = "distribution" }
    group:group("ammo_light_batteries", 5)
    group:group("ammo_medium_batteries", 5)
    group:group("ammo_heavy_batteries", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_pocket_batteries", kind = "distribution" }
    group:group("ammo_light_batteries", 10)
    group:group("ammo_medium_batteries", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_pocket_batteries_full", kind = "distribution" }
    group:group("ammo_light_batteries_full", 5)
    group:group("ammo_medium_batteries_full", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_cannon", kind = "distribution" }
    group:item("cannon_shot")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_heavy_batteries", kind = "distribution" }
    group:entry { item = "heavy_battery_cell", charges = { 0, 1000 }, probability = 40 }
    group:entry { item = "heavy_plus_battery_cell", charges = { 0, -1 }, probability = 80 }
    content.add(group)
end
