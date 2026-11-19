local ccb = require("ccb")

ccb.content.define_item {
    id = "pressin",
    copy_from = "lws32",
    name = ccb.content.plural_text("the Pressin", "the Pressin"),
    description = ccb.content.text("A compact short-range pistol without a pistol grip.  When in use, the entire gun body is pointed at targets and squeezed.  The body also conceals a switchblade for close quarters use."),
    mass = "300 g",
    volume = "150 ml",
    length = "15 cm",
    price = "230 USD",
    survival_price = "30 USD",
    accuracy = { grip = "weapon", length = "hand", surface = "point", balance = "neutral" },
    qualities = { { id = "CUT", level = 2 }, { id = "CUT_FINE", level = 1 }, { id = "BUTCHER", level = 14 } },
    techniques = { "RAPID" },
    flags = { "DURABLE_MELEE", "ALLOWS_BODY_BLOCK", "NO_TURRET" },
    weapon_categories = { "AUTOMATIC_PISTOLS", "SHIVS" },
    pockets = { { kind = "MAGAZINE", ammunition = { ["32"] = 2 } } },
    melee_damage = { stab = 16 },
    inheritance = { offset = { dispersion = 180 } },
    gun = { barrel_length = "80 mm", mod_locations = {} },
}
