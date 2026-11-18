local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mon_zombie_scientist_death_drops", kind = "collection" }
    group:entry { group = "lab_shoes", damage = { 1, 4 } }
    group:entry { group = "lab_torso", damage = { 1, 4 } }
    group:entry { group = "lab_pants", damage = { 1, 4 } }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:entry {
        collection = {
            { group = "harddrugs", probability = 25 },
            { group = "chem_lab", probability = 60 },
            { group = "teleport", probability = 6 },
            { group = "goo", probability = 20 },
            { group = "cloning_vat", probability = 1 },
            { group = "dissection", probability = 50 },
            { group = "electronics", probability = 40 },
            { item = "radio", probability = 15 },
            { item = "balthazar_radio", probability = 10 },
            { item = "xedra_field_notes", probability = 10 },
            { group = "textbooks", probability = 25 },
            { group = "lab_files_generic", probability = 15 },
            { group = "everyday_gear_lab", probability = 50 },
        },
    }
    group:entry { group = "wallets_science", damage = { 1, 4 }, probability = 5 }
    content.add(group)
end
