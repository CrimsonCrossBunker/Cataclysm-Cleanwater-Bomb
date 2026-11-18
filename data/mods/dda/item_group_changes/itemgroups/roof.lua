local content = require("ccb").content

do
    local group = content.ItemGroup { id = "roof_sign", kind = "distribution" }
    group:item("rock", 10)
    group:item("can_food", 10)
    group:item("lc_steel_chunk", 10)
    group:item("lc_steel_lump", 10)
    group:item("bottle_glass", 10)
    group:item("sharp_rock", 10)
    group:item("2x4", 10)
    group:item("american_flag", 2)
    group:item("national_flag", 1)
    group:item("pipe", 10)
    content.add(group)
end
