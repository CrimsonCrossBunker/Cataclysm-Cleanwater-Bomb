local ccb = require("ccb")

ccb.content.define_mutation {
    id = "HOMULLUS_BACKSTAGE",
    name = ccb.content.text("Backstage"),
    points = 1,
    visibility = -1,
    ugliness = 0,
    description = ccb.content.text("At will, you can recede from the foreground of people's perceptions.  They will still notice you if you make yourself known.  Conversation with actual humans will be harder while this trait is active."),
    categories = { "HOMULLUS" },
    purifiable = false,
    prerequisites = { "NO_TRACE_YET_I_WISH" },
    activation_setup_only = true,
    active = true,
    on_activate = "toggle_trait_form",
    on_deactivate = "toggle_trait_form",
}
