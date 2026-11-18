local content = require("ccb").content

do
    local group = content.ItemGroup { id = "highland_sarcophagus_common", kind = "collection" }
    group:item("skull_human")
    group:entry { item = "bone_human", count = { 20, 40 } }
    group:item("coin_highlands")
    group:item("highland_shroud")
    group:item("highland_medallion", 75)
    group:entry { item = "highland_purple_incense", count = { 1, 2 }, container = "bowl_clay", probability = 40 }
    group:entry { item = "highland_red_incense", count = { 1, 2 }, container = "bowl_clay", probability = 10 }
    group:entry { item = "highland_yellow_incense", count = { 1, 2 }, container = "bowl_clay", probability = 10 }
    group:entry { item = "highland_green_incense", count = { 1, 2 }, container = "bowl_clay", probability = 10 }
    group:entry { item = "highland_black_incense", count = { 1, 2 }, container = "bowl_clay", probability = 10 }
    group:entry { item = "highland_white_incense", count = { 1, 2 }, container = "bowl_clay", probability = 10 }
    group:entry { item = "highland_blue_incense", count = { 1, 2 }, container = "bowl_clay", probability = 10 }
    group:entry { item = "highland_golden_incense", count = { 1, 2 }, container = "bowl_clay", probability = 10 }
    content.add(group)
end
