local ccb = require("ccb")

ccb.content.define_mutation {
    id = "THRESH_DRAGON_BLACK",
    name = ccb.content.text("Black Dragon"),
    points = 1,
    description = ccb.content.text("You sometimes think back about the world you left behind.  You're glad you burned it in your wake."),
    valid = false,
    purifiable = false,
    threshold = true,
}

ccb.content.define_mutation {
    id = "PAINRESIST",
    copy_from = "PAINRESIST",
    add = { categories = { "DRAGON_BLACK", "SPECIES_DWARF" } },
}

ccb.content.define_mutation {
    id = "POISRESIST",
    copy_from = "POISRESIST",
    add = { categories = { "DRAGON_BLACK", "SPECIES_DWARF" } },
}

ccb.content.define_mutation { id = "TERRIFYING", copy_from = "TERRIFYING", add = { categories = { "DRAGON_BLACK" } } }

ccb.content.define_mutation {
    id = "BADTEMPER",
    copy_from = "BADTEMPER",
    add = { categories = { "DRAGON_BLACK", "SPECIES_DWARF" } },
}

ccb.content.define_mutation {
    id = "ADDICTIVE",
    copy_from = "ADDICTIVE",
    add = { categories = { "DRAGON_BLACK", "MANATOUCHED" } },
}

ccb.content.define_mutation {
    id = "CHEMIMBALANCE",
    copy_from = "CHEMIMBALANCE",
    add = { categories = { "DRAGON_BLACK", "SPECIES_GOBLIN" } },
}

ccb.content.define_mutation { id = "CLUMSY", copy_from = "CLUMSY", add = { categories = { "DRAGON_BLACK" } } }

ccb.content.define_mutation {
    id = "HOARDER",
    copy_from = "HOARDER",
    valid = true,
    add = { categories = { "DRAGON_BLACK", "SPECIES_LIZARDFOLK", "SPECIES_DWARF", "SPECIES_RAVENFOLK" } },
}

ccb.content.define_mutation {
    id = "MOODSWINGS",
    copy_from = "MOODSWINGS",
    add = { categories = { "DRAGON_BLACK", "SPECIES_ELF", "SPECIES_GOBLIN" } },
}

ccb.content.define_mutation {
    id = "LIZ_EYE",
    copy_from = "LIZ_EYE",
    add = { categories = { "DRAGON_BLACK", "SPECIES_LIZARDFOLK" } },
}

ccb.content.define_mutation { id = "LIZ_IR", copy_from = "LIZ_IR", add = { categories = { "DRAGON_BLACK" } } }

ccb.content.define_mutation {
    id = "FASTHEALER",
    copy_from = "FASTHEALER",
    add = { categories = { "DRAGON_BLACK", "SPECIES_LIZARDFOLK" } },
}

ccb.content.define_mutation {
    id = "REGEN_LIZ",
    copy_from = "REGEN_LIZ",
    add = {
        categories = { "DRAGON_BLACK", "SPECIES_LIZARDFOLK" },
        threshold_requirements = { "THRESH_DRAGON_BLACK", "THRESH_SPECIES_LIZARDFOLK" },
    },
}

ccb.content.define_mutation {
    id = "MEMBRANE",
    copy_from = "MEMBRANE",
    add = { categories = { "DRAGON_BLACK", "SPECIES_LIZARDFOLK" } },
}

ccb.content.define_mutation {
    id = "SKIN_PEELING",
    copy_from = "SKIN_PEELING",
    add = { categories = { "DRAGON_BLACK", "SPECIES_LIZARDFOLK" } },
}

ccb.content.define_mutation {
    id = "SPARSE_SCALES",
    copy_from = "SPARSE_SCALES",
    add = { categories = { "DRAGON_BLACK", "SPECIES_LIZARDFOLK" } },
}

ccb.content.define_mutation {
    id = "SCALES",
    copy_from = "SCALES",
    add = {
        categories = { "DRAGON_BLACK", "SPECIES_LIZARDFOLK" },
        replacements = { "DRAGON_SCALES_BLACK" },
    },
}

ccb.content.define_mutation {
    id = "DRAGON_SCALES_BLACK",
    name = ccb.content.text("Black Dragon Scales"),
    points = 3,
    visibility = 10,
    ugliness = 4,
    mixed_effect = true,
    description = ccb.content.text("Your skin has grown thick and a set of draconic black scales has grown to cover most of your body, acting as natural armor.  Greatly reduces wet effects."),
    types = { "SKIN" },
    prerequisites = { "SCALES" },
    threshold_requirements = { "THRESH_DRAGON_BLACK" },
    categories = { "DRAGON_BLACK" },
    wet_protection = {
        { part = "head", ignored = 5 },
        { part = "leg_l", ignored = 16 },
        { part = "leg_r", ignored = 16 },
        { part = "foot_l", ignored = 5 },
        { part = "foot_r", ignored = 5 },
        { part = "arm_l", ignored = 14 },
        { part = "arm_r", ignored = 14 },
        { part = "hand_l", ignored = 4 },
        { part = "hand_r", ignored = 4 },
        { part = "torso", ignored = 30 },
    },
    armor = { { part_types = { "tail" }, resistances = { cut = 32, bash = 22, bullet = 28 } } },
    integrated_armor = { "integrated_black_dragonscale" },
    species_anger = { HUMAN = 20 },
}

ccb.content.define_mutation {
    id = "TOE_CLAWS",
    name = ccb.content.text("Reptilian Legs"),
    points = 0,
    description = ccb.content.text("Your legs and feet have become reptile-like and your toenails have grown into short claws.  Fortunately they don't impede your movement."),
    types = { "LEGS", "FEET" },
    cancels = { "WEBBED_FEET" },
    categories = { "DRAGON_BLACK" },
    replacements = { "DRAGON_FEET" },
}

ccb.content.define_mutation {
    id = "DRAGON_FEET",
    name = ccb.content.text("Dragon Legs"),
    points = 0,
    visibility = 4,
    ugliness = 2,
    mixed_effect = true,
    description = ccb.content.text("Your legs and feet have become dragon-like and the claws on your toes have developed into incredibly tough talons.  These are fearsome and powerful, but prevent you from wearing shoes and slightly impede your movement."),
    types = { "LEGS", "FEET" },
    prerequisites = { "TOE_CLAWS" },
    cancels = { "WEBBED_FEET" },
    categories = { "DRAGON_BLACK" },
    threshold_requirements = { "THRESH_DRAGON_BLACK" },
    restricts_gear = { "foot_l", "foot_r" },
    destroys_gear = true,
    allowed_item_flags = { "ALLOWS_TALONS" },
    attacks = {
        {
            player_message = ccb.content.text("You slash %s with your clawed feet!"),
            npc_message = ccb.content.text("%1$s slashes %2$s with their clawed feet!"),
            chance = 20,
            base_damage = { type = "cut", amount = 20 },
            strength_damage = { type = "cut", amount = 0.25 },
        },
    },
    enchantments = { "dragon_leg_strength" },
}

ccb.content.define_mutation {
    id = "PAINREC1",
    copy_from = "PAINREC1",
    add = { categories = { "DRAGON_BLACK", "SPECIES_DWARF", "SPECIES_GOBLIN" } },
}

ccb.content.define_mutation {
    id = "PAINREC2",
    copy_from = "PAINREC2",
    add = { categories = { "DRAGON_BLACK", "SPECIES_DWARF", "SPECIES_GOBLIN" } },
}

ccb.content.define_mutation { id = "PAINREC3", copy_from = "PAINREC3", add = { categories = { "DRAGON_BLACK" } } }

ccb.content.define_mutation {
    id = "VERY_TALL",
    copy_from = "VERY_TALL",
    add = { categories = { "DRAGON_BLACK" }, replacements = { "LARGE_DRAGON" } },
}

ccb.content.define_mutation {
    id = "LARGE_DRAGON",
    flags = { "LARGE" },
    name = ccb.content.text("Inconvenient Draconic Growth"),
    points = 0,
    visibility = 1,
    ugliness = 1,
    mixed_effect = true,
    encumbrance = { torso = 10, arm_l = 10, arm_r = 10 },
    description = ccb.content.text("You have grown noticeably taller, broader, and menacing.  Much of it is useful muscle mass (Strength +2), but you find it throws off your balance and you get in your own way (+10 torso and arm encumbrance), and you notice people are starting to treat you differently."),
    types = { "SIZE" },
    prerequisites = { "DRAGON_STR", "DRAGON_STR2", "DRAGON_STR3", "DRAGON_STR4" },
    cancels = { "SMALL", "SMALL2", "LARGE", "LARGE_OK", "HUGE", "HUGE_OK" },
    replacements = { "LARGE_OK_DRAGON", "HUGE_DRAGON" },
    categories = { "DRAGON_BLACK" },
    enchantments = { "INLINE_ENCH_LARGE_DRAGON_0" },
    species_anger = { HUMAN = 10 },
}

ccb.content.define_mutation {
    id = "LARGE_OK_DRAGON",
    flags = { "LARGE" },
    name = ccb.content.text("Draconic Growth"),
    points = 2,
    visibility = 1,
    description = ccb.content.text("You carry your rugged body with the dignity you deserve, but are all the more menacing for it.  Strength +2."),
    types = { "SIZE" },
    prerequisites = { "LARGE_DRAGON" },
    secondary_prerequisites = { "DRAGON_STR", "DRAGON_STR2", "DRAGON_STR3", "DRAGON_STR4" },
    cancels = { "SMALL", "SMALL2", "LARGE", "LARGE_OK", "HUGE", "HUGE_OK" },
    threshold_requirements = { "THRESH_DRAGON_BLACK" },
    replacements = { "HUGE_DRAGON" },
    categories = { "DRAGON_BLACK" },
    enchantments = { "INLINE_ENCH_LARGE_OK_DRAGON_0" },
    species_anger = { HUMAN = 20 },
}

ccb.content.define_mutation {
    id = "HUGE_DRAGON",
    flags = { "HUGE" },
    name = ccb.content.text("Freakish Draconic Maturity"),
    points = 0,
    visibility = 4,
    ugliness = 4,
    mixed_effect = true,
    description = ccb.content.text("You have grown even more massive, to the point where you cannot usefully fit into human-sized clothing or vehicles.  Much of it is powerful muscle mass (Strength +4), but it's a real pain to haul around."),
    types = { "SIZE" },
    prerequisites = { "LARGE_DRAGON", "LARGE_OK_DRAGON" },
    secondary_prerequisites = { "DRAGON_STR3", "DRAGON_STR4" },
    cancels = { "SMALL", "SMALL2", "LARGE", "LARGE_OK", "HUGE", "HUGE_OK" },
    replacements = { "HUGE_OK_DRAGON" },
    categories = { "DRAGON_BLACK" },
    enchantments = { "INLINE_ENCH_HUGE_DRAGON_0" },
    restricts_gear = { "torso", "leg_l", "leg_r", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l", "foot_r" },
    destroys_gear = true,
    species_anger = { HUMAN = 30 },
}

ccb.content.define_mutation {
    id = "DRAGON_STR",
    name = ccb.content.text("Wyrmling Strength"),
    points = 4,
    visibility = 1,
    description = ccb.content.text("Your muscles are enhanced by some growing innate magic.  You are slightly stronger.  Strength + 1"),
    types = { "STR" },
    replacements = { "DRAGON_STR2" },
    categories = { "DRAGON_BLACK" },
    enchantments = { "INLINE_ENCH_DRAGON_STR_0" },
}

ccb.content.define_mutation {
    id = "DRAGON_STR2",
    name = ccb.content.text("Young Dragon Strength"),
    points = 4,
    visibility = 1,
    description = ccb.content.text("The connection to your inner magic is growing and your muscles are stronger, but you're a little more clumsy.  Strength + 3, Dexterity - 1"),
    types = { "STR" },
    prerequisites = { "DRAGON_STR" },
    replacements = { "DRAGON_STR3" },
    categories = { "DRAGON_BLACK" },
    enchantments = { "INLINE_ENCH_DRAGON_STR2_0" },
}

ccb.content.define_mutation {
    id = "DRAGON_STR3",
    name = ccb.content.text("Draconic Strength"),
    points = 4,
    visibility = 1,
    description = ccb.content.text("The magic within you courses through your muscles, greatly empowering them.  This costs you valuable flexibility and coordination, however.  Strength + 5, Dexterity - 2"),
    types = { "STR" },
    prerequisites = { "DRAGON_STR2" },
    replacements = { "DRAGON_STR4" },
    categories = { "DRAGON_BLACK" },
    enchantments = { "INLINE_ENCH_DRAGON_STR3_0" },
}

ccb.content.define_mutation {
    id = "DRAGON_STR4",
    name = ccb.content.text("Ancient Draconic Strength"),
    points = 7,
    visibility = 2,
    ugliness = 2,
    description = ccb.content.text("Your internal magic has filled you with unimaginable strength, but you can't move as freely as your form once could.  This is no problem.  Strength + 8, Dexterity - 3"),
    types = { "STR" },
    prerequisites = { "DRAGON_STR3" },
    categories = { "DRAGON_BLACK" },
    threshold_requirements = { "THRESH_DRAGON_BLACK" },
    enchantments = { "INLINE_ENCH_DRAGON_STR4_0" },
}

ccb.content.define_mutation {
    id = "HUGE_OK_DRAGON",
    flags = { "HUGE" },
    name = ccb.content.text("Draconic Maturity"),
    points = 2,
    visibility = 4,
    ugliness = 3,
    mixed_effect = true,
    description = ccb.content.text("Your cardiovascular system has caught up with your muscular physique, so who needs pathetic human cars?  Strength +4."),
    types = { "SIZE" },
    prerequisites = { "HUGE_DRAGON" },
    secondary_prerequisites = { "DRAGON_STR3", "DRAGON_STR4" },
    cancels = { "SMALL", "SMALL2", "LARGE", "LARGE_OK", "HUGE", "HUGE_OK" },
    threshold_requirements = { "THRESH_DRAGON_BLACK" },
    categories = { "DRAGON_BLACK" },
    enchantments = { "INLINE_ENCH_HUGE_OK_DRAGON_0" },
    restricts_gear = { "torso", "leg_l", "leg_r", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l", "foot_r" },
    destroys_gear = true,
    species_anger = { HUMAN = 40 },
}

ccb.content.define_mutation {
    id = "MUT_TOUGH",
    copy_from = "MUT_TOUGH",
    add = {
        categories = { "DRAGON_BLACK" },
        prerequisites = { "LARGE_OK_DRAGON", "HUGE_OK_DRAGON" },
        threshold_requirements = { "THRESH_DRAGON_BLACK" },
    },
}

ccb.content.define_mutation {
    id = "INT_UP",
    copy_from = "INT_UP",
    add = {
        categories = { "DRAGON_BLACK", "MANATOUCHED", "SPECIES_ELF", "SPECIES_LIZARDFOLK", "SPECIES_RAVENFOLK" },
    },
}

ccb.content.define_mutation {
    id = "INT_UP_2",
    copy_from = "INT_UP_2",
    add = { categories = { "DRAGON_BLACK", "MANATOUCHED" } },
}

ccb.content.define_mutation {
    id = "INT_UP_3",
    copy_from = "INT_UP_3",
    add = {
        categories = { "DRAGON_BLACK", "MANATOUCHED" },
        threshold_requirements = { "THRESH_DRAGON_BLACK", "THRESH_MANA" },
    },
}

ccb.content.define_mutation {
    id = "INT_UP_4",
    copy_from = "INT_UP_4",
    add = { categories = { "DRAGON_BLACK" }, threshold_requirements = { "THRESH_DRAGON_BLACK" } },
}

ccb.content.define_mutation {
    id = "SLIT_NOSTRILS",
    copy_from = "SLIT_NOSTRILS",
    add = { categories = { "DRAGON_BLACK", "SPECIES_LIZARDFOLK" } },
}

ccb.content.define_mutation {
    id = "HEADBUMPS",
    copy_from = "HEADBUMPS",
    add = { categories = { "DRAGON_BLACK", "SPECIES_GOBLIN" } },
}

ccb.content.define_mutation {
    id = "HORNS",
    copy_from = "HORNS",
    add = { categories = { "DRAGON_BLACK" }, replacements = { "HORNS_DRAGON" } },
}

ccb.content.define_mutation {
    id = "HORNS_DRAGON",
    name = ccb.content.text("Dragon Horns"),
    points = 1,
    visibility = 8,
    ugliness = 2,
    mixed_effect = true,
    description = ccb.content.text("You have a pair of long, curved back, dragon-like horns.  They allow you to make a strong bashing headbutt attack, but prevent wearing headwear that is not made of fabric."),
    types = { "HORNS" },
    prerequisites = { "HORNS" },
    categories = { "DRAGON_BLACK" },
    threshold_requirements = { "THRESH_DRAGON_BLACK" },
    restricts_gear = { "head" },
    allow_soft_gear = true,
    attacks = {
        {
            player_message = ccb.content.text("You headbutt %s with your draconic horns!"),
            npc_message = ccb.content.text("%1$s headbutts %2$s with their draconic horns!"),
            chance = 20,
            base_damage = { type = "bash", amount = 16 },
        },
    },
}

ccb.content.define_mutation {
    id = "FORKED_TONGUE",
    copy_from = "FORKED_TONGUE",
    add = { categories = { "DRAGON_BLACK", "SPECIES_LIZARDFOLK" } },
}

ccb.content.define_mutation { id = "HOLLOW_BONES", copy_from = "HOLLOW_BONES", add = { categories = { "SPECIES_RAVENFOLK" } } }

ccb.content.define_mutation {
    id = "ARM_FEATHERS",
    copy_from = "ARM_FEATHERS",
    valid = true,
    add = { categories = { "SPECIES_RAVENFOLK" } },
}

ccb.content.define_mutation {
    id = "WINGS_STUB",
    copy_from = "WINGS_STUB",
    add = { categories = { "DRAGON_BLACK" }, replacements = { "DRAGON_WINGS_BLACK" } },
}

ccb.content.define_mutation {
    id = "DRAGON_WINGS_BLACK",
    name = ccb.content.text("Black Dragon Wings"),
    points = 1,
    visibility = 9,
    ugliness = 4,
    description = ccb.content.text("You have a pair of large, black scaled dragon wings.  While you have control of them and can make attacks with them, they are not large enough nor strong enough to allow you to fly and they throw you off balance, greatly reducing your ability to dodge.  They can be used to cast a protective spell on yourself however."),
    types = { "WINGS" },
    prerequisites = { "WINGS_STUB" },
    categories = { "DRAGON_BLACK" },
    threshold_requirements = { "THRESH_DRAGON_BLACK" },
    enchantments = { "INLINE_ENCH_DRAGON_WINGS_BLACK_0" },
    attacks = {
        {
            player_message = ccb.content.text("You bash %s with your powerful wings!"),
            npc_message = ccb.content.text("%1$s bashes %2$s with their powerful wings!"),
            chance = 20,
            base_damage = { type = "bash", amount = 20 },
            strength_damage = { type = "bash", amount = 0.5 },
        },
    },
    spells_learned = { dragon_shell_black = 1 },
    species_anger = { HUMAN = 5 },
}

ccb.content.define_mutation {
    id = "WEAKSTOMACH",
    copy_from = "WEAKSTOMACH",
    add = { categories = { "DRAGON_BLACK", "MANATOUCHED", "SPECIES_ELF", "SPECIES_GOBLIN" } },
}

ccb.content.define_mutation {
    id = "NAUSEA",
    copy_from = "NAUSEA",
    add = { categories = { "DRAGON_BLACK", "SPECIES_GOBLIN" } },
    additions = { "OVERLY_ACID_GUT" },
}

ccb.content.define_mutation {
    id = "VOMITOUS",
    copy_from = "VOMITOUS",
    add = { categories = { "DRAGON_BLACK", "SPECIES_GOBLIN" } },
    additions = { "DRAGON_BREATH_BLACK" },
}

ccb.content.define_mutation {
    id = "OVERLY_ACID_GUT",
    name = ccb.content.text("Overly Acidic Digestion"),
    description = ccb.content.text("Your digestive issues have developed to become overly acidic which greatly impacts your ability to normally digest food, resulting in getting far less nutrition from the food you eat and making your need to eat more often."),
    points = -3,
    prerequisites = { "NAUSEA" },
    categories = { "DRAGON_BLACK", "SLIME" },
    enchantments = { "INLINE_ENCH_OVERLY_ACID_GUT_0" },
    vitamin_absorption = { all = { vitC = 0.5, calcium = 0.5, iron = 0.5 } },
}

ccb.content.define_mutation {
    id = "DRAGON_BREATH_BLACK",
    name = ccb.content.text("Black Dragon Breath"),
    description = ccb.content.text("Your digestive issues may not have settled entirely, but you can somewhat control them and now you have the ability to spit acid!"),
    points = 2,
    prerequisites = { "VOMITOUS", "OVERLY_ACID_GUT" },
    secondary_prerequisites = { "DRAGON_MAW_BLACK" },
    categories = { "DRAGON_BLACK" },
    threshold_requirements = { "THRESH_DRAGON_BLACK" },
    spells_learned = { dragon_spit_acid = 1, dragon_breath_acid = 1 },
}

ccb.content.define_mutation {
    id = "THIRST",
    copy_from = "THIRST",
    add = { categories = { "DRAGON_BLACK", "SPECIES_DWARF", "SPECIES_RAVENFOLK" } },
}

ccb.content.define_mutation { id = "THIRST2", copy_from = "THIRST2", add = { categories = { "DRAGON_BLACK" } } }

ccb.content.define_mutation { id = "CARNIVORE", copy_from = "CARNIVORE", add = { categories = { "DRAGON_BLACK" } } }

ccb.content.define_mutation {
    id = "DRAGONBLOOD",
    flags = { "COLDBLOOD" },
    name = ccb.content.text("Draconic Heat Dependence"),
    points = -1,
    description = ccb.content.text("Your muscle response is dependent on ambient temperatures.  You lose 1% of your speed for every 5 (2.8) degrees below 65 F (18.3 C).  Unfortunately, this doesn't seem to help you conserve any energy."),
    replacements = { "DRAGONBLOOD2" },
    types = { "METABOLISM" },
    categories = { "DRAGON_BLACK" },
    enchantments = { "INLINE_ENCH_DRAGONBLOOD_0" },
}

ccb.content.define_mutation {
    id = "DRAGONBLOOD2",
    flags = { "COLDBLOOD2" },
    name = ccb.content.text("High Draconic Heat Dependence"),
    points = -2,
    description = ccb.content.text("Your muscle response is highly dependent on ambient temperatures.  You lose 1% of your speed for every 3 (1.7) degrees below 65 F (18.3 C).  Unfortunately, it seems you have to exert more energy to keep moving."),
    replacements = { "DRAGONBLOOD3" },
    types = { "METABOLISM" },
    categories = { "DRAGON_BLACK" },
    enchantments = { "INLINE_ENCH_DRAGONBLOOD2_0" },
}

ccb.content.define_mutation {
    id = "DRAGONBLOOD3",
    flags = { "ECTOTHERM" },
    name = ccb.content.text("Draconic Ectothermia"),
    points = -3,
    description = ccb.content.text("Your body has become permanently cold-blooded.  Your speed lowers or raises 1% for every 2 (1.1) degrees below or above 65 F (18.3 C).  All this and you need even more food to maintain your energy."),
    prerequisites = { "DRAGONBLOOD2" },
    threshold_requirements = { "THRESH_DRAGON_BLACK" },
    purifiable = false,
    types = { "METABOLISM" },
    categories = { "DRAGON_BLACK" },
    enchantments = { "INLINE_ENCH_DRAGONBLOOD3_0" },
}

ccb.content.define_mutation { id = "HISS", copy_from = "HISS", add = { categories = { "DRAGON_BLACK", "SPECIES_LIZARDFOLK" } } }

ccb.content.define_mutation {
    id = "DRAGON_MAGIC",
    name = ccb.content.text("Draconic Magic"),
    description = ccb.content.text("You are imbued with the ancient magic powers of dragons, improving your mana reserves and opening your mind to amazing feats of magic."),
    points = 3,
    categories = { "DRAGON_BLACK" },
    replacements = { "DRAGON_SPELLS" },
    threshold_requirements = { "THRESH_DRAGON_BLACK" },
    prerequisites = { "MANA_MULT3" },
    purifiable = false,
    spells_learned = { dragon_terror = 1 },
    enchantments = { "INLINE_ENCH_DRAGON_MAGIC_0" },
}

ccb.content.define_mutation {
    id = "DRAGON_SPELLS",
    name = ccb.content.text("Draconic Spellcasting"),
    description = ccb.content.text("Your mind has fully opened to the power and ancient heritage of dragons.  You can access even greater quantities of mana and you have access to more dragon spells."),
    points = 3,
    categories = { "DRAGON_BLACK" },
    threshold_requirements = { "THRESH_DRAGON_BLACK" },
    prerequisites = { "DRAGON_MAGIC" },
    spells_learned = { dragon_terror = 0, dragon_boost = 1 },
    enchantments = { "INLINE_ENCH_DRAGON_SPELLS_0" },
}

ccb.content.define_mutation {
    id = "MUZZLE_DRAGON",
    name = ccb.content.text("Scaled Mouth"),
    points = 0,
    visibility = 6,
    ugliness = 6,
    mixed_effect = true,
    description = ccb.content.text("Your scales have grown up and around your mouth, digging into your gums and retracting your lips.  On the down side, it makes speaking difficult.  On the positive side, it makes it very easy to bite things, though what's driving you to do that?"),
    prerequisites = { "SCALES", "DRAGON_SCALES_BLACK" },
    categories = { "DRAGON_BLACK" },
    replacements = { "DRAGON_MAW_BLACK" },
    encumbrance = { mouth = 10 },
    social_modifiers = { intimidate = 10 },
    types = { "MUZZLE" },
    attacks = {
        {
            player_message = ccb.content.text("You bite a chunk out of %s!"),
            npc_message = ccb.content.text("%1$s bites a chunk out of %2$s!"),
            body_part = "mouth",
            chance = 15,
            base_damage = { type = "stab", amount = 15 },
            strength_damage = { type = "stab", amount = 0.1 },
        },
    },
}

ccb.content.define_mutation {
    id = "DRAGON_MAW_BLACK",
    name = ccb.content.text("Black Dragon Maw"),
    points = 0,
    visibility = 8,
    ugliness = 8,
    mixed_effect = true,
    description = ccb.content.text("Your face and jaws have extended to a long, toothy dragon maw.  It's fearsome and causes grievous wounds, but prevents wearing mouth gear."),
    prerequisites = { "MUZZLE_DRAGON" },
    categories = { "DRAGON_BLACK" },
    threshold_requirements = { "THRESH_DRAGON_BLACK" },
    social_modifiers = { intimidate = 30 },
    types = { "MUZZLE" },
    restricts_gear = { "mouth" },
    attacks = {
        {
            player_message = ccb.content.text("You bite a chunk out of %s!"),
            npc_message = ccb.content.text("%1$s bites a chunk out of %2$s!"),
            body_part = "mouth",
            chance = 20,
            base_damage = { type = "stab", amount = 25 },
            strength_damage = { type = "stab", amount = 0.25 },
        },
    },
    spells_learned = { acid_bite = 1 },
}

ccb.content.define_mutation {
    id = "DRAGON_TAIL_STUB",
    name = ccb.content.text("Stubby Dragon Tail"),
    points = 0,
    visibility = 1,
    ugliness = 2,
    description = ccb.content.text("You have a short, stubby tail that has strange bumps and ridges.  You can wiggle it, but it serves no purpose."),
    types = { "TAIL" },
    categories = { "DRAGON_BLACK" },
    replacements = { "DRAGON_TAIL_SCALED" },
}

ccb.content.define_mutation {
    id = "DRAGON_TAIL_SCALED",
    name = ccb.content.text("Short Dragon Tail"),
    points = 1,
    visibility = 8,
    ugliness = 2,
    description = ccb.content.text("You have a short, dragonlike tail.  You can use it decently as a club of sorts, but it's not doing anything to help you balance.  Prevents wearing non-fabric pants."),
    types = { "TAIL" },
    prerequisites = { "DRAGON_TAIL_STUB" },
    secondary_prerequisites = { "SCALES", "DRAGON_SCALES_BLACK" },
    categories = { "DRAGON_BLACK" },
    replacements = { "DRAGON_TAIL" },
    restricts_gear = { "leg_hip_l", "leg_hip_r" },
    allowed_item_flags = { "ALLOWS_TAIL" },
    allow_soft_gear = true,
    attacks = {
        {
            player_message = ccb.content.text("You whap %s with your tail!"),
            npc_message = ccb.content.text("%1$s whaps %2$s with their tail!"),
            chance = 20,
            base_damage = { type = "bash", amount = 10 },
        },
    },
}

ccb.content.define_mutation {
    id = "DRAGON_TAIL",
    name = ccb.content.text("Dragon Tail"),
    points = 1,
    visibility = 8,
    ugliness = 2,
    description = ccb.content.text("You have a long, thick, dragonlike tail.  It doesn't help you balance or dodge any better, but it is a powerful bashing weapon.  Prevents wearing non-fabric pants."),
    types = { "TAIL" },
    prerequisites = { "DRAGON_TAIL_SCALED" },
    categories = { "DRAGON_BLACK" },
    restricts_gear = { "leg_hip_l", "leg_hip_r" },
    allowed_item_flags = { "ALLOWS_TAIL" },
    allow_soft_gear = true,
    attacks = {
        {
            player_message = ccb.content.text("You smash %s with your tail!"),
            npc_message = ccb.content.text("%1$s smashes %2$s with their tail!"),
            chance = 20,
            base_damage = { type = "bash", amount = 15 },
            strength_damage = { type = "bash", amount = 0.25 },
        },
    },
}

ccb.content.define_mutation {
    id = "SCALED_HANDS",
    name = ccb.content.text("Scaled Hands"),
    points = 2,
    visibility = 4,
    ugliness = 3,
    integrated_armor = { "integrated_scaled_hands" },
    mixed_effect = true,
    restricts_gear = { "hand_l", "hand_r" },
    destroys_gear = true,
    description = ccb.content.text("Your scales have grown to cover your hands and elongate the tips in to jagged claws that can be serviceable as cutting and piercing weapons in unarmed combat.  You can still use them normally, but you can't wear gloves."),
    types = { "CLAWS" },
    prerequisites = { "SCALES", "DRAGON_SCALES_BLACK" },
    cancels = { "ARM_TENTACLES", "ARM_TENTACLES_4", "ARM_TENTACLES_8" },
    categories = { "DRAGON_BLACK" },
    replacements = { "DRAGON_TALONS_BLACK" },
}

ccb.content.define_mutation {
    id = "DRAGON_TALONS_BLACK",
    name = ccb.content.text("Black Dragon Talons"),
    points = 2,
    visibility = 4,
    ugliness = 3,
    mixed_effect = true,
    restricts_gear = { "hand_l", "hand_r" },
    integrated_armor = { "integrated_dragon_talons_black" },
    destroys_gear = true,
    description = ccb.content.text("All of your fingers have developed into huge scaled talons.  They prevent wearing gloves, but you can use them to powerful effect in melee combat and you appear to have uncovered some secrets about black dragons."),
    types = { "CLAWS" },
    prerequisites = { "SCALED_HANDS" },
    cancels = { "ARM_TENTACLES", "ARM_TENTACLES_4", "ARM_TENTACLES_8" },
    categories = { "DRAGON_BLACK" },
    threshold_requirements = { "THRESH_DRAGON_BLACK" },
    spells_learned = { acid_claw = 1 },
}

ccb.content.define_mutation {
    id = "DENSE_BONES",
    copy_from = "DENSE_BONES",
    add = { categories = { "DRAGON_BLACK", "SPECIES_DWARF" } },
}

ccb.content.define_mutation {
    id = "PRED1",
    copy_from = "PRED1",
    add = {
        categories = { "DRAGON_BLACK", "SPECIES_LIZARDFOLK" },
        threshold_requirements = { "THRESH_DRAGON_BLACK", "THRESH_SPECIES_LIZARDFOLK" },
    },
}

ccb.content.define_mutation {
    id = "PRED2",
    copy_from = "PRED2",
    add = {
        categories = { "DRAGON_BLACK", "SPECIES_LIZARDFOLK" },
        threshold_requirements = { "THRESH_DRAGON_BLACK", "THRESH_SPECIES_LIZARDFOLK" },
    },
}

ccb.content.define_mutation {
    id = "PRED3_DRAGON",
    name = ccb.content.text("Draconic Predator"),
    points = 4,
    description = ccb.content.text("You have become something more than human.  Something better - and far, far worse.  Combat skills are easy to learn and maintain, and unlike lesser predators, your mental faculties don't suffer at all."),
    social_modifiers = { intimidate = 5 },
    purifiable = false,
    types = { "PREDATION" },
    prerequisites = { "CARNIVORE" },
    secondary_prerequisites = { "PRED2" },
    additions = { "SAPIOVORE" },
    replacements = { "PRED4_DRAGON" },
    threshold_requirements = { "THRESH_DRAGON_BLACK" },
    cancels = { "PACIFIST" },
    categories = { "DRAGON_BLACK" },
    flags = { "PRED3" },
}

ccb.content.define_mutation {
    id = "PRED4_DRAGON",
    name = ccb.content.text("Draconic Apex Predator"),
    points = 5,
    description = ccb.content.text("Your mind and brain have fully adapted to your new place at the top of the magical food chain.  You can effortlessly master and maintain combat skills, and your malevolent intellect only grows."),
    social_modifiers = { intimidate = 6 },
    purifiable = false,
    types = { "PREDATION" },
    prerequisites = { "CARNIVORE" },
    secondary_prerequisites = { "PRED3_DRAGON" },
    threshold_requirements = { "THRESH_DRAGON_BLACK" },
    categories = { "DRAGON_BLACK" },
    enchantments = { "INLINE_ENCH_PRED4_DRAGON_0" },
    flags = { "PRED4" },
}

ccb.content.define_mutation {
    id = "SAPIOVORE",
    copy_from = "SAPIOVORE",
    add = {
        categories = { "DRAGON_BLACK" },
        threshold_requirements = { "THRESH_DRAGON_BLACK" },
        secondary_prerequisites = { "PRED3_DRAGON", "PRED4_DRAGON" },
    },
}

ccb.content.define_mutation {
    id = "DRAGON_ACID_PROOF",
    name = ccb.content.text("Draconic Acid Immunity"),
    points = 3,
    description = ccb.content.text("Like your scale and hide, your remaining flesh has been transmuted by black dragon's essence.  You are invulnerable to acid now."),
    purifiable = false,
    prerequisites = { "DRAGON_SCALES_BLACK" },
    secondary_prerequisites = { "DRAGON_SPELLS" },
    threshold_requirements = { "THRESH_DRAGON_BLACK" },
    categories = { "DRAGON_BLACK" },
    flags = { "ACID_IMMUNE" },
}
