local content = require("ccb").content

do
    local group = content.ItemGroup { id = "female_underwear_child", kind = "collection" }
    group:group("female_underwear_top_child")
    group:group("female_underwear_bottom")
    content.add(group)
end

do
    -- unisex underwear
    local group = content.ItemGroup { id = "underwear_unisex", kind = "distribution" }
    group:item("thermal_suit", 1)
    group:item("thermal_outfit", 1)
    group:item("long_undertop", 30)
    group:item("under_armor", 10)
    group:item("undershirt", 40)
    group:item("under_armor_shorts", 10)
    group:item("long_underpants", 30)
    content.add(group)
end
