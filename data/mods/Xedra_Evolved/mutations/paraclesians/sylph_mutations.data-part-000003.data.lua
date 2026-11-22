local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SYLPH_LIGHTNING_MELEE_ATTACKS",
    name = ccb.content.text("Fulgurating Strikes"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "ELECTRICAL_EMISSIONS" },
    secondary_prerequisites = { "ELECTRICAL_FIELD" },
    description = ccb.content.text("At will, the Sylph may cause their attacks to carry a charge, whose power grows with their mastery of lightning.  Each attack costs mana while this trait is active."),
    categories = { "SYLPH" },
    purifiable = false,
    active = true,
    activation_setup_only = true,
    on_activate = "sylph_lightning_melee_on",
    on_process = "sylph_lightning_melee_process",
    on_deactivate = "sylph_lightning_melee_off",
}
