local ccb = require("ccb")

ccb.content.define_item {
    id = "flashbang_act",
    copy_from = "flashbang",
    description = ccb.content.text("This flashbang is active, and will soon detonate with intense light and sound, blinding, deafening, and disorienting anyone nearby.  It may be a good idea to throw it!"),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Pull pin"),
        },
    },
    countdown_action = { kind = "explosion", flash = true },
    countdown_interval = "2 seconds",
}
