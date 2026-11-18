local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_AUGUSTMOON_DOCTOR_worn", kind = "collection" }
    group:item("boots")
    group:item("boxer_briefs")
    group:item("spacer_jumpsuit")
    group:item("afs_company_jacket")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_AUGUSTMOON_DOCTOR_stock", kind = "collection" }
    group:entry { item = "afs_medigel", count = { 4, 10 } }
    group:entry { item = "afs_stimpack", count = { 3, 10 } }
    group:entry { item = "afs_painkiller", count = { 3, 10 } }
    group:group("medical_tape_roll_part")
    group:entry { group = "quikclot_bag_plastic_5", count = { 4, 8 } }
    group:entry { group = "drugs_analgesic", count = { 2, 4 } }
    group:group("augustmoon_shop_money")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_augustmoon_guntrader", kind = "collection" }
    group:entry { group = "afs_civilian_armory", count = { 14, 28 } }
    group:entry { group = "afs_augustmoon_guntrader_seyfert", count = { 1, 1 } }
    group:group("augustmoon_shop_money")
    group:entry { item = "UPS_OFF", count = { 1, 1 }, charges = { 1000, 1000 } }
    group:entry { item = "small_repairkit", count = { 1, 1 } }
    group:entry { item = "large_repairkit", count = { 1, 1 } }
    group:group("afs_augustmoon_guntrader_energy_cells")
    group:entry { item = "chem_acetone", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_augustmoon_guntrader_seyfert",
        kind = "collection",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_seyfert_84K")
    group:item("afs_84k_20mag")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_augustmoon_guntrader_energy_cells",
        kind = "collection",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:entry { item = "afs_voltaic_cartridge", count = { 2, 2 } }
    group:entry { item = "afs_bootleg_cartridge", count = { 2, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_augustmoon_guntrader_military", kind = "collection" }
    group:entry { group = "afs_augustmoon_guntrader_military_gun", count = { 1, 2 } }
    group:entry { group = "afs_augustmoon_guntrader_military_ammo", count = { 4, 12 } }
    group:entry { group = "afs_any_hand_grenade", count = { 4, 8 } }
    group:entry { group = "afs_any_mine", count = { 2, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "AUGUSTMOON_GUNTRADER_worn", kind = "collection" }
    group:group("military_ballistic_vest_pristine")
    group:item("legpouch_large")
    group:item("pants_army")
    group:item("afs_company_jacket")
    group:item("boots_combat")
    group:item("under_armor")
    group:item("under_armor_shorts")
    group:item("sunglasses")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_augustmoon_outfitter", kind = "collection", with_ammo = 100, with_magazine = 100 }
    group:entry { group = "afs_wintersuit_generic_advanced", count = { 1, 3 } }
    group:entry { group = "afs_frontier_cryo_g_full_augustmoon", count = { 1, 1 } }
    group:entry { group = "afs_basic_armor", count = { 0, 3 } }
    group:entry { group = "afs_colonist_outfit", count = { 1, 3 } }
    group:entry { group = "afs_civilian_hazard_outfit", count = { 1, 3 }, probability = 60 }
    group:entry { group = "afs_pals_pieces", count = { 6, 12 } }
    group:entry { group = "afs_augustmoon_outfitter_bags", count = { 10, 28 } }
    group:group("augustmoon_shop_money")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "AUGUSTMOON_OUTFITTER_worn", kind = "collection" }
    group:item("legpouch_large")
    group:item("afs_jumpsuit_military")
    group:item("afs_company_jacket")
    group:item("boots_combat")
    group:item("under_armor")
    group:item("under_armor_shorts")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_augustmoon_outfitter_bags",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_herc_rig", 20)
    group:item("afs_ilbe", 20)
    group:item("molle_pack", 20)
    group:item("backpack", 20)
    group:item("runner_bag", 20)
    group:item("frame_pack", 20)
    group:item("nylon_scabbard", 1)
    group:item("dry_bag", 20)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_augustmoon_outfitter_military",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:group("afs_armor_military_infantry_g", 85)
    group:item("afs_backpack_rockets", 10)
    group:item("afs_backpack_shieldgen", 5)
    group:entry { item = "afs_combat_cryo", count = { 1, 2 }, probability = 60 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_augustmoon_tool_trader",
        kind = "collection",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:entry { group = "afs_tools_electric_repair", count = { 1, 3 } }
    group:entry { group = "afs_tools_robot_maintenance", count = { 1, 3 } }
    group:entry { group = "afs_tools_portable_power", count = { 1, 2 } }
    group:entry { group = "afs_tools_structural_repair", count = { 1, 3 } }
    group:entry { group = "afs_tools_programing", count = { 1, 1 } }
    group:entry { item = "nanomaterial", count = { 2, 3 }, probability = 66 }
    group:entry { group = "afs_tools_scavenging", count = { 6, 12 } }
    group:entry { group = "afs_tools_pocket", count = { 5, 10 } }
    group:entry { item = "afs_thermos", count = { 2, 3 } }
    group:entry { item = "multi_cooker", count = { 1, 1 } }
    group:entry { item = "g_shovel", count = { 1, 1 } }
    group:entry { item = "water_purifier", count = { 1, 1 } }
    group:entry { item = "afs_40g_plasma_civ", count = { 2, 5 } }
    group:entry { item = "afs_ipav_patch_kit", count = { 1, 2 } }
    group:entry { item = "goggles_welding", count = { 1, 1 } }
    group:entry { item = "afs_heavy_suit_battery_cell", count = { 2, 5 } }
    group:entry { group = "afs_tools_welding_consumable", count = { 6, 8 } }
    group:entry { group = "pur_tablets_bottle_plastic_small_50", count = { 1, 2 } }
    group:entry { group = "afs_augustmoon_batteries_disposable", count = { 5, 10 } }
    group:entry { group = "afs_augustmoon_batteries_rechargeable", count = { 2, 3 }, probability = 20 }
    group:entry { item = "ammonia_liquid", count = { 2, 4 } }
    group:group("augustmoon_shop_money")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_augustmoon_batteries_disposable",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("light_battery_cell", 4)
    group:item("light_minus_disposable_cell", 1)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_augustmoon_batteries_rechargeable",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("heavy_battery_cell", 2)
    group:item("medium_battery_cell", 1)
    group:item("light_battery_cell", 3)
    group:item("light_minus_battery_cell", 1)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_augustmoon_tools_premium",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:entry { item = "nanomaterial", count = { 2, 3 }, probability = 66 }
    group:item("electrohack", 20)
    group:item("control_laptop", 20)
    group:item("folding_solar_panel_v2", 20)
    group:item("afs_cRTG", 10)
    group:item("afs_40g_plasma_civ", 20)
    group:item("afs_imager", 20)
    group:item("afs_motion_sensor", 20)
    content.add(group)
end

do
    -- Too cool to wear helmets (or much armor while at that).  They make armor bionics for that.
    local group = content.ItemGroup { id = "NC_SOLO_worn", kind = "collection", with_ammo = 100, with_magazine = 100 }
    group:item("afs_combat_cryo")
    group:group("solo_jacket")
    group:item("boots_combat")
    group:item("under_armor")
    group:item("afs_combat_headset_off")
    group:item("afs_military_cloak", 20)
    group:item("under_armor_shorts")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "solo_jacket", kind = "distribution" }
    group:entry {
        item = "afs_bolero",
        contents = {
            { group = "solo_bolero" },
        },
        probability = 20,
    }
    group:item("afs_cyberpunk_bomber", 20)
    group:item("afs_leather_jacket", 20)
    group:entry {
        item = "afs_ilbe",
        contents = {
            { group = "solo_ilbe" },
        },
        probability = 10,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "solo_bolero", kind = "collection" }
    group:item("XL_holster")
    group:item("gadget_pouch")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "solo_ilbe", kind = "collection" }
    group:item("XL_holster")
    group:item("afs_grenade_pouch")
    group:item("afs_triple_stacker_pouch")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_augustmoon_genetech_trader",
        kind = "collection",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:entry { item = "afs_gene_disp", count = { 3, 10 } }
    group:entry { item = "afs_gene_template", count = { 2, 3 } }
    group:entry { item = "afs_combat_cryo_xl", count = { 2, 3 } }
    group:entry { group = "afs_frontier_xl_cryo_g", count = { 2, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "NC_SALVOR_FABRICATOR_worn",
        kind = "collection",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_frontier_cryo")
    group:item("afs_frontier_cryomask")
    group:item("afs_wrist_computer")
    group:item("spacer_cap")
    group:item("carbide_cuirass")
    group:item("afs_herc_rig")
    group:item("boots_combat")
    group:item("gloves_tactical")
    group:item("spacer_jumpsuit")
    group:item("holster")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_salvor_fabricator_trade",
        kind = "collection",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:group("afs_salvor_fabricator_scraps")
    group:group("afs_salvor_fabricator_tools")
    group:group("afs_salvor_fabricator_combat_gear")
    group:entry { item = "afs_40g_plasma_civ", count = { 2, 5 } }
    group:entry { group = "afs_tools_welding_consumable", count = { 6, 8 } }
    group:entry { group = "afs_augustmoon_batteries_disposable", count = { 5, 10 } }
    group:entry { group = "afs_augustmoon_batteries_rechargeable", count = { 2, 3 }, probability = 20 }
    group:group("augustmoon_shop_money")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_salvor_fabricator_scraps", kind = "collection" }
    group:entry { group = "afs_common_biomaterial_scrapgroup", count = { 3, 5 }, probability = 30 }
    group:entry { group = "afs_common_energy_storage_scrapgroup", count = { 5, 8 }, probability = 70 }
    group:entry { group = "afs_common_heat_scrapgroup", count = { 5, 8 }, probability = 70 }
    group:entry { group = "afs_common_magnet_scrapgroup", count = { 5, 8 }, probability = 70 }
    group:entry { group = "afs_common_circuitry_scrapgroup", count = { 6, 15 }, probability = 90 }
    group:entry { group = "afs_common_material_scrapgroup", count = { 8, 15 }, probability = 90 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_salvor_fabricator_tools", kind = "collection" }
    group:group("afs_salvor_fabricator_tools_general")
    group:group("afs_salvor_fabricator_tools_cooking")
    group:group("afs_salvor_fabricator_tools_electronics")
    group:group("afs_salvor_fabricator_tools_appliances")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_salvor_fabricator_combat_gear", kind = "collection" }
    group:group("afs_salvor_fabricator_makeshift_armor")
    group:group("afs_salvor_fabricator_makeshift_weapons")
    group:group("afs_salvor_fabricator_makeshift_ammo")
    group:group("afs_salvor_fabricator_makeshift_grenades")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_salvor_fabricator_makeshift_armor", kind = "collection" }
    group:item("xl_helmet_scrap", 40)
    group:item("helmet_scrap_xs", 40)
    group:item("helmet_scrap", 70)
    group:item("xl_cuirass_scrap", 40)
    group:item("xs_cuirass_scrap", 40)
    group:item("cuirass_scrap", 70)
    group:item("armguard_scrap", 70)
    group:item("legguard_scrap", 70)
    group:item("xl_boots_scrap", 40)
    group:item("xs_boots_scrap", 40)
    group:item("boots_scrap", 70)
    group:item("afs_titanium_vest", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_salvor_fabricator_makeshift_weapons", kind = "collection" }
    group:entry { item = "laser_rifle_cheap", count = { 1, 2 }, probability = 60 }
    group:item("makeshift_scrambler", 30)
    group:item("afs_launcher_salvaged", 10)
    group:item("afs_makeshift_fusion_gun", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_salvor_fabricator_makeshift_ammo", kind = "collection" }
    group:entry { item = "afs_bootleg_cartridge", count = { 1, 3 }, probability = 60 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_salvor_fabricator_makeshift_grenades", kind = "collection" }
    group:entry { item = "afs_electroshock_grenade_1", count = { 1, 4 }, probability = 60 }
    group:entry { item = "grenade_cryo", count = { 1, 2 }, probability = 60 }
    group:entry { item = "afs_oxygen_bomb", count = { 1, 2 }, probability = 30 }
    content.add(group)
end

do
    -- Some general tools that aren't especially hard to find or overly useful.
    local group = content.ItemGroup { id = "afs_salvor_fabricator_tools_general", kind = "collection" }
    group:entry { item = "flashlight", count = { 1, 3 }, probability = 80 }
    group:item("heavy_flashlight", 30)
    group:entry { item = "hammer", count = { 1, 3 }, probability = 80 }
    group:entry { item = "screwdriver", count = { 1, 3 }, probability = 80 }
    group:item("screwdriver_set", 30)
    group:entry { item = "wrench", count = { 1, 3 }, probability = 80 }
    group:item("cordless_impact_wrench", 30)
    group:item("wrench_large", 60)
    group:item("wrench_small", 60)
    group:item("socket_wrench_set", 30)
    group:entry { item = "multitool", count = { 1, 3 }, probability = 60 }
    group:entry { item = "xacto", count = { 1, 3 }, probability = 60 }
    group:entry { item = "utility_knife_folding", count = { 1, 2 }, probability = 80 }
    group:item("pipe_cleaner", 30)
    group:item("angle_grinder", 20)
    group:item("crash_axe", 20)
    group:item("crowbar", 20)
    group:item("geiger_off", 20)
    group:item("small_repairkit", 10)
    group:item("hacksaw", 10)
    group:item("chisel", 5)
    group:item("hammer_sledge", 20)
    group:item("hammer_sledge_short", 20)
    group:item("e_tool", 10)
    group:item("afs_plasma_torch", 40)
    group:entry { item = "goggles_welding", count = { 1, 2 }, probability = 90 }
    content.add(group)
end

do
    -- Some tools to assist in cooking while out and about. She makes a point of keeping these sorts of things available.
    local group = content.ItemGroup { id = "afs_salvor_fabricator_tools_cooking", kind = "collection" }
    group:entry { item = "hotplate", count = { 1, 3 }, probability = 80 }
    group:entry { item = "pot", count = { 1, 3 }, probability = 80 }
    group:entry { item = "steel_pan", count = { 1, 3 }, probability = 80 }
    group:item("military_mess_kit", 30)
    group:item("multi_cooker", 40)
    content.add(group)
end

do
    -- Tools for crafting and maintaining electronics. Less available in general since their usefulness in the field is limited.
    local group = content.ItemGroup { id = "afs_salvor_fabricator_tools_electronics", kind = "collection" }
    group:entry { item = "soldering_iron", count = { 1, 2 }, probability = 20 }
    group:entry { item = "soldering_iron_portable", count = { 1, 2 }, probability = 10 }
    group:item("multimeter", 20)
    group:item("voltmeter", 20)
    group:group("solder_wire_spool_part", 70)
    content.add(group)
end

do
    -- Appliances to setting up a small little outpost. She stocks these decently well for Salvors lacking the skill to fabricate them on their own.
    local group = content.ItemGroup { id = "afs_salvor_fabricator_tools_appliances", kind = "collection" }
    group:entry { item = "afs_battery_charger", count = { 1, 3 }, probability = 60 }
    group:item("afs_survival_heater", 40)
    group:entry { item = "afs_tripod_light", count = { 3, 8 }, probability = 80 }
    group:entry { item = "afs_survival_battery", count = { 1, 2 }, probability = 40 }
    group:entry { item = "foot_locker_recharge_station", count = { 1, 2 }, probability = 30 }
    group:entry { item = "cot", count = { 1, 3 }, probability = 80 }
    group:entry { item = "rollmat", count = { 1, 3 }, probability = 80 }
    content.add(group)
end

do
    -- Just a group for all aftershock tools she sells, prevents her marking them up to oblivion.
    local group = content.ItemGroup { id = "afs_salvor_fabricator_tools_aftershock", kind = "distribution" }
    group:item("afs_battery_charger")
    group:item("afs_ipav_patch_kit")
    group:item("afs_survival_heater")
    group:item("afs_tripod_light")
    group:item("afs_survival_battery")
    group:item("multi_cooker")
    group:item("afs_40g_plasma_civ")
    group:item("afs_shydrogen")
    group:item("afs_plasma_torch")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SALVOR_RIPPER_worn", kind = "collection", with_ammo = 100, with_magazine = 100 }
    group:item("afs_cryopod_bodyglove")
    group:item("afs_wrist_computer")
    group:item("spacer_cap")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "NC_SALVOR_STREET_FOOD_worn",
        kind = "collection",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_frontier_cryo")
    group:item("apron_plastic")
    group:item("afs_frontier_cryomask")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_street_vendor_food", kind = "collection" }
    group:entry { item = "afs_streetfood_meat", count = { 2, 3 }, container = "plastic_bowl_fast_food" }
    group:entry { item = "afs_streetfood_veggy", count = { 2, 3 }, container = "plastic_bowl_fast_food" }
    group:entry { item = "afs_soup_meat", count = { 2, 3 }, container = "plastic_bowl_fast_food" }
    group:entry { item = "afs_soup_veggy", count = { 2, 3 }, container = "plastic_bowl_fast_food" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_street_dry_food", kind = "collection" }
    group:entry { item = "alien_jerky", count = { 6, 13 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_merchant", kind = "collection" }
    group:group("afs_vehicle_merchant_fuel")
    group:group("afs_vehicle_merchant_wheels")
    group:group("afs_vehicle_merchant_utilities")
    group:group("afs_vehicle_merchant_seating")
    group:group("afs_vehicle_merchant_plating")
    group:group("afs_vehicle_merchant_motors")
    group:group("afs_vehicle_merchant_lights")
    group:group("afs_vehicle_merchant_frames")
    group:group("afs_vehicle_merchant_controls")
    group:group("afs_vehicle_merchant_cargo")
    group:group("afs_vehicle_merchant_batteries")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_merchant_wheels", kind = "collection" }
    group:entry { item = "wheel_mount_light", count = { 1, 2 }, probability = 50 }
    group:entry { item = "wheel_mount_medium", count = { 1, 4 }, probability = 50 }
    group:entry { item = "wheel_mount_heavy", count = { 1, 4 }, probability = 50 }
    group:entry { item = "wheel_motorbike", count = { 1, 2 }, probability = 50 }
    group:entry { item = "wheel", count = { 1, 4 }, probability = 50 }
    group:entry { item = "wheel_armor", count = { 1, 4 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_merchant_utilities", kind = "collection" }
    group:item("recharge_station", 50)
    group:item("battery_charger", 50)
    group:entry { item = "heattank", count = { 1, 7 }, probability = 60 }
    group:entry { item = "turret_mount", count = { 1, 2 }, probability = 30 }
    group:entry { item = "workbench", count = { 1, 3 }, probability = 70 }
    group:entry { item = "solar_panel", count = { 3, 12 }, probability = 70 }
    group:entry { item = "reinforced_solar_panel", count = { 1, 2 }, probability = 20 }
    group:entry { item = "solar_panel_v2", count = { 2, 7 }, probability = 20 }
    group:entry { item = "beeper", count = { 1, 6 }, probability = 20 }
    group:entry { item = "stereo", count = { 1, 6 }, probability = 20 }
    group:entry { item = "v_motorcycle_kickstand_item", count = { 1, 8 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_merchant_seating", kind = "collection" }
    group:entry { item = "seat", count = { 3, 8 }, probability = 60 }
    group:entry { item = "seat_bench", count = { 3, 8 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_merchant_plating", kind = "collection" }
    group:entry { item = "sheet_metal", count = { 5, 15 }, probability = 80 }
    group:entry { item = "steel_plate", count = { 5, 15 }, probability = 60 }
    group:entry { item = "mil_plate", count = { 1, 8 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_merchant_motors", kind = "collection" }
    group:item("motor", 30)
    group:item("motor_enhanced", 10)
    group:item("motor_super", 5)
    group:item("motor_large", 40)
    group:item("motor_small", 20)
    group:item("motor_tiny", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_merchant_lights", kind = "collection" }
    group:entry { item = "car_headlight", count = { 5, 12 }, probability = 60 }
    group:entry { item = "motorcycle_headlight", count = { 3, 7 }, probability = 50 }
    group:entry { item = "headlight_reinforced", count = { 1, 3 }, probability = 20 }
    group:entry { item = "floodlight", count = { 1, 3 }, probability = 10 }
    group:entry { item = "directed_floodlight", count = { 1, 3 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_merchant_frames", kind = "collection" }
    group:entry { item = "xlframe", count = { 2, 8 }, probability = 40 }
    group:entry { item = "frame", count = { 7, 18 }, probability = 60 }
    group:entry { item = "hdframe", count = { 3, 15 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_merchant_controls", kind = "collection" }
    group:item("camera_control", 20)
    group:entry { item = "omnicamera", count = { 3, 7 }, probability = 20 }
    group:entry { item = "omnicamera_reinforced", count = { 1, 4 }, probability = 10 }
    group:entry { item = "vehicle_controls", count = { 3, 8 }, probability = 60 }
    group:entry { item = "vehicle_dashboard", count = { 3, 7 }, probability = 40 }
    group:entry { item = "electronics_controls", count = { 2, 5 }, probability = 40 }
    group:item("turret_controls", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_merchant_cargo", kind = "collection" }
    group:entry { item = "cargo_lock", count = { 3, 7 }, probability = 30 }
    group:entry { item = "cargo_rack", count = { 3, 8 }, probability = 40 }
    group:entry { item = "cargo_aisle", count = { 3, 7 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_merchant_batteries", kind = "collection", with_ammo = 100 }
    group:item("large_storage_battery", 10)
    group:entry { item = "storage_battery", count = { 1, 4 }, probability = 30 }
    group:entry { item = "medium_storage_battery", count = { 3, 8 }, probability = 40 }
    group:entry { item = "small_storage_battery", count = { 5, 15 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_merchant_fuel", kind = "collection" }
    group:entry { item = "plut_cell", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "NC_UICA_GROUND_ENGINEER_worn",
        kind = "collection",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("tac_fullhelmet_uicas")
    group:item("afs_military_vest")
    group:item("afs_combat_cryo")
    group:item("afs_frontier_cryomask")
    group:item("afs_ammo_satchel")
    group:item("afs_jumpsuit_military")
    group:item("afs_military_cloak")
    group:item("afs_herc_rig")
    group:item("boots_combat")
    group:item("gloves_tactical")
    group:item("under_armor")
    group:item("under_armor_shorts")
    group:item("holster")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "NC_UICA_GROUND_SOLDIER_worn",
        kind = "collection",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("tac_fullhelmet_uicas")
    group:item("afs_military_vest")
    group:item("afs_combat_cryo")
    group:item("afs_ammo_satchel")
    group:item("afs_jumpsuit_military")
    group:item("afs_military_cloak")
    group:item("holster")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "NC_UICA_NAVAL_POLICE_worn",
        kind = "collection",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_military_vest")
    group:entry {
        item = "legpouch_large",
        contents = {
            { group = "army_mags_m4" },
        },
    }
    group:item("afs_jumpsuit_military")
    group:item("boots_combat")
    group:item("under_armor")
    group:item("under_armor_shorts")
    group:item("holster")
    group:entry { item = "PR24-extended", container = "police_belt" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_UICA_PORT_CREW_worn", kind = "collection", with_ammo = 100, with_magazine = 100 }
    group:item("spacer_jumpsuit")
    group:group("afs_colonist_coats")
    group:entry {
        item = "afs_herc_rig",
        contents = {
            { item = "afs_40g_plasma_civ" },
            { item = "afs_plasma_torch" },
        },
        probability = 30,
    }
    group:item("boots")
    group:item("spacer_cap", 30)
    group:item("socks")
    group:item("under_armor")
    group:item("under_armor_shorts")
    group:group("afs_hard_hat", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_UICA_PORT_CREW_carry", kind = "collection" }
    group:group("afs_tools_pocket")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_AUGUSTMOON_shipping_stock", kind = "collection", with_ammo = 100 }
    group:entry { item = "afs_shuttle_radiobeacon", count = { 4, 10 } }
    group:group("augustmoon_shop_money")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_uica_quartermaster_military", kind = "collection" }
    group:entry { group = "afs_uica_weapon_locker", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_uica_quartermaster_armor", kind = "collection" }
    group:entry { group = "afs_uica_armor_locker", count = { 2, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_uica_quartermaster_medical", kind = "collection" }
    group:entry { group = "afs_ifak", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_GANGER_worn", kind = "collection" }
    group:item("briefs")
    group:item("socks")
    group:item("sneakers")
    group:item("tank_top")
    group:item("pants_army")
    group:item("vest_leather_mod")
    group:item("dump_pouch")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_GANGER_carried", kind = "distribution" }
    group:item("ear_plugs")
    group:entry { group = "NC_GANGER_misc", count = { 3, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_GANGER_melee", kind = "distribution" }
    group:item("knife_combat", 50)
    group:item("knife_trench", 30)
    group:item("hammer_sledge", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_GANGER_wield", kind = "distribution" }
    group:group("NC_GANGER_melee")
    group:group("guns_ganger")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CYBERNINJA_worn", kind = "collection" }
    group:item("briefs")
    group:item("socks")
    group:item("sneakers")
    group:item("tank_top")
    group:item("pants_army")
    group:item("jacket_army")
    group:item("molle_pack")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CYBERNINJA_carried", kind = "distribution" }
    group:item("ear_plugs")
    group:entry { group = "NC_CYBERNINJA_misc", count = { 3, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CYBERNINJA_melee", kind = "distribution" }
    group:item("knife_combat", 50)
    group:item("knife_trench", 30)
    group:item("knife_rm42", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CYBERNINJA_wield", kind = "distribution" }
    group:group("NC_CYBERNINJA_melee")
    group:group("guns_smg_milspec", 40)
    group:group("guns_rifle_milspec", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "prepnet_orchard_trade", kind = "distribution" }
    group:group("irradiated_food", 200)
    group:group("hardware")
    group:group("gear_survival")
    group:group("rad_gear")
    group:group("prepnet_basic_robots", 20)
    group:group("prepnet_basic_grenades", 30)
    group:group("ammo_any_batteries_full")
    group:group("prepnet_id_cards", 50)
    group:group("afs_exosuit_worker", 10)
    group:group("afs_exo_advanced_power", 5)
    group:group("afs_exosuit_security", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "prepnet_id_cards", kind = "distribution" }
    group:item("id_science", 90)
    group:item("id_military", 5)
    group:item("id_industrial", 5)
    group:item("STEED_registry", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "prepnet_basic_grenades", kind = "distribution" }
    group:item("grenade_inc", 50)
    group:item("scrambler", 25)
    group:item("fungicidalbomb", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "prepnet_basic_robots", kind = "distribution" }
    group:item("bot_rifleturret", 40)
    group:item("bot_bloodhound_drone", 25)
    content.add(group)
end

do
    -- The bare minimum matching suit to vist Salus. Prevents having to restart because Port Augustmoon is mising a part like the mask.
    local group = content.ItemGroup { id = "afs_frontier_cryo_g_full_augustmoon", kind = "collection" }
    group:entry {
        item = "afs_frontier_cryo",
        flags = {
            "FIT",
        },
    }
    group:entry {
        item = "afs_frontier_cryomask",
        flags = {
            "FIT",
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLO_carry", kind = "collection" }
    group:entry { item = "afs_UICASTA30", count = { 2, 2 }, charges = { 30, 30 }, ammo = { item = "afs_7.50mm_caseless" } }
    group:item("knife_folding")
    group:group("misc_smoking_legal", 33)
    group:entry {
        item = "afs_marsec_t72",
        charges = { 9, 9 },
        ammo = { item = "afs_7.50mm_caseless" },
        contents = {
            { item = "barrel_ported" },
        },
        probability = 33,
    }
    group:entry { item = "afs_HE_grenade", count = { 2, 2 }, probability = 40 }
    group:entry { item = "afs_stimpack", count = { 3, 3 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLO_wield", kind = "collection" }
    group:entry {
        item = "afs_gibrifle",
        charges = { 30, 30 },
        variant = "branded",
        ammo = { item = "afs_7.50mm_caseless" },
        contents = {
            { item = "shoulder_strap" },
            { item = "recoil_stock" },
            { item = "compensator" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_salvor_ripper_software", kind = "collection" }
    group:entry {
        item = "afs_data_shard",
        variables = { browsed = "true" },
        contents = {
            { item = "software_archiving" },
        },
    }
    group:entry {
        item = "afs_data_shard",
        variables = { browsed = "true" },
        contents = {
            { item = "software_hacking" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_salvor_ripper_computers", kind = "collection" }
    group:entry { item = "laptop", charges = { 52, 500 }, variables = { browsed = "true" }, probability = 80 }
    group:entry { item = "electrohack", charges = { 52, 500 }, probability = 80 }
    group:entry { item = "afs_wrist_computer", count = { 2, 2 }, charges = { 52, 500 }, variables = { browsed = "true" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_UICA_GROUND_ENGINEER_carry", kind = "collection" }
    group:entry {
        item = "ear_plugs",
        flags = {
            "no_auto_equip",
        },
    }
    group:entry { item = "afs_marsec_4", charges = { 14, 14 }, ammo = { item = "afs_10mm_caseless_JHP" } }
    group:entry { item = "afs_10mm_caseless_JHP", count = { 1, 2 } }
    group:entry { item = "afs_sr77_45mag", count = { 2, 2 }, charges = { 45, 45 }, ammo = { item = "afs_7.50mm_caseless" } }
    group:item("afs_plasma_torch")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_UICA_GROUND_ENGINEER_wield", kind = "collection" }
    group:entry {
        item = "afs_sr77",
        charges = { 45, 45 },
        variant = "military",
        ammo = { item = "afs_7.50mm_caseless" },
        contents = {
            { item = "shoulder_strap" },
            { item = "suppressor" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_UICA_GROUND_SOLDIER_carry", kind = "collection" }
    group:entry {
        item = "ear_plugs",
        flags = {
            "no_auto_equip",
        },
    }
    group:entry { item = "afs_marsec_4", charges = { 14, 14 }, ammo = { item = "afs_10mm_caseless_JHP" } }
    group:entry { item = "afs_10mm_caseless_JHP", count = { 1, 2 } }
    group:entry { item = "afs_sr77_45mag", count = { 2, 2 }, charges = { 45, 45 }, ammo = { item = "afs_7.50mm_caseless" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_UICA_GROUND_SOLDIER_wield", kind = "collection" }
    group:entry {
        item = "afs_sr77",
        charges = { 45, 45 },
        variant = "military",
        ammo = { item = "afs_7.50mm_caseless" },
        contents = {
            { item = "shoulder_strap" },
            { item = "suppressor" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_UICA_NAVAL_POLICE_carry", kind = "collection" }
    group:entry {
        item = "ear_plugs",
        flags = {
            "no_auto_equip",
        },
    }
    group:entry { item = "afs_marsec_4", charges = { 14, 14 }, ammo = { item = "afs_10mm_caseless_JHP" } }
    group:entry { item = "afs_10mm_caseless_JHP", count = { 1, 2 } }
    group:entry { item = "shot_00", count = { 2, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_UICA_NAVAL_POLICE_wield", kind = "collection" }
    group:entry {
        item = "afs_shotgun",
        charges = { 9, 9 },
        variant = "military",
        ammo = { item = "shot_00" },
        contents = {
            { item = "shoulder_strap" },
            { item = "suppressor" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "augustmoon_kit",
        kind = "collection",
        with_ammo = 100,
        with_magazine = 100,
        container = "afs_augustmoon_kit_box",
        overflow = "spill",
    }
    group:item("knife_folding")
    group:entry { group = "afs_escapepod_ration_bag_plastic_4", count = { 2, 2 } }
    group:item("flashlight")
    group:entry {
        item = "afs_frontier_cryomask",
        flags = {
            "FIT",
        },
    }
    group:entry {
        item = "afs_frontier_cryo",
        flags = {
            "FIT",
        },
    }
    group:item("backpack")
    group:item("afs_thermos")
    group:item("multi_cooker")
    group:entry { item = "afs_seyfert_84K", container = "holster" }
    group:item("afs_10mm_caseless_FMJ")
    content.add(group)
end
