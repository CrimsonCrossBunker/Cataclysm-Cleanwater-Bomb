local ccb = require("ccb")

-- weight is accounted for in gun item
ccb.content.define_item {
    id = "integrated_fn_suppressor",
    copy_from = "suppressor",
    name = ccb.content.plural_text("FN integral suppressor", "FN integral suppressors"),
    description = ccb.content.text("This is the integrated suppressor for the FN Five-seveN suppressed.  Its large expansion chamber decelerates ammunition via several ports in the barrel, rendering most ammo subsonic at the cost of terminal performance.  It is not as effective as modern designs."),
    mass = "250 g",
    integral_volume = "0 ml",
    integral_mass = "0 g",
    integral_length = "0 mm",
    flags = { "IRREMOVABLE" },
    gunmod = {
        damage_modifier = { type = "bullet", amount = -2 },
        loudness_modifier = -32,
        range_modifier = -1,
        dispersion_modifier = 0,
        location = ccb.content.text("barrel"),
    },
}
