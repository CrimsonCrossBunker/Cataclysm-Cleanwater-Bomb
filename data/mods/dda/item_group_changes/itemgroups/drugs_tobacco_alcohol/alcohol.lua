local content = require("ccb").content

do
    local group = content.ItemGroup { id = "liquor_and_spirits", kind = "distribution" }
    group:item("whiskey", 16)
    group:item("vodka", 20)
    group:item("gin", 20)
    group:item("rum", 14)
    group:item("tequila", 12)
    group:item("triple_sec", 12)
    group:item("brandy", 12)
    group:entry { item = "single_malt_whiskey", container = "bottle_glass", probability = 2 }
    group:item("single_pot_whiskey", 10)
    group:item("cheap_whiskey", 10)
    group:item("canadian_whiskey", 10)
    content.add(group)
end
