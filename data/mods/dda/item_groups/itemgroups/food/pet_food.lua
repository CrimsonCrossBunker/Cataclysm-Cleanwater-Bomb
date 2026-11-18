local content = require("ccb").content

do
    local group = content.ItemGroup { id = "dog_food_six_pack_box", kind = "distribution", container = "box_medium" }
    group:entry { item = "dogfood", count = { 1, 6 }, container = "can_medium", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dog_food_six_pack_box_full", kind = "distribution", container = "box_medium" }
    group:entry { item = "dogfood", count = { 6, 6 }, container = "can_medium", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dog_food_six_pack_bag", kind = "distribution", container = "bag_plastic" }
    group:entry { item = "dogfood", count = { 1, 6 }, container = "can_medium", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dog_food_six_pack_bag_full", kind = "distribution", container = "bag_plastic" }
    group:entry { item = "dogfood", count = { 6, 6 }, container = "can_medium", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dog_food_six_pack", kind = "distribution" }
    group:group("dog_food_six_pack_box", 1)
    group:group("dog_food_six_pack_bag", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dog_food_six_pack_full", kind = "distribution" }
    group:group("dog_food_six_pack_box_full", 1)
    group:group("dog_food_six_pack_bag_full", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dog_food_in_container", kind = "distribution" }
    group:group("dog_food_six_pack", 1)
    group:entry { item = "dogfood_dry", count = { 1, 100 }, wrapper = "bag_garbage", probability = 1 }
    group:entry { item = "dogfood_dry", count = { 1, 50 }, wrapper = "bag_garbage", probability = 1 }
    group:entry { item = "dogfood_dry", count = { 1, 20 }, wrapper = "bag_plastic", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dog_food_in_container_full", kind = "distribution" }
    group:group("dog_food_six_pack_full", 1)
    group:entry { item = "dogfood_dry", count = { 100, 100 }, wrapper = "bag_garbage", probability = 1 }
    group:entry { item = "dogfood_dry", count = { 50, 50 }, wrapper = "bag_garbage", probability = 1 }
    group:entry { item = "dogfood_dry", count = { 20, 20 }, wrapper = "bag_plastic", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cat_food_six_pack_box", kind = "distribution", container = "box_medium" }
    group:entry { item = "catfood", count = { 1, 6 }, container = "can_medium", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cat_food_six_pack_box_full", kind = "distribution", container = "box_medium" }
    group:entry { item = "catfood", count = { 6, 6 }, container = "can_medium", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cat_food_six_pack_bag", kind = "distribution", container = "bag_plastic" }
    group:entry { item = "catfood", count = { 1, 6 }, container = "can_food", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cat_food_six_pack_bag_full", kind = "distribution", container = "bag_plastic" }
    group:entry { item = "catfood", count = { 6, 6 }, container = "can_food", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cat_food_six_pack", kind = "distribution" }
    group:group("cat_food_six_pack_box", 1)
    group:group("cat_food_six_pack_bag", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cat_food_six_pack_full", kind = "distribution" }
    group:group("cat_food_six_pack_box_full", 1)
    group:group("cat_food_six_pack_bag_full", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cat_food_in_container", kind = "distribution" }
    group:group("cat_food_six_pack", 1)
    group:entry { item = "catfood_dry", count = { 1, 100 }, wrapper = "bag_garbage", probability = 1 }
    group:entry { item = "catfood_dry", count = { 1, 50 }, wrapper = "bag_garbage", probability = 1 }
    group:entry { item = "catfood_dry", count = { 1, 20 }, wrapper = "bag_plastic", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cat_food_in_container_full", kind = "distribution" }
    group:group("cat_food_six_pack_full", 1)
    group:entry { item = "catfood_dry", count = { 100, 100 }, wrapper = "bag_garbage", probability = 1 }
    group:entry { item = "catfood_dry", count = { 50, 50 }, wrapper = "bag_garbage", probability = 1 }
    group:entry { item = "catfood_dry", count = { 20, 20 }, wrapper = "bag_plastic", probability = 1 }
    content.add(group)
end
