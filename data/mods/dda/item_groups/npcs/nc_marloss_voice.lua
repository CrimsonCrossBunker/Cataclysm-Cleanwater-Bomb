local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_VOICE_weapon", kind = "distribution" }
    group:item("q_staff", 20)
    group:item("stick_long", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_VOICE_worn", kind = "collection" }
    group:group("NC_VOICE_armor")
    group:item("marloss_scarf")
    group:item("boots")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_VOICE_carry", kind = "collection" }
    group:entry { item = "marloss_berry", count = { 1, 4 } }
    group:entry { item = "marloss_seed", count = { 1, 4 } }
    group:item("mycenacean_hymns")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_VOICE_armor", kind = "distribution" }
    group:item("robe")
    content.add(group)
end
