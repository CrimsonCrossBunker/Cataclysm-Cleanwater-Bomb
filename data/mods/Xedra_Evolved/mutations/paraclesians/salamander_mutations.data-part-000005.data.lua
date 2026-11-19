local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SALAMANDER_SLEEP_LESS3",
    name = ccb.content.text("The Watchfire Burns Throughout the Night"),
    points = 10,
    description = ccb.content.text("Like a blazing signal fire, a Salamander never stops shining.  They never need to sleep if they do not want to, and when they do, they need much less sleep than normal.  However, they require twice as much food as a human."),
    prerequisites = { "SALAMANDER_SLEEP_LESS2" },
    types = { "SLEEP" },
    active = true,
    activation_setup_only = true,
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    enchantments = { "INLINE_ENCH_SALAMANDER_SLEEP_LESS3_0" },
    cooldown = "6 h",
    on_activate = "salamander_reset_sleep",
    on_process = "salamander_reset_sleep",
}
