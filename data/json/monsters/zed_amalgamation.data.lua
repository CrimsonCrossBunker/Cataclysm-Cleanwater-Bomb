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

-- Small, nasty glass cannon spawning in groups.  WP: mandible, leg
ccb.content.define_monster {
    id = "mon_amalgamation_swarmer",
    copy_from = "mon_amalgamation_abstract_small",
    name = ccb.content.plural_text("swarming amalgamation", "swarming amalgamations"),
    description = ccb.content.text("A small, flat creature dashing around erratically on seven short legs.  Its form is dominated by an oversized set of black mandibles on an almost comically small head, featureless apart from a single black eye.  The rest of the body is covered with sickly white skin crisscrossed by black veins."),
    volume = "20 L",
    mass = "20 kg",
    hp = 35,
    speed = 120,
    move_skills = { climb = 6 },
    attack_cost = 120,
    melee_dice = 2,
    melee_damage = { { type = "cut", amount = 3 } },
    attacks = {
        {
            cooldown = 3,
            move_cost = 150,
            damage = { { type = "cut", amount = 15, penetration = 5 } },
            minimum_hit_size = 4,
            minimum_damage_multiplier = 0.5,
            maximum_damage_multiplier = 1.2,
            infection_chance = 10,
            attack_upper = false,
            kind = "bite",
            when = "monster_attack_intact_mandibles",
        },
    },
    vision_day = 18,
    inheritance = {
        add = {
            flags = { "SWARMS", "HARDTOSHOOT", "HIT_AND_RUN" },
            weakpoint_sets = { "wps_amalgamation_mandible" },
        },
    },
}

ccb.content.define_monster {
    id = "mon_amalgamation_spotter",
    copy_from = "mon_amalgamation_abstract_small",
    symbol = "ä",
    name = ccb.content.plural_text("vigilant amalgamation", "vigilant amalgamations"),
    description = ccb.content.text("An inflated white body carried by five dainty legs, waving its remaining two limbs constantly.  Each one is tipped by a head-sized compound eye, independently scanning the horizon for prey."),
    attacks = {
        {
            spell = { id = "create_noise", hit_self = true },
            casting_message = ccb.content.text("The amalgamation screams!"),
            cooldown = 12,
            kind = "spell",
        },
    },
    vision_day = 60,
    melee_damage = { { type = "cut", amount = 2 } },
    tracking_distance = 12,
    armor = { stab = 4, acid = 5, bullet = 12, electric = 5, bash = 10, cut = 5 },
    inheritance = { add = { flags = { "KEENNOSE", "KEEP_DISTANCE" } } },
}

ccb.content.define_monster {
    id = "mon_amalgamation_corroder",
    copy_from = "mon_amalgamation_abstract_small",
    name = ccb.content.plural_text("caustic amalgamation", "caustic amalgamations"),
    description = ccb.content.text("A gangly creature running on six legs, its form made irregular by the green pustules at the limbs' base, each feeding into a large vein leading to two blackened claws.  What must have been a seventh leg fused with the creature's head forming a jagged proboscis emerging from below its eyes, dripping a caustic liquid."),
    color = "yellow_green",
    body_type = "insect",
    melee_damage = { { type = "cut", amount = 5 }, { type = "acid", amount = 3 } },
    attacks = {
        {
            id = "impale",
            cooldown = 8,
            damage = { { type = "stab", amount = 8 }, { type = "acid", amount = 8 } },
            effects = { { id = "corroding", duration = { 10, 30 }, affect_hit_body_part = true } },
            when = "monster_attack_intact_mandibles",
        },
        { id = "acid_slash" },
        { id = "acid_charge" },
    },
    harvest = "zombie_amalgamation_acid",
    inheritance = {
        add = { flags = { "ACIDPROOF", "ACID_BLOOD" }, weakpoint_sets = { "wps_amalgamation_acid" } },
    },
}

ccb.content.define_monster {
    id = "mon_amalgamation_jumper",
    copy_from = "mon_amalgamation_abstract_med",
    name = ccb.content.plural_text("leaping amalgamation", "leaping amalgamations"),
    description = ccb.content.text("A four-legged white creature about the size of a human, running with a decidedly feline gait, the three remaining limbs holding an almost-translucent skin membrane outstretched on its side and rear.  Much of its head is taken up by a beak like a raven's, which opens to reveal a set of jagged black teeth."),
    color = "i_blue",
    body_type = "dog",
    mass = "90 kg",
    volume = "90 L",
    hp = 135,
    speed = 100,
    attack_cost = 100,
    melee_dice = 2,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 5, penetration = 5 } },
    attacks = {
        {
            minimum_target_distance = 2,
            minimum_range = 2,
            move_cost = 50,
            maximum_range = 8,
            allow_no_target = false,
            cooldown = 3,
            kind = "leap",
            when = "allow_dragonfly_giant_grab",
        },
        {
            cooldown = 3,
            move_cost = 150,
            damage = { { type = "cut", amount = 15, penetration = 8 } },
            infection_chance = 10,
            kind = "bite",
            when = "monster_attack_intact_mandibles",
        },
    },
    dodge = 7,
    inheritance = {
        add = {
            flags = { "HARDTOSHOOT" },
            weakpoint_sets = { "wps_amalgamation_wing", "wps_amalgamation_mandible" },
        },
    },
}

ccb.content.define_monster {
    id = "mon_amalgamation_zapper",
    copy_from = "mon_amalgamation_abstract_med",
    name = ccb.content.plural_text("charged amalgamation", "charged amalgamations"),
    description = ccb.content.text("A short, crablike creature waddling around on six multi-jointed legs, its body dominated by a large glowing organ bulging from between the white armor plates.  A single raised appendage connects to the mass, its tip surrounded by brilliant white sparks."),
    color = "blue",
    speed = 95,
    luminance = 8,
    melee_damage = { { type = "electric", amount = 5 } },
    attacks = {
        {
            id = "shock_blast",
            spell = { id = "shock_blast", hit_self = true, min_level = 1 },
            cooldown = 25,
            casting_message = ccb.content.text("A cloud of electricity explodes from the %s"),
            kind = "spell",
            when = "allow_amalgamation_zapper_shock_blast",
        },
        {
            id = "shock_cone",
            spell = { id = "shock_cone", min_level = 1 },
            casting_message = ccb.content.text("A bolt of electricity arcs from %s!"),
            cooldown = 20,
            kind = "spell",
            when = "allow_amalgamation_zapper_shock_cone",
        },
        { id = "elec_charge", when = "allow_amalgamation_zapper_shock_cone" },
    },
    defense = { id = "ZAPBACK", chance = 100 },
    harvest = "zombie_amalgamation_electric",
    inheritance = {
        add = {
            flags = { "ELECTRIC", "PULP_PRYING" },
            weakpoint_sets = { "wps_amalgamation_armor", "wps_amalgamation_electric" },
        },
    },
    death = { outcome = { spell = { id = "death_shock_blast", hit_self = true } } },
}

ccb.content.define_monster {
    id = "mon_amalgamation_soldier",
    copy_from = "mon_amalgamation_abstract_med",
    name = ccb.content.plural_text("brutish amalgamation", "brutish amalgamations"),
    description = ccb.content.text("A large, thickly armored creature built not unlike a bear, if a bear had a long, clubbed tail and two short limbs ending in black talons framing a vertical mouth on an otherwise smooth, featureless head.  On second thought, not that much like a bear at all."),
    color = "dark_gray",
    body_type = "dog",
    volume = "200 L",
    mass = "200 kg",
    speed = 100,
    attack_cost = 150,
    melee_skill = 8,
    melee_dice = 4,
    melee_sides = 4,
    grab_strength = 100,
    attacks = {
        {
            id = "bite_grab",
            cooldown = 10,
            move_cost = 120,
            damage = { { type = "cut", amount = 18, penetration = 22 } },
            infection_chance = 10,
            minimum_hit_size = 0,
            when = "monster_attack_intact_mandibles",
        },
        {
            id = "scratch",
            cooldown = 4,
            move_cost = 80,
            damage = { { type = "cut", amount = 12, penetration = 15 } },
            maximum_damage_multiplier = 1.5,
            minimum_hit_size = 4,
        },
        { id = "tail_club" },
        {
            id = "grab_drag",
            cooldown = 15,
            grab_settings = { drag_distance = 2, move_cost_multiplier = 0.2 },
        },
        { id = "drag_followup", grab_settings = { drag_distance = 2, move_cost_multiplier = 0.2 } },
    },
    dodge = 3,
    vision_night = 8,
    armor = { bash = 20, cut = 25, stab = 30, acid = 12, bullet = 40, electric = 12 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_amalgamation_armor", "wps_amalgamation_mandible", "wps_amalgamation_tail" },
            families = { "prof_wp_nat_armored" },
            flags = { "GRABS", "PULP_PRYING" },
        },
    },
}
