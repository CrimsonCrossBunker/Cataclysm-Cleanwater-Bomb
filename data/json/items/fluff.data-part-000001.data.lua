local ccb = require("ccb")

ccb.content.define_item {
    id = "xedra_seismograph",
    name = ccb.content.text("portable seismograph"),
    description = ccb.content.text("A sturdy steel briefcase, containing what appears to be an old-fashioned drum seismograph.  The stenciled acronyms of its outer case imply it was used by XEDRA as some sort of recording device.\n\nThin parallel lines cover both ends of the drum, but as they approach the middle their vibrations intensify, until the ink fuses into a thick red stain."),
    mass = "5000 g",
    volume = "15750 ml",
    price = "240 USD",
    survival_price = "50 cent",
    accuracy = { grip = "none", length = "long", surface = "any", balance = "clumsy" },
    materials = { "steel" },
    symbol = "?",
    looks_like = "briefcase",
    color = "light_gray",
    flags = { "OVERSIZE", "BELTED", "RESTRICT_HANDS", "WATER_FRIENDLY" },
    melee_damage = { bash = 16 },
    armor = {
        sided = true,
        thickness = 2,
        portions = { { encumbrance = 45, coverage = 10, covers = { "arm_l", "arm_r", "hand_l", "hand_r" } } },
    },
}
