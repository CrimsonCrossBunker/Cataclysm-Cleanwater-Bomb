local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_SPIRAL_MADMAN_worn", kind = "collection" }
    group:entry { group = "clothing_work_boots", damage = { 0, 2 } }
    group:entry { group = "clothing_work_glasses", damage = { 0, 2 }, probability = 60 }
    group:entry { group = "clothing_work_gloves", damage = { 0, 2 }, probability = 75 }
    group:entry { group = "clothing_work_mask", damage = { 0, 2 }, probability = 40 }
    group:entry { item = "ear_plugs", damage = { 0, 2 }, probability = 15 }
    group:entry { item = "tool_belt", damage = { 0, 2 }, probability = 25 }
    group:entry {
        distribution = {
            {
                collection = {
                    { group = "clothing_work_pants", damage = { 0, 2 } },
                    { group = "clothing_work_torso", damage = { 0, 2 } },
                },
                probability = 75,
            },
            { item = "jumpsuit", damage = { 0, 2 }, probability = 25 },
        },
    }
    group:entry { group = "underwear", damage = { 0, 1 } }
    group:entry { group = "hat_hard_flashlight", damage = { 0, 2 }, probability = 90 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SPIRAL_MADMAN_wield", kind = "distribution" }
    group:item("pickaxe", 50)
    group:item("shovel", 50)
    group:item("bucket_5gal", 20)
    group:item("gasoline_lantern", 10)
    group:item("electric_lantern", 10)
    group:item("oil_lamp", 10)
    group:item("jackhammer_mining", 5)
    group:item("elec_jackhammer_mining", 5)
    content.add(group)
end
