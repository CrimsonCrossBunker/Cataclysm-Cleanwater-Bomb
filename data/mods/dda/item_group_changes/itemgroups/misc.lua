local content = require("ccb").content

do
    local group = content.ItemGroup { id = "maps", kind = "distribution" }
    group:group("roadmap_stock", 33)
    group:item("touristmap", 33)
    group:item("survivormap", 33)
    content.add(group)
end
