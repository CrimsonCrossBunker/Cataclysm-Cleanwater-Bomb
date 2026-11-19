local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_spitter",
    name = ccb.content.plural_text("spitter zombie", "spitter zombies"),
    description = ccb.content.text("A hunched human body with its eyes pushed up into its forehead and drooping cheeks, most of its face is occupied by a puckered mouth.  Its stomach is swollen and nearly translucent, with a sickly yellow tint."),
    copy_from = "mon_zombie_base",
    difficulty_adjustment = 10,
    hp = 70,
    speed = 95,
    color = "yellow_green",
    melee_skill = 3,
    melee_sides = 6,
    dodge = 1,
    bleed_rate = 50,
    harvest = "zombie_humanoid_acid",
    attacks = { { reference = "ACID", cooldown = 20 } },
    upgrade = { half_life = 168, monster = "mon_zombie_corrosive" },
    fungalize_into = "mon_zombie_acidic_dusted",
    inheritance = {
        add = {
            flags = { "ACIDPROOF", "ACID_BLOOD", "RANGED_ATTACKER" },
            weakpoint_sets = { "wps_humanoid_head_big" },
        },
    },
    death = {
        outcome = {
            message = ccb.content.text("The %s's body leaks acid."),
            spell = { id = "death_acid", hit_self = true },
        },
    },
}

-- Higher weight from attached junks.
ccb.content.define_monster {
    id = "mon_zombie_wretched",
    name = ccb.content.plural_text("wretched puker", "wretched pukers"),
    description = ccb.content.text("A degenerate corpse, shambling as it walks.  Various pieces of trash and waste materials have melded into the black goo leaking from its skin."),
    copy_from = "mon_zombie_base",
    difficulty_adjustment = 2,
    mass = "84500 g",
    hp = 55,
    speed = 65,
    looks_like = "mon_zombie_acidic",
    color = "dark_gray_yellow",
    melee_skill = 2,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 1 } },
    vision_day = 14,
    harvest = "zombie_humanoid_acid",
    attacks = { { reference = "ACID_BARF", cooldown = 22 } },
    upgrade = { half_life = 120, monster = "mon_zombie_acidic" },
    inheritance = { add = { flags = { "ACIDPROOF", "ACID_BLOOD" } } },
    death = {
        outcome = {
            message = ccb.content.text("The %s's body leaks acid."),
            spell = { id = "death_acid", hit_self = true },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_dog_acidic",
    name = ccb.content.plural_text("acidic zombie dog", "acidic zombie dogs"),
    description = ccb.content.text("A deformed, sickly-looking animated corpse of a canine.  A dangerous-looking yellow saliva drips from its mouth."),
    default_faction = "zombie",
    aggression = 100,
    morale = 100,
    body_type = "dog",
    symbol = "d",
    color = "light_gray_yellow",
    species = { "ZOMBIE" },
    materials = { "flesh" },
    volume = "30000 ml",
    mass = "40750 g",
    scents_tracked = { "sc_human", "sc_fetid" },
    difficulty_adjustment = 5,
    hp = 24,
    speed = 85,
    melee_skill = 3,
    melee_dice = 1,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 2 }, { type = "acid", amount = 4 } },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie" },
    dodge = 1,
    harvest = "zombie_dog_acid",
    grab_strength = 20,
    attacks = {
        { id = "bite_grab", attack_upper = false, cooldown = 5 },
        { id = "scratch_grab_required", attack_upper = false },
        { reference = "ACID_BARF", cooldown = 10 },
    },
    upgrade = { half_life = 120, monster = "mon_zombie_dog_brute_acidic" },
    flags = {
        "SEES", "HEARS", "SMELLS", "STUMBLES", "WARM", "GOODHEARING", "GRABS", "BASHES", "POISON",
        "NO_BREATHE", "REVIVES", "FILTHY", "ACIDPROOF", "ACID_BLOOD", "RANGED_ATTACKER",
    },
    armor = { electric = 1 },
    death = {
        drops = "mon_dog_death_drops",
        outcome = {
            message = ccb.content.text("The %s's body leaks acid."),
            spell = { id = "death_acid", hit_self = true },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_dog_brute_acidic",
    copy_from = "mon_zombie_dog_acidic",
    name = ccb.content.plural_text("blistered horror", "blistered horrors"),
    description = ccb.content.text("A huge canine with multiple large, foul-looking blisters covering its body.  A corrosive liquid spills from its menacing-looking mouth."),
    color = "yellow_white",
    upgrade = false,
    grab_strength = 40,
    harvest = "zombie_dog_acid",
    attacks = {
        {
            id = "bite_grab",
            attack_upper = false,
            cooldown = 5,
            minimum_damage_multiplier = 0.75,
            maximum_damage_multiplier = 1.5,
        },
        {
            id = "scratch_grab_required",
            attack_upper = false,
            minimum_damage_multiplier = 0.75,
            maximum_damage_multiplier = 1.5,
        },
        { reference = "ACID_BARF", cooldown = 10 },
    },
    bleed_rate = 50,
    defense = { id = "ACIDSPLASH", chance = 100 },
    inheritance = {
        scale = { hp = 1.8, speed = 1.3, volume = 1.4, mass = 1.1 },
        offset = {
            melee_dice = 1,
            melee_sides = 4,
            melee_damage = { { type = "cut", amount = 2 }, { type = "acid", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 4, bullet = 3, electric = 1 },
        },
    },
}
