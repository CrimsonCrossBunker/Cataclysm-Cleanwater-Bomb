local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_MERC_1_worn", kind = "collection" }
    group:item("under_armor")
    group:item("under_armor_shorts")
    group:item("socks")
    group:item("ring_wedding")
    group:item("robofac_enviro_suit")
    group:group("molle_backpacks_and_accessories")
    group:group("clothing_watch")
    group:item("robofac_kevlar_vambraces")
    group:item("robofac_kevlar_greaves")
    group:entry { item = "knife_combat", container = "bootsheath" }
    group:group("robofac_mantle_merc")
    group:group("robofac_helmet_merc")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_MERC_1_carry", kind = "collection" }
    group:entry {
        item = "ear_plugs",
        flags = {
            "no_auto_equip",
        },
    }
    group:entry { item = "robofac40", charges = { 40, 40 }, ammo = { item = "556" } }
    group:item("robofac_gun_kit")
    group:item("grenade_emp")
    group:group("mil_food_nodrugs")
    group:entry { item = "bot_grenade_hack", count = { 2, 2 } }
    group:entry { item = "protein_bar_evac", count = { 7, 7 } }
    group:entry { item = "water_clean", count = { 2, 2 } }
    group:entry { item = "RobofacCoin", count = { 15, 18 } }
    group:group("charged_smart_phone")
    group:group("full_1st_aid")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_MERC_1_wield", kind = "collection" }
    group:entry {
        item = "robofac_gun",
        charges = { 40, 40 },
        ammo = { item = "556" },
        contents = {
            { item = "shoulder_strap" },
            { item = "robofac_gun_ar" },
        },
    }
    content.add(group)
end
