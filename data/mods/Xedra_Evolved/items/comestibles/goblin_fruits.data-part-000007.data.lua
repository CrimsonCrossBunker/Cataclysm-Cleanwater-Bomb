local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_dream_shadow_player",
    copy_from = "mon_dream_shadow",
    name = ccb.content.plural_text("shadow", "shadows"),
    default_faction = "player",
}
