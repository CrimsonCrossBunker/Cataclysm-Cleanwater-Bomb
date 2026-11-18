local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_worn", kind = "collection" }
    group:item("under_armor")
    group:item("under_armor_shorts")
    group:item("socks")
    group:item("robofac_enviro_suit")
    group:entry {
        item = "basic_papr_helmet",
        contents = {
            { item = "diving_flashlight_small_hipower" },
        },
    }
    group:item("basic_papr_belt_off")
    group:item("coat_lab")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_carry", kind = "collection" }
    group:entry { item = "exodii_chop_shop_head", count = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_wield", kind = "collection" }
    group:item("soldering_iron_portable")
    content.add(group)
end
