local content = require("ccb").content

do
    local group = content.ItemGroup { id = "regional_military_reserve_ammo", kind = "distribution" }
    group:group("ammo_can_300_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_military_surplus_firearms", kind = "distribution" }
    group:group("guns_common")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_military_surplus_magazines", kind = "distribution" }
    group:group("mags_common")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_kit_sidearm-CA", kind = "collection" }
    group:item("m17")
    group:item("p320mag_17rd_9x19mm")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_case_sidearm-CA", kind = "collection" }
    group:group("regional_service_kit_sidearm-CA")
    group:group("ammo_can_9mm_any_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_kit_rifle-CA", kind = "collection" }
    group:item("modular_m16_auto_rifle")
    group:item("stanag30")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_case_rifle-CA", kind = "collection" }
    group:group("regional_service_kit_rifle-CA")
    group:group("ammo_can_223_any_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_kit_secondary-CA", kind = "collection" }
    group:group("modular_m4a1")
    group:item("stanag30")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_case_secondary-CA", kind = "collection" }
    group:group("regional_service_kit_secondary-CA")
    group:group("ammo_can_223_any_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_kit_support-CA", kind = "collection" }
    group:item("m249")
    group:item("belt223")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_case_support-CA", kind = "collection" }
    group:group("regional_service_kit_support-CA")
    group:group("ammo_can_223_mg_any_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_kit_medium_support-CA", kind = "collection" }
    group:item("m240")
    group:item("belt308")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_case_medium_support-CA", kind = "collection" }
    group:group("regional_service_kit_medium_support-CA")
    group:group("ammo_can_308_mg_any_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_kit_sniper-CA", kind = "collection" }
    group:item("steyr_scout")
    group:item("steyr_scout_mag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_case_sniper-CA", kind = "collection" }
    group:group("regional_service_kit_sniper-CA")
    group:group("ammo_can_308_any_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_patrol_kit-CA", kind = "collection" }
    group:group("regional_service_kit_rifle-CA")
    group:group("ammo_can_223_any_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_any_pistol-CA", kind = "distribution" }
    group:group("police_armory_glock_17", 50)
    group:group("police_armory_glock_19", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_any_assaultrifle-CA", kind = "distribution" }
    group:group("regional_patrol_kit-CA", 60)
    group:group("police_armory_patrolrifle_stanag", 20)
    group:group("police_armory_mp5", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_any_smg-CA", kind = "distribution" }
    group:group("police_armory_mp5")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_any_sniperrifle-CA", kind = "distribution" }
    group:group("regional_service_case_sniper-CA")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_any_shotgun-CA", kind = "collection" }
    group:group("police_armory_shotgun_pick1")
    group:group("police_armory_boxes_shotshells")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sidearms_cop-CA", kind = "distribution" }
    group:entry { item = "glock_17", charges = { 0, 8 }, damage = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sidearms_cop_in_field-CA", kind = "collection" }
    group:entry { item = "glock_17", charges = { 0, 8 }, damage = { 0, 3 } }
    group:group("field_glock_17")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sidearms_cop_in_field_no_gun-CA", kind = "distribution" }
    group:group("field_glock_17")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "longguns_cop_in_field_no_gun-CA", kind = "distribution" }
    group:group("field_ar15_223")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_swat-CA", kind = "distribution" }
    group:group("longguns_cop_in_field-CA", 85)
    group:entry {
        collection = {
            { item = "hk_mp5", charges = { 0, 8 } },
            { item = "mp5mag" },
        },
        probability = 15,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_cop-CA", kind = "distribution" }
    group:item("glock17_17")
    group:item("stanag30")
    group:item("mp5mag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_swat-CA", kind = "distribution" }
    group:item("glock17_17")
    group:item("stanag30")
    group:item("mp5mag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "military_standard_pistols-CA", kind = "distribution" }
    group:entry { item = "m17", charges = { 0, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "military_grenadier_assault_rifles-CA", kind = "distribution" }
    group:entry { item = "modular_m16_auto_rifle", charges = { 0, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "military_standard_lmgs-CA", kind = "distribution" }
    group:entry { item = "m249", charges = { 0, 8 } }
    group:entry { item = "m240", charges = { 0, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "military_standard_sniper_rifles-CA", kind = "distribution" }
    group:entry { item = "steyr_scout", charges = { 0, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "military_standard_shotguns-CA", kind = "distribution" }
    group:entry { item = "remington_870", charges = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_milspec-CA", kind = "distribution" }
    group:entry { item = "m17", charges = { 0, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_smg_milspec-CA", kind = "distribution" }
    group:item("hk_mp5")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_milspec-CA", kind = "distribution" }
    group:item("p320mag_17rd_9x19mm", 20)
    group:item("stanag30", 55)
    group:item("stanag30", 10)
    group:item("belt223", 10)
    group:item("belt308", 5)
    group:item("steyr_scout_mag", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_military-CA", kind = "distribution" }
    group:item("p320mag_17rd_9x19mm", 20)
    group:item("stanag30", 55)
    group:item("stanag30", 10)
    group:item("belt223", 10)
    group:item("belt308", 5)
    group:item("steyr_scout_mag", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_group_guns&mags&cans-CA", kind = "distribution" }
    group:group("regional_service_case_sidearm-CA", 20)
    group:group("regional_service_case_rifle-CA", 55)
    group:group("regional_service_case_secondary-CA", 10)
    group:group("regional_service_case_support-CA", 10)
    group:group("regional_service_case_medium_support-CA", 5)
    group:group("regional_service_case_sniper-CA", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_group_guns-CA", kind = "distribution" }
    group:group("regional_service_kit_sidearm-CA", 20)
    group:group("regional_service_kit_rifle-CA", 55)
    group:group("regional_service_kit_secondary-CA", 10)
    group:group("regional_service_kit_support-CA", 10)
    group:group("regional_service_kit_medium_support-CA", 5)
    group:group("regional_service_kit_sniper-CA", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_group_ammo_full-CA", kind = "distribution" }
    group:group("ammo_can_9mm_any_full", 20)
    group:group("ammo_can_223_any_full", 55)
    group:group("ammo_can_223_any_full", 10)
    group:group("ammo_can_223_mg_any_full", 10)
    group:group("ammo_can_308_mg_any_full", 5)
    group:group("ammo_can_308_any_full", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_military_reserve_ammo-CA", kind = "distribution" }
    group:group("ammo_can_308_any_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_military_surplus_magazines-CA", kind = "distribution" }
    group:item("p320mag_17rd_9x19mm", 20)
    group:item("stanag30", 55)
    group:item("stanag30", 10)
    group:item("belt223", 10)
    group:item("belt308", 5)
    group:item("steyr_scout_mag", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_kit_sidearm-MX", kind = "collection" }
    group:item("m9")
    group:item("m9mag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_case_sidearm-MX", kind = "collection" }
    group:group("regional_service_kit_sidearm-MX")
    group:group("ammo_can_9mm_any_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_kit_rifle-MX", kind = "collection" }
    group:item("bren2_556")
    group:item("stanag30")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_case_rifle-MX", kind = "collection" }
    group:group("regional_service_kit_rifle-MX")
    group:group("ammo_can_223_any_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_kit_secondary-MX", kind = "collection" }
    group:item("hk_g3")
    group:item("g3mag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_case_secondary-MX", kind = "collection" }
    group:group("regional_service_kit_secondary-MX")
    group:group("ammo_can_308_any_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_kit_support-MX", kind = "collection" }
    group:item("m240")
    group:item("belt308")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_case_support-MX", kind = "collection" }
    group:group("regional_service_kit_support-MX")
    group:group("ammo_can_308_mg_any_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_kit_sniper-MX", kind = "collection" }
    group:item("steyr_scout")
    group:item("steyr_scout_mag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_service_case_sniper-MX", kind = "collection" }
    group:group("regional_service_kit_sniper-MX")
    group:group("ammo_can_308_any_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_patrol_kit-MX", kind = "collection" }
    group:group("regional_service_kit_rifle-MX")
    group:group("ammo_can_223_any_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_any_pistol-MX", kind = "distribution" }
    group:group("police_armory_m9", 50)
    group:group("police_armory_glock_17", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_any_assaultrifle-MX", kind = "distribution" }
    group:group("regional_patrol_kit-MX", 60)
    group:group("police_armory_mp5", 20)
    group:group("police_armory_patrolrifle_stanag", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_any_smg-MX", kind = "distribution" }
    group:group("police_armory_mp5")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_any_sniperrifle-MX", kind = "distribution" }
    group:group("regional_service_case_sniper-MX")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "police_armory_any_shotgun-MX", kind = "collection" }
    group:group("police_armory_shotgun_pick1")
    group:group("police_armory_boxes_shotshells")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sidearms_cop-MX", kind = "distribution" }
    group:entry { item = "m9", charges = { 0, 8 }, damage = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sidearms_cop_in_field-MX", kind = "collection" }
    group:entry { item = "m9", charges = { 0, 8 }, damage = { 0, 3 } }
    group:group("field_m9")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sidearms_cop_in_field_no_gun-MX", kind = "distribution" }
    group:group("field_m9")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "longguns_cop-MX", kind = "distribution" }
    group:entry { item = "bren2_556", charges = { 0, 15 }, damage = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "longguns_cop_loaded-MX", kind = "distribution" }
    group:entry { item = "bren2_556", charges = { 0, 15 }, damage = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "longguns_cop_in_field-MX", kind = "collection" }
    group:entry { item = "bren2_556", charges = { 0, 15 }, damage = { 0, 3 } }
    group:group("field_ar15_223")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "longguns_cop_in_field_no_gun-MX", kind = "distribution" }
    group:group("field_ar15_223")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_swat-MX", kind = "distribution" }
    group:group("longguns_cop_in_field-MX", 85)
    group:entry {
        collection = {
            { item = "hk_mp5", charges = { 0, 8 } },
            { item = "mp5mag" },
        },
        probability = 15,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_cop-MX", kind = "distribution" }
    group:item("m9mag")
    group:item("stanag30")
    group:item("mp5mag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_swat-MX", kind = "distribution" }
    group:item("m9mag")
    group:item("stanag30")
    group:item("mp5mag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "military_standard_pistols-MX", kind = "distribution" }
    group:entry { item = "m9", charges = { 0, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "military_standard_assault_rifles-MX", kind = "distribution" }
    group:entry { item = "bren2_556", charges = { 0, 8 }, probability = 85 }
    group:entry { item = "hk_g3", charges = { 0, 8 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "military_grenadier_assault_rifles-MX", kind = "distribution" }
    group:entry { item = "bren2_556", charges = { 0, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "military_standard_lmgs-MX", kind = "distribution" }
    group:entry { item = "m240", charges = { 0, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "military_standard_sniper_rifles-MX", kind = "distribution" }
    group:entry { item = "steyr_scout", charges = { 0, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "military_standard_shotguns-MX", kind = "distribution" }
    group:entry { item = "mossberg_590", charges = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_milspec-MX", kind = "distribution" }
    group:entry { item = "bren2_556", charges = { 0, 8 }, probability = 85 }
    group:entry { item = "hk_g3", charges = { 0, 8 }, probability = 15 }
    group:item("steyr_scout", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_milspec-MX", kind = "distribution" }
    group:entry { item = "m9", charges = { 0, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_smg_milspec-MX", kind = "distribution" }
    group:item("hk_mp5")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_milspec-MX", kind = "distribution" }
    group:item("m9mag", 20)
    group:item("stanag30", 55)
    group:item("g3mag", 10)
    group:item("belt308", 10)
    group:item("steyr_scout_mag", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_military-MX", kind = "distribution" }
    group:item("m9mag", 20)
    group:item("stanag30", 55)
    group:item("g3mag", 10)
    group:item("belt308", 10)
    group:item("steyr_scout_mag", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_group_guns&mags&cans-MX", kind = "distribution" }
    group:group("regional_service_case_sidearm-MX", 20)
    group:group("regional_service_case_rifle-MX", 55)
    group:group("regional_service_case_secondary-MX", 10)
    group:group("regional_service_case_support-MX", 10)
    group:group("regional_service_case_sniper-MX", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_group_guns-MX", kind = "distribution" }
    group:group("regional_service_kit_sidearm-MX", 20)
    group:group("regional_service_kit_rifle-MX", 55)
    group:group("regional_service_kit_secondary-MX", 10)
    group:group("regional_service_kit_support-MX", 10)
    group:group("regional_service_kit_sniper-MX", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_group_ammo_full-MX", kind = "distribution" }
    group:group("ammo_can_9mm_any_full", 20)
    group:group("ammo_can_223_any_full", 55)
    group:group("ammo_can_308_any_full", 10)
    group:group("ammo_can_308_mg_any_full", 10)
    group:group("ammo_can_308_any_full", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_military_reserve_ammo-MX", kind = "distribution" }
    group:group("ammo_can_308_any_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_military_surplus_firearms-MX", kind = "distribution" }
    group:entry { item = "bren2_556", charges = { 0, 8 }, probability = 85 }
    group:entry { item = "hk_g3", charges = { 0, 8 }, probability = 15 }
    group:item("steyr_scout", 5)
    group:item("m9", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_military_surplus_magazines-MX", kind = "distribution" }
    group:item("m9mag", 20)
    group:item("stanag30", 55)
    group:item("g3mag", 10)
    group:item("belt308", 10)
    group:item("steyr_scout_mag", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "longguns_cop-CA", kind = "distribution" }
    group:entry { group = "modular_m4a1", charges = { 0, 15 }, damage = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "longguns_cop_loaded-CA", kind = "distribution" }
    group:entry { group = "modular_m4a1", charges = { 0, 15 }, damage = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "longguns_cop_in_field-CA", kind = "collection" }
    group:entry { group = "modular_m4a1", charges = { 0, 15 }, damage = { 0, 3 } }
    group:group("field_ar15_223")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "military_standard_assault_rifles-CA", kind = "distribution" }
    group:entry { item = "modular_m16_auto_rifle", charges = { 0, 8 }, probability = 85 }
    group:entry { group = "modular_m4a1", charges = { 0, 8 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_milspec-CA", kind = "distribution" }
    group:entry { item = "modular_m16_auto_rifle", charges = { 0, 8 }, probability = 85 }
    group:entry { group = "modular_m4a1", charges = { 0, 8 }, probability = 15 }
    group:item("steyr_scout", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_military_surplus_firearms-CA", kind = "distribution" }
    group:entry { item = "modular_m16_auto_rifle", charges = { 0, 8 }, probability = 85 }
    group:entry { group = "modular_m4a1", charges = { 0, 8 }, probability = 15 }
    group:item("steyr_scout", 5)
    group:item("m17", 30)
    content.add(group)
end
