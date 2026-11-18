local content = require("ccb").content

do
    -- Standard (non-winter) set of clothes and combat gear worn by soldiers and paramilitary forces.
    -- TODO: Check these are up to date and can't just add onto the vanilla versions using copy-from
    local group = content.ItemGroup { id = "clothing_soldier_set_no_hope", kind = "collection" }
    group:group("clothing_military_no_hope")
    group:item("elbow_pads", 10)
    group:item("knee_pads", 60)
    group:item("helmet_army", 60)
    group:item("gloves_tactical", 60)
    group:item("ballistic_vest_esapi", 20)
    group:item("molle_pack", 60)
    group:group("clothing_tactical_leg", 15)
    group:entry {
        distribution = {
            { group = "clothing_glasses", probability = 60 },
            { item = "glasses_bal", probability = 30 },
            { item = "goggles_nv", probability = 5 },
            { item = "goggles_ir", probability = 5 },
        },
        probability = 20,
    }
    group:group("clothing_watch", 5)
    content.add(group)
end

do
    -- Winter set of clothes and combat gear worn by soldiers and paramilitary forces.
    local group = content.ItemGroup { id = "clothing_soldier_winter_set_no_hope", kind = "collection" }
    group:group("clothing_military_winter_no_hope")
    group:item("elbow_pads", 10)
    group:item("knee_pads", 60)
    group:entry {
        collection = {
            { item = "helmet_army" },
            { item = "helmet_liner" },
        },
        probability = 60,
    }
    group:entry {
        collection = {
            { item = "gloves_liner", probability = 20 },
            { item = "winter_gloves_army" },
        },
        probability = 60,
    }
    group:item("ballistic_vest_esapi", 20)
    group:item("molle_pack", 60)
    group:group("clothing_tactical_leg", 15)
    group:entry {
        distribution = {
            { group = "clothing_glasses", probability = 60 },
            { item = "glasses_bal", probability = 30 },
            { item = "goggles_nv", probability = 5 },
            { item = "goggles_ir", probability = 5 },
        },
        probability = 20,
    }
    group:group("clothing_watch", 5)
    content.add(group)
end

do
    -- Standard (non-winter) set of clothes worn by soldiers and paramilitary forces.
    local group = content.ItemGroup { id = "clothing_military_no_hope", kind = "collection" }
    group:group("clothing_soldier_shirt", 90)
    group:item("jacket_army", 70)
    group:item("pants_army", 80)
    group:item("webbing_belt", 50)
    group:entry {
        distribution = {
            { item = "socks", probability = 95 },
            { item = "socks_wool", probability = 5 },
        },
        probability = 90,
    }
    group:item("boots_combat", 70)
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "sports_bra" },
                    { item = "boy_shorts" },
                },
            },
            {
                distribution = {
                    { item = "briefs" },
                    { item = "boxer_briefs" },
                    { item = "boxer_shorts" },
                },
            },
        },
    }
    content.add(group)
end

do
    -- Winter set of clothes worn by soldiers and paramilitary forces.
    local group = content.ItemGroup { id = "clothing_military_winter_no_hope", kind = "collection" }
    group:group("clothing_soldier_shirt", 90)
    group:item("winter_jacket_army", 70)
    group:item("winter_pants_army", 80)
    group:item("webbing_belt", 50)
    group:entry {
        distribution = {
            { item = "socks", probability = 10 },
            { item = "socks_wool", probability = 90 },
        },
    }
    group:item("boots_combat", 70)
    group:entry {
        collection = {
            {
                distribution = {
                    { item = "balclava", variant = "black", probability = 90 },
                    { item = "balaclava_cut_resistant", probability = 10 },
                },
            },
        },
        probability = 25,
    }
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "sports_bra" },
                    { item = "boy_shorts" },
                },
            },
            {
                distribution = {
                    { item = "briefs" },
                    { item = "boxer_briefs" },
                    { item = "boxer_shorts" },
                },
            },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nohope_fuel_jp8", kind = "distribution" }
    group:entry { item = "jp8", charges = { 0, 5000 }, container = "jerrycan", probability = 70 }
    group:entry { item = "jp8", charges = { 0, 5000 }, container = "jerrycan_big", probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_flamer", kind = "collection", with_ammo = 50, with_magazine = 100 }
    group:entry { item = "flamethrower", charges = { 0, 500 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "necropolis_visitors", kind = "distribution" }
    group:item("newest_newspaper", 10)
    group:item("necropolis_leaflet", 50)
    content.add(group)
end

do
    -- Used in the necropolis
    local group = content.ItemGroup { id = "vault_survival", kind = "distribution", with_ammo = 90, with_magazine = 100 }
    group:group("guns_common", 35)
    group:item("mask_filter", 20)
    group:group("ammo_pocket_batteries_full", 15)
    group:item("radio", 10)
    group:item("bandages", 10)
    group:item("knife_combat", 20)
    group:item("vest", 15)
    group:item("cleansuit", 20)
    group:item("rad_monitor", 10)
    group:item("geiger_off", 10)
    group:item("tool_belt", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vault_wanderer", kind = "distribution", with_ammo = 20, with_magazine = 100 }
    group:item("jumpsuit", 90)
    group:entry { item = "mask_filter", charges = { 0, 100 }, probability = 10 }
    group:group("ammo_pocket_batteries_full", 10)
    group:entry { item = "radio", charges = { 10, 95 }, probability = 10 }
    group:item("boots_combat", 20)
    group:entry { item = "bandages", count = { 1, 3 }, probability = 10 }
    group:group("cig_box_cigarette_1_20", 30)
    group:item("knife_combat_army", 10, "m9bayonet")
    group:item("vest", 15)
    group:item("glasses_safety", 15)
    group:entry { item = "9mm", charges = { 1, 50 }, probability = 15 }
    group:entry { item = "m9", charges = { 0, 15 }, probability = 10 }
    group:item("water_clean", 10)
    group:entry { item = "eyedrops", count = { 1, 10 }, probability = 10 }
    group:entry { item = "steroid_eyedrops", count = { 1, 10 }, probability = 10 }
    group:item("screwdriver", 10)
    group:group("wallets_science", 5)
    group:item("cleansuit", 10)
    group:item("coat_lab", 20)
    group:item("glasses_eye", 30)
    group:entry { item = "rad_monitor", charges = { 2, 20 }, probability = 10 }
    group:entry { item = "geiger_off", charges = { 10, 95 }, probability = 10 }
    group:item("tool_belt", 15)
    group:item("panties", 20)
    group:item("boy_shorts", 20)
    group:item("bra", 20)
    group:item("undershirt", 40)
    group:item("boxer_shorts", 30)
    group:item("briefs", 30)
    content.add(group)
end

do
    -- TODO: Check this is up to date and can't just add onto the vanilla version using copy-from
    local group = content.ItemGroup {
        id = "mon_zombie_soldier_death_drops_no_hope",
        kind = "collection",
        with_ammo = 60,
        with_magazine = 100,
    }
    group:entry {
        distribution = {
            { group = "clothing_soldier_set_no_hope", damage = { 1, 4 }, probability = 65 },
            { group = "clothing_soldier_winter_set_no_hope", damage = { 1, 4 }, probability = 35 },
        },
    }
    group:entry {
        distribution = {
            {
                group = "military_standard_assault_rifles",
                damage = { 1, 4 },
                contents = {
                    { item = "shoulder_strap" },
                },
                probability = 75,
            },
            {
                group = "military_standard_lmgs",
                damage = { 1, 4 },
                contents = {
                    { item = "shoulder_strap" },
                },
                probability = 10,
            },
            {
                group = "military_standard_shotguns",
                damage = { 1, 4 },
                contents = {
                    { item = "shoulder_strap" },
                },
                probability = 5,
            },
        },
        probability = 10,
    }
    group:entry { group = "infantry_common_gear", damage = { 1, 4 } }
    group:entry { group = "military_standard_grenades", count = { 1, 3 }, probability = 20 }
    group:group("military_patrol_food")
    group:entry {
        distribution = {
            { group = "infantry_officer_gear" },
            { group = "infantry_medical_gear" },
        },
        probability = 25,
    }
    group:entry { item = "cash_card", charges = { 0, 50000 }, probability = 10 }
    group:group("misc_smoking", 30)
    content.add(group)
end
