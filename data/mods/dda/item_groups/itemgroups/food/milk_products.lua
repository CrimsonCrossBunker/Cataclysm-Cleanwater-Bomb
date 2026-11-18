local content = require("ccb").content

do
    local group = content.ItemGroup { id = "any_milk", kind = "distribution" }
    group:group("any_milk_standard", 71)
    group:group("any_milk_lactosefree", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "any_milk_standard", kind = "distribution" }
    group:item("milk", 20)
    group:item("milk_UHT", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "any_milk_lactosefree", kind = "distribution" }
    group:item("soy_milk", 33)
    group:item("almond_milk", 33)
    group:item("oat_milk", 11)
    group:item("hazelnut_milk", 11)
    group:item("walnut_milk", 11)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milk_in_container_full", kind = "distribution" }
    group:entry { group = "any_milk", container = "jug_plastic" }
    group:entry { group = "any_milk", container = "jug_plastic_1892ml" }
    group:entry { group = "any_milk", container = "carton_sealed" }
    group:entry { group = "any_milk", container = "carton_946ml" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milk_in_big_container_full", kind = "distribution" }
    group:entry { group = "any_milk", container = "jug_plastic" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milk_powder_various", kind = "distribution" }
    group:entry { item = "milk_powder", count = { 0, 8 }, wrapper = "bottle_plastic_seasoning", probability = 2 }
    group:entry { item = "milk_powder", count = { 0, 8 }, wrapper = "bottle_glass_seasoning", probability = 2 }
    group:entry { item = "milk_powder", count = { 0, 8 }, wrapper = "bag_plastic_small", probability = 4 }
    group:entry { item = "milk_powder", count = { 0, 40 }, wrapper = "bag_paper_powder", probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milk_powder_various_full", kind = "distribution" }
    group:entry { item = "milk_powder", count = { 8, 8 }, wrapper = "bottle_plastic_seasoning", probability = 2 }
    group:entry { item = "milk_powder", count = { 8, 8 }, wrapper = "bottle_glass_seasoning", probability = 2 }
    group:entry { item = "milk_powder", count = { 8, 8 }, wrapper = "bag_plastic_small", probability = 4 }
    group:entry { item = "milk_powder", count = { 40, 40 }, wrapper = "bag_paper_powder", probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "butter_wrapper_8", kind = "collection", container = "wrapper" }
    group:entry { item = "butter", count = { 8, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "butter_wrapper_1_32", kind = "collection", container = "wrapper" }
    group:entry { item = "butter", count = { 1, 32 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "butter_wrapper_32", kind = "collection", container = "wrapper" }
    group:entry { item = "butter", count = { 32, 32 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "butter_wrapper_8_64", kind = "collection", container = "wrapper" }
    group:entry { item = "butter", count = { 8, 64 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milk_cream_bottle_2", kind = "collection", container = "bottle_plastic" }
    group:entry { item = "milk_cream", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cheese_bag_8", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "cheese", count = { 8, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cheese_bag_plastic", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "cheese", count = { 2, 16 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cheese_in_can", kind = "distribution" }
    group:entry { item = "can_cheese", count = { 8, 8 }, wrapper = "can_food" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cheese_hard_wrapper_8", kind = "collection", container = "wrapper" }
    group:entry { item = "cheese_hard", count = { 8, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mozzarella_cheese_bag_1", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "mozzarella_cheese", count = { 1, 1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "mozzarella_cheese_smoked_bag_1",
        kind = "collection",
        container = "bag_plastic_small",
    }
    group:entry { item = "mozzarella_cheese_smoked", count = { 1, 1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pecorino_cheese_wrapper_4", kind = "collection", container = "wrapper" }
    group:entry { item = "pecorino_cheese", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mascarpone_container_1", kind = "collection", container = "cup_plastic" }
    group:entry { item = "mascarpone", count = { 1, 1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cottage_cheese_tub_1", kind = "collection", container = "plastic_bucket" }
    group:entry { item = "cottage_cheese", count = { 1, 1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milk_in_container", kind = "distribution" }
    group:entry { group = "any_milk", charges = { 1, -1 }, container = "jug_plastic" }
    group:entry { group = "any_milk", charges = { 1, -1 }, container = "jug_plastic_1892ml" }
    group:entry { group = "any_milk", charges = { 1, -1 }, container = "carton_sealed" }
    group:entry { group = "any_milk", charges = { 1, -1 }, container = "carton_946ml" }
    content.add(group)
end
