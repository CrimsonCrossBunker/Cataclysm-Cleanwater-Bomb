local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mom_mycus_forest_items", kind = "distribution" }
    group:item("rock", 40)
    group:item("rock_flaking", 5)
    group:item("flint", 2)
    group:item("rock_large", 5)
    content.add(group)
end
