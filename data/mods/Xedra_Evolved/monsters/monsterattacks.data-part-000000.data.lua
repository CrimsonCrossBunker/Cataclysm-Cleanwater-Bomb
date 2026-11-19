local ccb = require("ccb")

ccb.content.define_item {
    id = "changeling_thrown_knife",
    symbol = "%",
    color = "red",
    name = ccb.content.text("thrown knife"),
    description = ccb.content.text("Shiny reflective throwing knife at the ready."),
    materials = { "stone" },
    flags = {
        "PRIMITIVE_RANGED_WEAPON", "NEVER_JAMS", "NONCONDUCTIVE", "NO_REPAIR", "WATERPROOF_GUN",
        "NO_SALVAGE", "NO_UNLOAD", "NO_TURRET",
    },
    mass = "540 g",
    volume = "210 ml",
    length = "75 mm",
    accuracy = { grip = "weapon", length = "hand", surface = "point", balance = "good" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            capacity = "200 L",
            mass_limit = "400 kg",
            max_item_length = "2000 m",
            ammunition = { throwing_knives = 3 },
        },
    },
    melee_damage = { bash = 2 },
    gun = {
        skill = "throw",
        ammunition = { "throwing_knives" },
        effects = { "NO_PENETRATE_OBSTACLES" },
        damage = { type = "cut", amount = -1 },
        clip_size = 1,
        loudness = 2,
        range = 6,
        dispersion = 150,
        durability = 8,
    },
}
