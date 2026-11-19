local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_werewolf_primal_form_fur",
    category = "armor",
    name = ccb.content.plural_text("primal form fur", "primal form furs"),
    description = ccb.content.text("A heavy carpet of fur, as strong as steel."),
    mass = "2 kg",
    volume = "2 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_fur" },
    symbol = "x",
    color = "dark_gray",
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "NORMAL",
        "WATER_FRIENDLY",
        "SOFT",
        "MUNDANE",
    },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 45,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 20 } },
                covers = { "leg_l", "leg_r", "arm_l", "arm_r", "torso" },
                coverage = 100,
                encumbrance = 5,
            },
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 12 } },
                covers = { "hand_l", "hand_r", "foot_l", "foot_r", "head" },
                coverage = 100,
                encumbrance = 6,
            },
            {
                materials = { { id = "mut_fur", coverage = 100, thickness = 7 } },
                covers = { "mouth" },
                coverage = 85,
                encumbrance = 0,
            },
        },
    },
    artifact = { enchantments = { "ench_primal_form_protection" } },
}
