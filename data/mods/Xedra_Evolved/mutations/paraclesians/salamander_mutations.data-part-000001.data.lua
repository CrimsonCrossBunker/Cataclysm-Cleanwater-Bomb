local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SALAMANDER_DROP_FIRE",
    name = ccb.content.text("Searing Footsteps"),
    points = 6,
    description = ccb.content.text("The Salamander can enhance their inner fire to the point where they leave fiery footprints everywhere they travel.  Activate this trait to leave a trail of fire in your wake at the cost of mana for every footstep."),
    prerequisites = { "SALAMANDER_EMIT_HEAT" },
    secondary_prerequisites = { "SALAMANDER_SKIN_2", "SALAMANDER_SKIN_3" },
    categories = { "SALAMANDER" },
    purifiable = false,
    active = true,
    activation_setup_only = true,
    cooldown = "1 s",
    consumes_mana = true,
    cost = 4,
    on_process = "salamander_fire_footsteps",
}
