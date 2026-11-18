local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_MERC_MONSTER_CORPSE_1_worn", kind = "collection" }
    group:item("under_armor")
    group:item("under_armor_shorts")
    group:item("socks")
    group:item("robofac_enviro_suit")
    group:group("clothing_watch")
    group:entry { item = "knife_combat", container = "bootsheath" }
    group:group("robofac_helmet_merc")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_MERC_MONSTER_CORPSE_1_carry", kind = "collection" }
    group:entry { item = "RobofacCoin", count = { 15, 18 } }
    group:group("charged_smart_phone")
    content.add(group)
end
