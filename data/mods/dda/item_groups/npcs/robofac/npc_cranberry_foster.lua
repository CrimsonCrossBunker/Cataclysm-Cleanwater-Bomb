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
