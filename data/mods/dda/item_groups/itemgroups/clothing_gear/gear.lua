local content = require("ccb").content

do
    local group = content.ItemGroup {
        id = "wrapped_gasmask_filter",
        kind = "collection",
        with_ammo = 100,
        container = "wrapping_vacuumed",
        overflow = "spill",
    }
    group:item("gasfilter_med")
    content.add(group)
end

do
    -- These are accessories grouped together for use in stashed-away or unused gas mask bags.
    -- Vision correction assemblies have been omitted for handling within the gas mask bag item group itself.
    local group = content.ItemGroup { id = "gasmask_inserts_stowed", kind = "distribution" }
    group:item("outsert_clear")
    group:item("outsert_sunlight", 50)
    group:item("outsert_breach", 25)
    content.add(group)
end

do
    -- Accessories grouped together for use as pre-installed spawns within gas masks.
    local group = content.ItemGroup { id = "gasmask_inserts_in_use", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "outsert_clear" },
            { item = "outsert_sunlight", probability = 50 },
            { item = "outsert_breach", probability = 25 },
        },
    }
    group:item("insert_vision_correction", 30)
    content.add(group)
end

do
    -- This is a stowed-away gas mask in its carrier, packed with all its equipment but unused and unassembled. Groups together a gas mask, a spare filter, and loose accessories.
    -- The gas mask doesn't have its own filter installed, so a second one is sitting ready in the pouch for the user to assemble.
    local group = content.ItemGroup {
        id = "gasmask_bag_full",
        kind = "collection",
        with_ammo = 100,
        with_magazine = 0,
        container = "gas_mask_pouch",
        overflow = "spill",
    }
    group:item("mask_gas")
    group:entry { group = "wrapped_gasmask_filter", count = { 2, 2 } }
    group:group("gasmask_inserts_stowed", 90)
    group:item("insert_vision_correction", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "papr_kit", kind = "distribution" }
    group:item("basic_papr_helmet")
    group:item("basic_papr_belt_off")
    group:group("wrapped_gasmask_filter")
    group:item("medium_battery_cell")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "military_papr_kit", kind = "distribution" }
    group:item("military_papr_mask")
    group:item("military_papr_blower_off")
    group:group("wrapped_gasmask_filter")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "molle_papr_kit", kind = "distribution" }
    group:item("military_papr_mask")
    group:item("molle_papr_blower_off")
    group:group("wrapped_gasmask_filter")
    group:item("modular_papr_strap")
    content.add(group)
end

do
    -- A gas mask left in its carrier, but that was in use prior to being found: assumed that the former user had required it or anticipated needing it and assembled it in readiness. The spare filter may be absent, a canister's already been loaded into the gas mask, and there's a greater chance that the loose attachments have already been added to the mask.
    local group = content.ItemGroup {
        id = "gasmask_bag_used",
        kind = "collection",
        with_ammo = 100,
        container = "gas_mask_pouch",
        overflow = "spill",
    }
    group:entry {
        distribution = {
            { item = "mask_gas", charges = { 0, 100 }, probability = 40 },
            {
                item = "mask_gas",
                charges = { 0, 100 },
                contents = {
                    { group = "gasmask_inserts_in_use" },
                },
                probability = 60,
            },
        },
    }
    group:group("wrapped_gasmask_filter", 50)
    group:group("gasmask_inserts_stowed", 55)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "army_helmet_nvg", kind = "collection" }
    group:entry {
        item = "helmet_army",
        contents = {
            { group = "nvg_distribution" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tac_helmet_nvg", kind = "collection" }
    group:entry {
        item = "tac_helmet",
        contents = {
            { group = "nvg_distribution" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nvg_distribution", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "military_nvg", charges = { 0, 100 }, probability = 60 },
            { item = "advanced_gpnvg", charges = { 0, 100 }, probability = 30 },
            { item = "enhanced_nvg", charges = { 0, 100 }, probability = 10 },
        },
    }
    content.add(group)
end

do
    -- Medical equipment including consumables but not major painkillers
    local group = content.ItemGroup { id = "gear_medical", kind = "distribution" }
    group:group("tools_medical")
    group:group("drugs_heal_simple", 40)
    group:group("drugs_emergency", 40)
    group:group("drugs_misc", 20)
    group:item("gloves_medical", 5)
    group:item("mask_dust", 5)
    content.add(group)
end

do
    -- Sidearm and appropriate holster or sheath for soldiers or other paramilitary forces.
    local group = content.ItemGroup { id = "gear_soldier_sidearm", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "PR24-retracted", probability = 20 },
            { group = "infantry_knives", probability = 14 },
            {
                collection = {
                    { group = "guns_pistol_milspec" },
                    { item = "holster" },
                },
                probability = 50,
            },
        },
    }
    content.add(group)
end

do
    -- gear needed for bomb defusal.  Based on ATP 4-32.  Intentionally stripped of more military items for placement in civilian locations.
    local group = content.ItemGroup { id = "gear_eod", kind = "collection" }
    group:item("EOD_hotstick", 50)
    group:entry { item = "multitool", container = "sheath", probability = 30 }
    group:entry { item = "light_battery_cell", count = { 1, 8 }, probability = 30 }
    group:entry { item = "light_minus_disposable_cell", count = { 1, 6 }, probability = 20 }
    group:item("cordless_drill", 30)
    group:item("rope_30", 50)
    group:item("pliers", 50)
    group:group("new_laptops", 70)
    group:group("cable_roll_part", 40)
    group:group("copper_wire_roll_part", 30)
    group:item("manual_traps_mil", 80)
    group:group("gear_eod_light_or_heavy")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "gear_eod_light_or_heavy",
        kind = "distribution",
        container = "duffelbag",
        overflow = "spill",
    }
    group:group("eod_duffle", 90)
    group:group("eod_duffle_light", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "eod_duffle", kind = "collection" }
    group:item("trousers_eod")
    group:entry { item = "eod_plate", container = "jacket_eod" }
    group:item("helmet_eod")
    group:item("foot_protectors_eod", 80)
    group:item("gloves_eod", 20)
    group:item("eod_plate", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "eod_duffle_light", kind = "collection" }
    group:entry {
        item = "jacket_eod_light",
        contents = {
            { group = "eod_tactical_plates_set" },
        },
    }
    group:item("trousers_eod_light")
    group:item("face_shield_eod")
    group:item("eod_plate", 5)
    content.add(group)
end

do
    -- complete EOD plate set for the tactical EOD jacket
    local group = content.ItemGroup { id = "eod_tactical_plates_set", kind = "collection" }
    group:item("eod_plate")
    group:item("deltoid_plates")
    content.add(group)
end

do
    -- This group is for lockers storing safety gear for woodcrafts. SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    local group = content.ItemGroup { id = "SUS_woodcrafts_gear", kind = "collection" }
    group:item("glasses_safety", 95)
    group:item("mask_dust", 30)
    group:item("gloves_work", 30)
    group:item("apron_leather", 95)
    group:item("apron_cut_resistant", 15)
    group:item("chaps_cut_resistant", 25)
    group:item("armguard_cut_resistant", 25)
    group:item("balaclava_cut_resistant", 5)
    group:item("throat_guard_cut_resistant", 2)
    content.add(group)
end

do
    -- armor that a civilian might have.
    local group = content.ItemGroup { id = "civilian_armor", kind = "distribution" }
    group:group("civilian_face_armor", 20)
    group:group("civilian_body_armor", 20)
    content.add(group)
end

do
    -- armor that a civilian might have.
    local group = content.ItemGroup { id = "civilian_ballistic_inserts", kind = "distribution" }
    group:group("some_steel_front_plates", 30)
    group:group("some_stab_front_plates", 45)
    group:group("pristine_esapi_front_plates", 25)
    content.add(group)
end

do
    -- armor that a civilian might have.
    local group = content.ItemGroup { id = "civilian_face_armor", kind = "distribution" }
    group:entry { item = "mask_gas", charges = { 100, 100 }, probability = 20 }
    group:item("mask_dust", 20)
    group:item("glasses_bal", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "full_oxygen_tank", kind = "collection" }
    group:entry { item = "oxygen_tank", charges = { 24, 24 } }
    content.add(group)
end
