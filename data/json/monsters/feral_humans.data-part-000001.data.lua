local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_feral_sapien_spear",
    name = ccb.content.plural_text("cunning feral", "cunning ferals"),
    description = ccb.content.text("This feral human's eyes look more focused, and its movements steadier, than others of their kind.  They're carrying a crude spear, and have assembled some basic armor from scavenged clothing and bits of riot armor, though you can see several gaps.  Despite these signs of greater intelligence, this creature is still only a few steps away from being a zombie themselves."),
    copy_from = "mon_feral_human_pipe",
    dodge = 3,
    attacks = { { reference = "PARROT_AT_DANGER", cooldown = 0 }, { id = "feral_weapon_spear_knife" } },
    vision_day = 50,
    zombify_into = "mon_zombie_survivor",
    armor = { bash = 9, cut = 14, acid = 4, bullet = 18 },
    inheritance = {
        add = {
            flags = { "PRIORITIZE_TARGETS" },
            weakpoint_sets = { "wps_humanoid_body_armor" },
            families = { "prof_wp_syn_armored" },
        },
    },
    death = { drops = "feral_sapien_death_drops_spear" },
}

ccb.content.define_monster {
    id = "mon_chud",
    name = ccb.content.plural_text("feral troglobite", "feral troglobites"),
    description = ccb.content.text("This person is still alive but completely crazed, changed by something they were exposed to down here.  Their face is dominated by unnaturally large, faintly glowing eyes and needle-sharp teeth poking through their lips.  They remind you of something out of a campy monster movie - and of the good times when underground cannibals were less of a real concern."),
    copy_from = "mon_feral_human_pipe",
    looks_like = "mon_zombie_runner",
    symbol = "@",
    color = "white",
    melee_skill = 6,
    melee_dice = 2,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 3 } },
    weakpoint_sets = { "wps_humanoid_body", "wps_vital_organs", "wps_eyes" },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    dodge = 4,
    vision_night = 15,
    attacks = {
        { id = "scratch", minimum_damage_multiplier = 0.5, cooldown = 10 },
        { minimum_damage_multiplier = 0.7, cooldown = 15, kind = "bite" },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
    },
    dissect = "dissect_troglobite_sample_small",
    zombify_into = "mon_zombie_shady",
    inheritance = { add = { flags = { "FILTHY", "INFRARED_VISION" } } },
    death = { drops = "default_zombie_death_drops" },
}
