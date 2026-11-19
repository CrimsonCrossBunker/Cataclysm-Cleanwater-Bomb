local ccb = require("ccb")

ccb.content.define_mutation {
    id = "TAIL_SKUNK",
    name = ccb.content.text("Skunk Tail"),
    points = 1,
    vitamin_cost = 130,
    visibility = 7,
    description = ccb.content.text("You have a long, black and white striped, fluffy-furred tail.  When attacked you will reflexively spray a defensive stink chemical.  Prevents wearing non-fabric pants."),
    types = { "TAIL" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    valid = false,
    restricts_gear = { "leg_hip_l", "leg_hip_r" },
    allowed_item_flags = { "ALLOWS_TAIL" },
    allow_soft_gear = true,
    integrated_armor = { "integrated_skunk_tail" },
    active = true,
    starts_active = true,
}
