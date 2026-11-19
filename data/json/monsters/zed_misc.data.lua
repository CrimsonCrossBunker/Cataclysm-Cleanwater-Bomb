local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_swimmer_base",
    name = ccb.content.plural_text("swimmer zombie", "swimmer zombies"),
    description = ccb.content.text("A zombie clad in swimwear.  Probably not a very graceful swimmer anymore."),
    copy_from = "mon_zombie_base",
    hp = 60,
    speed = 90,
    color = "light_blue",
    melee_skill = 2,
    melee_dice = 1,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 3 } },
    dodge = 1,
    upgrade = { half_life = 120, monster = "mon_zombie_swimmer" },
    categories = { "CLASSIC" },
    inheritance = { add = { flags = { "CLUMSY_ATTACKS" } } },
    death = { drops = "mon_zombie_swimmer_death_drops" },
}

-- Tier 2 mob, but webbed hands don't sound very grabby
ccb.content.define_monster {
    id = "mon_zombie_swimmer",
    name = ccb.content.plural_text("webbed zombie", "webbed zombies"),
    description = ccb.content.text("A slick and glistening human body clad in swimwear.  Its hands and feet are heavily webbed, suggesting some kind of rapid evolutionary adaptation to water."),
    copy_from = "mon_zombie_base",
    hp = 70,
    speed = 95,
    move_skills = { swim = 10 },
    color = "light_blue",
    melee_skill = 3,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 2 } },
    dodge = 2,
    upgrade = { half_life = 168, monster = "mon_zombie_mancroc" },
    inheritance = { add = { flags = { "WATER_CAMOUFLAGE", "CLUMSY_ATTACKS" } } },
    death = { drops = "mon_zombie_swimmer_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_technician",
    name = ccb.content.plural_text("zombie technician", "zombie technicians"),
    description = ccb.content.text("Still wearing its work clothes and hardhat, this zombie likely used to work on power lines or other electrical equipment."),
    copy_from = "mon_zombie_base",
    hp = 85,
    speed = 75,
    color = "i_light_cyan",
    melee_skill = 5,
    vision_day = 15,
    vision_night = 2,
    armor = { bash = 2, cut = 2, bullet = 2, electric = 3 },
    inheritance = { add = { weakpoint_sets = { "wps_humanoid_open_helmet" }, flags = { "CLUMSY_ATTACKS" } } },
    death = { drops = "mon_zombie_technician_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_miner",
    name = ccb.content.plural_text("zombie miner", "zombie miners"),
    description = ccb.content.text("This zombie's face, hands, work clothes, and miner's helmet are fully covered with stains of coal dust."),
    copy_from = "mon_zombie_base",
    looks_like = "mon_zombie_technician",
    hp = 85,
    speed = 75,
    color = "i_light_cyan",
    melee_skill = 5,
    vision_day = 15,
    vision_night = 2,
    upgrade = { half_life = 140, monster_group = "GROUP_ZOMBIE_MINER_UPGRADE" },
    armor = { bash = 2, cut = 2, bullet = 2, electric = 1 },
    inheritance = { add = { weakpoint_sets = { "wps_humanoid_open_helmet" }, flags = { "CLUMSY_ATTACKS" } } },
    death = { drops = "mon_zombie_miner_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_thorny",
    name = ccb.content.plural_text("thorny shambler", "thorny shamblers"),
    description = ccb.content.text("A shambling undead humanoid, its body overgrown with a tangled mass of otherworldly vegetation.  Hunched over and dragging its feet as it moves, the bramble utterly enveloping its upper half twitches and moves with a life of its own, tendrils tipped with a paralytic sting."),
    copy_from = "mon_zombie_base",
    species = { "ZOMBIE", "PLANT" },
    speed = 50,
    materials = { "veggy" },
    scents_tracked = { "sc_human", "sc_fetid", "sc_flower" },
    melee_skill = 3,
    melee_damage = { { type = "cut", amount = 4 } },
    bleed_rate = 50,
    vision_night = 5,
    harvest = "zombie_thorny",
    attack_effects = { { id = "paralyzepoison", duration = 33 } },
    attacks = {
        { id = "grab", cooldown = 7 },
        { id = "scratch_humanoid" },
        { reference = "PARA_STING", cooldown = 30 },
    },
    upgrade = false,
    armor = { bash = 2, cut = 4, bullet = 3, electric = 1 },
    inheritance = { add = { flags = { "SMELLS", "RANGED_ATTACKER", "PARALYZEVENOM", "CLUMSY_ATTACKS" } } },
    death = { drops = "mon_zombie_thorny_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_reenactor",
    name = ccb.content.plural_text("ravenous reenactor", "ravenous reenactors"),
    description = ccb.content.text("This shambling corpse is dressed in the tatters of an antiquated soldier's uniform.  Either it was a historical reenactor, or zombies have also started to time travel."),
    copy_from = "mon_zombie",
    color = "blue",
    death = { drops = "zombie_reenactor_drops" },
}

-- The torn fursuit offers slightly more protection.
ccb.content.define_monster {
    id = "mon_zombie_fursuit",
    name = ccb.content.plural_text("fursuited zombie", "fursuited zombies"),
    description = ccb.content.text("A human body, swaying awkwardly in a torn cloth suit of an anthropomorphized animal.  Black goo and blood cakes the suit, and it gives off a foul, rotting odor."),
    copy_from = "mon_zombie",
    speed = 50,
    color = "white_green",
    melee_skill = 3,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 2 } },
    armor = { bash = 5, cut = 5, bullet = 1, electric = 1 },
    death = {
        drops = {
            kind = "collection",
            groups = {
                { id = "default_zombie_clothes", weight = 100 },
                { id = "zombie_fursuits", weight = 100 },
            },
        },
    },
}

-- No PARROT is deliberate, it's in no condition to speak
ccb.content.define_monster {
    id = "mon_zombie_rot_grabber",
    name = ccb.content.plural_text("decayed grasper", "decayed graspers"),
    description = ccb.content.text("A once-dead human corpse, moving despite seeming like it could fall apart into putrescence at any moment.  It slowly crawls along the ground with an eerily-fluid motion."),
    copy_from = "mon_zombie_base",
    hp = 55,
    speed = 30,
    color = "light_green_yellow",
    melee_skill = 1,
    melee_sides = 2,
    grab_strength = 50,
    vision_day = 15,
    fungalize_into = "mon_zombie_rot_dusted",
    upgrade = false,
    attacks = {
        { id = "bite_humanoid", cooldown = 5 },
        { id = "scratch_humanoid" },
        {
            id = "grab",
            accuracy = 4,
            move_cost = 25,
            cooldown = 2,
            attack_upper = false,
            avatar_hit = ccb.content.text_without_extraction("%1$s winds its limbs around your %2$s!"),
            npc_hit = ccb.content.text_without_extraction("%1$s winds its limbs around <npcname>'s %2$s!"),
        },
    },
    inheritance = { add = { flags = { "GEN_DORMANT" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_rot_diseased",
    name = ccb.content.plural_text("zombie plaguebearer", "zombie plaguebearers"),
    description = ccb.content.text("The skin of this walking corpse glistens with disturbing fluids.  Even at a distance, the smell nearly makes you gag."),
    copy_from = "mon_zombie_base",
    hp = 65,
    speed = 70,
    color = "light_green_yellow",
    melee_skill = 3,
    melee_sides = 2,
    grab_strength = 50,
    attack_effects = {
        { id = "pre_flu", duration = 432000, chance = 2 },
        { id = "rat_bite_fever", duration = 345600, chance = 3 },
    },
    fungalize_into = "mon_zombie_rot_dusted",
    emissions = { { id = "emit_nauseating_smell", delay = "1 s" } },
    upgrade = false,
    attacks = {
        { id = "bite_humanoid", cooldown = 5, infection_chance = 95 },
        { id = "grab", cooldown = 2 },
        { id = "scratch_humanoid" },
    },
}
