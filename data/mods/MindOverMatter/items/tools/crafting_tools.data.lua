local ccb = require("ccb")

ccb.content.define_item {
    id = "matrix_channeling_tool",
    name = ccb.content.plural_text("matrix channeling array", "matrix channeling arrays"),
    description = ccb.content.text("A set of matrix crystals arranged together to direct Netherium energy.  You're not entirely sure all the crystals are actually touching the metal assembly soldered around them."),
    mass = "2500 g",
    volume = "500 ml",
    length = "15 cm",
    price = "20 USD",
    survival_price = "50 cent",
    melee_damage = { bash = 2 },
    materials = { "nether_crystal", "steel" },
    symbol = "[",
    color = "white",
    qualities = { { id = "MATRIX_CHANNEL", level = 1 } },
    tool = {},
}

ccb.content.define_item {
    id = "matrix_aligning_tool",
    name = ccb.content.plural_text("crystalline focusing assembly", "crystalline focusing assemblies"),
    description = ccb.content.text("A precise arrangement of cut crystal pieces from the crystal outgrowths left by the portal storms.  The air in the center shimmers like a summer heat gaze when you look through the focal point of the apparatus."),
    mass = "4000 g",
    volume = "750 ml",
    length = "25 cm",
    price = "30 USD",
    survival_price = "40 cent",
    melee_damage = { bash = 5 },
    materials = { "nether_crystal", "steel" },
    symbol = "[",
    color = "light_gray",
    qualities = { { id = "MATRIX_FOCUS", level = 1 } },
    tool = {},
}

ccb.content.define_item {
    id = "telepathic_focusing_tool",
    name = ccb.content.plural_text("telepathic focusing tool", "telepathic focusing assemblies"),
    description = ccb.content.text("A glowing white netherium crystal surrounded by floating dust and shards of crystal.  The closer you look at the assembly the louder your thoughts sound."),
    mass = "4000 g",
    volume = "750 ml",
    length = "25 cm",
    price = "30 USD",
    survival_price = "40 cent",
    melee_damage = { bash = 5 },
    materials = { "nether_crystal", "steel" },
    symbol = "[",
    color = "light_gray",
    tool = {},
}
