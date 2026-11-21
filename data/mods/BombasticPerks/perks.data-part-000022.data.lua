local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_forge_blood",
    name = ccb.content.text("Blood of the Forge"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your blood might not be able to make weapons, but it still can make anything coated with sturdier but unable to be repaired.  Activate to use."),
    active = true,
    activation_setup_only = false,
    on_activate = "forge_blood",
    flags = { "PERK" },
}
