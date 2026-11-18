local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mass_grave_casings", kind = "distribution" }
    group:item("223_casing", 60)
    group:item("308_casing", 20)
    group:item("shot_hull", 20)
    content.add(group)
end
