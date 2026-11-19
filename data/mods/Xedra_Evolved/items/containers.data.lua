local ccb = require("ccb")

ccb.content.define_item {
    id = "blood_bank",
    category = "container",
    name = ccb.content.text("blood bank"),
    looks_like = "canteen",
    description = ccb.content.text("A large moon tear canteen.  It radiates the cold of the grave and smells strongly of blood.  Any blood stored inside is protected from spoilage by some kind of fae enchantment."),
    mass = "155 g",
    volume = "2625 ml",
    price = "10 USD",
    survival_price = "50 cent",
    melee_damage = { bash = 1 },
    materials = { "moon_tears" },
    symbol = ")",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            watertight = true,
            rigid = true,
            capacity = "2500 ml",
            max_item_volume = "32 ml",
            mass_limit = "5 kg",
            allowed_materials = { "blood", "hblood" },
            spoil_multiplier = 0,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "COLLAPSE_CONTENTS" },
    armor = {
        portions = {
            {
                materials = { { id = "moon_tears", coverage = 100, thickness = 2.0 } },
                encumbrance = 4,
                coverage = 10,
                covers = { "torso" },
                subparts = { "torso_hanging_front" },
            },
        },
    },
}

ccb.content.define_item {
    id = "blood_camel",
    category = "container",
    name = ccb.content.text("blood camel"),
    looks_like = "runner_bag",
    description = ccb.content.text("A slim and lightweight insulated moon tear bladder worn on the back or within a hydration pouch in a backpack.  Perfect for the renfield on the go.  It has a large pocket and a capped mouth for filling with blood, with a hose that allows the wearer to drink hands-free.  Any blood stored inside is protected from spoilage by some kind of fae enchantment."),
    mass = "286 g",
    volume = "3001 ml",
    price = "100 USD",
    survival_price = "2 USD 50 cent",
    melee_damage = { bash = 1 },
    materials = { "moon_tears" },
    symbol = ")",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            rigid = true,
            watertight = true,
            capacity = "3000 ml",
            max_item_volume = "32 ml",
            mass_limit = "20 kg",
            allowed_materials = { "blood", "hblood" },
            spoil_multiplier = 0,
        },
    },
    flags = { "BELTED", "COLLAPSE_CONTENTS" },
    armor = {
        portions = {
            {
                materials = { { id = "moon_tears", coverage = 100, thickness = 1.0 } },
                coverage = 30,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}
