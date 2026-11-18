local content = require("ccb").content

do
    local group = content.ItemGroup { id = "marloss_yellow_drops", kind = "collection" }
    group:item("marloss_gel")
    group:item("fungal_seeds")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "marloss_zealot_death_drops", kind = "collection" }
    group:entry { item = "footrags", damage = { 0, 2 } }
    group:group("zealot_outfit")
    group:item("marloss_berry", 33)
    group:item("stick_long", 50)
    group:item("mycenacean_hymns", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "zealot_outfit", kind = "distribution" }
    group:item("tunic", 90)
    group:item("tunic_rag", 9)
    group:item("armor_nomad_light", 1)
    content.add(group)
end
