local ccb = require("ccb")

ccb.content.define_mutation {
    id = "IERDE_ROOTED_IN_PLACE",
    name = ccb.content.text("The Root of the Mountain"),
    points = 8,
    description = ccb.content.text("When standing on the living earth or underground, the Ierde can root themselves in place.  While doing so, they cannot move, but they are immune to being stunned, dazed, or downed, and gain additional armor."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    prerequisites = { "IERDE_NO_KNOCKBACK" },
    secondary_prerequisites = { "IERDE_STR_BONUS_3", "IERDE_STR_BONUS_4" },
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 1,
    cooldown = 10,
    activation_message = ccb.content.text("You merge with the ground beneath your feet."),
    on_activate = "ierde_rooted_in_place_on",
    on_deactivate = "ierde_rooted_in_place_off",
}
