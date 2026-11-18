local content = require("ccb").content

do
    -- Nested group to damage the container-item
    local group = content.ItemGroup { id = "map_extra_phavian_science", kind = "collection" }
    group:entry { group = "map_extra_phavian_science_corpse", damage = { 3, 4 } }
    content.add(group)
end

do
    -- Half the time a wallet with an id card, all the time a lab coat, small chance of psi reseach to tantalize
    local group = content.ItemGroup {
        id = "map_extra_phavian_science_corpse",
        kind = "collection",
        container = "corpse_generic_human",
    }
    group:group("wallets_phavian", 50)
    group:entry { item = "coat_lab", damage = { 1, 3 } }
    group:group("psi_lab")
    group:entry { group = "lab_pants", damage = { 1, 3 } }
    group:entry { group = "socks_unisex", damage = { 1, 3 } }
    group:entry { group = "lab_shoes", damage = { 1, 3 } }
    group:entry { group = "lab_torso", damage = { 1, 3 } }
    group:entry { group = "underwear", damage = { 1, 3 } }
    group:item("lab_postit_psi", 15)
    group:group("dist_lab_file_phavian_psi_research_any", 3)
    content.add(group)
end
