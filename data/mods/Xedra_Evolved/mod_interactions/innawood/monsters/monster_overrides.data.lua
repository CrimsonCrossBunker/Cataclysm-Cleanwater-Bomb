local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_renfield_innawood",
    copy_from = "mon_renfield",
    name = ccb.content.plural_text("renfield", "renfields"),
    upgrade = { half_life = 200, monster_group = "GROUP_RENFIELD_UPGRADE_INNAWOOD" },
}

ccb.content.define_monster { id = "mon_vampire_feral_innawood", copy_from = "mon_vampire_feral" }

ccb.content.define_monster { id = "mon_vampire_moroi_fast_innawood", copy_from = "mon_vampire_moroi_fast" }

ccb.content.define_monster { id = "mon_vampire_moroi_tough_innawood", copy_from = "mon_vampire_moroi_tough" }

ccb.content.define_monster { id = "mon_vampire_moroi_animalistic_innawood", copy_from = "mon_vampire_moroi_animalistic" }

ccb.content.define_monster { id = "mon_vampire_moroi_stealthy_innawood", copy_from = "mon_vampire_moroi_stealthy" }

ccb.content.define_monster {
    id = "mon_fetch_child",
    copy_from = "mon_fetch_child",
    death = { drops = "fetch_child_death_drops" },
}
