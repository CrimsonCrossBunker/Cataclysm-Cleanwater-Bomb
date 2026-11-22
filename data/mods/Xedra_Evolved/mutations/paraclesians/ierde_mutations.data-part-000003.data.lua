local ccb = require("ccb")

ccb.content.define_mutation {
    id = "IERDE_SMASHING_PUNCH",
    name = ccb.content.text("Avalanche Blow"),
    points = 3,
    description = ccb.content.text("With a brief moment to stabilize themselves, the Ierde strikes a wall, door, or other terrain feature with the force of a falling boulder, doing many times their normal damage."),
    categories = { "IERDE" },
    purifiable = false,
    activation_setup_only = false,
    active = true,
    on_activate = "ierde_smashing_punch",
}
