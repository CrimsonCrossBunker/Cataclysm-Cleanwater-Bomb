local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_rot",
    name = ccb.content.plural_text("decayed zombie", "decayed zombies"),
    description = ccb.content.text("A once-dead human corpse.  Its discolored, swollen flesh is riddled with festering wounds and open sores.  It smells indescribably awful."),
    copy_from = "mon_zombie_base",
    hp = 55,
    speed = 60,
    color = "light_green_yellow",
    melee_skill = 1,
    melee_sides = 2,
    grab_strength = 15,
    fungalize_into = "mon_zombie_rot_dusted",
    emissions = { { id = "emit_nauseating_smell", delay = "1 s" } },
    upgrade = { half_life = 172, monster_group = "GROUP_ZOMBIE_DECAYED_UPGRADE" },
    inheritance = { add = { flags = { "GEN_DORMANT", "CLUMSY_ATTACKS" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_swat",
    name = ccb.content.plural_text("SWAT zombie", "SWAT zombies"),
    description = ccb.content.text("This zombie was part of a specialized unit of law enforcement.  It still wears a battered armor with the SWAT logo emblazoned on the front.  The protective mask makes its head a difficult target, but also prevents it from biting you."),
    copy_from = "mon_zombie_cop",
    hp = 90,
    speed = 75,
    melee_sides = 5,
    grab_strength = 30,
    upgrade = { half_life = 152, monster = "mon_zombie_kevlar_0" },
    armor = { bash = 10, cut = 16, bullet = 18, electric = 3 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet" },
            families = { "prof_wp_syn_armored" },
            flags = { "CLUMSY_ATTACKS" },
        },
        remove = { attacks = { "bite_humanoid" } },
    },
    death = { drops = "mon_zombie_swat_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_tough",
    name = ccb.content.plural_text("tough zombie", "tough zombies"),
    description = ccb.content.text("This was once an athletic human, now a brutal monster.  Its facial features are twisted into an expression of pure rage."),
    copy_from = "mon_zombie_base",
    hp = 100,
    speed = 85,
    color = "light_red",
    melee_dice = 3,
    melee_damage = { { type = "cut", amount = 1 } },
    dodge = 1,
    grab_strength = 30,
    attacks = {
        { id = "grab", cooldown = 7 },
        { id = "bite_humanoid", cooldown = 5, minimum_damage_multiplier = 0.7 },
        { id = "scratch_humanoid" },
    },
    fungalize_into = "mon_zombie_tough_dusted",
    armor = { bash = 2, cut = 1, bullet = 1, electric = 2 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_humanoid_head_small" },
            flags = { "GEN_DORMANT", "CLUMSY_ATTACKS" },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_resort_dancer",
    name = ccb.content.plural_text("sleek zombie", "sleek zombies"),
    description = ccb.content.text("This zombie is rather sleek and scantily clothed."),
    copy_from = "mon_zombie",
    looks_like = "mon_zombie",
    upgrade = { half_life = 120, monster_group = "GROUP_ZOMBIE_UPGRADE" },
    death = { drops = "mon_zombie_resort_dancer_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_resort_bouncer",
    name = ccb.content.plural_text("bouncer zombie", "bouncer zombies"),
    description = ccb.content.text("This muscular zombie is dressed in the tattered remnants of a security uniform."),
    copy_from = "mon_zombie_tough",
    death = { drops = "mon_zombie_resort_bouncer_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_resort_staff",
    copy_from = "mon_zombie",
    looks_like = "mon_zombie",
    death = { drops = "mon_zombie_resort_staff_death_drops" },
}
