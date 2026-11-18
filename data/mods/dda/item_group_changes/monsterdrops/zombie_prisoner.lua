local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mon_zombie_prisoner_death_drops", kind = "collection" }
    group:entry { item = "jumpsuit_pocketless", damage = { 1, 4 }, variant = "orange" }
    group:entry { item = "bandana", damage = { 1, 4 }, probability = 5 }
    group:group("clothing_glasses", 10)
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:entry { group = "clothing_prisoner_shoes", damage = { 1, 4 } }
    group:group("contraband", 30)
    content.add(group)
end
