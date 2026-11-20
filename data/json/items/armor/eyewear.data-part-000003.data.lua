local ccb = require("ccb")

-- Best case scenario: ~37 seconds. This video actually involves them lighting a cigarette, so that's about as good as it gets short of some scientific study. https://youtu.be/z51-ruPsupE?t=110
ccb.content.define_item {
    id = "glasses_reading",
    name = ccb.content.plural_text("reading glasses", "reading glasses"),
    description = ccb.content.text("A pair of glasses for the far-sighted.  Useless for anyone else.  You can use them to focus sunlight."),
    ascii_picture = "glasses_reading",
    mass = "30 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "5 USD",
    materials = { "glass", "plastic" },
    symbol = "[",
    looks_like = "glasses_eye",
    color = "cyan",
    flags = { "WATER_FRIENDLY", "FIRESTARTER", "FIX_FARSIGHT", "FRAGILE", "SKINTIGHT" },
    armor = {
        thickness = 1,
        environmental_protection = 1,
        portions = { { coverage = 75, covers = { "eyes" }, rigid_only = true } },
    },
    use_actions = { { kind = "firestarter", moves = 3700, slow_moves = 25000, need_sunlight = true } },
}
