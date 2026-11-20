local ccb = require("ccb")

ccb.content.define_item {
    id = "smart_watch_adv_music",
    copy_from = "smart_watch_adv",
    name = ccb.content.plural_text("advanced smart watch - music", "advanced smart watches - music"),
    description = ccb.content.text("This advanced smart watch is playing music, steadily raising your morale.  You can't hear anything else while you're listening."),
    revert_to = "smart_watch_adv",
    inheritance = { add = { flags = { "TRADER_AVOID" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "200 mW" },
    armor = {},
    use_actions = {
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        "CAMERA",
        "CALORIES_INTAKE_TRACKER",
        "FITNESS_CHECK",
        "PORTABLE_GAME",
        {
            kind = "mp3",
            target = "smart_watch_adv",
            message = ccb.content.text("You stop listening to music and take your earbuds out."),
            activate = false,
        },
        { kind = "link_up", cable_length = 3, charge_rate = "20 W" },
    },
    tick_actions = { "MP3_ON" },
}
