local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_dog_skeleton",
    name = ccb.content.plural_text("skeletal dog", "skeletal dogs"),
    description = ccb.content.text("This undead canine has shed all of its skin, revealing a carapace of fused bones and ribs.  This walking suit of bone seems to be controlled by a net of veins and sinews which pulse with glistening black goo."),
    copy_from = "mon_zombie_dog",
    hp = 12,
    speed = 100,
    materials = { "bone" },
    color = "white",
    melee_sides = 9,
    melee_damage = { { type = "cut", amount = 6 } },
    grab_strength = 20,
    dodge = 3,
    bleed_rate = 50,
    harvest = "doggy_bones",
    upgrade = { half_life = 168, monster = "mon_dog_skeleton_brute" },
    armor = { cut = 15, stab = 30, acid = 3, bullet = 12, electric = 1 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_bone_armor" },
            families = { "prof_wp_skeleton" },
            flags = { "PULP_PRYING" },
        },
        remove = { flags = { "SMELLS" } },
    },
}

ccb.content.define_monster {
    id = "mon_dog_zombie_brute",
    name = ccb.content.plural_text("barghest", "barghests"),
    copy_from = "mon_dog_zombie_rot",
    description = ccb.content.text("A huge swollen zombie dog, smeared black with slime.  Its teeth have grown longer, and its broad back ripples with muscles and oozing wounds."),
    difficulty_adjustment = 2,
    volume = "46 L",
    mass = "60 kg",
    color = "red",
    upgrade = { half_life = 168, monster = "mon_dog_zombie_hulk" },
    grab_strength = 30,
    attacks = {
        { id = "scratch_grab_required", maximum_damage_multiplier = 1.5 },
        {
            id = "bite_grab",
            attack_upper = false,
            move_cost = 150,
            cooldown = 2,
            accuracy = 4,
            infection_chance = 8,
        },
    },
    inheritance = {
        add = { flags = { "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5, attack_cost = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { type = "cut", amount = 2 },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5, electric = 1 },
        },
    },
}

-- Cuspated just means angled, sharp, pointy. Other ways of translating the feel of the name may be something akin to 'scythe dog', or 'beaked beast'.
-- Can't bite because it doesn't exactly have a mouth anymore. Instead, it's effectively a one-hit, one-trick wonder. It tries to drive its extremely sharp beak into you. If it succeeds, you're thoroughly damaged. If it fails, it's screwed.
-- Minor amounts of protection due to the boney jaw.
ccb.content.define_monster {
    id = "mon_dog_cuspated",
    name = ccb.content.plural_text("cuspated dog", "cuspated dogs"),
    description = ccb.content.text("This dog's snout and jaw have seemingly fused together, the skin and flesh ranging from completely gone to barely hanging on.  The boney mass as a whole has an incredibly sharp yet jagged point.  It stumbles around, barely keeping its hefty 'beak' from hitting the ground."),
    copy_from = "mon_zombie_dog",
    hp = 30,
    speed = 65,
    color = "white_red",
    melee_skill = 3,
    melee_damage = { { type = "stab", amount = 10, penetration = 8 } },
    vision_day = 15,
    vision_night = 5,
    upgrade = false,
    attacks = { { id = "wicked_impale", attack_upper = false } },
    armor = { cut = 5, stab = 8, acid = 1, bullet = 8, electric = 1 },
    inheritance = { remove = { flags = { "GRABS", "SMELLS" } } },
}

ccb.content.define_monster {
    id = "mon_dog_howling",
    name = ccb.content.plural_text("howling dog", "howling dogs"),
    description = ccb.content.text("The underbelly of this undead canine expands and contracts arrhythmically, almost like it's breathing.  Despite that, it is clearly in an advanced state of decomposition.  Its snout and throat appear far too large for its species, and the remains of its eyes appear much more analytical than its brethren."),
    copy_from = "mon_zombie_dog",
    hp = 34,
    speed = 85,
    color = "magenta",
    upgrade = false,
    inheritance = {
        add = {
            attacks = {
                { reference = "PARROT_AT_DANGER", cooldown = 2 },
                { reference = "SHRIEK", cooldown = 2 },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_dog_scorched",
    name = ccb.content.plural_text("scorched dog", "scorched dogs"),
    description = ccb.content.text("A charred and damaged corpse of a canid, covered in fused patches of burnt hide and flesh."),
    copy_from = "mon_zombie_dog",
    hp = 27,
    speed = 72,
    color = "i_brown",
    melee_skill = 3,
    bleed_rate = 25,
    upgrade = false,
    armor = { bash = 2, cut = 4, acid = 3, heat = 15, bullet = 2, electric = 3 },
    inheritance = { add = { flags = { "REVIVES_HEALTHY", "NO_NECRO" } } },
}

ccb.content.define_monster {
    id = "mon_dog_zombie_hulk",
    name = ccb.content.plural_text("hulking horror", "hulking horrors"),
    copy_from = "mon_dog_zombie_brute",
    description = ccb.content.text("What may once have been a dog is now a grotesquely swollen monstrosity, standing on four limbs as wide as trash cans and showing massive, jagged teeth."),
    difficulty_adjustment = 5,
    volume = "440 L",
    mass = "100 kg",
    color = "white_magenta",
    bleed_rate = 0,
    upgrade = false,
    grab_strength = 60,
    attacks = {
        { id = "smash", throw_strength = 81 },
        {
            id = "bite_grab",
            move_cost = 188,
            cooldown = 2,
            accuracy = 4,
            infection_chance = 8,
            minimum_damage_multiplier = 1.0,
            maximum_damage_multiplier = 2.0,
        },
        { id = "scratch_grab_required" },
    },
    burn_into = "mon_dog_scorched_hulk",
    armor = { bash = 8, cut = 12, bullet = 10, electric = 4 },
    inheritance = {
        add = { flags = { "DESTROYS" } },
        scale = { hp = 4, speed = 1.25, attack_cost = 1.25 },
        offset = { melee_skill = 1, melee_dice = 1, melee_damage = { type = "cut", amount = -2 } },
    },
}

ccb.content.define_monster {
    id = "mon_dog_scorched_hulk",
    name = ccb.content.plural_text("scorched hulking dog", "scorched hulking dogs"),
    description = ccb.content.text("A charred and damaged corpse of what you can only assume was once a horribly mutated dog.  Covering its entire body is a layer of fused and melted hide, giving it an armored appearance."),
    copy_from = "mon_dog_zombie_hulk",
    color = "i_brown",
    armor = { bash = 9, cut = 13, acid = 6, heat = 15, bullet = 11, electric = 3 },
    inheritance = {
        add = { flags = { "REVIVES_HEALTHY", "NO_NECRO" } },
        scale = { hp = 0.75, speed = 0.6875 },
        offset = { melee_skill = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_dog_skeleton_brute",
    copy_from = "mon_dog_skeleton",
    name = ccb.content.plural_text("boneplate wolf", "boneplate wolves"),
    description = ccb.content.text("A four-legged creature covered in fused bony plates, shaped somewhat like a dog or wolf.  Joints and cracks across its body ooze with black goo."),
    volume = "46 L",
    mass = "60 kg",
    hp = 70,
    bleed_rate = 0,
    attacks = {
        { id = "bite_grab", attack_upper = false, cooldown = 5, maximum_damage_multiplier = 1.5 },
        {
            id = "scratch_grab_required",
            attack_upper = false,
            damage = { { type = "cut", amount = 15, armor_multiplier = 0.6 } },
        },
    },
    upgrade = false,
    armor = { stab = 30, bash = 12, cut = 30, acid = 1, bullet = 24, electric = 2 },
    inheritance = {
        add = { flags = { "PULP_PRYING" } },
        offset = { melee_dice = 1, melee_sides = 2, melee_damage = { type = "cut", amount = 6 } },
    },
}

ccb.content.define_monster {
    id = "mon_zpig_brute",
    name = ccb.content.plural_text("skull pig", "skull pigs"),
    copy_from = "mon_zombie_pig",
    description = ccb.content.text("This undead boar appears to have been a truly massive specimen in life.  Stretching eight to nine feet in length, the most arresting feature of this animal is that the enamel of its tusks has spread across its face, leaving a skull-like appearance with deep-set eye holes."),
    difficulty_adjustment = 2,
    color = "red",
    volume = "281 L",
    mass = "281 kg",
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 }, { id = "impale" } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_VEH", "HIT_AND_RUN" } },
        scale = { hp = 1.5, speed = 1.5, attack_cost = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { type = "cut", amount = 2 },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_pig_gas",
    name = ccb.content.plural_text("trench pig", "trench pigs"),
    copy_from = "mon_zombie_pig",
    description = ccb.content.text("Billowing clouds of yellowish gas precede a boar-shaped shadow.  Glimpses of a zombified boar are quickly obscured by the gases spewing forth from the open wounds on its body."),
    difficulty_adjustment = 5,
    color = "red",
    bleed_rate = 50,
    mass = "150 kg",
    harvest = "exempt",
    emissions = { { id = "emit_tear_gas_stream", delay = "1 s" } },
    attacks = { { id = "impale" } },
    upgrade = false,
    inheritance = { add = { flags = { "HIT_AND_RUN" } } },
    death = {
        drops = "explode_zed_beast",
        outcome = {
            spell = { id = "death_tearburst", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
            corpse = "NO_CORPSE",
        },
    },
}

ccb.content.define_monster {
    id = "mon_wolf_skeleton",
    name = ccb.content.plural_text("skeletal wolf", "skeletal wolves"),
    description = ccb.content.text("This undead canine has shed all of its skin, revealing a carapace of fused bones and ribs."),
    looks_like = "mon_dog_skeleton",
    copy_from = "mon_zolf",
    hp = 18,
    speed = 100,
    materials = { "bone" },
    symbol = "d",
    color = "white",
    melee_skill = 4,
    melee_dice = 3,
    melee_sides = 7,
    melee_damage = { { type = "cut", amount = 8 } },
    burn_into = "mon_dog_scorched",
    dodge = 4,
    bleed_rate = 50,
    vision_night = 3,
    harvest = "puppy_bones",
    upgrade = { half_life = 168, monster = "mon_dog_skeleton_brute" },
    armor = { cut = 15, stab = 30, acid = 3, bullet = 12, electric = 3 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_bone_armor" },
            families = { "prof_wp_skeleton" },
            flags = { "PULP_PRYING" },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zougar_hunter",
    name = ccb.content.plural_text("spearcat hunter", "spearcat hunters"),
    copy_from = "mon_zougar",
    description = ccb.content.text("This undead cougar's eyes ooze with dark, oily fluid, and its fur is torn, revealing deep, festering wounds.  Its claws and teeth are unnaturally long, and sharpened into dangerous looking spikes."),
    hp = 200,
    speed = 190,
    move_skills = { climb = 9 },
    attack_cost = 190,
    color = "brown",
    melee_dice = 6,
    melee_damage = { { type = "cut", amount = 8 } },
    dodge = 5,
    bleed_rate = 50,
    vision_night = 12,
    attacks = {
        { id = "scratch", move_cost = 190, damage = { { type = "cut", amount = 12 } } },
        { cooldown = 5, maximum_range = 5, kind = "leap" },
        {
            cooldown = 10,
            move_cost = 190,
            damage = { { type = "stab", amount = 12, armor_multiplier = 0.7 } },
            kind = "bite",
        },
    },
    upgrade = false,
    flags = {
        "SEES",
        "HEARS",
        "SMELLS",
        "WARM",
        "BASHES",
        "POISON",
        "NO_BREATHE",
        "REVIVES",
        "PUSH_MON",
        "FILTHY",
    },
}

ccb.content.define_monster {
    id = "mon_zombear_skeleton",
    name = ccb.content.plural_text("skeletal zombear", "skeletal zombears"),
    copy_from = "mon_zombear",
    description = ccb.content.text("As if a zombified bear wasn't already a problem, this one is layered in thick bone growths that protect it from harm.  The irregular way the plates grow against each other has somewhat stifled its movement, but not enough to stop it from easily gaining up on you."),
    hp = 170,
    speed = 100,
    materials = { "bone" },
    color = "white",
    melee_dice = 5,
    melee_sides = 9,
    melee_damage = { { type = "cut", amount = 10 } },
    dodge = 4,
    weakpoint_sets = { "wps_bone_armor" },
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie",
        "prof_wp_skeleton", "prof_wp_bear",
    },
    bleed_rate = 0,
    vision_day = 10,
    harvest = "puppy_bones",
    grab_strength = 35,
    attacks = {
        {
            id = "bite_grab",
            move_cost = 150,
            cooldown = 5,
            minimum_damage_multiplier = 1,
            maximum_damage_multiplier = 1.8,
        },
        {
            id = "scratch",
            cooldown = 10,
            minimum_damage_multiplier = 1,
            maximum_damage_multiplier = 1.8,
        },
    },
    upgrade = false,
    flags = { "SEES", "HEARS", "GRABS", "REVIVES", "NO_BREATHE", "POISON", "FILTHY" },
    armor = { bash = 2, cut = 17, stab = 30, acid = 3, bullet = 32, electric = 3 },
    inheritance = { add = { flags = { "PULP_PRYING" } } },
}

ccb.content.define_monster {
    id = "mon_zougar_shady",
    name = ccb.content.plural_text("shadowcat", "shadowcats"),
    copy_from = "mon_zougar",
    description = ccb.content.text("An uncanny shadow envelops this creature, as if light itself were too repulsed to touch it.  All you can make out is the outline of a large, shambling cat."),
    color = "light_gray",
    vision_day = 3,
    bleed_rate = 50,
    vision_night = 45,
    harvest = "zombie_fur_shadow",
    upgrade = false,
    flags = {
        "SEES", "HEARS", "SMELLS", "STUMBLES", "WARM", "KEENNOSE", "GOODHEARING", "BASHES", "POISON",
        "NO_BREATHE", "REVIVES", "FILTHY", "NIGHT_INVISIBILITY",
    },
}

ccb.content.define_monster {
    id = "mon_zombear_acidic",
    name = ccb.content.plural_text("acidic zombear", "acidic zombears"),
    copy_from = "mon_zombear",
    description = ccb.content.text("Most of this bear's fur has burnt off and its body looks to be falling apart, not entirely immune to its own acidic fluids.  Despite its weakened state, the strength of a bear hasn't left it."),
    difficulty_adjustment = 5,
    hp = 145,
    speed = 135,
    attack_cost = 135,
    color = "light_gray_yellow",
    melee_skill = 4,
    melee_dice = 3,
    dodge = 3,
    bleed_rate = 50,
    harvest = "zombie_animal_acid",
    attacks = {
        { reference = "ACID_BARF", cooldown = 10 },
        {
            id = "bite_grab",
            move_cost = 150,
            cooldown = 3,
            minimum_damage_multiplier = 0.75,
            maximum_damage_multiplier = 1.5,
        },
        { id = "scratch" },
    },
    upgrade = false,
    inheritance = { add = { flags = { "ACIDPROOF", "ACID_BLOOD" } } },
    death = {
        outcome = {
            message = ccb.content.text("The %s's body leaks acid."),
            spell = { id = "death_acid", hit_self = true },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_horse_white",
    name = ccb.content.plural_text("acidic zombie horse", "acidic zombie horses"),
    copy_from = "mon_zombie_horse",
    description = ccb.content.text("The abdomen of this once majestic horse has grown rotund to the point you can see through the skin, at the reservoir of caustic bile inside.  Its neck is equally enlarged as well as slightly longer than normal."),
    difficulty_adjustment = 3,
    hp = 75,
    speed = 195,
    attack_cost = 195,
    color = "light_gray_yellow",
    bleed_rate = 40,
    harvest = "zombie_animal_acid",
    attacks = { { reference = "ACID", cooldown = 15 } },
    upgrade = false,
    flags = {
        "SEES", "HEARS", "SMELLS", "STUMBLES", "WARM", "BASHES", "GROUP_BASH", "POISON", "ACIDPROOF",
        "ACID_BLOOD", "NO_BREATHE", "REVIVES", "PUSH_MON",
    },
    death = {
        outcome = {
            message = ccb.content.text("The %s's body leaks acid."),
            spell = { id = "death_acid", hit_self = true },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_horse_red",
    name = ccb.content.plural_text("sinewy warhorse", "sinewy warhorses"),
    copy_from = "mon_zombie_horse",
    description = ccb.content.text("A zombified horse without skin, its overgrown, bloody musculature clear for all to see.  Some muscles occasionally tear from their tendons as it barrels towards its target, flailing around like a loose hose before weaving back into place."),
    difficulty_adjustment = 5,
    hp = 90,
    color = "red",
    melee_dice = 4,
    melee_damage = { { type = "cut", amount = 7 } },
    harvest = "zombie_animal",
    attacks = { { id = "smash", throw_strength = 91, cooldown = 30 } },
    regenerates = 9,
    upgrade = false,
    flags = { "SEES", "HEARS", "SMELLS", "BASHES", "NO_BREATHE", "REVIVES" },
}

ccb.content.define_monster {
    id = "mon_zombie_horse_black",
    name = ccb.content.plural_text("smoldering stallion", "smoldering stallions"),
    copy_from = "mon_zombie_horse",
    description = ccb.content.text("This undead horse has a charred hide as black as soot, the underside of which is littered with gashes and holes.  Pillars of choking black smoke pour from the wounds, smothering everything that draws near."),
    difficulty_adjustment = 4,
    hp = 75,
    color = "blue_white",
    dodge = 3,
    upgrade = false,
    emissions = { { id = "emit_smoke_stream", delay = "1 s" } },
    flags = { "SEES", "HEARS", "SMELLS", "BASHES", "POISON", "HARDTOSHOOT", "NO_BREATHE", "REVIVES" },
    death = {
        outcome = {
            spell = { id = "death_smokeburst", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_horse_pale",
    name = ccb.content.plural_text("pale charger", "pale chargers"),
    copy_from = "mon_zombie_horse",
    description = ccb.content.text("With plates of asymmetrical bone tissue overlapping its body, this ignoble steed needs no rider for you to fear its approach.  Completing its ghoulish look is an overgrown skull which, judging by the flattened and battered forehead, has become its main weapon."),
    difficulty_adjustment = 5,
    hp = 90,
    color = "white",
    melee_dice = 4,
    melee_damage = { { type = "cut", amount = 8 } },
    weakpoint_sets = { "wps_bone_armor" },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_wp_zombie", "prof_wp_skeleton" },
    harvest = "puppy_bones",
    attacks = { { id = "smash", throw_strength = 91, cooldown = 30 } },
    upgrade = false,
    flags = {
        "SEES",
        "HEARS",
        "BASHES",
        "GROUP_BASH",
        "HARDTOSHOOT",
        "REVIVES",
        "NO_BREATHE",
        "POISON",
        "FILTHY",
    },
    armor = { bash = 5, electric = 2, cut = 16, stab = 30, acid = 2, bullet = 24 },
}
