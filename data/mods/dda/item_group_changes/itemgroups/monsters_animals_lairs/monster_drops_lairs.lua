local content = require("ccb").content

do
    -- Beekeeper gear, as spawned on beekeeper zombie
    local group = content.ItemGroup { id = "hive", kind = "distribution" }
    group:item("honeycomb", 10)
    group:item("honey_scraper", 2)
    group:item("beekeeping_hood", 5)
    group:item("beekeeping_suit", 5)
    group:item("beekeeping_gloves", 5)
    content.add(group)
end

do
    -- Damaged generic/military/science drops, nothing fancy
    local group = content.ItemGroup { id = "wasp_lair", kind = "distribution", with_ammo = 10 }
    group:entry { group = "allclothes", damage = { 2, 4 }, probability = 150 }
    group:entry { group = "clothing_outdoor_set", damage = { 2, 4 }, probability = 10 }
    group:entry { group = "clothing_hunting", damage = { 2, 4 }, probability = 10 }
    group:entry { group = "clothing_work_set", damage = { 2, 4 }, probability = 10 }
    group:entry { group = "everyday_gear", damage = { 2, 4 }, probability = 50 }
    group:entry { group = "gear_homeless", damage = { 2, 4 }, probability = 30 }
    group:entry { group = "child_items", damage = { 2, 4 }, probability = 30 }
    group:entry { group = "traveler", damage = { 2, 4 }, probability = 10 }
    group:entry { group = "default_zombie_clothes", damage = { 2, 4 }, probability = 30 }
    group:entry { group = "default_zombie_items_bags", damage = { 2, 4 }, probability = 30 }
    group:entry { group = "default_zombie_items_pockets", damage = { 2, 4 }, probability = 30 }
    group:entry { group = "mon_zombie_scientist_death_drops", damage = { 2, 4 }, probability = 5 }
    group:entry { group = "mon_zombie_labsecurity_death_drops", damage = { 2, 4 }, probability = 5 }
    group:entry { group = "mon_zombie_kevlar_death_drops", damage = { 2, 4 }, probability = 15 }
    group:entry { group = "mon_zombie_military_pilot_death_drops", damage = { 2, 4 }, probability = 5 }
    content.add(group)
end
