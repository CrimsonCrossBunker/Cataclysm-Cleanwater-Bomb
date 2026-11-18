local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mon_zombie_resort_dancer_death_drops", kind = "collection" }
    group:entry { group = "private_resort_dancer_drop", damage = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_resort_bouncer_death_drops", kind = "collection" }
    group:entry { item = "polo_shirt", damage = { 1, 4 } }
    group:entry { item = "pants", damage = { 1, 4 } }
    group:entry { item = "blazer", damage = { 1, 4 } }
    group:entry { group = "underwear_mens", damage = { 1, 4 } }
    group:group("wallets", 10)
    group:group("misc_smoking", 30)
    group:entry { group = "accesories_personal_unisex", count = { 0, 2 }, probability = 25 }
    group:item("tool_belt", 50)
    group:entry { item = "tazer", damage = { 1, 4 }, probability = 10 }
    group:item("bootsheath", 15)
    group:entry { item = "gartersheath1", damage = { 1, 4 }, probability = 15 }
    group:entry { item = "punch_dagger", damage = { 1, 4 }, container = "gartersheath1", probability = 2 }
    group:item("switchblade", 15)
    group:item("bbholster", 5)
    group:item("knuckle_brass", 15)
    group:item("knuckle_steel_forged", 8)
    group:entry { group = "default_zombie_items_pockets", count = { 0, 4 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_resort_staff_death_drops", kind = "collection" }
    group:entry { group = "private_resort_staff_drop", damage = { 0, 4 } }
    content.add(group)
end
