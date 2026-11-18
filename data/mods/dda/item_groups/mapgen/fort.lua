local content = require("ccb").content

do
    local group = content.ItemGroup { id = "fort_giftshop_rack", kind = "distribution" }
    group:item("tshirt", 50)
    group:item("flintlock_pouch", 20)
    group:item("ceramic_mug", 10)
    group:item("tricorne", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fort_breakroom_lockers", kind = "collection" }
    group:group("pants", 50)
    group:group("shirts", 50)
    group:group("clothing_outdoor_shoes", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fort_historic_wardrobe", kind = "collection" }
    group:entry { item = "knee_high_boots", damage = { 1, 4 }, probability = 20 }
    group:entry { item = "breeches", damage = { 1, 4 }, probability = 50 }
    group:entry { item = "waistcoat", damage = { 1, 4 }, probability = 30 }
    group:entry { item = "peacoat", damage = { 1, 4 }, probability = 50 }
    group:entry { item = "leather_belt", damage = { 1, 4 }, probability = 10 }
    group:entry { item = "knit_scarf", damage = { 1, 4 }, probability = 10 }
    group:entry { item = "tricorne", damage = { 1, 4 }, probability = 30 }
    group:entry { item = "gloves_leather", damage = { 1, 4 }, probability = 10 }
    group:entry { item = "stockings", damage = { 1, 4 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fort_giftshop_case", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "rifle_flintlock", probability = 50 },
            { item = "pistol_flintlock", probability = 20 },
            { item = "longrifle_flintlock", probability = 30 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fort_crate", kind = "collection" }
    group:item("cannonball_4lb")
    group:item("cotton_patchwork", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fort_powderbarrel", kind = "collection" }
    group:entry { item = "chem_black_powder", charges = { 100, 2500 }, container = "wooden_barrel" }
    content.add(group)
end
