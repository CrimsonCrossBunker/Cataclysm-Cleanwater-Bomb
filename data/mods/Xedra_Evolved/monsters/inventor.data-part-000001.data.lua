local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_sniperbot_science",
    copy_from = "mon_sniperbot",
    default_faction = "science",
    revert_item = "bot_sniperbot",
    broken_item = "broken_sniperbot",
    death = { outcome = { corpse = "BROKEN" } },
}
