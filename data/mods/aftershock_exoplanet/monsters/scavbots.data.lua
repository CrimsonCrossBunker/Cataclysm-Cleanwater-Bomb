local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_eyebot_heater",
    copy_from = "mon_afs_eyebot",
    name = ccb.content.plural_text("floating heater", "floating heaters"),
    color = "pink",
    luminance = 8,
    description = ccb.content.text("A salvaged eyebot repurposed into a floating space heater.  It emits a constant jet of warm air to heat an enclosed space."),
    revert_item = "bot_eyebot_heater",
    fear_triggers = { "HURT" },
    emissions = { { id = "emit_hot_air2_stream", delay = "1 s" } },
    armor = { bash = 8, cut = 10, bullet = 15 },
    inheritance = { add = { flags = { "PET_WONT_FOLLOW", "WARM" } } },
}
