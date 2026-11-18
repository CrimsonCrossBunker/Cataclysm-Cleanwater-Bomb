local content = require("ccb").content

do
    local group = content.ItemGroup { id = "the_thing_victim", kind = "collection" }
    group:group("mine_equipment", 60)
    group:entry { item = "corpse", damage = { 4, 4 } }
    content.add(group)
end
