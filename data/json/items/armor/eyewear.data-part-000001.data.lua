local ccb = require("ccb")

-- Best case scenario: ~37 seconds. This video actually involves them lighting a cigarette, so that's about as good as it gets short of some scientific study. https://youtu.be/z51-ruPsupE?t=110
ccb.content.define_item {
    id = "glasses_bifocal",
    name = ccb.content.plural_text("bifocal glasses", "bifocal glasses"),
    description = ccb.content.text("A pair of bifocal glasses for those who are both near-sighted and far-sighted.  You can use them to focus sunlight."),
    mass = "30 g",
    volume = "250 ml",
    price = "79 USD",
    survival_price = "7 USD 50 cent",
    materials = { "glass", "plastic" },
    symbol = "[",
    looks_like = "glasses_eye",
    color = "cyan",
    flags = { "WATER_FRIENDLY", "FIRESTARTER", "FIX_NEARSIGHT", "FIX_FARSIGHT", "FRAGILE", "SKINTIGHT" },
    variant_kind = "generic",
    variants = {
        {
            id = "glasses_bifocal_round",
            name = ccb.content.plural_text("round bifocal glasses", "round bifocal glasses"),
            description = ccb.content.text("This pair has rounded lenses."),
            weight = 10,
            append = true,
        },
        {
            id = "glasses_bifocal_square",
            name = ccb.content.plural_text("square bifocal glasses", "square bifocal glasses"),
            description = ccb.content.text("This pair has square lenses."),
            weight = 20,
            append = true,
        },
        {
            id = "glasses_bifocal_aviator",
            name = ccb.content.plural_text("aviator bifocal glasses", "aviator bifocal glasses"),
            description = ccb.content.text("This pair has aviator-styled lenses."),
            weight = 5,
            append = true,
        },
    },
    armor = {
        thickness = 1,
        environmental_protection = 1,
        portions = { { coverage = 75, covers = { "eyes" }, rigid_only = true } },
    },
    use_actions = { { kind = "firestarter", moves = 3700, slow_moves = 25000, need_sunlight = true } },
}
