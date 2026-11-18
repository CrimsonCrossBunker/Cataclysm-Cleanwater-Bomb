local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_BOUNTY_HUNTER_pants", kind = "distribution" }
    group:item("jeans", 20)
    group:item("pants", 20)
    group:item("pants_leather", 20)
    group:item("pants_cargo", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BOUNTY_HUNTER_shoes", kind = "distribution" }
    group:item("sneakers", 20)
    group:item("boots", 20)
    group:item("boots_steel", 40)
    group:item("sneakers_steel", 28)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BOUNTY_HUNTER_coat", kind = "distribution" }
    group:item("null", 20)
    group:item("hoodie", 20)
    group:item("jacket_light", 20)
    group:item("jacket_windbreaker", 10)
    group:item("jacket_leather", 80)
    group:item("trenchcoat", 20)
    group:item("jacket_jean", 20)
    group:item("vest_jean", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BOUNTY_HUNTER_vest", kind = "distribution" }
    group:item("null", 20)
    group:item("kevlar", 80)
    group:item("tacvest", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BOUNTY_HUNTER_masks", kind = "distribution" }
    group:item("null", 10)
    group:item("mask_dust", 30)
    group:item("bandana", 10)
    group:entry { item = "mask_filter", charges = { 10, -1 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BOUNTY_HUNTER_storage", kind = "distribution" }
    group:item("null", 20)
    group:item("backpack", 40)
    group:item("backpack_denim", 5)
    group:item("backpack_leather", 35)
    group:item("rucksack", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BOUNTY_HUNTER_eyes", kind = "distribution" }
    group:item("null", 60)
    group:item("glasses_safety", 20)
    group:item("goggles_ski", 20)
    group:item("sunglasses", 20)
    content.add(group)
end
