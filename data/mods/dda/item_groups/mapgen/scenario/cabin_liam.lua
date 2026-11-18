local content = require("ccb").content

do
    local group = content.ItemGroup { id = "chris_body", kind = "collection" }
    group:item("ax")
    group:entry { item = "corpse_gunned", damage = { 4, 4 } }
    group:item("boots_hiking")
    group:item("socks")
    group:item("boxer_shorts")
    group:item("jeans_ripped")
    group:entry { item = "jersey", damage = { 0, 2 } }
    group:entry { item = "coat_rain", damage = { 0, 2 }, probability = 30 }
    group:item("gloves_light", 50)
    group:item("hat_ball", 40)
    content.add(group)
end
