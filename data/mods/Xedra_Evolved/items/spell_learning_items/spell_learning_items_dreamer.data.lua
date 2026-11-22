local ccb = require("ccb")

ccb.content.define_item {
    id = "artifact_dreamer_clairvoyance",
    name = ccb.content.plural_text("pair of glasses", "pairs of glasses"),
    description = "A pair of a common glasses.  They have no lens or glass inside, only casing.  There is a strange engraving of vines, snakes, and foxes covering every surface of the frames.  You think that maybe the engravings are moving when you aren't looking at them.",
    symbol = "[",
    color = "cyan",
    category = "artifacts",
    looks_like = "glasses_eye",
    mass = "15 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "10 cent",
    materials = { "forged_dreamstuff" },
    use_actions = {
        {
            kind = "learn_spell",
            spells = { "spell_dreamer_clairvoyance" },
        },
    },
    armor = {
        thickness = 1,
        environmental_protection = 1,
        portions = {
            {
                covers = { "eyes" },
                coverage = 75,
                rigid_only = true,
            },
        },
    },
}
