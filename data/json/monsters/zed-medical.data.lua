local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_medical",
    name = ccb.content.plural_text("zombie medic", "zombie medics"),
    description = ccb.content.text("This shambling corpse is dressed like a medical professional.  It was either a doctor, or only played one on TV."),
    copy_from = "mon_zombie",
    looks_like = "mon_zombie",
    color = "blue",
    upgrade = { half_life = 120, monster_group = "GROUP_MEDICAL_UPGRADE" },
    death = { drops = "mon_zombie_medical_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_medical_brute",
    name = ccb.content.plural_text("medical horror", "medical horrors"),
    description = ccb.content.text("A former doctor of some sort, though its uniform has been torn apart.  You assume the oversized muscles that cover it to be the culprit."),
    copy_from = "mon_zombie_brute",
    looks_like = "mon_zombie_brute",
    color = "red",
    death = { drops = "mon_zombie_medical_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_medical_regenerating",
    name = ccb.content.plural_text("regenerating zombie medic", "regenerating zombie medics"),
    description = ccb.content.text("The zombified remains of a practitioner of medicine, you aren't certain what field - your focus is instead drawn to the way that its pink flesh snakes all over it, weaving its way over wounds and injuries."),
    copy_from = "mon_zombie_regenerating",
    looks_like = "mon_zombie_regenerating",
    upgrade = { half_life = 120, monster = "mon_zombie_regenerating_hunter" },
    death = { drops = "mon_zombie_medical_death_drops" },
}

ccb.content.define_monster {
    id = "mon_skeleton_medical",
    name = ccb.content.plural_text("sawbones", "sawbones"),
    description = ccb.content.text("A malformed armor of misshapen bone has grown over this zombie, having pushed what remains of the skin out of the way.  The clothes of a medical worker are still draped over it."),
    copy_from = "mon_skeleton",
    looks_like = "mon_skeleton",
    color = "white",
    death = { drops = "zombie_medical_clothes" },
}

ccb.content.define_monster {
    id = "mon_zombie_medical_acidic",
    name = ccb.content.plural_text("doctor burns", "doctor burns"),
    description = ccb.content.text("This is the body of a doctor or nurse of some kind.  It's hard to tell now that most of its clothing has corroded away from whatever vile acid its secreting."),
    copy_from = "mon_zombie_acidic",
    looks_like = "mon_zombie_acidic",
    death = { drops = "mon_zombie_medical_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_medical_pupa",
    copy_from = "mon_zombie_pupa",
    looks_like = "mon_zombie_pupa",
    death = { drops = "mon_zombie_medical_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_pupa_medical_decoy",
    copy_from = "mon_zombie_pupa_decoy",
    looks_like = "mon_zombie_pupa_decoy",
    death = { drops = "mon_zombie_medical_death_drops" },
}
