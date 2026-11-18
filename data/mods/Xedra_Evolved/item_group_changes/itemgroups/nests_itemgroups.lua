local content = require("ccb").content

do
    local group = content.ItemGroup { id = "hedge_magick_materials", kind = "distribution" }
    group:item("mortar_pestle", 40)
    group:entry { item = "corpse_ash", count = { 5, 10 }, wrapper = "jug_plastic", container = "null", probability = 15 }
    group:entry { item = "ash", count = { 10, 20 }, wrapper = "jug_plastic", container = "null", probability = 15 }
    group:entry { item = "wild_herbs", count = { 20, 80 }, wrapper = "bag_zipper", container = "null", probability = 75 }
    group:entry {
        distribution = {
            { item = "alder_bark", count = { 2, 5 }, probability = 1 },
            { item = "tanbark", count = { 2, 5 }, probability = 1 },
            { item = "birchbark", count = { 2, 5 }, probability = 1 },
            { item = "willowbark", count = { 2, 5 }, probability = 1 },
        },
        probability = 40,
    }
    group:entry {
        distribution = {
            { item = "leaves", count = { 5, 10 }, probability = 1 },
            { item = "grape_leaves", count = { 5, 10 }, probability = 1 },
            { item = "young_leaves", count = { 5, 10 }, probability = 1 },
            { item = "chicory_leaves", count = { 5, 10 }, probability = 1 },
            { item = "wintergreen_leaves", count = { 5, 10 }, probability = 1 },
        },
        probability = 40,
    }
    group:entry {
        distribution = {
            { item = "leather", count = { 1, 5 }, probability = 2 },
            { item = "thread", count = { 5, 50 }, probability = 5 },
            { item = "sinew", count = { 2, 20 }, probability = 1 },
            { item = "plant_fibre", count = { 3, 30 }, probability = 1 },
            { item = "yarn", count = { 5, 50 }, probability = 5 },
            { item = "plant_fibre", count = { 5, 50 }, probability = 1 },
            { item = "yarn", count = { 5, 50 }, probability = 5 },
        },
        probability = 25,
    }
    group:entry { item = "salt", count = { 10, 50 }, wrapper = "bag_zipper", container = "null", probability = 15 }
    group:entry { item = "candle", charges = { 10, -1 }, probability = 75 }
    group:entry { item = "copper", count = { 5, 10 }, probability = 15 }
    group:entry { item = "scrap_dreamdross", count = { 5, 10 }, probability = 10 }
    content.upsert_item_group(group)
end
