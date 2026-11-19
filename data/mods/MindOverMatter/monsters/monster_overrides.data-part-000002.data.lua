local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_shoggoth",
    copy_from = "mon_shoggoth",
    inheritance = { add = { flags = { "TEEP_IMMUNE" }, armor = { psi_telekinetic_damage = 20 } } },
}

ccb.content.define_monster {
    id = "mon_fleshy_shambler",
    copy_from = "mon_fleshy_shambler",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_jabberwock",
    copy_from = "mon_jabberwock",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_flesh_golem",
    copy_from = "mon_flesh_golem",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_amigara_horror",
    copy_from = "mon_amigara_horror",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_breather",
    copy_from = "mon_breather",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_shrapnel_swarm",
    copy_from = "mon_shrapnel_swarm",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_structural_spur",
    copy_from = "mon_structural_spur",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_dog_thing",
    copy_from = "mon_dog_thing",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_flaming_eye",
    copy_from = "mon_flaming_eye",
    inheritance = { add = { flags = { "TEEP_IMMUNE" }, armor = { psi_telekinetic_damage = 20 } } },
}

ccb.content.define_monster {
    id = "mon_flying_polyp",
    copy_from = "mon_flying_polyp",
    inheritance = { add = { flags = { "TEEP_IMMUNE" }, armor = { psi_telekinetic_damage = 15 } } },
}

ccb.content.define_monster {
    id = "mon_headless_dog_thing",
    copy_from = "mon_headless_dog_thing",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}
