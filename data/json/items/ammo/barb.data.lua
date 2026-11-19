local ccb = require("ccb")

ccb.content.define_item {
    id = "barb_paralysis",
    price = "4 USD",
    name = ccb.content.text("paralyzing barb"),
    symbol = "=",
    color = "green",
    description = ccb.content.text("Tiny droplets of venom trickle out of the sponge-like tissue of this sharp barb."),
    materials = { "bone" },
    volume = "250 ml",
    mass = "37 g",
    melee_damage = { bash = 6, cut = 2 },
    ammunition = {
        type = "barb",
        damage = { type = "stab", amount = 5, penetration = 5 },
        dispersion = 120,
        loudness = 0,
        count = 10,
        show_stats = true,
        effects = { "PARALYZEPOISON" },
    },
}

ccb.content.define_item {
    id = "gene_sting_barb",
    price = "4 USD",
    name = ccb.content.text("gene sting barb"),
    symbol = "=",
    color = "cyan",
    description = ccb.content.text("Tiny droplets of cyan venom trickle out of the sponge-like tissue of this sharp barb."),
    materials = { "bone" },
    volume = "250 ml",
    mass = "30 g",
    melee_damage = { bash = 6, cut = 2 },
    ammunition = {
        type = "gene_sting",
        damage = { type = "bullet", amount = 5, penetration = 5 },
        effects = { "GENE_STING_BARB" },
        dispersion = 120,
        loudness = 0,
        count = 10,
        show_stats = true,
    },
}
