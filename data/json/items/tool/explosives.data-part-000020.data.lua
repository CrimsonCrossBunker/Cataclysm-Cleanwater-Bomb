local ccb = require("ccb")

ccb.content.define_item {
    id = "scrambler_act",
    copy_from = "scrambler",
    description = ccb.content.text("This scrambler grenade is active and will soon detonate, releasing a control wave that temporarily converts robots to your side."),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Pull pin"),
        },
    },
    countdown_action = { kind = "explosion", draw_radius = 4, draw_color = "cyan", scrambler_radius = 4 },
    countdown_interval = "3 seconds",
}
