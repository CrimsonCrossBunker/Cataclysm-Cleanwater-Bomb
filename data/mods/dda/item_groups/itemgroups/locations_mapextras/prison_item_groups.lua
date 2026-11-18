local content = require("ccb").content

do
    local group = content.ItemGroup { id = "prison_canine_food", kind = "distribution" }
    group:entry { item = "dogfood", container = "can_medium" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "prison_canine_bowl", kind = "distribution" }
    group:item("bowl_plastic")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "prison_canine_utility", kind = "distribution" }
    group:item("dog_whistle", 10)
    group:item("pet_carrier", 30)
    group:item("towel", 20)
    group:item("soap", 10)
    group:item("gloves_medical", 20)
    group:item("cotton_patchwork", 15)
    group:item("bag_plastic", 20)
    group:item("jerky", 40)
    group:item("rope_6", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "prison_workshop_safety", kind = "collection" }
    group:entry { item = "mask_dust", damage = { 1, 4 }, probability = 75 }
    group:entry { item = "gloves_work", damage = { 1, 4 }, probability = 75 }
    group:entry { item = "glasses_safety", damage = { 1, 4 }, probability = 75 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "prison_jumpsuit", kind = "distribution" }
    group:entry { item = "jumpsuit_pocketless", damage = { 1, 4 }, variant = "orange", probability = 75 }
    content.add(group)
end

do
    -- Nested group to damage the container-item
    local group = content.ItemGroup { id = "prisoner_or_cop_clothes", kind = "collection" }
    group:entry { group = "prisoner_or_cop_clothes_corpse", damage = { 3, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "prisoner_or_cop_clothes_corpse",
        kind = "collection",
        container = "corpse_generic_human",
    }
    group:entry { group = "male_underwear", damage = { 1, 4 } }
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "jumpsuit_pocketless", damage = { 1, 4 }, variant = "orange" },
                    { group = "clothing_prisoner_shoes", damage = { 1, 4 }, probability = 20 },
                    { item = "bandana", damage = { 1, 4 } },
                },
            },
            {
                collection = {
                    { group = "cop_pants", damage = { 1, 4 } },
                    { group = "cop_shoes", damage = { 1, 4 }, probability = 20 },
                    { group = "cop_torso", damage = { 1, 4 } },
                    { group = "clothing_watch", probability = 20 },
                    { item = "police_belt", damage = { 1, 4 }, probability = 20 },
                },
            },
        },
        probability = 90,
    }
    group:entry { group = "socks_unisex", damage = { 1, 4 } }
    group:group("clothing_glasses", 20)
    content.add(group)
end
