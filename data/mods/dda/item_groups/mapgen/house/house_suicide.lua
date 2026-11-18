local content = require("ccb").content

do
    local group = content.ItemGroup { id = "house_suicide_clothing", kind = "collection" }
    group:group("underwear")
    group:group("shoes")
    group:group("pants")
    group:group("shirts")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "house_suicide_shotgun", kind = "collection" }
    group:group("guns_shotgun_common")
    group:entry { item = "shot_hull", charges = { 1, 1 } }
    group:entry { item = "corpse", damage = { 2, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "oxy_small", kind = "collection" }
    group:group("oxycodone_bottle_plastic_pill_prescription_1")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "oxycodone_bottle_plastic_pill_prescription_1",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "oxycodone", container = "null" }
    content.add(group)
end
