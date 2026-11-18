local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ammo_can_50_mg_any_part", kind = "distribution" }
    group:item("ammo_can_50_50bmg_4fmj1tracer_100")
    group:item("ammo_can_50_50bmg_1tracer4mk211_100")
    content.add(group)
end
