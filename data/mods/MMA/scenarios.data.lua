local ccb = require("ccb")

ccb.content.define_scenario {
    copy_from = "portal_dependent",
    extend = { professions = { "mma_battle_angel", "mma_hylian_adventurer" } },
    id = "portal_dependent",
}
