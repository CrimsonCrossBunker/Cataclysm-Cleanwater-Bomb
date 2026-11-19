local ccb = require("ccb")

ccb.content.define_mutation {
    id = "IERDE_STONE_FORM",
    name = ccb.content.text("Form of the Solid Earth"),
    points = 8,
    description = ccb.content.text("The Ierde may transform into rock and earth.  They become incredibly resilient and nearly immune to some forms of damage, but will be much, much slower."),
    prerequisites = { "IERDE_NO_KNOCKBACK" },
    secondary_prerequisites = { "IERDE_FEEL_NO_PAIN" },
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    active = true,
    activation_setup_only = true,
    cost = 1,
    cooldown = 2,
    consumes_mana = true,
    on_activate = "enable_trait_form",
    on_deactivate = "disable_trait_form",
}
