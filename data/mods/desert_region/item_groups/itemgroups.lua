local content = require("ccb").content

do
    local group = content.ItemGroup { id = "desertpavement", kind = "distribution" }
    group:item("rock", 10)
    group:item("rock_large", 1)
    group:item("rock_flaking", 8)
    group:item("sharp_rock", 8)
    group:entry { item = "pebble", charges = { 1, 1 }, probability = 33 }
    group:entry { item = "pebble", charges = { 0, 10 }, probability = 33 }
    content.add(group)
end
