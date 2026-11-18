local content = require("ccb").content

do
    local group = content.ItemGroup { id = "Zomborg_CBM_harvest", kind = "collection" }
    group:group("Zomborg_CBM_harvest_utility", 80)
    group:group("Zomborg_CBM_harvest_structural", 50)
    group:group("Zomborg_CBM_harvest_combat", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "Zomborg_CBM_harvest_power", kind = "collection" }
    group:group("Zomborg_CBM_harvest_charging_tools", 25)
    group:entry {
        distribution = {
            { item = "bio_power_storage", probability = 90 },
            { item = "bio_power_storage_mkII", probability = 10 },
        },
        probability = 50,
    }
    group:item("bio_power_storage", 20)
    group:item("burnt_out_bionic", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "Zomborg_CBM_harvest_combat", kind = "collection" }
    group:entry {
        distribution = {
            { group = "Zomborg_CBM_harvest_expensive_combat_systems", probability = 50 },
            { group = "Zomborg_CBM_harvest_fancy_defense", probability = 50 },
        },
        probability = 2,
    }
    group:group("Zomborg_CBM_harvest_melee_weapons", 70)
    group:group("Zomborg_CBM_harvest_ranged_weapons", 40)
    group:item("burnt_out_bionic", 50)
    content.add(group)
end
