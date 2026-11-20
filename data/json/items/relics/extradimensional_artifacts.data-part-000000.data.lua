local ccb = require("ccb")

ccb.content.define_item {
    id = "mp3_on_reverberation",
    category = "artifacts",
    copy_from = "mp3_on",
    color = "light_red",
    name = ccb.content.plural_text("red mp3 player (on)", "red mp3 players (on)"),
    description = ccb.content.text("A light-red mp3 player, you feel the text on the screen says \"TRAVEL // JOURNEY\".  Under that, \"Let's go on an adventure!\"\nThe screen is blank, it's powered on."),
    pockets = {},
    tool = { power_draw = "0 W", charges_per_use = 0 },
    use_actions = {
        {
            kind = "mp3",
            target = "mp3_reverberation",
            message = ccb.content.text("You turn off the device."),
            activate = false,
        },
    },
}
