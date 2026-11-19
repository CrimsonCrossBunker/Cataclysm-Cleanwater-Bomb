local ccb = require("ccb")

ccb.content.define_item {
    id = "spacer_cap",
    copy_from = "hat_cotton",
    materials = { "plastic", "cotton" },
    looks_like = "powered_earmuffs",
    variants = {},
    flags = { "OVERSIZE", "BELTED", "ALLOWS_NATURAL_ATTACKS", "PARTIAL_DEAF" },
    name = ccb.content.text("communications cap"),
    description = ccb.content.text("A padded cotton cap built around an augmented reality headset.  During normal operation it would provide visual information about a ship subsystems and a communications link with the rest of the crew, but severed from a spaceship, only their hearing protection function retains any utility."),
    color = "brown",
    armor = {
        portions = {
            { covers = { "eyes" }, rigid_only = true, coverage = 33, encumbrance = 0 },
            { covers = { "head" }, coverage = 100, encumbrance = 2 },
        },
    },
}
