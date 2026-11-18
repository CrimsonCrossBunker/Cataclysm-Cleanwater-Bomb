local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ANCILLA_BOSS_CHOP_SHOP_worn", kind = "collection" }
    group:item("under_armor")
    group:item("under_armor_shorts")
    group:item("socks")
    group:item("boots_combat")
    group:item("pants_army")
    group:item("kevlar")
    group:group("molle_backpacks_and_accessories")
    group:group("clothing_watch")
    group:item("robofac_kevlar_vambraces")
    group:item("robofac_kevlar_greaves")
    group:entry { item = "knife_combat", container = "bootsheath" }
    group:group("robofac_helmet_merc")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ANCILLA_BOSS_CHOP_SHOP_carry", kind = "collection" }
    group:entry { group = "on_hand_545x39", count = { 2, 2 } }
    group:entry { group = "nested_aks74", count = { 2, 2 } }
    group:entry { group = "any_MRE", count = { 2, 2 } }
    group:entry { item = "RobofacCoin", count = { 15, 18 } }
    group:group("charged_smart_phone")
    group:group("full_1st_aid")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ANCILLA_BOSS_CHOP_SHOP_wield", kind = "collection" }
    group:entry {
        item = "ak74_semi",
        contents = {
            { item = "shoulder_strap" },
            { item = "suppressor" },
        },
    }
    content.add(group)
end
