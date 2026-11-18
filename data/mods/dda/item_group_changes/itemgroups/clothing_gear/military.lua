local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mil_armor", kind = "distribution" }
    group:item("pants_army", 10)
    group:item("jacket_army_modern", 5)
    group:item("jacket_army_modern", 5)
    group:item("winter_pants_army", 30)
    group:item("winter_jacket_army", 30)
    group:item("winter_gloves_army", 30)
    group:item("tank_top", 30, "tank_top_camo")
    group:item("kevlar", 10)
    group:group("military_ballistic_vest", 30)
    group:item("vest", 15)
    group:group("gasmask_bag_full", 10)
    group:entry { item = "goggles_nv", charges = { 0, 100 }, probability = 1 }
    group:entry { item = "goggles_ir", charges = { 0, 100 }, probability = 1 }
    group:item("backpack", 38)
    group:entry { item = "UPS_OFF", charges = { 0, 1000 }, probability = 8 }
    group:item("tacvest", 10)
    group:group("molle_backpacks_and_accessories", 8)
    group:item("duffelbag", 15)
    group:group("large_duffelbags", 5)
    group:item("dump_pouch", 20)
    group:item("legrig", 10)
    group:item("under_armor", 20)
    group:item("boots", 70)
    group:item("boots_combat", 70)
    group:item("gloves_tactical", 30)
    group:item("glasses_bal", 40)
    group:item("chestguard_hard", 20)
    group:item("armguard_hard", 20)
    group:item("legguard_hard", 15)
    group:group("army_helmet_nvg", 1)
    group:item("helmet_army", 40)
    group:item("helmet_liner", 10)
    group:item("mask_bal", 5)
    group:item("beret", 50)
    group:item("beret_wool", 40)
    group:item("elbow_pads", 50)
    group:item("knee_pads", 50)
    group:item("folding_solar_panel_v2", 5)
    content.add(group)
end

do
    -- Standard (non-winter) set of clothes and combat gear worn by soldiers and paramilitary forces.
    local group = content.ItemGroup { id = "clothing_soldier_set", kind = "collection" }
    group:group("clothing_military")
    group:item("elbow_pads", 10)
    group:item("knee_pads", 85)
    group:entry {
        distribution = {
            { group = "army_helmet_nvg", probability = 15 },
            { item = "helmet_army", probability = 85 },
        },
        probability = 80,
    }
    group:item("gloves_tactical", 60)
    group:group("military_ballistic_vest", 90)
    group:group("molle_backpacks_and_accessories", 85)
    group:group("clothing_tactical_leg", 15)
    group:entry {
        distribution = {
            { group = "clothing_glasses", probability = 60 },
            { item = "glasses_bal", probability = 30 },
        },
        probability = 20,
    }
    group:group("clothing_watch", 5)
    content.add(group)
end

do
    -- Winter set of clothes and combat gear worn by soldiers and paramilitary forces.
    local group = content.ItemGroup { id = "clothing_soldier_winter_set", kind = "collection" }
    group:group("clothing_military_winter")
    group:item("elbow_pads", 10)
    group:item("knee_pads", 85)
    group:entry {
        collection = {
            {
                distribution = {
                    { group = "army_helmet_nvg", probability = 15 },
                    { item = "helmet_army", probability = 85 },
                },
            },
            { item = "helmet_liner" },
        },
        probability = 80,
    }
    group:entry {
        collection = {
            { item = "gloves_liner", probability = 60 },
            { item = "winter_gloves_army" },
        },
        probability = 80,
    }
    group:group("military_ballistic_vest", 90)
    group:group("molle_backpacks_and_accessories", 85)
    group:group("clothing_tactical_leg", 15)
    group:entry {
        distribution = {
            { group = "clothing_glasses", probability = 60 },
            { item = "glasses_bal", probability = 30 },
        },
        probability = 20,
    }
    group:group("clothing_watch", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mil_accessories", kind = "distribution" }
    group:group("gasmask_bag_full", 10)
    group:item("duffelbag", 15)
    group:group("large_duffelbags", 5)
    group:entry { item = "goggles_nv", charges = { 0, 100 }, probability = 1 }
    group:entry { item = "goggles_ir", charges = { 0, 100 }, probability = 1 }
    group:entry { item = "military_nvg", charges = { 0, 100 }, probability = 1 }
    group:entry { item = "advanced_gpnvg", charges = { 0, 100 }, probability = 1 }
    group:entry { item = "enhanced_nvg", charges = { 0, 100 }, probability = 1 }
    group:item("optical_cloak", 1)
    group:entry { item = "holo_cloak", charges = { 0, 1000 }, probability = 1 }
    group:item("mess_kit", 9)
    group:item("backpack", 38)
    group:item("briefcase", 10)
    group:entry { item = "UPS_OFF", charges = { 0, 1000 }, probability = 8 }
    group:item("chestguard_hard", 20)
    group:item("armguard_hard", 20)
    group:item("legguard_hard", 15)
    group:item("power_armor_frame", 4)
    group:item("power_armor_generator", 4)
    group:item("elbow_pads", 40)
    group:item("knee_pads", 40)
    group:item("mask_bal", 5)
    group:item("e_tool", 10)
    group:item("grapnel", 3)
    group:item("glasses_bal", 30)
    group:item("sheath", 10)
    group:item("bootsheath", 8)
    group:item("nylon_holster", 15)
    group:item("sholster", 10)
    group:item("shoulder_holster", 1)
    group:item("bandolier_shotgun", 8)
    group:item("torso_bandolier_grenade", 8)
    group:item("chem_hexamine", 3)
    group:entry { item = "esbit_stove", charges = { 0, 50 }, probability = 6 }
    group:group("full_survival_kit", 4)
    content.add(group)
end
