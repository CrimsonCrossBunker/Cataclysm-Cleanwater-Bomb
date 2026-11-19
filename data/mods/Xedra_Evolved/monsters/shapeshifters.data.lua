local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_werewolf_shadow_pack",
    copy_from = "mon_werewolf_elder",
    looks_like = "mon_loup_garou",
    name = ccb.content.plural_text("shadow pack", "shadow packs"),
    description = ccb.content.text("A mighty hunter of the People from ages past, now given form again to join in the Hunt."),
    default_faction = "player",
}
