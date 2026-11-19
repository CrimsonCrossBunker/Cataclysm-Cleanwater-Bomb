local ccb = require("ccb")

-- no GUILT_CHILD because it no longer looks enough like a child to evoke pity
ccb.content.define_monster {
    id = "mon_zombie_anklebiter",
    name = ccb.content.plural_text("anklebiter", "anklebiters"),
    description = ccb.content.text("This horrifying little mutated wretch looks to have once been a child, but its massive gaping jaws are now far more suggestive of a predatory beast."),
    copy_from = "mon_zombie_child_base",
    hp = 35,
    speed = 105,
    color = "brown",
    melee_skill = 4,
    dodge = 3,
    bleed_rate = 50,
    upgrade = false,
}

ccb.content.define_monster {
    id = "mon_zombie_child",
    name = ccb.content.plural_text("zombie child", "zombie children"),
    description = ccb.content.text("It was only a child, and little is different about it now aside from the hungry look in its eyes.  You'd be hard-pressed to not feel like you were killing an actual child by putting it down."),
    copy_from = "mon_zombie_child_base",
    categories = { "CLASSIC" },
    inheritance = { add = { flags = { "GUILT_CHILD", "GEN_DORMANT" } } },
    death = { outcome = { spell = { id = "death_guilt", min_level = 6 } } },
}

-- no GUILT_CHILD because it no longer looks enough like a child to evoke pity
ccb.content.define_monster {
    id = "mon_zombie_creepy",
    name = ccb.content.plural_text("creepy crawler", "creepy crawlers"),
    description = ccb.content.text("What was once a child is now a mutant beast with blackened skin and massive eyes.  This abomination's vile form makes a mockery of its human origin."),
    copy_from = "mon_zombie_child_base",
    hp = 25,
    speed = 55,
    color = "dark_gray",
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 1 } },
    bleed_rate = 50,
    vision_day = 10,
    vision_night = 10,
    upgrade = false,
    inheritance = {
        add = {
            weakpoint_sets = { "wps_eyes_big" },
            move_skills = { climb = 8 },
            attacks = { { reference = "SHRIEK", cooldown = 5 } },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_shriekling",
    name = ccb.content.plural_text("shriekling", "shrieklings"),
    description = ccb.content.text("This heavily mutated child zombie twitches and flails its limbs in painful-looking spasms as it runs about."),
    copy_from = "mon_zombie_child_base",
    difficulty_adjustment = 2,
    hp = 20,
    speed = 95,
    color = "magenta",
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 1 } },
    bleed_rate = 50,
    vision_night = 5,
    upgrade = false,
    inheritance = { add = { attacks = { { reference = "SHRIEK", cooldown = 5 } } } },
}

ccb.content.define_monster {
    id = "mon_zombie_snotgobbler",
    name = ccb.content.plural_text("snotgobbler", "snotgobblers"),
    description = ccb.content.text("This swollen, gooey-looking mutant child looks bad, even for a zombie.  Maybe that's why it seems to want a hug so badly."),
    copy_from = "mon_zombie_child_base",
    hp = 25,
    color = "pink",
    melee_skill = 4,
    dodge = 1,
    bleed_rate = 50,
    upgrade = false,
    armor = { bash = 1, electric = 1 },
    death = {
        drops = {
            kind = "collection",
            groups = {
                { id = "default_zombie_children_clothes", weight = 100 },
                { id = "child_items_pockets", weight = 65 },
                { id = "explode_innards_small", weight = 100 },
            },
        },
        outcome = {
            spell = { id = "death_boomer", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
            corpse = "NO_CORPSE",
        },
    },
}

-- no GUILT_CHILD because it no longer looks enough like a child to evoke pity
ccb.content.define_monster {
    id = "mon_zombie_sproglodyte",
    name = ccb.content.plural_text("sproglodyte", "sproglodytes"),
    description = ccb.content.text("This crouching child-mutant's face is dominated by a pair of huge black eyes, and its fingertips end in sharp claws."),
    copy_from = "mon_zombie_child_base",
    hp = 30,
    speed = 85,
    color = "light_gray",
    melee_skill = 3,
    melee_damage = { { type = "cut", amount = 3 } },
    bleed_rate = 50,
    vision_day = 10,
    vision_night = 10,
    upgrade = false,
    inheritance = {
        add = {
            weakpoint_sets = { "wps_eyes_big" },
            move_skills = { climb = 6 },
            attacks = { { cooldown = 10, maximum_range = 5, kind = "leap" } },
        },
    },
}

-- GUILT_CHILD because it still looks enough like a child to evoke pity
ccb.content.define_monster {
    id = "mon_zombie_waif",
    name = ccb.content.plural_text("howling waif", "howling waifs"),
    description = ccb.content.text("Undeath has not been kind to the children of the apocalypse.  This one is little more than a reanimated membrane of skin stretched across tiny brittle bones."),
    copy_from = "mon_zombie_child_base",
    difficulty_adjustment = 2,
    hp = 15,
    materials = { "bone" },
    color = "white",
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 1 } },
    bleed_rate = 50,
    upgrade = false,
    inheritance = { add = { flags = { "GUILT_CHILD" }, attacks = { { reference = "SHRIEK", cooldown = 15 } } } },
    death = { outcome = { spell = { id = "death_guilt", min_level = 6 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_wretch",
    name = ccb.content.plural_text("wretched hatchery", "wretched hatcheries"),
    description = ccb.content.text("Lethargically resting on its back, this hideous mass of sagging flesh and writhing organs, which used to be a child, twitches feebly as its midsection churns.  Almost bursting from its skin, the child's ribcage has arched outward, forming a hive-like construct covered by severely stretched epidermis.  Through the wretched organism's taut abdominal flesh, you witness small forms swarming within its ribcage—its guts roiling as new beings are sculpted from pilfered flesh and bone.  The creature's limbs rest haphazardly on the ground, contorted in ways that suggest the absence of bones or any interior construct."),
    copy_from = "mon_zombie_child_base",
    body_type = "blob",
    speed = 20,
    color = "pink",
    melee_skill = 1,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 0 } },
    vision_day = 20,
    bleed_rate = 0,
    attacks = {
        {
            spell = { id = "wretch_raptor_spawn", hit_self = true },
            cooldown = 50,
            casting_message = ccb.content.text("Ripping and tearing, a small beast burrows free of the wretch's abdomen!"),
            kind = "spell",
        },
    },
    fungalize_into = "mon_zombie_wretch_dusted",
    upgrade = false,
    flags = { "SEES", "HEARS", "IMMOBILE", "WARM", "POISON", "NO_BREATHE", "FILTHY" },
}
