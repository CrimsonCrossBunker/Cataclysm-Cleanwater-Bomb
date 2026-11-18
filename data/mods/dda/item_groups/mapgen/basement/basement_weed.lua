local content = require("ccb").content

do
    local group = content.ItemGroup { id = "weed_farm", kind = "distribution" }
    group:entry { item = "weed", count = { 0, 20 }, probability = 70 }
    group:entry { item = "seed_weed", count = { 2, 2 }, probability = 60 }
    group:item("cannabis", 50)
    group:item("withered", 70)
    content.add(group)
end
