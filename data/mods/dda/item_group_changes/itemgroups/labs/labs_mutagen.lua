local content = require("ccb").content

do
    local group = content.ItemGroup { id = "lab_mutagen_ingredients_fridge", kind = "collection" }
    group:entry { item = "meat", count = { 1, 3 }, probability = 40 }
    group:entry { item = "rabbit_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "rat_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "chiropteran_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "mouse_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "fish_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "meat_tainted", count = { 1, 3 }, probability = 30 }
    group:entry { item = "tallow", count = { 5, 15 }, probability = 30 }
    group:entry { item = "fish", count = { 1, 3 }, probability = 40 }
    group:entry { item = "tallow_tainted", count = { 5, 10 }, probability = 20 }
    group:entry { item = "egg_bird_unfert", count = { 1, 12 }, probability = 30 }
    group:entry { item = "gastropod_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "batrachian_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "insect_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "cattle_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "spider_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "troglobite_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "lizard_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "ursine_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "beast_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "human_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "cephalopod_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "lupine_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "feline_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "plant_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "slime_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "bird_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "crustacean_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "water_clean", count = { 1, 3 }, sealed = false, container = "bottle_plastic", probability = 65 }
    group:entry { item = "water_mineral", count = { 1, 2 }, sealed = false, container = "bottle_plastic", probability = 35 }
    content.add(group)
end
