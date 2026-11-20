local ccb = require("ccb")

ccb.content.define_item {
    id = "pyrokinetic_matrix_crystal_bomb_act",
    category = "weapons",
    looks_like = "matrix_crystal_pyrokinesis",
    copy_from = "matrix_crystal_pyrokinesis",
    name = ccb.content.plural_text("destabilized pyrokinetic matrix crystal bomb", "destabilized pyrokinetic matrix crystal bombs"),
    description = ccb.content.text("A matrix crystal attuned to pyrokinesis.  The faint light in its depths is growing brighter and brighter, and the crystal itself is heating up as you hold it."),
    light = 20,
    flags = { "BOMB", "TRADER_AVOID", "DANGEROUS" },
    melee_damage = { bash = 6 },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("The %s is already destabilized, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Push buttons"),
        },
    },
    countdown_action = {
        kind = "explosion",
        field = "fd_fire",
        field_radius = 10,
        field_minimum = 2,
        field_maximum = 3,
        blast = { power = 120000, fire = true, max_noise = 25, shrapnel = 0 },
    },
    countdown_interval = "5 seconds",
}
