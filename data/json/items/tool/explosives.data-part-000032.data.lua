local ccb = require("ccb")

ccb.content.define_item {
    id = "half_barrel_bomb_act",
    copy_from = "half_barrel_bomb",
    description = ccb.content.text("A metal keg filled with stable explosives.  The fuse has been lit and once it ignites the primary explosive, the bomb will detonate and rain fire and steel on everything in sight."),
    color = "light_red",
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Activate fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 34400, shrapnel = { casing_mass = 12600, fragment_mass = 600 } },
    },
    countdown_interval = "100 seconds",
}
