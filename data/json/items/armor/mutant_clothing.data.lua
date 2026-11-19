local ccb = require("ccb")

ccb.content.define_item {
    id = "horseshoes_wearable",
    name = ccb.content.plural_text("pair of horseshoes", "pair of horseshoes"),
    description = ccb.content.text("A pair of U-shaped bands of iron fitted onto the horse's hooves to protect them from wear, or onto your own hooves, if you have them."),
    mass = "1876 g",
    volume = "2000 ml",
    length = "35 cm",
    price = "80 USD",
    survival_price = "20 cent",
    materials = { "mc_steel" },
    symbol = "u",
    color = "light_gray",
    accuracy = { grip = "weapon", length = "hand", surface = "any", balance = "neutral" },
    melee_damage = { bash = 8 },
    flags = { "MUTATED_ANATOMY_ONLY", "DURABLE_MELEE" },
    armor = {
        portions = {
            {
                covers = { "hoof_r", "hoof_l" },
                subparts = { "hoof_sole_r", "hoof_sole_l" },
                materials = { { id = "iron", coverage = 100, thickness = 10 } },
                encumbrance = 0,
                coverage = 50,
                rigid_only = true,
            },
        },
    },
}
