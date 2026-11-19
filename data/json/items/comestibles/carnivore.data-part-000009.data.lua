local ccb = require("ccb")

ccb.content.define_item {
    id = "tainted_innards_human",
    copy_from = "tainted_innards",
    name = ccb.content.plural_text("tainted innards", "tainted innards"),
    description = ccb.content.text("An unidentifiable selection of rotted human innards that barely hold their form.  It is revolting and certainly no longer healthy to eat."),
    snippet_category = "tainted_innards_desc",
    comestible = {
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 16 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "mutant_bug_organs",
    copy_from = "offal",
    name = ccb.content.plural_text("mutant organs", "mutant organs"),
    snippet_category = "bug_organs_desc",
    description = ccb.content.text("Raw organs from a giant mutant bug."),
    display_type = "BY_WEIGHT",
    looks_like = "offal",
    comestible = {
        cooks_like = "mutant_bug_organs_cooked",
        cooked_item = "mutant_bug_organs_cooked",
        cooking_energy = "300 kJ",
        vitamins = { { id = "mutant_toxin", amount = 25 }, { id = "meat_allergen", amount = 1 } },
    },
    inheritance = { add = { flags = { "BAD_TASTE" } }, scale = { price = 0.1, calories = 0.65 } },
}

ccb.content.define_item {
    id = "mutant_bug_organs_cooked",
    copy_from = "mutant_bug_organs",
    name = ccb.content.plural_text("cooked mutant bug organs", "cooked mutant bug organs"),
    snippet_category = "cooked_bug_organs_desc",
    description = ccb.content.text("A selection of cooked mutant bug organs.  Looks awful, but if you give it a try, you'll find -- that it's worse than it looks."),
    looks_like = "offal_cooked",
    comestible = { parasites = 0 },
    inheritance = { remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "offal_pickled",
    copy_from = "offal",
    name = ccb.content.plural_text("pickled offal", "pickled offal"),
    description = ccb.content.text("A mass of entrails and organ meat, preserved in brine.  Packed with essential vitamins, and although it looks like a lab specimen, it actually tastes pretty palatable."),
    display_type = "BY_WEIGHT",
    survival_price = "150 cent",
    default_container = "jar_glass_sealed",
    comestible = { parasites = 0, shelf_life = "1 day 12 hours", quench = -1, fun = -1 },
    inheritance = { remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "offal_canned",
    copy_from = "offal",
    name = ccb.content.plural_text("canned offal", "canned offal"),
    description = ccb.content.text("Cooked organ meat and entrails, preserved by canning.  Unappetizing, but filled with essential vitamins."),
    survival_price = "150 cent",
    default_container = "can_medium",
    comestible = { parasites = 0, fun = -2 },
    inheritance = { remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "stomach",
    copy_from = "flesh",
    name = ccb.content.text("stomach"),
    description = ccb.content.text("The stomach of a woodland creature.  It is surprisingly durable."),
    mass = "72 g",
    volume = "250 ml",
    survival_price = "25 cent",
    price = "2 USD",
    comestible = { shelf_life = "8 hours", calories = 60, quench = 1, fun = -15 },
    inheritance = { add = { flags = { "PREDATOR_FUN" } } },
}

ccb.content.define_item {
    id = "stomach_large",
    copy_from = "stomach",
    name = ccb.content.text("large stomach"),
    description = ccb.content.text("The stomach of a large woodland creature.  It is surprisingly durable."),
    comestible = {},
    inheritance = { scale = { mass = 2.0, volume = 2.0, price = 1.5, calories = 2.0 } },
}

ccb.content.define_item {
    id = "jerky",
    copy_from = "flesh",
    name = ccb.content.plural_text("meat jerky", "meat jerky"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("jerk jerky", "jerk jerky"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("talking animal jerky", "talking animal jerky"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("monster jerky", "monster jerky"),
        },
    },
    description = ccb.content.text("Salty dried meat that lasts for a long time, but will make you thirsty."),
    materials = { { id = "cured_meat", portions = 1 } },
    mass = "85 g",
    default_container = "bag_plastic_small",
    color = "brown",
    volume = "250 ml",
    price = "3 USD 20 cent",
    survival_price = "2 USD 50 cent",
    comestible = {
        shelf_life = "42 days",
        parasites = 0,
        quench = -5,
        fun = 4,
        calories = 348,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 26 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "salted_fish",
    copy_from = "fish",
    name = ccb.content.plural_text("salted fish", "salted fish"),
    description = ccb.content.text("Salty dried fish that lasts for a long time, but will make you thirsty."),
    materials = { { id = "cured_meat", portions = 1 } },
    default_container = "bag_plastic",
    color = "light_gray",
    survival_price = "2 USD 50 cent",
    volume = "50 ml",
    comestible = {
        shelf_life = "42 days",
        parasites = 0,
        quench = -5,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 1 },
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 7 },
            { id = "meat_allergen", amount = 1 },
        },
        calories = 130,
    },
    inheritance = { remove = { flags = { "RAW" } }, scale = { price = 2.0, mass = 0.345 } },
}

ccb.content.define_item {
    id = "salted_mollusk",
    copy_from = "mollusk",
    name = ccb.content.text("salted mollusk"),
    description = ccb.content.text("Salty dried mollusk that lasts for a long time, but will make you thirsty."),
    materials = { { id = "cured_meat", portions = 1 } },
    default_container = "bag_plastic",
    color = "light_red",
    survival_price = "2 USD 50 cent",
    comestible = { shelf_life = "42 days", parasites = 0, quench = -5, fun = 4 },
    inheritance = { remove = { flags = { "RAW" } }, scale = { price = 2.0, mass = 0.345 } },
}

ccb.content.define_item {
    id = "meat_smoked",
    copy_from = "meat_cooked",
    name = ccb.content.plural_text("smoked meat", "smoked meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("smoked sucker", "smoked sucker"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("smoked Narnian", "smoked Narnian"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    description = ccb.content.text("Tasty meat that has been heavily smoked for preservation.  It could be further smoked until complete dehydration."),
    color = "brown",
    survival_price = "2 USD",
    flags = { "EATEN_HOT", "SMOKED" },
    comestible = { shelf_life = "28 days", quench = -1, fun = 5, smoking_result = "dry_meat" },
}

ccb.content.define_item {
    id = "fish_smoked",
    copy_from = "fish_cooked",
    name = ccb.content.plural_text("smoked fish", "smoked fish"),
    description = ccb.content.text("Tasty fish that has been heavily smoked for long term preservation.  It could be further smoked until complete dehydration."),
    color = "brown",
    survival_price = "2 USD",
    flags = { "EATEN_HOT", "SMOKED" },
    comestible = { shelf_life = "42 days", fun = 6, smoking_result = "dry_fish" },
}

ccb.content.define_item {
    id = "lobster_smoked",
    copy_from = "fish_smoked",
    name = ccb.content.text("smoked lobster"),
    description = ccb.content.text("Tasty lobster that has been heavily smoked for long term preservation.  It could be further smoked until complete dehydration."),
    color = "brown",
    survival_price = "3 USD",
    flags = { "EATEN_HOT", "SMOKED" },
    comestible = { fun = 10, smoking_result = "dry_lobster" },
}

ccb.content.define_item {
    id = "mollusk_smoked",
    copy_from = "fish_smoked",
    name = ccb.content.text("smoked mollusk"),
    description = ccb.content.text("Tasty mollusk that has been heavily smoked for long term preservation.  It could be further smoked until complete dehydration."),
    color = "brown",
    survival_price = "3 USD",
    flags = { "EATEN_HOT" },
    comestible = { fun = 10, smoking_result = "dry_mollusk" },
}

ccb.content.define_item {
    id = "lung",
    copy_from = "flesh",
    looks_like = "offal",
    name = ccb.content.plural_text("piece of raw lung", "of raw lung pieces"),
    description = ccb.content.text("A portion of lung from an animal.  It's spongy and pink, and spoils very quickly.  It can be a delicacy if properly prepared - but if improperly prepared, it's a chewy lump of flavorless connective tissue."),
    display_type = "BY_WEIGHT",
    mass = "45 g",
    volume = "50 ml",
    color = "pink",
    survival_price = "6 cent",
    comestible = {
        shelf_life = "1 day",
        quench = 2,
        fun = -10,
        calories = 40,
        vitamins = {
            { id = "vitC", amount = 9 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 14 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "PREDATOR_FUN" } } },
}

ccb.content.define_item {
    id = "human_lung",
    copy_from = "lung",
    looks_like = "lung",
    name = ccb.content.plural_text("piece of raw human lung", "of raw human lung pieces"),
    description = ccb.content.text("A portion of lung from a human.  It's spongy and pink, and spoils very quickly.  It appears to have been extracted too crudely to ever be useful as a transplant."),
    materials = { "hflesh" },
    comestible = {
        vitamins = {
            { id = "vitC", amount = 9 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 14 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "demihuman_lung",
    copy_from = "lung",
    looks_like = "lung",
    name = ccb.content.plural_text("piece of raw demihuman lung", "of raw demihuman lung pieces"),
    description = ccb.content.text("A portion of lung from a demihuman being.  It's spongy and pink, and spoils very quickly."),
    comestible = {},
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "lung_cooked",
    copy_from = "lung",
    looks_like = "offal_cooked",
    name = ccb.content.plural_text("cooked piece of lung", "of cooked lung pieces"),
    description = ccb.content.text("A chewy, grayish lump of flavorless connective tissue.  It doesn't look any tastier than it did raw, but any parasites are all cooked out."),
    comestible = { fun = -5, parasites = 0 },
    inheritance = { add = { flags = { "EATEN_HOT" } }, remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "mutant_lung",
    copy_from = "lung",
    name = ccb.content.plural_text("piece of raw mutant lung", "of raw mutant lung pieces"),
    snippet_category = "mutant_lung_desc",
    comestible = {
        fun = -15,
        vitamins = {
            { id = "vitC", amount = 9 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 14 },
            { id = "mutant_toxin", amount = 10 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "BAD_TASTE" } }, scale = { survival_price = 0.5 } },
}

ccb.content.define_item {
    id = "mutant_lung_cooked",
    copy_from = "lung_cooked",
    name = ccb.content.plural_text("cooked piece of mutant lung", "of cooked mutant lung pieces"),
    snippet_category = "cooked_mutant_lung_desc",
    comestible = {},
}

ccb.content.define_item {
    id = "heart",
    copy_from = "flesh",
    looks_like = "offal",
    name = ccb.content.plural_text("piece of raw heart", "of raw heart pieces"),
    description = ccb.content.text("A portion of an animal's heart.  It's tough but not that chewy, and it spoils very quickly."),
    display_type = "BY_WEIGHT",
    mass = "55 g",
    volume = "50 ml",
    color = "pink",
    survival_price = "6 cent",
    comestible = {
        shelf_life = "1 day",
        fun = -10,
        calories = 67,
        vitamins = {
            { id = "vitC", amount = "3 mg" },
            { id = "calcium", amount = "2840 μg" },
            { id = "iron", amount = "2660 μg" },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "PREDATOR_FUN" } } },
}

ccb.content.define_item {
    id = "human_heart",
    copy_from = "heart",
    looks_like = "heart",
    name = ccb.content.plural_text("piece of raw human heart", "of raw human heart pieces"),
    description = ccb.content.text("A portion of heart from a human.  It's tough but not that chewy, and it spoils very quickly.  It appears to have been extracted too crudely to ever be useful as a transplant."),
    materials = { "hflesh" },
    comestible = {
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 14 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "demihuman_heart",
    copy_from = "heart",
    looks_like = "heart",
    name = ccb.content.plural_text("piece of raw demihuman heart", "of raw demihuman heart pieces"),
    description = ccb.content.text("A portion of heart from a demihuman being.  It's tough but not that chewy, and it spoils very quickly."),
    comestible = {},
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "heart_cooked",
    copy_from = "heart",
    looks_like = "offal_cooked",
    name = ccb.content.plural_text("cooked piece of heart", "of cooked heart pieces"),
    description = ccb.content.text("A roasted piece of heart.  It doesn't look any tastier than it did raw, but any parasites are all cooked out."),
    comestible = { fun = -5, parasites = 0 },
    inheritance = { add = { flags = { "EATEN_HOT" } }, remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "mutant_heart",
    copy_from = "heart",
    name = ccb.content.plural_text("piece of raw mutant heart", "of raw mutant heart pieces"),
    snippet_category = "mutant_heart_desc",
    comestible = {
        fun = -15,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 14 },
            { id = "mutant_toxin", amount = 10 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "BAD_TASTE" } }, scale = { survival_price = 0.5 } },
}

ccb.content.define_item {
    id = "mutant_human_heart",
    copy_from = "heart",
    name = ccb.content.plural_text("piece of raw mutant humanoid heart", "of raw mutant humanoid heart pieces"),
    snippet_category = "mutant_heart_desc",
    comestible = {
        fun = -15,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 14 },
            { id = "mutant_toxin", amount = 10 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "BAD_TASTE" } }, scale = { survival_price = 0.5 } },
}

ccb.content.define_item {
    id = "mutant_heart_cooked",
    copy_from = "heart_cooked",
    name = ccb.content.plural_text("cooked piece of mutant heart", "of cooked mutant heart pieces"),
    snippet_category = "cooked_mutant_heart_desc",
    comestible = {},
}

ccb.content.define_item {
    id = "mutant_bug_lungs",
    copy_from = "lung",
    name = ccb.content.plural_text("piece of raw mutant lung", "of raw mutant lung pieces"),
    snippet_category = "mutant_bug_lung_desc",
    description = ccb.content.text("You're pretty sure this is lung tissue."),
    looks_like = "lung",
    comestible = {
        vitamins = {
            { id = "vitC", amount = 9 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 14 },
            { id = "mutant_toxin", amount = 25 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "BAD_TASTE" } }, scale = { survival_price = 0.1, calories = 0.65 } },
}

ccb.content.define_item {
    id = "liver",
    copy_from = "lung",
    looks_like = "offal",
    name = ccb.content.plural_text("piece of raw liver", "of raw liver pieces"),
    description = ccb.content.text("A piece of liver from an animal.  Although many dislike its texture, it's one of the more vitamin-rich parts of the animal.  It is very good in sausages, but maybe a little less appetizing when cooked on its own."),
    display_type = "BY_WEIGHT",
    survival_price = "25 cent",
    comestible = {
        quench = -4,
        calories = 92,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 28 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "human_liver",
    copy_from = "liver",
    looks_like = "liver",
    name = ccb.content.plural_text("piece of raw human liver", "of raw human liver pieces"),
    description = ccb.content.text("A piece of liver from a human, which appears to have been extracted too crudely to ever be useful as a transplant."),
    materials = { "hflesh" },
    comestible = {
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 28 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "demihuman_liver",
    copy_from = "liver",
    looks_like = "liver",
    name = ccb.content.plural_text("piece of raw demihuman liver", "of raw demihuman liver pieces"),
    description = ccb.content.text("A chunk of liver from a demihuman being."),
    comestible = {},
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "liver_cooked",
    copy_from = "liver",
    looks_like = "meat_cooked",
    name = ccb.content.plural_text("cooked piece of liver", "of cooked liver pieces"),
    description = ccb.content.text("Chock-full of A- and B-Vitamins!  Cooked liver isn't all that bad, depending on how you feel about the texture, but this is probably the least fancy way to do it."),
    survival_price = "50 cent",
    comestible = { parasites = 0, fun = 0 },
    inheritance = { remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "mutant_liver",
    copy_from = "liver",
    name = ccb.content.plural_text("piece of raw mutant liver", "of raw mutant liver pieces"),
    snippet_category = "mutant_liver_desc",
    comestible = {
        fun = -15,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 28 },
            { id = "mutant_toxin", amount = 40 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "BAD_TASTE" } }, scale = { survival_price = 0.5 } },
}

ccb.content.define_item {
    id = "mutant_liver_cooked",
    copy_from = "liver_cooked",
    name = ccb.content.plural_text("cooked piece of mutant liver", "of cooked mutant liver pieces"),
    snippet_category = "cooked_mutant_liver_desc",
    comestible = { fun = -5 },
}

ccb.content.define_item {
    id = "bone_marrow",
    copy_from = "flesh",
    name = ccb.content.plural_text("portion of raw bone marrow", "of raw bone marrow portions"),
    description = ccb.content.text("A soft, spongy substance found in bones, rich in fat.  Chock-full of good stuff and doesn't taste too bad even raw, but beware of parasites."),
    display_type = "BY_WEIGHT",
    mass = "60 g",
    volume = "65 ml",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "RAW", "PREDATOR_FUN" },
    comestible = {
        shelf_life = "1 day",
        calories = 471,
        fun = -3,
        vitamins = { { id = "iron", amount = 17 }, { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "human_marrow",
    copy_from = "bone_marrow",
    name = ccb.content.plural_text("portion of raw human bone marrow", "of raw human bone marrow portions"),
    description = ccb.content.text("Soft, spongy marrow tissue from a human bone."),
    materials = { "hflesh" },
    comestible = {
        vitamins = {
            { id = "iron", amount = 17 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "demihuman_marrow",
    copy_from = "bone_marrow",
    name = ccb.content.plural_text("portion of raw demihuman bone marrow", "of raw demihuman bone marrow portions"),
    description = ccb.content.text("Soft, spongy marrow tissue from a demihuman bone."),
    comestible = {},
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "mutant_marrow",
    copy_from = "bone_marrow",
    name = ccb.content.plural_text("portion of raw mutant bone marrow", "of raw mutant bone marrow portions"),
    description = ccb.content.text("Soft, spongy, and oddly-colored marrow tissue from the bone of a heavily mutated animal."),
    flags = { "BAD_TASTE", "RAW", "PREDATOR_FUN" },
    comestible = {
        vitamins = {
            { id = "iron", amount = 7 },
            { id = "mutant_toxin", amount = 25 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { scale = { price = 0.2, calories = 0.5 } },
}

ccb.content.define_item {
    id = "mutant_human_marrow",
    copy_from = "mutant_marrow",
    name = ccb.content.plural_text("portion of raw mutant human bone marrow", "of raw mutant human bone marrow portions"),
    description = ccb.content.text("Soft, spongy, and oddly-colored marrow tissue from the bone of a heavily mutated creature that was unsettlingly humanoid in appearance."),
    materials = { "hflesh" },
    comestible = {
        vitamins = {
            { id = "iron", amount = 17 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "brain",
    copy_from = "lung",
    looks_like = "offal",
    name = ccb.content.plural_text("piece of raw brain", "of raw brain pieces"),
    description = ccb.content.text("A chunk of brain from an animal.  You wouldn't want to eat this raw…"),
    display_type = "BY_WEIGHT",
    color = "light_gray",
    survival_price = "10 cent",
    comestible = {
        quench = 10,
        parasites = 15,
        calories = 78,
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 10 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "human_brain",
    copy_from = "brain",
    looks_like = "brain",
    name = ccb.content.plural_text("piece of raw human brain", "of raw human brain pieces"),
    description = ccb.content.text("A chunk of brain from a human.  Eating this may cause kuru, but you probably won't live long enough to care about that anyway."),
    materials = { "hflesh" },
    comestible = {
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 10 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "demihuman_brain",
    copy_from = "brain",
    looks_like = "brain",
    name = ccb.content.plural_text("piece of raw demihuman brain", "of raw demihuman brain pieces"),
    description = ccb.content.text("A chunk of brain from a demihuman being.  Don't prion diseases cross species barriers?"),
    comestible = {},
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "brain_cooked",
    copy_from = "brain",
    looks_like = "offal_cooked",
    name = ccb.content.plural_text("cooked piece of brain", "of cooked brain pieces"),
    description = ccb.content.text("Now you can emulate those zombies you love so much!  Preparing brain for eating is challenging, and this doesn't seem to be the best way to do it."),
    survival_price = "25 cent",
    comestible = { parasites = 0, fun = -5 },
    inheritance = { add = { flags = { "EATEN_HOT" } }, remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "mutant_brain",
    copy_from = "brain",
    looks_like = "brain",
    name = ccb.content.plural_text("piece of raw mutant brain", "of raw mutant brain pieces"),
    snippet_category = "mutant_brain_desc",
    comestible = {
        fun = -20,
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "iron", amount = 10 },
            { id = "mutant_toxin", amount = 50 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "BAD_TASTE" } }, scale = { survival_price = 0.5 } },
}

ccb.content.define_item {
    id = "mutant_brain_cooked",
    copy_from = "brain_cooked",
    name = ccb.content.plural_text("cooked piece of mutant brain", "of cooked mutant brain pieces"),
    snippet_category = "cooked_mutant_brain_desc",
    comestible = { fun = -12 },
}

ccb.content.define_item {
    id = "kidney",
    copy_from = "lung",
    looks_like = "offal",
    name = ccb.content.plural_text("piece of raw kidney", "of raw kidney pieces"),
    description = ccb.content.text("A chunk of kidney from an animal.  Preparing it for cooking is a challenge unless you want the kitchen to smell strongly of urine."),
    display_type = "BY_WEIGHT",
    color = "brown",
    survival_price = "25 cent",
    comestible = {
        calories = 54,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 25 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "human_kidney",
    copy_from = "kidney",
    looks_like = "kidney",
    name = ccb.content.plural_text("piece of raw human kidney", "of raw human kidney pieces"),
    description = ccb.content.text("A chunk of kidney from a human, which appears to have been extracted too crudely to ever be useful as a transplant."),
    materials = { "hflesh" },
    comestible = {
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 25 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "demihuman_kidney",
    copy_from = "kidney",
    looks_like = "kidney",
    name = ccb.content.plural_text("piece of raw demihuman kidney", "of raw demihuman kidney pieces"),
    description = ccb.content.text("This is probably a piece of kidney extracted from a demihuman being."),
    comestible = {},
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "kidney_cooked",
    copy_from = "kidney",
    looks_like = "offal_cooked",
    name = ccb.content.plural_text("cooked piece of kidney", "of cooked kidney pieces"),
    description = ccb.content.text("No, this is not beans."),
    survival_price = "25 cent",
    comestible = { quench = 0, fun = -2, parasites = 0 },
    inheritance = { remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "mutant_kidney",
    copy_from = "kidney",
    name = ccb.content.plural_text("piece of raw mutant kidney", "of raw mutant kidney pieces"),
    snippet_category = "mutant_kidney_desc",
    comestible = {
        fun = -15,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 25 },
            { id = "mutant_toxin", amount = 25 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "BAD_TASTE" } }, scale = { survival_price = 0.5 } },
}

ccb.content.define_item {
    id = "mutant_kidney_cooked",
    copy_from = "kidney_cooked",
    name = ccb.content.plural_text("cooked piece of mutant kidney", "of cooked mutant kidney pieces"),
    snippet_category = "cooked_mutant_kidney_desc",
    comestible = { fun = -12 },
}

ccb.content.define_item {
    id = "sweetbread",
    copy_from = "lung",
    looks_like = "offal",
    name = ccb.content.plural_text("piece of raw sweetbread", "of raw sweetbread pieces"),
    description = ccb.content.text("A piece of the thymus or pancreas of an animal.  These are a delicacy, if prepared properly."),
    display_type = "BY_WEIGHT",
    color = "brown",
    survival_price = "25 cent",
    comestible = {
        quench = 0,
        calories = 133,
        vitamins = {
            { id = "vitC", amount = 11 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 5 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "human_sweetbread",
    copy_from = "sweetbread",
    looks_like = "sweetbread",
    name = ccb.content.plural_text("piece of raw human sweetbread", "of raw human sweetbread pieces"),
    description = ccb.content.text("A piece of the thymus or pancreas of a human, which appears to have been extracted too crudely to ever be useful as a transplant."),
    materials = { "hflesh" },
    comestible = {
        vitamins = {
            { id = "vitC", amount = 11 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 5 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "demihuman_sweetbread",
    copy_from = "sweetbread",
    looks_like = "sweetbread",
    name = ccb.content.plural_text("piece of raw demihuman sweetbread", "of raw demihuman sweetbread pieces"),
    description = ccb.content.text("The consistency of this chunk of organ suggests possibly a thymus or pancreas equivalent."),
    comestible = {},
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "sweetbread_cooked",
    copy_from = "sweetbread",
    looks_like = "meat_cooked",
    name = ccb.content.plural_text("cooked piece of sweetbread", "of cooked sweetbread pieces"),
    survival_price = "50 cent",
    description = ccb.content.text("Normally a delicacy, but this style of preparation is missing something."),
    comestible = { fun = -1, parasites = 0 },
    inheritance = { remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "blood",
    name = ccb.content.plural_text("blood", "blood"),
    copy_from = "human_flesh",
    mass = "262 g",
    color = "red",
    default_container = "bag_iv",
    symbol = "~",
    survival_price = "10 cent",
    description = ccb.content.text("Blood extracted from a human being."),
    display_type = "BY_VOLUME",
    price = "0 cent",
    materials = { "hblood" },
    volume = "250 ml",
    phase = "liquid",
    comestible = {
        kind = "DRINK",
        servings = 1,
        smoking_result = "null",
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "fat",
    name = ccb.content.plural_text("chunk of fat", "of fat chunks"),
    mass = "22 g",
    color = "pink",
    symbol = "%",
    price = "0 cent",
    survival_price = "25 cent",
    description = ccb.content.text("A chunk of raw fat.  You could eat it as-is, but it is better used as an ingredient in other foods or projects."),
    display_type = "BY_WEIGHT",
    materials = { "flesh" },
    volume = "25 ml",
    stackable = true,
    comestible = {
        shelf_life = "7 days",
        kind = "FOOD",
        quench = -1,
        calories = 192,
        parasites = 3,
        fun = -20,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "tallow",
    copy_from = "fat",
    name = ccb.content.plural_text("tallow", "tallow"),
    description = ccb.content.text("A smooth, white block of cleaned and rendered animal fat.  It will remain edible for a very long time, and can be used as an ingredient in many foods and projects."),
    color = "white",
    price = "125 cent",
    survival_price = "50 cent",
    comestible = { kind = "FOOD", shelf_life = "60 days", parasites = 0 },
}

ccb.content.define_item {
    id = "mutant_fat",
    copy_from = "fat",
    name = ccb.content.plural_text("chunk of mutant fat", "of mutant fat chunks"),
    description = ccb.content.text("A chunk of raw fat butchered from a heavily-mutated animal.  It smells, if anything, even more disgusting than the rest of the mutant.  There are little puddles of unidentified oils dripping from it."),
    looks_like = "fat",
    comestible = { vitamins = { { id = "mutant_toxin", amount = 36 }, { id = "meat_allergen", amount = 1 } } },
    inheritance = { scale = { price = 0.2 } },
}

ccb.content.define_item {
    id = "mutant_tallow",
    copy_from = "tallow",
    name = ccb.content.plural_text("mutant tallow", "mutant tallow"),
    description = ccb.content.text("A smooth, white block of cleaned and rendered fat, sourced from a mutant animal.  It will remain edible for a very long time, and can be used as an ingredient in many foods and projects."),
    looks_like = "tallow",
    comestible = { vitamins = { { id = "mutant_toxin", amount = 18 }, { id = "meat_allergen", amount = 1 } } },
    inheritance = { scale = { price = 0.2 } },
}

ccb.content.define_item {
    id = "mutant_human_fat",
    copy_from = "mutant_fat",
    name = ccb.content.plural_text("chunk of mutant humanoid fat", "of mutant humanoid fat chunks"),
    description = ccb.content.text("Raw fat butchered from a heavily-mutated humanoid."),
    materials = { "hflesh" },
    comestible = {},
    inheritance = { add = { vitamins = { { id = "human_flesh_vitamin", amount = 1 } } } },
}

ccb.content.define_item {
    id = "mutant_human_tallow",
    name = ccb.content.plural_text("mutant humanoid tallow", "mutant humanoid tallow"),
    copy_from = "mutant_tallow",
    description = ccb.content.text("A smooth, white block of cleaned and rendered fat, sourced from a mutant humanoid.  It won't rot for a very long time, and can be used as an ingredient in many foods and projects."),
    materials = { "hflesh" },
    comestible = {},
    inheritance = { add = { vitamins = { { id = "human_flesh_vitamin", amount = 1 } } } },
}
