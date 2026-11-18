local content = require("ccb").content

do
    local group = content.ItemGroup { id = "BEM_GUNRUNNER_worn", kind = "collection" }
    group:group("military_ballistic_vest_pristine")
    group:item("legpouch_large")
    group:group("NC_BOUNTY_HUNTER_pants")
    group:item("pants_army")
    group:group("NC_BOUNTY_HUNTER_coat")
    group:item("boots_combat")
    group:item("rope_loop")
    group:item("molle_pack")
    group:item("under_armor")
    group:item("under_armor_shorts")
    group:item("holster")
    group:item("sunglasses")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "BEM_GUNRUNNER_STOCK", kind = "collection" }
    group:entry { group = "SUS_rivtech_loot", count = { 3, 6 } }
    group:entry { group = "guns_energy", count = { 1, 4 }, probability = 50 }
    content.add(group)
end
