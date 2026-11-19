local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_scientist_phavian",
    copy_from = "mon_zombie_scientist",
    looks_like = "mon_zombie_scientist",
    name = ccb.content.plural_text("zombie scientist", "zombie scientists"),
    death = { drops = "mon_zombie_scientist_phavian_death_drops" },
}

-- Heat armor is needed to make it immune to pyrokinesis.
ccb.content.define_monster {
    id = "mon_zombie_blank",
    copy_from = "mon_zombie_base",
    name = ccb.content.plural_text("zombie blank", "zombie blanks"),
    description = ccb.content.text("This zombie looks fairly ordinary, other than walking slightly more quickly than the standard shambling.  But there's something subtly wrong about it.  When you look directly at it, gray static flickers on the edge of your vision and you hear a very low droning hum."),
    species = { "ZOMBIE", "HUMAN", "PSI_NULL" },
    symbol = "Z",
    color = "dark_gray_white",
    dodge = 1,
    bleed_rate = 50,
    vision_day = 30,
    vision_night = 5,
    emissions = { { id = "emit_anti_psi", delay = "1 s" } },
    upgrade = { half_life = 120, monster_group = "GROUP_ZOMBIE_BLANK_UPGRADE" },
    armor = {
        electric = 1,
        heat = 999,
        psi_telekinetic_damage = 999,
        psi_telepathic_damage = 999,
        psi_teleporter_teleporting_damage = 999,
        psi_enervation_damage = 999,
    },
    inheritance = {
        add = {
            flags = {
                "FIREPROOF", "ENERVATE_IMMUNE", "PHOTOKIN_MONSTER_IMMUNE", "TELEPORT_IMMUNE",
                "TEEP_IMMUNE", "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE",
            },
        },
        scale = { speed = 1.15 },
    },
    death = { outcome = { spell = { id = "delete_nullifying_fields_monster", hit_self = true } } },
}
