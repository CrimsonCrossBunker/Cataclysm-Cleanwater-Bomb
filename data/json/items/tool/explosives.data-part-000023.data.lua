local ccb = require("ccb")

ccb.content.define_item {
    id = "military_explosive_pipebomb_act",
    copy_from = "military_explosive_pipebomb",
    looks_like = "pipebomb_act",
    description = ccb.content.text("This pipebomb's pin is pulled, and it will explode any second now.  Throw it immediately!"),
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
        blast = { power = 920, shrapnel = { casing_mass = 410, fragment_mass = 0.5 } },
    },
    countdown_interval = "5 seconds",
}
