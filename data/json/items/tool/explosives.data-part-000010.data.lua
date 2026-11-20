local ccb = require("ccb")

ccb.content.define_item {
    id = "grenade_act",
    copy_from = "grenade",
    description = ccb.content.text("This fragmentation grenade is active, and will explode any second now.  Better throw it!"),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Pull pin"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 240, shrapnel = { casing_mass = 217, fragment_mass = 0.02 } },
    },
    countdown_interval = "5 seconds",
}
