local ccb = require("ccb")

ccb.content.define_mutation {
    id = "WEREWOLF_WALK_THROUGH_WALLS",
    name = ccb.content.text("Ghostwalker"),
    points = 4,
    description = ccb.content.text("You can concentrate for a moment and turn into a spirit form that allows you to walk through walls."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 20,
    cooldown = 1,
    activation_message = ccb.content.text("You concentrate for a moment and sublimate your body into spirit."),
    on_activate = "werewolf_phase_through_walls",
    on_deactivate = "werewolf_stop_phasing",
}
