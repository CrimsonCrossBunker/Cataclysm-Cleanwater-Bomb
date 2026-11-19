local ccb = require("ccb")

-- Values based roughly on an adult female African elephant femur. 61 times the size of the normal bone.
-- While it would make sense to be able to mill it, the bone won't fit into a mill…
ccb.content.define_item {
    id = "large_bone",
    name = ccb.content.text("large bone"),
    description = ccb.content.text("A huge bone of a large creature."),
    mass = "17700 g",
    volume = "19550 ml",
    length = "110 cm",
    symbol = "I",
    color = "white",
    materials = { "bone" },
    price = "0 cent",
    survival_price = "20 cent",
    accuracy = { grip = "bad", length = "long", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 15 },
    flags = { "RAW", "INEDIBLE", "NO_TEMP", "PUNCTURE_VEHICLE_WHEELS" },
    comestible = {
        kind = "FOOD",
        calories = 10436,
        vitamins = { { id = "calcium", amount = "1561750 mg" }, { id = "meat_allergen", amount = 1 } },
    },
}
