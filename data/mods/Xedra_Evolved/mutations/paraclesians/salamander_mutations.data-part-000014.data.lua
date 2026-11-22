local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SALAMANDER_BERSERK_STANCE",
    name = ccb.content.text("Wildfire Soul"),
    points = 5,
    description = ccb.content.text("As a banked fire can suddenly spring up with a gust of wind, the Salamander can surge into raging activity.  Activating this trait will make the Salamander immune to pain and add +3 Strength and Dexterity for as long as it is active.  However, when it ends, all the previously put-off pain and more returns."),
    prerequisites = { "SALAMANDER_REMOVE_STUN" },
    secondary_prerequisites = { "SALAMANDER_CURE_CONDITIONS" },
    active = true,
    activation_setup_only = true,
    cost = 7,
    consumes_calories = true,
    cooldown = 10,
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    on_activate = "salamander_berserk_stance_on",
    on_deactivate = "salamander_berserk_stance_off",
}
