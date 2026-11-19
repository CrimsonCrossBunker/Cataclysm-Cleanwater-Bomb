local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_feral_human_vita3_revived",
    name = ccb.content.plural_text("font of vitality", "fonts of vitality"),
    description = ccb.content.text("This is the healthiest person you've even seen, especially after the end of the world.  Their skin positively glows, and as you watch them brush past a jagged chunk of wood to get to you, the wound they receive immediately stops bleeding and rapidly begins to close."),
    copy_from = "mon_feral_human_vita3",
    death = { drops = "feral_humans_death_drops_vita", outcome = {} },
}
