local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_robofac_security_head_worn", kind = "collection" }
    group:item("under_armor")
    group:item("under_armor_shorts")
    group:entry {
        item = "rm13_armor",
        contents = {
            { item = "rm13_battery" },
            { item = "rebreather_cartridge_regen" },
        },
    }
    group:entry { item = "legrig", count = { 2, 2 } }
    group:item("tacvest")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_robofac_security_head_weapon", kind = "distribution" }
    group:entry { item = "fn_p90", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_robofac_security_head_misc", kind = "collection" }
    group:entry { item = "flashbang", count = { 2, 2 } }
    group:entry { item = "fnp90mag", count = { 3, 3 }, charges = { 50, 50 } }
    content.add(group)
end
