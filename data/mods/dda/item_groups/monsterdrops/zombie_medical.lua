local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mon_zombie_medical_death_drops", kind = "collection" }
    group:entry { group = "lab_torso", damage = { 1, 4 } }
    group:entry { group = "lab_pants", damage = { 1, 4 } }
    group:entry { group = "lab_shoes", damage = { 1, 4 } }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:entry { group = "hazmat_gloves", damage = { 1, 4 } }
    group:entry { group = "hazmat_masks", damage = { 1, 4 } }
    group:group("gear_medical")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "zombie_medical_clothes", kind = "collection" }
    group:entry { group = "lab_torso", damage = { 1, 4 } }
    group:entry { group = "lab_pants", damage = { 1, 4 } }
    group:entry { group = "lab_shoes", damage = { 1, 4 } }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:entry { group = "hazmat_gloves", damage = { 1, 4 } }
    group:entry { group = "hazmat_masks", damage = { 1, 4 } }
    group:entry { item = "mask_plague", damage = { 1, 4 }, event = "halloween", probability = 25 }
    content.add(group)
end
