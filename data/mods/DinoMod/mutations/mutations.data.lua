local ccb = require("ccb")

ccb.content.define_mutation {
    id = "THRESH_HORNS",
    name = ccb.content.text("Horns"),
    points = 1,
    description = ccb.content.text("Big, strong, fierce, brave, and a loyal friend, always leading with horns."),
    valid = false,
    profession = true,
    purifiable = false,
    species_anger = { DINOSAUR = -20, REPTILE = -20, PLANT = 20, MAMMAL = -20 },
    ignored_by = { "BIRD" },
    threshold = true,
}

ccb.content.define_mutation { id = "HERBIVORE", copy_from = "HERBIVORE", add = { categories = { "STEGO", "HORNS" } } }

ccb.content.define_mutation { id = "RUMINANT", copy_from = "RUMINANT", add = { categories = { "STEGO", "HORNS" } } }

ccb.content.define_mutation {
    id = "GRAZER",
    copy_from = "GRAZER",
    add = {
        categories = { "STEGO", "HORNS" },
        threshold_requirements = { "THRESH_STEGO", "THRESH_HORNS" },
    },
}

ccb.content.define_mutation { id = "FASTHEALER", copy_from = "FASTHEALER", add = { categories = { "STEGO", "TYRANT" } } }

ccb.content.define_mutation {
    id = "PAINRESIST",
    copy_from = "PAINRESIST",
    add = { categories = { "STEGO", "TYRANT", "HORNS" } },
}

ccb.content.define_mutation {
    id = "TOUGH_FEET",
    copy_from = "TOUGH_FEET",
    add = { categories = { "STEGO", "TYRANT", "HORNS" } },
}

ccb.content.define_mutation {
    id = "TOUGH",
    copy_from = "TOUGH",
    valid = true,
    add = { categories = { "STEGO", "TYRANT", "HORNS" } },
}

ccb.content.define_mutation {
    id = "TOUGH2",
    copy_from = "TOUGH2",
    valid = true,
    add = { categories = { "STEGO", "TYRANT", "HORNS" } },
}

ccb.content.define_mutation {
    id = "TOUGH3",
    copy_from = "TOUGH3",
    valid = true,
    add = { categories = { "STEGO", "TYRANT", "HORNS" } },
}

ccb.content.define_mutation {
    id = "THICKSKIN2",
    name = ccb.content.text("Tough-Skinned"),
    points = 3,
    description = ccb.content.text("Your skin is getting tougher.  Greatly improves protection against all sorts of damage.  Makes you less dextrous though."),
    prerequisites = { "THICKSKIN" },
    cancels = { "THINSKIN" },
    categories = { "STEGO", "TYRANT", "HORNS" },
    replacements = { "THICKSKIN3" },
    armor = { { part_types = { "tail" }, resistances = { cut = 14, bash = 10 } } },
    integrated_armor = { "integrated_reptilescales" },
    enchantments = { "INLINE_ENCH_THICKSKIN2_0" },
}

ccb.content.define_mutation {
    id = "THICKSKIN3",
    name = ccb.content.text("Diamond-Skinned"),
    points = 4,
    description = ccb.content.text("Your skin is developing Kevlar-like qualities.  Makes you slower though, and is rather cumbersome."),
    prerequisites = { "THICKSKIN2" },
    cancels = { "THINSKIN" },
    threshold_requirements = { "THRESH_STEGO" },
    categories = { "STEGO" },
    armor = { { part_types = { "tail" }, resistances = { cut = 24, bash = 20 } } },
    integrated_armor = { "integrated_stegoskin" },
    enchantments = { "INLINE_ENCH_THICKSKIN3_0" },
}

ccb.content.define_mutation {
    id = "STRONGBACKDINO",
    name = ccb.content.text("Apatosaurus Back"),
    points = 2,
    description = ccb.content.text("You are capable of carrying inhuman amounts - more than others with similar strength could.  Your maximum weight carried is increased by 70%."),
    prerequisites = { "STRONGBACK" },
    cancels = { "BADBACK" },
    enchantments = { "INLINE_ENCH_STRONGBACKDINO_0" },
    categories = { "STEGO", "TYRANT", "HORNS" },
}

ccb.content.define_mutation { id = "DEFT", copy_from = "DEFT", add = { categories = { "TYRANT", "HORNS" } } }

ccb.content.define_mutation { id = "GOURMAND", copy_from = "GOURMAND", add = { categories = { "TYRANT" } } }

ccb.content.define_mutation { id = "ANIMALEMPATH", copy_from = "ANIMALEMPATH", add = { categories = { "STEGO", "HORNS" } } }

ccb.content.define_mutation { id = "TERRIFYING", copy_from = "TERRIFYING", add = { categories = { "TYRANT" } } }

ccb.content.define_mutation { id = "BADTEMPER", copy_from = "BADTEMPER", add = { categories = { "STEGO", "TYRANT" } } }

ccb.content.define_mutation {
    id = "SLOWLEARNER",
    copy_from = "SLOWLEARNER",
    add = { categories = { "STEGO", "TYRANT", "HORNS" } },
}

ccb.content.define_mutation { id = "VEGETARIAN", copy_from = "VEGETARIAN", add = { categories = { "STEGO", "HORNS" } } }

ccb.content.define_mutation { id = "INSOMNIA", copy_from = "INSOMNIA", add = { categories = { "TYRANT" } } }

ccb.content.define_mutation { id = "HATES_BOOKS", copy_from = "HATES_BOOKS", add = { categories = { "TYRANT" } } }

ccb.content.define_mutation { id = "ANTIJUNK", copy_from = "ANTIJUNK", add = { categories = { "STEGO", "TYRANT", "HORNS" } } }

ccb.content.define_mutation { id = "CLUMSY", copy_from = "CLUMSY", add = { categories = { "STEGO", "TYRANT" } } }

ccb.content.define_mutation {
    id = "SKIN_PEELING",
    copy_from = "SKIN_PEELING",
    add = { categories = { "STEGO", "TYRANT", "HORNS" } },
}

ccb.content.define_mutation { id = "LIZ_EYE", copy_from = "LIZ_EYE", add = { categories = { "STEGO", "TYRANT" } } }

ccb.content.define_mutation { id = "LIZ_IR", copy_from = "LIZ_IR", add = { categories = { "STEGO", "TYRANT" } } }

ccb.content.define_mutation {
    id = "SPARSE_SCALES",
    copy_from = "SPARSE_SCALES",
    add = { categories = { "STEGO", "TYRANT", "HORNS" } },
}

ccb.content.define_mutation { id = "SCALES", copy_from = "SCALES", add = { categories = { "STEGO", "TYRANT", "HORNS" } } }

ccb.content.define_mutation { id = "NAILS", copy_from = "NAILS", add = { categories = { "STEGO", "TYRANT", "HORNS" } } }

ccb.content.define_mutation { id = "CLAWS", copy_from = "CLAWS", add = { categories = { "STEGO", "TYRANT" } } }

ccb.content.define_mutation { id = "CARNIVORE", copy_from = "CARNIVORE", add = { categories = { "TYRANT" } } }

ccb.content.define_mutation {
    id = "TYRANT_TEETH",
    name = ccb.content.text("Serrated Teeth"),
    points = 3,
    visibility = 10,
    ugliness = 8,
    mixed_effect = true,
    description = ccb.content.text("Your mouth has reshaped to accommodate many serrated teeth.  They make it impossible to wear mouthgear and difficult to eat… but tear giant wounds in your prey."),
    types = { "TEETH" },
    prerequisites = { "FANGS" },
    threshold_requirements = { "THRESH_TYRANT" },
    categories = { "TYRANT" },
    restricts_gear = { "mouth" },
    destroys_gear = true,
    social_modifiers = { intimidate = 20 },
    attacks = {
        {
            player_message = ccb.content.text("You tear into %s with your serrated teeth!"),
            npc_message = ccb.content.text("%1$s tears into %2$s with their serrated teeth!"),
            body_part = "mouth",
            chance = 20,
            base_damage = { type = "stab", amount = 30 },
            strength_damage = { type = "bash", amount = 3 },
        },
    },
}

ccb.content.define_mutation { id = "HEADBUMPS", copy_from = "HEADBUMPS", add = { categories = { "STEGO", "HORNS" } } }

ccb.content.define_mutation { id = "HORNS", copy_from = "HORNS", add = { categories = { "STEGO", "HORNS" } } }

ccb.content.define_mutation { id = "HORNS_POINTED", copy_from = "HORNS_POINTED", add = { categories = { "HORNS" } } }

ccb.content.define_mutation { id = "HORNS_CURLED", copy_from = "HORNS_CURLED", add = { categories = { "HORNS" } } }

ccb.content.define_mutation {
    id = "HORNS_TRI",
    name = ccb.content.text("Triceratops Horns"),
    description = ccb.content.text("You have three long, pointed horns, like those of a triceratops.  They allow you to make a strong piercing headbutt attack, but prevent wearing headwear that is not made of fabric."),
    prerequisites = { "HORNS_POINTED", "HORNS_CURLED" },
    attacks = {
        {
            player_message = ccb.content.text("You stab %s with your three pointed horns!"),
            npc_message = ccb.content.text("%1$s stabs %2$s with their three pointed horns!"),
            chance = 33,
            base_damage = { type = "stab", amount = 36 },
        },
    },
    copy_from = "HORNS_POINTED",
    add = { categories = { "HORNS" }, threshold_requirements = { "THRESH_HORNS" } },
}

ccb.content.define_mutation { id = "TAIL_STUB", copy_from = "TAIL_STUB", add = { categories = { "STEGO", "TYRANT", "HORNS" } } }

ccb.content.define_mutation { id = "TAIL_LONG", copy_from = "TAIL_LONG", add = { categories = { "STEGO", "TYRANT" } } }

ccb.content.define_mutation { id = "TAIL_THICK", copy_from = "TAIL_THICK", add = { categories = { "STEGO", "HORNS" } } }

ccb.content.define_mutation {
    id = "TAIL_HORNED",
    name = ccb.content.text("Horned Tail"),
    points = 2,
    visibility = 8,
    ugliness = 4,
    description = ccb.content.text("You have a long, thick, tail with sharp pointed horns.  It helps you balance a bit but also makes a heavy bludgeon.  Prevents wearing non-fabric pants."),
    types = { "TAIL" },
    prerequisites = { "TAIL_CLUB" },
    threshold_requirements = { "THRESH_STEGO" },
    categories = { "STEGO" },
    restricts_gear = { "leg_l", "leg_r" },
    allow_soft_gear = true,
    attacks = {
        {
            player_message = ccb.content.text("You smash %s with your tail!"),
            npc_message = ccb.content.text("%1$s smashes %2$s with their tail!"),
            chance = 20,
            base_damage = { type = "bash", amount = 24 },
            strength_damage = { type = "stab", amount = 2 },
        },
    },
    enchantments = { "INLINE_ENCH_TAIL_HORNED_0" },
}

ccb.content.define_mutation {
    id = "MUT_TOUGH",
    copy_from = "MUT_TOUGH",
    add = {
        categories = { "STEGO", "TYRANT", "HORNS" },
        threshold_requirements = { "THRESH_STEGO", "THRESH_TYRANT", "THRESH_HORNS" },
    },
}

ccb.content.define_mutation {
    id = "MUT_TOUGH2",
    copy_from = "MUT_TOUGH2",
    add = {
        categories = { "STEGO", "TYRANT" },
        threshold_requirements = { "THRESH_STEGO", "THRESH_TYRANT" },
    },
}

ccb.content.define_mutation {
    id = "MUT_TOUGH3",
    copy_from = "MUT_TOUGH3",
    add = { categories = { "STEGO" }, threshold_requirements = { "THRESH_STEGO" } },
}

ccb.content.define_mutation {
    id = "PRED1",
    copy_from = "PRED1",
    add = { categories = { "TYRANT" }, threshold_requirements = { "THRESH_TYRANT" } },
}

ccb.content.define_mutation {
    id = "PRED2",
    copy_from = "PRED2",
    add = { categories = { "TYRANT" }, threshold_requirements = { "THRESH_TYRANT" } },
}

ccb.content.define_mutation {
    id = "PRED3",
    copy_from = "PRED3",
    add = { categories = { "TYRANT" }, threshold_requirements = { "THRESH_TYRANT" } },
}

ccb.content.define_mutation {
    id = "PRED4",
    copy_from = "PRED4",
    add = { categories = { "TYRANT" }, threshold_requirements = { "THRESH_TYRANT" } },
}

ccb.content.define_mutation {
    id = "SAPIOVORE",
    copy_from = "SAPIOVORE",
    add = { categories = { "TYRANT" }, threshold_requirements = { "THRESH_TYRANT" } },
}

ccb.content.define_mutation { id = "VERY_TALL", copy_from = "VERY_TALL", add = { categories = { "STEGO", "TYRANT", "HORNS" } } }

ccb.content.define_mutation { id = "LARGE", copy_from = "LARGE", add = { categories = { "STEGO", "TYRANT", "HORNS" } } }

ccb.content.define_mutation {
    id = "DENSE_BONES",
    copy_from = "DENSE_BONES",
    add = { categories = { "STEGO", "TYRANT", "HORNS" } },
}

ccb.content.define_mutation {
    id = "LARGE_OK",
    copy_from = "LARGE_OK",
    add = {
        categories = { "STEGO", "TYRANT", "HORNS" },
        threshold_requirements = { "THRESH_STEGO", "THRESH_TYRANT", "THRESH_HORNS" },
    },
}

ccb.content.define_mutation { id = "HUGE", copy_from = "HUGE", add = { categories = { "STEGO", "TYRANT", "HORNS" } } }

ccb.content.define_mutation {
    id = "HUGE_OK",
    copy_from = "HUGE_OK",
    add = {
        categories = { "STEGO", "TYRANT", "HORNS" },
        threshold_requirements = { "THRESH_STEGO", "THRESH_TYRANT", "THRESH_HORNS" },
    },
}

ccb.content.define_mutation {
    id = "SLIT_NOSTRILS",
    copy_from = "SLIT_NOSTRILS",
    add = { categories = { "STEGO", "TYRANT", "HORNS" } },
}

ccb.content.define_mutation { id = "UGLY", copy_from = "UGLY", add = { categories = { "STEGO", "TYRANT" } } }

ccb.content.define_mutation { id = "DEFORMED", copy_from = "DEFORMED", add = { categories = { "STEGO", "TYRANT" } } }

ccb.content.define_mutation { id = "DEFORMED2", copy_from = "DEFORMED2", add = { categories = { "STEGO", "TYRANT" } } }

ccb.content.define_mutation { id = "THIRST", copy_from = "THIRST", add = { categories = { "STEGO", "TYRANT", "HORNS" } } }

ccb.content.define_mutation { id = "THIRST2", copy_from = "THIRST2", add = { categories = { "STEGO", "TYRANT", "HORNS" } } }

ccb.content.define_mutation { id = "THIRST3", copy_from = "THIRST3", add = { categories = { "STEGO", "TYRANT", "HORNS" } } }

ccb.content.define_mutation { id = "PONDEROUS1", copy_from = "PONDEROUS1", add = { categories = { "STEGO", "TYRANT" } } }

ccb.content.define_mutation { id = "PONDEROUS2", copy_from = "PONDEROUS2", add = { categories = { "STEGO", "TYRANT" } } }

ccb.content.define_mutation { id = "COLDBLOOD", copy_from = "COLDBLOOD", add = { categories = { "STEGO", "HORNS" } } }

ccb.content.define_mutation { id = "COLDBLOOD2", copy_from = "COLDBLOOD2", add = { categories = { "STEGO", "HORNS" } } }

ccb.content.define_mutation { id = "COLDBLOOD3", copy_from = "COLDBLOOD3", add = { categories = { "STEGO", "HORNS" } } }

ccb.content.define_mutation {
    id = "COLDBLOOD4",
    copy_from = "COLDBLOOD4",
    add = {
        categories = { "STEGO", "HORNS" },
        threshold_requirements = { "THRESH_STEGO", "THRESH_HORNS" },
    },
}

ccb.content.define_mutation { id = "STR_UP", copy_from = "STR_UP", add = { categories = { "STEGO", "TYRANT", "HORNS" } } }

ccb.content.define_mutation { id = "STR_UP_2", copy_from = "STR_UP_2", add = { categories = { "STEGO", "TYRANT", "HORNS" } } }

ccb.content.define_mutation {
    id = "STR_UP_3",
    copy_from = "STR_UP_3",
    add = {
        categories = { "STEGO", "TYRANT", "HORNS" },
        threshold_requirements = { "THRESH_STEGO", "THRESH_TYRANT", "THRESH_HORNS" },
    },
}

ccb.content.define_mutation {
    id = "STR_UP_4",
    copy_from = "STR_UP_4",
    add = {
        categories = { "STEGO", "TYRANT", "HORNS" },
        threshold_requirements = { "THRESH_STEGO", "THRESH_TYRANT", "THRESH_HORNS" },
    },
}

ccb.content.define_mutation { id = "THICKSKIN", copy_from = "THICKSKIN", add = { categories = { "STEGO", "TYRANT", "HORNS" } } }

ccb.content.define_mutation {
    id = "STRONGBACK",
    copy_from = "STRONGBACK",
    add = { categories = { "STEGO", "TYRANT", "HORNS" } },
}

ccb.content.define_mutation { id = "FANGS", copy_from = "FANGS", add = { categories = { "TYRANT" } } }

ccb.content.define_mutation { id = "TAIL_CLUB", copy_from = "TAIL_CLUB", add = { categories = { "STEGO" } } }

ccb.content.define_mutation { id = "FLEET", copy_from = "FLEET", add = { categories = { "HORNS" } } }

ccb.content.define_mutation { id = "SNOUT", copy_from = "SNOUT", add = { categories = { "HORNS", "STEGO" } } }

ccb.content.define_mutation { id = "BEAK", copy_from = "BEAK", add = { categories = { "HORNS", "STEGO" } } }

ccb.content.define_mutation { id = "LIGHTEATER", copy_from = "LIGHTEATER", add = { categories = { "HORNS", "STEGO" } } }

ccb.content.define_mutation { id = "GIZZARD", copy_from = "GIZZARD", add = { categories = { "HORNS", "STEGO" } } }

ccb.content.define_mutation { id = "HOOVES", copy_from = "HOOVES", add = { categories = { "HORNS" } } }

ccb.content.define_mutation {
    id = "PACK_LEADER",
    name = ccb.content.text("Pack Leader"),
    points = 4,
    description = ccb.content.text("Puny as they may seem, a leader needs a pack, and some of those hairless bipeds may yet prove some worth.  You gain combat skills at an elevated rate, and maintain a level of critical thinking that supports cooperation."),
    social_modifiers = { intimidate = 4 },
    purifiable = false,
    prerequisites = { "GRAZER" },
    secondary_prerequisites = { "HORNS" },
    threshold_requirements = { "THRESH_HORNS" },
    categories = { "HORNS" },
}
