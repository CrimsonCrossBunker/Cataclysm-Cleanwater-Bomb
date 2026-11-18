local content = require("ccb").content

do
    -- The campus guards stick to melee weapons, as guns are banned on campus.
    local group = content.ItemGroup { id = "NC_CAMPUS_GUARD_wield_phase1", kind = "distribution" }
    group:item("spear_knife_proper", 20)
    group:item("bat", 20)
    group:item("cudgel", 20)
    group:item("shortbow", 20)
    group:item("spear_pipe", 20)
    group:item("spear_homemade_halfpike", 20)
    group:item("makeshift_glaive", 20)
    content.add(group)
end

do
    -- Initially the campus guards have basic but decent clothing, but they're not geared for heavy combat.
    local group = content.ItemGroup { id = "NC_CAMPUS_GUARD_worn_phase1", kind = "collection" }
    group:entry {
        distribution = {
            { item = "jeans", probability = 30 },
            { item = "pants", probability = 30 },
            { item = "pants_leather", probability = 10 },
            { item = "pants_cargo", probability = 30 },
        },
    }
    group:entry {
        distribution = {
            { item = "sneakers", probability = 40 },
            { item = "boots", probability = 40 },
            { item = "boots_steel", probability = 10 },
            { item = "sneakers_steel", probability = 10 },
        },
    }
    group:entry {
        distribution = {
            { item = "vest", probability = 80 },
            { item = "vest_leather", probability = 40 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "backpack", probability = 80 },
            { item = "backpack_denim", probability = 5 },
            { item = "backpack_leather", probability = 20 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "glasses_safety", probability = 10 },
            { item = "goggles_chem", probability = 5 },
            { item = "goggles_ski", probability = 5 },
            { item = "glasses_reading", probability = 20 },
            { item = "sunglasses", probability = 20 },
        },
        probability = 50,
    }
    group:item("jacket_jean", 60)
    group:item("jacket_leather", 20)
    group:item("bandana", 10)
    content.add(group)
end
