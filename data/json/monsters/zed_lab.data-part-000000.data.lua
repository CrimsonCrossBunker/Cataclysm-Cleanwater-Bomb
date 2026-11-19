local ccb = require("ccb")

-- zombie scientists are recognised as friendly by the lab's defense system
ccb.content.define_monster {
    id = "mon_zombie_scientist",
    name = ccb.content.plural_text("zombie scientist", "zombie scientists"),
    description = ccb.content.text("The remaining protective gear, laboratory equipment, and long, formerly white labcoat tell you that this zombie was some kind of researcher before turning."),
    copy_from = "mon_zombie_base",
    default_faction = "science",
    categories = { "CLASSIC" },
    color = "white_cyan",
    inheritance = { remove = { flags = { "GROUP_BASH" } } },
    death = { drops = "mon_zombie_scientist_death_drops" },
}
