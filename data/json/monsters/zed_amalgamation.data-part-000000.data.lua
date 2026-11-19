local ccb = require("ccb")

-- 10 - 35 kg corpse
ccb.content.define_monster {
    id = "mon_meat_cocoon_tiny",
    copy_from = "mon_meat_cocoon_small",
    name = ccb.content.plural_text("tiny meat cocoon", "tiny meat cocoons"),
    description = ccb.content.text("A small, wet sack of pink skin, with something dog-sized moving around underneath the surface.  Black roots anchor it to the ground."),
    volume = "20 L",
    mass = "20 kg",
    upgrade = { grow_at_age = 1, monster_group = "GROUP_COCOON_TINY" },
    death = {
        drops = "explode_innards_small",
        outcome = {
            message = ccb.content.text("The %s explodes in a shower of gore!"),
            corpse = "NO_CORPSE",
            spell = { id = "death_blood", hit_self = true, min_level = 0 },
        },
    },
}

-- 36-100 kg corpse
-- No REVIVE until monsters get smart enough to pulp/eat zombies
ccb.content.define_monster {
    id = "mon_meat_cocoon_small",
    name = ccb.content.plural_text("small meat cocoon", "small meat cocoons"),
    looks_like = "mon_breather",
    description = ccb.content.text("A sack of pink flesh sitting in the middle of a net of black roots.  At irregular intervals it shudders as something (or multiple somethings?) inside changes position.  You're not sure you want to know what's inside."),
    color = "black_red",
    symbol = "8",
    body_type = "blob",
    materials = { "flesh" },
    species = { "ZOMBIE", "ABERRATION" },
    default_faction = "zombie",
    volume = "75 L",
    mass = "75 kg",
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_amalgamation" },
    hp = 100,
    speed = 100,
    upgrade = {
        grow_at_age = 1,
        monster_group = "GROUP_COCOON_SMALL",
        multiple_spawns = true,
        spawn_range = 5,
    },
    flags = { "IMMOBILE", "NO_BREATHE", "WARM" },
    death = {
        drops = "explode_innards_small",
        outcome = {
            message = ccb.content.text("The %s explodes in a shower of gore!"),
            corpse = "NO_CORPSE",
            spell = { id = "death_blood", hit_self = true, min_level = 1 },
        },
    },
}

-- 101-300 kg corpse
ccb.content.define_monster {
    id = "mon_meat_cocoon_med",
    copy_from = "mon_meat_cocoon_small",
    looks_like = "mon_breather_hub",
    name = ccb.content.plural_text("large meat cocoon", "large meat cocoons"),
    description = ccb.content.text("A mass of pink flesh the size of a fridge squirming constantly, black veins anchoring it to the ground.  Occasionally a malformed limb pushes against the skin from the inside, before a churn of the cocoon pushes it back.  Not ready yet, it seems."),
    volume = "200 L",
    mass = "200 kg",
    hp = 200,
    upgrade = {
        grow_at_age = 1,
        monster_group = "GROUP_COCOON_MED_1",
        multiple_spawns = true,
        spawn_range = 5,
    },
    death = {
        drops = "explode_innards",
        outcome = {
            message = ccb.content.text("The %s explodes in a shower of gore!"),
            corpse = "NO_CORPSE",
            spell = { id = "death_blood", hit_self = true, min_level = 2 },
        },
    },
}

-- 300+ kg
ccb.content.define_monster {
    id = "mon_meat_cocoon_large",
    copy_from = "mon_meat_cocoon_small",
    looks_like = "mon_breather_hub",
    name = ccb.content.plural_text("gigantic meat cocoon", "gigantic meat cocoons"),
    description = ccb.content.text("A rigid, off-white lump of flesh the size of a small car constricted by bands of rope-sized pulsing black veins that tie it to the floor below.  The whole thing is shuddering constantly, and gives off an otherworldly stench."),
    volume = "450 L",
    mass = "450 kg",
    hp = 600,
    upgrade = {
        grow_at_age = 1,
        monster_group = "GROUP_COCOON_LARGE",
        multiple_spawns = true,
        spawn_range = 5,
    },
    death = {
        drops = "explode_innards",
        outcome = {
            message = ccb.content.text("The %s explodes in a shower of gore!"),
            corpse = "NO_CORPSE",
            spell = { id = "death_blood", hit_self = true, min_level = 3 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_amalgamation_breather",
    name = ccb.content.plural_text("breather", "breathers"),
    description = ccb.content.text("This is some sort of unearthly pink flesh sac; moist and ridged with veins, it is otherwise without discernible exterior features.  Seemingly immobile and defenseless, it sits in place, swelling and collapsing upon itself as it breathes."),
    default_faction = "zombie",
    body_type = "blob",
    species = { "ZOMBIE", "ABERRATION" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 100,
    speed = 100,
    symbol = "o",
    color = "pink",
    melee_damage = { { type = "cut", amount = 0 } },
    melee_training_cap = 2,
    harvest = "exempt",
    attacks = { { reference = "BREATHE", cooldown = 8 } },
    flags = { "IMMOBILE", "NOGIB" },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s melts away.") } },
}

ccb.content.define_monster {
    id = "mon_amalgamation_breather_hub",
    name = ccb.content.plural_text("breather", "breathers"),
    description = ccb.content.text("A weird mass of immobile, breathing pink goo.  The other breathers seem to originate from this one."),
    default_faction = "zombie",
    body_type = "blob",
    species = { "ZOMBIE", "ABERRATION" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 100,
    speed = 100,
    symbol = "O",
    color = "pink",
    melee_damage = { { type = "cut", amount = 0 } },
    harvest = "exempt",
    attacks = { { reference = "BREATHE", cooldown = 8 } },
    flags = { "ACIDPROOF", "ACID_BLOOD", "IMMOBILE" },
    death = { outcome = { spell = { id = "death_kill_breathers", hit_self = true }, corpse = "NO_CORPSE" } },
}

-- NO_I18N
-- TODO: When effects/spells can mess with path settings + flags move smartness to the effect of dedicated coordinatiors
ccb.content.define_monster {
    id = "mon_amalgamation_abstract_small",
    abstract = true,
    name = ccb.content.text_without_extraction("abstracted amalgamation"),
    color = "white",
    symbol = "a",
    body_type = "spider",
    materials = { "flesh" },
    species = { "ZOMBIE", "ABERRATION" },
    default_faction = "zombie",
    volume = "37 L",
    mass = "40 kg",
    hp = 160,
    speed = 110,
    scents_tracked = { "sc_human", "sc_fetid" },
    attack_cost = 110,
    melee_skill = 5,
    melee_dice = 3,
    melee_sides = 3,
    dodge = 6,
    bleed_rate = 0,
    vision_day = 20,
    vision_night = 8,
    aggression = 100,
    morale = 100,
    weakpoint_sets = { "wps_amalgamation_base" },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_amalgamation" },
    harvest = "zombie_amalgamation",
    pathing = { avoid_sharp = true, avoid_traps = true, avoid_dangerous_fields = true, max_distance = 400 },
    flags = { "SEES", "SMELLS", "HEARS", "PATH_AVOID_DANGER", "REVIVES", "NO_BREATHE", "VENOM_IMMUNE" },
    armor = { bash = 8, cut = 4, stab = 4, acid = 5, bullet = 12, electric = 5 },
}

ccb.content.define_monster {
    id = "mon_amalgamation_abstract_med",
    abstract = true,
    copy_from = "mon_amalgamation_abstract_small",
    symbol = "A",
    volume = "120 L",
    mass = "120 kg",
    hp = 180,
    melee_skill = 7,
    dodge = 5,
    vision_night = 10,
    armor = { bash = 16, cut = 10, stab = 16, acid = 8, bullet = 30, electric = 8 },
    inheritance = { add = { flags = { "BASHES", "GROUP_BASH" } } },
}
