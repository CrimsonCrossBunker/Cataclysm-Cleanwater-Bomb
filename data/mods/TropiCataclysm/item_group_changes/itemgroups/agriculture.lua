local content = require("ccb").content

do
    local group = content.ItemGroup { id = "farming_seeds", kind = "distribution" }
    group:item("seed_melon", 60)
    group:item("seed_banana", 60)
    group:item("seed_kiwi", 60)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "hydro", kind = "distribution" }
    group:item("melon", 2)
    group:item("banana", 6)
    group:item("kiwi", 4)
    group:item("seed_melon", 1)
    group:item("seed_banana", 1)
    group:item("seed_kiwi", 1)
    content.extend_item_group(group)
end
