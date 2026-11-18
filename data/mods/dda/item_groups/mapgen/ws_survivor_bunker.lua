local content = require("ccb").content

do
    local group = content.ItemGroup { id = "oa_ig_sb_water", kind = "distribution" }
    group:entry { item = "water_clean", charges = { 50, 200 }, container = "keg", probability = 30 }
    group:entry { item = "water_clean", charges = { 0, 50 }, container = "keg", probability = 70 }
    content.add(group)
end
