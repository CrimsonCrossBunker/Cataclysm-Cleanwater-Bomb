local ccb = require("ccb")

ccb.content.define_mutation {
    id = "UNDINE_WATER_FORM",
    name = ccb.content.text("Form of the Flowing Waters"),
    points = 8,
    description = ccb.content.text("You may transform your body into pure water, becoming much more difficult to hurt (except by fire), able to flow easily over all terrain, and capable of moving much faster and more stealthily when in water.  However, you will be unable to attack, cold will do triple damage to you, and cold weather will affect you more."),
    prerequisites = { "UNDINE_WATER_BODY" },
    secondary_prerequisites = { "UNDINE_ABSORB_WATER" },
    categories = { "UNDINE" },
    purifiable = false,
    threshold_requirements = { "THRESH_UNDINE" },
    active = true,
    consumes_water = true,
    cost = 1,
    cooldown = 3,
    activation_setup_only = true,
    on_activate = "undine_water_form_on",
    on_deactivate = "undine_water_form_off",
}
