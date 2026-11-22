local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_GRACKEN_FRIENDSHIP",
    name = ccb.content.text("Grack Pack"),
    points = 0,
    description = ccb.content.text("You've found a kinship with those strange shadowy creatures as long as you move your hands fast enough when you see them.  You can befriend gracken, causing them to come to your defense."),
    categories = { "perk" },
    starting_trait = false,
    valid = false,
    purifiable = false,
    active = true,
    on_activate = "perk_grack_pack",
}
