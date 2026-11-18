local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_FIELD_RESEARCHER_worn", kind = "collection" }
    group:item("under_armor")
    group:item("under_armor_shorts")
    group:item("robofac_enviro_suit")
    group:group("robofac_mantle_prototype")
    group:item("robofac_basic_greaves")
    group:item("robofac_basic_vambraces")
    group:entry { item = "mask_gas", charges = { 50, 100 } }
    group:entry {
        collection = {
            { group = "guns_pistol_milspec" },
            { item = "holster" },
        },
        probability = 90,
    }
    group:item("tacvest")
    content.add(group)
end
