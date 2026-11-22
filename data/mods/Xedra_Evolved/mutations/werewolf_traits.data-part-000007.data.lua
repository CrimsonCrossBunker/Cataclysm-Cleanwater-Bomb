local ccb = require("ccb")

-- Tier 5 traits begin here
ccb.content.define_mutation {
    id = "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM",
    name = ccb.content.text("Form of the Primal Hunter"),
    points = 10,
    description = ccb.content.text("While in wolf form, you can call on the spirit of the primal wolves of the mythic past and transform into an atavistic creature of nightmare, two meters high at the shoulder, with fur as thick as armor and teeth that can rend steel.  This form also regenerates the same as the war form does."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 3,
    cooldown = 1,
    on_activate = "werewolf_primal_form_on",
    on_process = "werewolf_hybrid_form_healing",
    on_deactivate = "werewolf_primal_form_off",
}
