local content = require("ccb").content

do
    local group = content.ItemGroup { id = "Zomborg_CBM_harvest_ranged_weapons", kind = "distribution" }
    group:item("bio_ley_energy_blaster", 5)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "EXODII_CBM_Store_Tier2", kind = "distribution" }
    group:item("bio_mana_to_bionic_power", 10)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "EXODII_CBM_Store_Tier3", kind = "distribution" }
    group:item("bio_see_wizards_eyes", 10)
    group:item("bio_ley_energy_blaster", 10)
    content.extend_item_group(group)
end
