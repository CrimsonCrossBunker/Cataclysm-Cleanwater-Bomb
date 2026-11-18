local content = require("ccb").content

do
    -- Should contain all Hub 01 gear
    local group = content.ItemGroup { id = "NC_ROBOFAC_gear", kind = "collection" }
    group:group("robofac_armor_pieces")
    group:group("robofac_armor_pieces_basic")
    group:group("robofac_armor_pieces_military")
    group:group("robofac_gun_mags")
    group:group("robofac_gun_exodii")
    group:group("robofac_gun_kit")
    group:item("robofac_armor_anchor")
    group:item("robofac_armor_anchor_on")
    group:item("robofac_armor_rig")
    group:item("robofac_enviro_suit")
    group:item("robofac_enviro_suit_casual")
    group:item("robofac_head_rig")
    group:item("robofac_head_rig_nv")
    group:item("hm12")
    group:item("robofac_poncho_liner")
    group:item("template_armor")
    group:item("template_photonics")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "robofac_armor_pieces_basic", kind = "collection" }
    group:item("robofac_basic_helmet")
    group:item("robofac_basic_greaves")
    group:item("robofac_basic_mantle")
    group:item("robofac_basic_skirt")
    group:item("robofac_basic_vambraces")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "robofac_id_cards", kind = "distribution" }
    group:item("id_science", 90)
    group:item("id_military", 5)
    group:item("id_industrial", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "robofac_basic_grenades", kind = "distribution" }
    group:item("grenade_emp", 70)
    group:item("scrambler", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "robofac_basic_robots", kind = "distribution" }
    group:item("bot_tazer_hack", 40)
    group:item("bot_grenade_hack", 40)
    group:item("bot_skitterbot", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "robofac_robots", kind = "distribution" }
    group:item("bot_robofac_hound", 40)
    group:item("bot_robofac_skittergun", 40)
    group:item("robofac_robotrig", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "robofac_armor_pieces", kind = "distribution" }
    group:item("robofac_rubber_mantle", 25)
    group:item("robofac_nomex_mantle", 25)
    group:item("robofac_kevlar_mantle", 25)
    group:item("robofac_rubber_skirt", 25)
    group:item("robofac_nomex_skirt", 25)
    group:item("robofac_kevlar_skirt", 25)
    group:item("robofac_rubber_vambraces", 25)
    group:item("robofac_nomex_vambraces", 25)
    group:item("robofac_kevlar_vambraces", 25)
    group:item("robofac_rubber_greaves", 25)
    group:item("robofac_nomex_greaves", 25)
    group:item("robofac_kevlar_greaves", 25)
    group:item("robofac_armor_rig", 25)
    group:item("robofac_rubber_helmet", 25)
    group:item("robofac_nomex_helmet", 25)
    group:item("robofac_kevlar_helmet", 25)
    group:item("robofac_head_rig", 25)
    group:item("robofac_poncho_liner", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "robofac_armor_pieces_military", kind = "distribution" }
    group:item("robofac_military_skirt", 10)
    group:item("robofac_military_vambraces", 10)
    group:item("robofac_military_greaves", 10)
    group:item("robofac_military_mantle", 10)
    group:item("robofac_military_helmet", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "robofac_gun_mags", kind = "collection" }
    group:entry { item = "robofac40", count = { 5, 5 } }
    group:entry { item = "robofac60", count = { 5, 5 } }
    group:entry { item = "robofac20", count = { 5, 5 } }
    group:entry { item = "robofac10", count = { 5, 5 } }
    group:entry { item = "robofac50", count = { 2, 2 } }
    group:entry { item = "robofacmultimag", count = { 5, 5 } }
    group:entry { item = "robofac30", count = { 2, 2 } }
    group:entry { item = "robofac100", count = { 2, 2 } }
    group:entry { item = "robofac_gun_40mm_10rd", count = { 2, 2 } }
    group:entry { item = "robofac_gun_40mm_5rd", count = { 2, 2 } }
    group:entry { item = "robofac_gun_40mm_3rd", count = { 2, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "robofac_gun_exodii", kind = "collection" }
    group:entry { item = "robofac_gun_exodii", count = { 1, 1 }, probability = 25 }
    group:entry { item = "robofac60_123ln", count = { 5, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "robofac_gun_kit", kind = "collection" }
    group:entry {
        collection = {
            { item = "robofac_gun", count = { 1, 1 } },
            { item = "robofac_gun_ar", count = { 1, 1 } },
            { item = "robofac_gun_smg", count = { 1, 1 } },
            { item = "robofac_gun_dmr", count = { 1, 1 } },
            { item = "robofac_gun_shotgun", count = { 1, 1 } },
            { item = "robofac_gun_shotgun_breach", count = { 1, 1 } },
            { item = "robofac_gun_57", count = { 1, 1 } },
            { item = "robofac_gun_kit", count = { 1, 1 } },
            { item = "robofac_gun_40mm", count = { 1, 1 } },
        },
        probability = 25,
    }
    content.add(group)
end

do
    -- a robofac poncho with a few armored bits
    local group = content.ItemGroup { id = "robofac_mantle_merc", kind = "collection", container = "robofac_armor_rig" }
    group:item("robofac_kevlar_skirt")
    group:item("robofac_kevlar_mantle")
    group:group("robofac_merc_mags")
    content.add(group)
end

do
    -- a robofac headrig with kevlar insert
    local group = content.ItemGroup { id = "robofac_helmet_merc", kind = "collection", container = "robofac_head_rig" }
    group:item("robofac_kevlar_helmet")
    content.add(group)
end

do
    -- a robofac poncho with a few basic bits
    local group = content.ItemGroup { id = "robofac_mantle_prototype", kind = "collection", container = "robofac_armor_rig" }
    group:item("robofac_basic_skirt")
    group:item("robofac_basic_mantle")
    content.add(group)
end

do
    -- a group of nano templates for one of the missions
    local group = content.ItemGroup { id = "nano_templates", kind = "collection", container = "box_small_wood" }
    group:item("template_armor")
    group:item("template_photonics")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "robofac_merc_mags", kind = "collection" }
    group:entry { item = "robofac40", charges = { 40, 40 }, ammo = { item = "556" } }
    group:entry { item = "robofac40", charges = { 40, 40 }, ammo = { item = "556" } }
    content.add(group)
end
