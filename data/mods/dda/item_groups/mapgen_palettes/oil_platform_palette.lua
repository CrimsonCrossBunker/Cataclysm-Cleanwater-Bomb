local content = require("ccb").content

do
    local group = content.ItemGroup { id = "lubricant", kind = "distribution" }
    group:entry { item = "motor_oil", charges = { 2000, 60000 }, container = "metal_tank", probability = 50 }
    group:entry { item = "motor_oil", charges = { 0, 20000 }, container = "jerrycan_big", probability = 30 }
    group:item("metal_tank", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "oil_drums", kind = "distribution" }
    group:entry { item = "crude_oil", charges = { 180000, 200000 }, container = "55gal_drum", probability = 60 }
    group:item("55gal_drum", 30)
    content.add(group)
end
