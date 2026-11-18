local content = require("ccb").content

do
    -- a list of all plates that could be sold in stores
    local group = content.ItemGroup { id = "armor_plates", kind = "distribution" }
    group:item("esapi_plate", 50)
    group:item("stab_plate", 50)
    group:item("steel_ballistic_plate", 50)
    group:item("heavy_steel_ballistic_plate", 50)
    group:item("esbi_plate", 50)
    content.add(group)
end

do
    -- plate that is either broken or working
    local group = content.ItemGroup { id = "maybe_esapi_plate", kind = "distribution" }
    group:item("esapi_plate", 50)
    group:item("destroyed_large_ceramic_plate", 50)
    content.add(group)
end

do
    -- plate that is either broken or working
    local group = content.ItemGroup { id = "maybe_esbi_plate", kind = "distribution" }
    group:item("esbi_plate", 50)
    group:item("destroyed_medium_ceramic_plate", 50)
    content.add(group)
end

do
    -- ESAPI plates for full vest
    local group = content.ItemGroup { id = "some_esapi_plates", kind = "collection" }
    group:group("maybe_esapi_plate")
    group:group("maybe_esapi_plate")
    group:group("maybe_esbi_plate")
    group:group("maybe_esbi_plate")
    content.add(group)
end

do
    -- ESAPI plates for light vest
    local group = content.ItemGroup { id = "some_esapi_front_plates", kind = "collection" }
    group:group("maybe_esapi_plate")
    group:group("maybe_esapi_plate")
    content.add(group)
end

do
    -- ESAPI plates for light vest
    local group = content.ItemGroup { id = "some_steel_front_plates", kind = "collection" }
    group:entry { item = "steel_ballistic_plate", damage = { 0, 2 } }
    group:entry { item = "steel_ballistic_plate", damage = { 0, 2 } }
    content.add(group)
end

do
    -- ESAPI plates for light vest
    local group = content.ItemGroup { id = "some_heavy_steel_front_plates", kind = "collection" }
    group:entry { item = "heavy_steel_ballistic_plate", damage = { 0, 2 } }
    group:entry { item = "heavy_steel_ballistic_plate", damage = { 0, 2 } }
    content.add(group)
end

do
    -- ESAPI plates for light vest
    local group = content.ItemGroup { id = "some_stab_front_plates", kind = "collection" }
    group:entry { item = "stab_plate", damage = { 0, 2 } }
    group:entry { item = "stab_plate", damage = { 0, 2 } }
    content.add(group)
end

do
    -- ESAPI plates for full vest
    local group = content.ItemGroup { id = "pristine_esapi_plates", kind = "collection" }
    group:item("esapi_plate")
    group:item("esapi_plate")
    group:item("esbi_plate")
    group:item("esbi_plate")
    content.add(group)
end

do
    -- ESAPI plates for light vest
    local group = content.ItemGroup { id = "pristine_esapi_front_plates", kind = "collection" }
    group:item("esapi_plate")
    group:item("esapi_plate")
    content.add(group)
end

do
    -- Shoulder and groin protectors for heavy vest
    local group = content.ItemGroup { id = "ballistic_protectors", kind = "collection" }
    group:item("iotv_groin_plate")
    group:item("iotv_shoulder_plate")
    group:item("iotv_neck_plate")
    content.add(group)
end

do
    -- ESAPI plates and protectors for heavy vest and pouches
    local group = content.ItemGroup { id = "kitted_heavy_vest", kind = "collection" }
    group:group("pristine_esapi_plates")
    group:group("custom_heavy_lbv")
    group:group("ballistic_protectors")
    content.add(group)
end

do
    -- ESAPI plates and protectors for heavy vest and pouches
    local group = content.ItemGroup { id = "used_kitted_heavy_vest", kind = "collection" }
    group:group("some_esapi_plates")
    group:group("custom_heavy_lbv")
    group:entry { group = "ballistic_protectors", damage = { 0, 2 } }
    content.add(group)
end

do
    -- ESAPI plates for full vest and pouches
    local group = content.ItemGroup { id = "used_kitted_medium_vest", kind = "collection" }
    group:group("some_esapi_plates")
    group:group("custom_medium_lbv")
    content.add(group)
end

do
    -- ESAPI plates for full vest and pouches
    local group = content.ItemGroup { id = "kitted_medium_vest", kind = "collection" }
    group:group("pristine_esapi_plates")
    group:group("custom_medium_lbv")
    content.add(group)
end

do
    -- ESAPI plates for full vest and pouches
    local group = content.ItemGroup { id = "kitted_light_vest", kind = "collection" }
    group:group("pristine_esapi_front_plates")
    group:group("custom_light_lbv")
    content.add(group)
end

do
    -- ESAPI plates for full vest and pouches
    local group = content.ItemGroup { id = "used_kitted_light_vest", kind = "collection" }
    group:group("some_esapi_front_plates")
    group:group("custom_light_lbv")
    content.add(group)
end

do
    -- ESAPI vest plus plates
    local group = content.ItemGroup { id = "military_ballistic_vest", kind = "distribution" }
    group:entry {
        distribution = {
            {
                item = "ballistic_vest_esapi",
                variant = "us_ballistic_vest",
                contents = {
                    { group = "used_kitted_medium_vest" },
                },
            },
            {
                collection = {
                    {
                        item = "ballistic_vest_esapi",
                        variant = "us_ballistic_vest",
                        contents = {
                            { group = "some_esapi_plates" },
                        },
                    },
                    { group = "loaded_lbv" },
                },
                probability = 50,
            },
        },
        probability = 40,
    }
    group:entry {
        collection = {
            {
                item = "level_3_vest",
                variant = "national_guard_armor_vest",
                contents = {
                    { group = "some_esapi_front_plates" },
                },
            },
            { group = "loaded_lbv" },
        },
        probability = 50,
    }
    group:group("military_ballistic_vest_light", 10)
    group:group("military_ballistic_vest_heavy", 5)
    content.add(group)
end

do
    -- ESAPI vest plus plates
    local group = content.ItemGroup { id = "swat_ballistic_vest", kind = "distribution" }
    group:entry {
        item = "ballistic_vest_esapi",
        variant = "swat_ballistic_vest",
        contents = {
            { group = "used_kitted_medium_vest" },
        },
        probability = 7,
    }
    group:entry {
        collection = {
            {
                item = "ballistic_vest_esapi",
                variant = "swat_ballistic_vest",
                contents = {
                    { group = "some_esapi_plates" },
                },
            },
            { item = "tacvest" },
        },
        probability = 2,
    }
    group:entry {
        collection = {
            {
                item = "ballistic_vest_esapi",
                variant = "swat_ballistic_vest",
                contents = {
                    { group = "some_esapi_plates" },
                },
            },
            {
                item = "heavy_load_bearing_vest_breacher",
                contents = {
                    { item = "mossberg_590_shockwave" },
                    { group = "custom_light_lbv" },
                },
            },
        },
        probability = 1,
    }
    content.add(group)
end

do
    -- ESAPI vest plus plates
    local group = content.ItemGroup { id = "swat_ballistic_vest_pristine", kind = "distribution" }
    group:entry {
        item = "ballistic_vest_esapi",
        variant = "swat_ballistic_vest",
        contents = {
            { group = "kitted_medium_vest" },
        },
    }
    content.add(group)
end

do
    -- ESAPI vest plus plates
    local group = content.ItemGroup { id = "us_ballistic_vest_pristine", kind = "collection" }
    group:entry {
        item = "ballistic_vest_esapi",
        variant = "us_ballistic_vest",
        contents = {
            { group = "kitted_medium_vest" },
        },
    }
    content.add(group)
end

do
    -- light ballistic vests with assorted plates
    local group = content.ItemGroup { id = "contractor_ballistic_vest_light", kind = "distribution" }
    group:entry {
        item = "ballistic_vest_light",
        contents = {
            { group = "kitted_light_vest" },
        },
        probability = 50,
    }
    group:entry {
        item = "ballistic_vest_light_pouches",
        contents = {
            { group = "kitted_light_vest" },
        },
        probability = 50,
    }
    group:entry {
        item = "ballistic_vest_light_operator",
        contents = {
            { group = "kitted_light_vest" },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- light ballistic vests you could get away with in the army
    local group = content.ItemGroup { id = "military_ballistic_vest_light", kind = "distribution" }
    group:entry {
        item = "ballistic_vest_light",
        variant = "ballistic_vest_light_tan",
        contents = {
            { group = "used_kitted_light_vest" },
        },
        probability = 50,
    }
    group:entry {
        item = "ballistic_vest_light",
        variant = "ballistic_vest_light_olive",
        contents = {
            { group = "used_kitted_light_vest" },
        },
        probability = 50,
    }
    group:entry {
        item = "ballistic_vest_light_pouches",
        variant = "ballistic_vest_light_tan",
        contents = {
            { group = "used_kitted_light_vest" },
        },
        probability = 50,
    }
    group:entry {
        item = "ballistic_vest_light_pouches",
        variant = "ballistic_vest_light_olive",
        contents = {
            { group = "used_kitted_light_vest" },
        },
        probability = 50,
    }
    group:entry {
        item = "ballistic_vest_light_operator",
        variant = "ballistic_vest_light_tan",
        contents = {
            { group = "used_kitted_light_vest" },
        },
        probability = 50,
    }
    group:entry {
        item = "ballistic_vest_light_operator",
        variant = "ballistic_vest_light_olive",
        contents = {
            { group = "used_kitted_light_vest" },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- light ballistic vests you could get away with in the army
    local group = content.ItemGroup { id = "military_ballistic_vest_light_pristine", kind = "distribution" }
    group:entry {
        item = "ballistic_vest_light",
        variant = "ballistic_vest_light_tan",
        contents = {
            { group = "kitted_light_vest" },
        },
        probability = 50,
    }
    group:entry {
        item = "ballistic_vest_light",
        variant = "ballistic_vest_light_olive",
        contents = {
            { group = "kitted_light_vest" },
        },
        probability = 50,
    }
    group:entry {
        item = "ballistic_vest_light_pouches",
        variant = "ballistic_vest_light_tan",
        contents = {
            { group = "kitted_light_vest" },
        },
        probability = 50,
    }
    group:entry {
        item = "ballistic_vest_light_pouches",
        variant = "ballistic_vest_light_olive",
        contents = {
            { group = "kitted_light_vest" },
        },
        probability = 50,
    }
    group:entry {
        item = "ballistic_vest_light_operator",
        variant = "ballistic_vest_light_tan",
        contents = {
            { group = "kitted_light_vest" },
        },
        probability = 50,
    }
    group:entry {
        item = "ballistic_vest_light_operator",
        variant = "ballistic_vest_light_olive",
        contents = {
            { group = "kitted_light_vest" },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- light ballistic vest plus plates
    local group = content.ItemGroup { id = "ballistic_vest_light_pristine", kind = "collection" }
    group:entry {
        item = "ballistic_vest_light",
        contents = {
            { group = "kitted_light_vest" },
        },
    }
    content.add(group)
end

do
    -- heavy ballistic vest plus plates
    local group = content.ItemGroup { id = "military_ballistic_vest_heavy_pristine", kind = "collection" }
    group:entry {
        item = "ballistic_vest_heavy",
        contents = {
            { group = "kitted_heavy_vest" },
        },
    }
    content.add(group)
end

do
    -- heavy xedra ballistic vest plus plates
    local group = content.ItemGroup { id = "xedra_ballistic_vest_heavy_pristine", kind = "collection" }
    group:entry {
        item = "ballistic_vest_heavy",
        variant = "ballistic_vest_heavy_xedra",
        contents = {
            { group = "kitted_heavy_vest" },
        },
    }
    content.add(group)
end

do
    -- heavy ballistic vest plus plates
    local group = content.ItemGroup { id = "military_ballistic_vest_heavy", kind = "collection" }
    group:entry {
        item = "ballistic_vest_heavy",
        contents = {
            { group = "used_kitted_heavy_vest" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "military_standard_sniper_rifles", kind = "distribution" }
    group:entry { item = "m2010", charges = { 0, 5 }, probability = 20 }
    group:entry { item = "m110a1", charges = { 0, 20 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "infantry_common_gear_feral", kind = "collection" }
    group:item("e_tool", 60)
    group:item("military_poncho", 40)
    group:item("military_poncho_heavy", 40)
    group:item("military_poncho_liner", 40)
    group:group("gasmask_bag_full", 20)
    group:group("military_papr_kit", 5)
    group:entry { item = "two_way_radio", charges = { 0, 100 }, probability = 60 }
    group:group("infantry_knives")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "infantry_knives", kind = "distribution", container = "sheath" }
    group:item("knife_combat", 30)
    group:item("knife_combat_army", 50, "m9bayonet")
    group:item("knife_combat_marine", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xedra_kill_team_set", kind = "collection" }
    group:group("clothing_military")
    group:item("resonance_measurement_device", 10)
    group:item("elbow_pads", 80)
    group:item("knee_pads", 85)
    group:entry {
        distribution = {
            { group = "tac_helmet_nvg", probability = 60 },
            { item = "tac_helmet", probability = 40 },
        },
    }
    group:group("molle_papr_kit", 90)
    group:item("gloves_tactical", 80)
    group:group("xedra_ballistic_vest_heavy_pristine")
    group:group("clothing_tactical_leg", 80)
    group:group("clothing_watch", 45)
    group:item("glasses_bal", 30)
    group:group("xedra_gun")
    group:group("cop_melee")
    group:group("cop_holster_field")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "army_bed", kind = "distribution" }
    group:item("blanket", 70)
    group:item("military_poncho_liner", 20)
    group:item("pillow", 70)
    group:item("sheet", 70)
    group:item("mag_porn", 40)
    group:item("mag_comic", 10)
    group:item("mag_guns", 10)
    group:item("manual_brawl", 5)
    group:item("manual_melee", 5)
    group:item("manual_knives", 5)
    group:item("manual_swords", 5)
    group:item("manual_gun", 5)
    group:item("manual_shotgun", 5)
    group:item("manual_rifle", 5)
    group:item("manual_pistol", 5)
    group:item("manual_traps_mil", 5)
    group:item("manual_traps_mil_basic", 5)
    group:item("mag_pistol", 10)
    group:item("mag_rifle", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mil_food_nodrugs", kind = "distribution" }
    group:group("MRE", 1035)
    group:group("chocolate_wrapper_3", 20)
    group:group("neccowafers_bag_plastic_3", 30)
    group:group("beans_in_can", 40)
    group:group("pork_beans_in_can", 40)
    group:entry {
        distribution = {
            { group = "full_ifak" },
            { group = "used_ifak" },
        },
        probability = 35,
    }
    group:item("saline", 10)
    group:item("instant_coffee", 25)
    group:item("con_milk", 10)
    group:group("milk_in_container", 25)
    group:group("breakfast_cereal_in_box_full", 20)
    group:group("breakfast_cereal_in_box_full", 20)
    group:item("sports_drink", 40)
    group:item("water_clean", 90)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "inactive_bots_milspec", kind = "distribution" }
    group:item("bot_EMP_hack")
    group:item("bot_c4_hack", 25)
    group:item("bot_flashbang_hack", 50)
    group:item("bot_gasbomb_hack", 50)
    group:item("bot_grenade_hack", 50)
    group:item("bot_antimateriel", 5)
    group:item("bot_rifleturret", 10)
    group:item("bot_crows_m240", 10)
    group:item("bot_talon_m202a1", 10)
    group:item("bot_dispatch_military", 15)
    group:item("bot_turret_searchlight", 75)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "maps_milspec", kind = "distribution" }
    group:item("militarymap")
    group:item("satellitemap")
    content.add(group)
end

do
    -- same as supplies_mechanics, but mostly for heavy vehicle
    local group = content.ItemGroup { id = "supplies_mechanics_milspec", kind = "distribution" }
    group:item("v_airjack_item", 20)
    group:item("jumper_cable", 15)
    group:item("jumper_cable_heavy", 5)
    group:item("frame", 10)
    group:item("hd_tow_cable", 5)
    group:item("hdframe", 20)
    group:item("motor", 2)
    group:item("wheel", 10)
    group:entry { item = "polycarbonate_sheet", count = { 1, 3 }, probability = 4 }
    group:group("glue_weak_professional")
    group:item("vac_mold", 1)
    group:item("wheel_wide", 10)
    group:item("wheel_small", 10)
    group:item("wheel_wide_or", 5)
    group:item("tire_medium", 10)
    group:item("tire_wide", 5)
    group:item("tire_wide_or", 5)
    group:item("deflated_wheel", 10)
    group:item("deflated_wheel_wide_or", 5)
    group:item("wheel_rim_medium", 5)
    group:item("wheel_rim_wide", 5)
    group:item("1cyl_combustion", 1)
    group:item("engine_1cyl_diesel_large", 10)
    group:item("v2_combustion", 2)
    group:item("i4_combustion", 2)
    group:item("v6_combustion", 10)
    group:item("v6_diesel", 10)
    group:item("aero_engine_light", 1)
    group:item("vehicle_controls", 3)
    group:item("horn_car", 1)
    group:item("horn_big", 1)
    group:item("v8_combustion", 7)
    group:item("v8_diesel", 7)
    group:item("v12_combustion", 5)
    group:item("v12_diesel", 5)
    group:item("small_turbine_engine", 7)
    group:item("medium_turbine_engine", 5)
    group:item("large_turbine_engine", 3)
    group:item("veh_tools_workshop", 1)
    group:item("welder", 1)
    group:item("soldering_iron", 1)
    group:item("soldering_iron", 1)
    group:entry { item = "soldering_iron_portable", charges = { 0, 50 }, probability = 1 }
    group:item("solar_cell", 1)
    group:item("bearing", 1)
    group:item("headlight_reinforced", 10)
    group:item("motor_large", 1)
    group:item("battery_car", 6)
    group:item("alternator_car", 6)
    group:item("alternator_truck", 6)
    group:item("hd_tow_cable", 1)
    group:item("storage_battery", 6)
    group:item("motor_oil")
    group:item("solar_panel", 3)
    group:item("recharge_station", 8)
    content.add(group)
end

do
    -- for National Guardsman start
    local group = content.ItemGroup { id = "guardsman_profession_bag", kind = "collection", container = "duffelbag" }
    group:item("backpack")
    group:item("helmet_army")
    group:item("jacket_army_modern")
    group:item("pants_army")
    group:entry { item = "tshirt", count = { 3, 3 } }
    group:item("under_armor")
    group:item("tacvest")
    group:item("coat_rain")
    group:item("hood_rain")
    group:item("long_underpants")
    group:item("towel")
    group:item("boots_combat")
    group:entry { item = "socks", count = { 3, 3 } }
    group:item("gloves_tactical")
    group:group("batteries")
    group:entry { item = "flashlight", charges = { 150, 150 } }
    group:entry { item = "light_battery_cell", charges = { 150, 150 }, container = "radio" }
    group:entry { item = "lighter", charges = { 100, 100 } }
    group:item("pockknife")
    group:item("multitool")
    group:group("full_ifak")
    group:item("rollmat")
    group:item("sleeping_bag_roll")
    group:item("ear_plugs")
    group:entry { group = "MRE", count = { 3, 3 } }
    group:entry { item = "water_clean", count = { 2, 2 }, charges = { 2, 2 }, sealed = false, container = "bottle_plastic" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "military_grenadier_assault_rifles", kind = "distribution" }
    group:entry {
        group = "modular_m4a1",
        charges = { 0, 30 },
        contents = {
            { group = "issued_grenadier_mods" },
        },
    }
    content.add(group)
end

do
    -- ESAPI vest plus plates
    local group = content.ItemGroup { id = "military_ballistic_vest_pristine", kind = "collection" }
    group:entry {
        distribution = {
            {
                item = "ballistic_vest_esapi",
                variant = "us_ballistic_vest",
                contents = {
                    { group = "kitted_medium_vest" },
                },
            },
            {
                collection = {
                    {
                        item = "ballistic_vest_esapi",
                        variant = "us_ballistic_vest",
                        contents = {
                            { group = "pristine_esapi_plates" },
                        },
                    },
                    { group = "loaded_lbv" },
                },
                probability = 50,
            },
        },
        probability = 40,
    }
    group:entry {
        collection = {
            {
                item = "level_3_vest",
                variant = "national_guard_armor_vest",
                contents = {
                    { group = "pristine_esapi_front_plates" },
                },
            },
            { group = "loaded_lbv" },
        },
        probability = 50,
    }
    group:group("military_ballistic_vest_light_pristine", 10)
    group:group("military_ballistic_vest_heavy_pristine", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mil_food", kind = "distribution" }
    group:group("mil_food_nodrugs", 1410)
    group:group("codeine_bottle_plastic_pill_painkiller_1_10", 15)
    group:group("antibiotics_bottle_plastic_pill_prescription_1_15", 25)
    group:item("purifier", 12)
    group:item("heatpack", 60)
    group:group("pur_tablets_bottle_plastic_small_1_50", 20)
    group:group("fungicide_bag_plastic_400", 5)
    group:group("insecticide_bag_plastic", 5)
    group:entry { item = "oxygen_tank", charges = { 0, 24 }, probability = 10 }
    group:entry { item = "smoxygen_tank", charges = { 0, 12 }, probability = 20 }
    group:group("bfipowder_bottle_plastic_small_1_4", 15)
    group:group("quikclot_bag_plastic_1_6", 10)
    group:group("weak_antibiotic_bottle_plastic_pill_prescription_1_5", 40)
    group:entry { item = "prophylactic_antivenom", count = { 5, 5 }, probability = 5 }
    content.add(group)
end
