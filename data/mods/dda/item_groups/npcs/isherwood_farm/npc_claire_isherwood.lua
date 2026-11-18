local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ISHERWOOD_CLAIRE_storage", kind = "distribution" }
    group:item("backpack_hiking")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ISHERWOOD_CLAIRE_gloves", kind = "distribution" }
    group:item("gloves_leather", 45)
    group:item("gloves_light", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ISHERWOOD_CLAIRE_pants", kind = "distribution" }
    group:item("jeans", 50)
    group:item("pants_cargo", 70)
    group:item("leather_belt", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ISHERWOOD_CLAIRE_shoes", kind = "distribution" }
    group:item("boots", 70)
    group:item("knee_high_boots", 50)
    group:item("boots_hiking", 20)
    group:item("mocassins", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ISHERWOOD_CLAIRE_torso", kind = "distribution" }
    group:item("tank_top", 50)
    group:item("dress", 45)
    group:item("jacket_light", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ISHERWOOD_CLAIRE_hat", kind = "distribution" }
    group:item("null", 40)
    group:item("cowboy_hat", 40)
    group:item("straw_hat", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ISHERWOOD_CLAIRE_misc", kind = "distribution" }
    group:item("royal_jelly", 50)
    group:entry { item = "flavored_bonemeal_tablet", count = { 42, 42 }, probability = 55 }
    group:entry { item = "bonemeal_tablet", count = { 40, 40 }, probability = 95 }
    group:item("cattail_jelly", 95)
    group:entry { item = "thyme_oil", charges = { 2, 2 }, container = "jar_glass_sealed", probability = 80 }
    group:entry { item = "mugwort_oil", charges = { 2, 2 }, container = "jar_glass_sealed", probability = 80 }
    group:group("poppy_pain_jar_glass_sealed_2", 80)
    group:group("poppy_sleep_jar_glass_sealed_2", 80)
    group:entry { item = "poppysyrup", charges = { 10, 10 }, container = "jar_glass_sealed", probability = 80 }
    group:entry { item = "bee_balm_tea", charges = { 2, 2 }, container = "jar_glass_sealed", probability = 80 }
    group:entry { item = "chamomile_tea", charges = { 2, 2 }, container = "jar_glass_sealed", probability = 80 }
    group:entry { item = "dandelion_tea", charges = { 2, 2 }, container = "jar_glass_sealed", probability = 80 }
    group:entry { item = "herbal_tea", charges = { 2, 2 }, container = "jar_glass_sealed", probability = 80 }
    group:entry { item = "pine_tea", charges = { 2, 2 }, container = "jar_glass_sealed", probability = 80 }
    group:entry { item = "tea_bark", charges = { 2, 2 }, container = "jar_glass_sealed", probability = 80 }
    group:entry { item = "hb_beer", charges = { 2, 2 }, container = "jar_glass_sealed", probability = 80 }
    group:entry { item = "fruit_wine", charges = { 2, 2 }, container = "jar_glass_sealed", probability = 80 }
    group:entry { item = "honey_bottled", charges = { 2, 2 }, container = "jar_glass_sealed", probability = 80 }
    content.add(group)
end
