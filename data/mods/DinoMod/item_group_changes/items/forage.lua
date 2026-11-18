local content = require("ccb").content

do
    local group = content.ItemGroup { id = "forage_spring", kind = "distribution" }
    group:entry { item = "egg_dino", count = { 2, 5 }, probability = 2 }
    group:entry { item = "egg_dino_small", count = { 2, 5 }, probability = 1 }
    group:entry { item = "egg_dino_large", count = { 2, 5 }, probability = 1 }
    group:entry { item = "egg_dino_theropod", count = { 2, 5 }, probability = 2 }
    group:entry { item = "egg_dino_theropod_small", count = { 2, 5 }, probability = 1 }
    group:entry { item = "egg_dino_theropod_large", count = { 2, 5 }, probability = 1 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "forage_summer", kind = "distribution" }
    group:entry { item = "egg_dino", count = { 2, 5 }, probability = 2 }
    group:entry { item = "egg_dino_small", count = { 2, 5 }, probability = 1 }
    group:entry { item = "egg_dino_large", count = { 2, 5 }, probability = 1 }
    group:entry { item = "egg_dino_theropod", count = { 2, 5 }, probability = 2 }
    group:entry { item = "egg_dino_theropod_small", count = { 2, 5 }, probability = 1 }
    group:entry { item = "egg_dino_theropod_large", count = { 2, 5 }, probability = 1 }
    content.extend_item_group(group)
end
