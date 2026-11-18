local content = require("ccb").content

do
    -- Initially the free mechant guards have basic but decent clothing, but they're not geared for heavy combat.
    local group = content.ItemGroup { id = "NC_FREE_MERCH_GUARD_worn_phase1", kind = "collection" }
    group:entry {
        distribution = {
            { item = "jeans", probability = 20 },
            { item = "pants", probability = 20 },
            { item = "pants_leather", probability = 20 },
            { item = "pants_cargo", probability = 60 },
        },
    }
    group:entry {
        distribution = {
            { item = "sneakers", probability = 20 },
            { item = "boots", probability = 20 },
            { item = "boots_steel", probability = 40 },
            { item = "sneakers_steel", probability = 28 },
        },
    }
    group:entry {
        distribution = {
            { item = "kevlar", probability = 80 },
            { item = "tacvest", probability = 40 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "glasses_safety", probability = 20 },
            { item = "goggles_ski", probability = 10 },
            { item = "sunglasses", probability = 20 },
        },
        probability = 50,
    }
    group:item("jacket_evac", 90)
    group:item("bandana", 10)
    content.add(group)
end
