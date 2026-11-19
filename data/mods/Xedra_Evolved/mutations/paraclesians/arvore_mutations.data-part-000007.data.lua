local ccb = require("ccb")

ccb.content.define_mutation {
    id = "ARVORE_VINES",
    name = ccb.content.text("Writhing Vines"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("At will, the Arvore can grow long vines from their shoulders and back.  They can be used to climb or to lash at enemies, and can also be detached to serve as a rope if necessary.  Activate to toggle vines on and off."),
    prerequisites = { "ARVORE_VINE_DRAG" },
    threshold_requirements = { "THRESH_ARVORE" },
    categories = { "ARVORE" },
    purifiable = false,
    activation_setup_only = true,
    active = true,
    cooldown = 2,
    consumes_mana = true,
    cost = 1,
    activation_message = ccb.content.text("Lashing vines grow from your shoulders."),
    on_activate = "enable_trait_form",
    on_deactivate = "disable_trait_form",
}
