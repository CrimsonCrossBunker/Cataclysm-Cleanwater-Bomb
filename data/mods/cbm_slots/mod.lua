local ccb = require("ccb")

return ccb.ModDefinition {
    id = "cbm_slots",
    name = ccb.content.text("Bionic Slots"),
    authors = { "anothersimulacrum" },
    description = ccb.content.text("Enables the bionic slots system, which limits the number of CBMs you can install in each bodypart."),
    category = "rebalance",
    dependencies = { "ccb" },
    world_options = {
        CBM_SLOTS_ENABLED = true,
    },
}
