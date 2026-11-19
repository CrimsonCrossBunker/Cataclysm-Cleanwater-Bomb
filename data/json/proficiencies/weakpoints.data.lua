local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_proficiency {
    id = "prof_debug_weakpoint",
    category = "prof_weakpoint",
    name = ccb.content.text_without_extraction("Debug Weakpoint"),
    description = ccb.content.text_without_extraction("Basic improvement on the chance of hitting the Weakpoint Monster's weak points."),
    can_learn = true,
    time_to_learn = "30 m",
    weakpoint_bonus = 4,
    weakpoint_penalty = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_proficiency {
    id = "prof_debug_weakpoint_expert",
    category = "prof_weakpoint",
    name = ccb.content.text_without_extraction("Expert Debug Weakpoint"),
    description = ccb.content.text_without_extraction("Expert improvement on the chance of hitting the Weakpoint Monster's weak points."),
    can_learn = true,
    time_to_learn = "1 h",
    requires = { "prof_debug_weakpoint" },
}

ccb.content.define_proficiency {
    id = "prof_wp_zombie",
    category = "prof_weakpoint",
    name = ccb.content.text("Principles of Zombie Biology"),
    description = ccb.content.text("Very basic familiarity with various types of undead creatures."),
    can_learn = true,
    time_to_learn = "30 m",
    requires = { "prof_gross_anatomy" },
    weakpoint_bonus = 2,
    weakpoint_penalty = 0,
}

ccb.content.define_proficiency {
    id = "prof_wp_demihuman",
    category = "prof_weakpoint",
    name = ccb.content.text("Principles of Near Human Biology"),
    description = ccb.content.text("Very basic familiarity with various types of demihuman creatures."),
    can_learn = true,
    time_to_learn = "30 m",
    requires = { "prof_gross_anatomy" },
    weakpoint_bonus = 2,
    weakpoint_penalty = 0,
}

ccb.content.define_proficiency {
    id = "prof_wp_amalgamation",
    category = "prof_weakpoint",
    name = ccb.content.text("Anatomy of Amalgamations"),
    description = ccb.content.text("You are familiar with the common anatomy of these purpose-built abominations, as far as they have one."),
    can_learn = true,
    time_to_learn = "30 m",
    weakpoint_bonus = 4,
    weakpoint_penalty = -2,
}

ccb.content.define_proficiency {
    id = "prof_wp_syn_armored",
    category = "prof_weakpoint",
    name = ccb.content.text("Synthetic Armors"),
    description = ccb.content.text("Understanding of man-made armors and ways to exploit them.  You're able to find openings in certain kinds of body armor."),
    can_learn = true,
    time_to_learn = "30 m",
    weakpoint_bonus = 4,
    weakpoint_penalty = -4,
}

ccb.content.define_proficiency {
    id = "prof_wp_nat_armored",
    category = "prof_weakpoint",
    name = ccb.content.text("Natural Armors"),
    description = ccb.content.text("You're somewhat familiar with naturally armored creatures.  You're able to find openings in certain kinds of hardened shells and thick hides."),
    can_learn = true,
    time_to_learn = "30 m",
    weakpoint_bonus = 4,
    weakpoint_penalty = -4,
}

ccb.content.define_proficiency {
    id = "prof_wp_cyborg",
    category = "prof_weakpoint",
    name = ccb.content.text("Cyborg Anatomy"),
    description = ccb.content.text("You're somewhat familiar with cybernetic creatures.  You're able to find openings and gaps that aren't as hardened."),
    can_learn = true,
    time_to_learn = "30 m",
    weakpoint_bonus = 4,
    weakpoint_penalty = -4,
}

ccb.content.define_proficiency {
    id = "prof_wp_basic_amphibian",
    category = "prof_weakpoint",
    name = ccb.content.text("Amphibian Biology"),
    description = ccb.content.text("Basic familiarity with various types of frogs and salamanders."),
    can_learn = true,
    time_to_learn = "30 m",
    requires = { "prof_gross_anatomy" },
    weakpoint_bonus = 1,
    weakpoint_penalty = 0,
}

ccb.content.define_proficiency {
    id = "prof_wp_basic_bird",
    category = "prof_weakpoint",
    name = ccb.content.text("Bird Biology"),
    description = ccb.content.text("Basic familiarity with various types of birds."),
    can_learn = true,
    time_to_learn = "30 m",
    requires = { "prof_gross_anatomy" },
    weakpoint_bonus = 1,
    weakpoint_penalty = 0,
}

ccb.content.define_proficiency {
    id = "prof_wp_canine",
    category = "prof_weakpoint",
    name = ccb.content.text("Canine Anatomy"),
    description = ccb.content.text("Basic familiarity with the anatomy of various canines."),
    can_learn = true,
    time_to_learn = "30 m",
    requires = { "prof_gross_anatomy" },
    weakpoint_bonus = 1,
    weakpoint_penalty = 0,
}

ccb.content.define_proficiency {
    id = "prof_wp_ungulate",
    category = "prof_weakpoint",
    name = ccb.content.text("Ungulate Anatomy"),
    description = ccb.content.text("Basic familiarity with the anatomy of various ungulates."),
    can_learn = true,
    time_to_learn = "30 m",
    requires = { "prof_gross_anatomy" },
    weakpoint_bonus = 1,
    weakpoint_penalty = 0,
}

ccb.content.define_proficiency {
    id = "prof_wp_bear",
    category = "prof_weakpoint",
    name = ccb.content.text("Bear Anatomy"),
    description = ccb.content.text("You are familiar with the anatomy of bears and ways of putting them down easier."),
    requires = { "prof_intro_biology" },
    can_learn = true,
    time_to_learn = "6 h",
    weakpoint_bonus = 4,
    weakpoint_penalty = -2,
}

ccb.content.define_proficiency {
    id = "prof_wp_basic_bug",
    category = "prof_weakpoint",
    name = ccb.content.text("Invertebrate Biology"),
    description = ccb.content.text("Basic familiarity with various types of insects, arachnids, and worms."),
    can_learn = true,
    time_to_learn = "30 m",
    requires = { "prof_gross_anatomy" },
    weakpoint_bonus = 1,
    weakpoint_penalty = 0,
}

ccb.content.define_proficiency {
    id = "prof_wp_beetle",
    category = "prof_weakpoint",
    name = ccb.content.text("Beetle Anatomy"),
    description = ccb.content.text("You are familiar with the anatomy of mutated beetles - bypassing their thick armor should be easier."),
    can_learn = true,
    time_to_learn = "1 h",
    requires = { "prof_wp_basic_bug" },
    weakpoint_bonus = 4,
    weakpoint_penalty = -2,
}

ccb.content.define_proficiency {
    id = "prof_wp_centipede",
    category = "prof_weakpoint",
    name = ccb.content.text("Centipede Anatomy"),
    description = ccb.content.text("You are familiar with the anatomy of mutated centipedes, letting you target their less-deadly parts with ease."),
    can_learn = true,
    time_to_learn = "30 m",
    requires = { "prof_wp_basic_bug" },
    weakpoint_bonus = 4,
    weakpoint_penalty = -2,
}

-- Technically Apocritan Anatomy would be sufficient, but let's not geek out too much
ccb.content.define_proficiency {
    id = "prof_wp_hymenoptera",
    category = "prof_weakpoint",
    name = ccb.content.text("Hymenopteran Anatomy"),
    description = ccb.content.text("Familiarity with the comparative anatomy of mutant Hymenopterans - ants, bees, and wasps of all kinds.  You find it easier to exploit their weak points, and possibly disable their natural weaponry."),
    can_learn = true,
    time_to_learn = "30 m",
    requires = { "prof_wp_basic_bug" },
    weakpoint_bonus = 4,
    weakpoint_penalty = -2,
}

ccb.content.define_proficiency {
    id = "prof_wp_spider",
    category = "prof_weakpoint",
    name = ccb.content.text("Arachnid Anatomy"),
    description = ccb.content.text("You are familiar with the anatomy of mutated spiders of all shapes and sizes."),
    can_learn = true,
    time_to_learn = "30 m",
    requires = { "prof_wp_basic_bug" },
    weakpoint_bonus = 4,
    weakpoint_penalty = -2,
}

ccb.content.define_proficiency {
    id = "prof_wp_flying",
    category = "prof_weakpoint",
    name = ccb.content.text("Creatures of Flight"),
    description = ccb.content.text("Basic understanding of what's needed for certain creatures to fly, as well as ways of preventing it."),
    can_learn = true,
    time_to_learn = "30 m",
    weakpoint_bonus = 1,
    weakpoint_penalty = 0,
}

ccb.content.define_proficiency {
    id = "prof_wp_skeleton",
    category = "prof_weakpoint",
    name = ccb.content.text("Ossified Exoskeletons"),
    description = ccb.content.text("You're familiar with creatures presenting unsettling bones on their outer structure."),
    can_learn = true,
    time_to_learn = "30 m",
    weakpoint_bonus = 4,
    weakpoint_penalty = -2,
}

ccb.content.define_proficiency {
    id = "prof_wp_child",
    category = "prof_weakpoint",
    name = ccb.content.text("Small Humanoids"),
    description = ccb.content.text("You have some practice in fighting small humanoids like children.  You don't necessarily feel good about it."),
    can_learn = true,
    time_to_learn = "30 m",
    requires = { "prof_gross_anatomy" },
    weakpoint_bonus = 2,
    weakpoint_penalty = 0,
}

ccb.content.define_proficiency {
    id = "prof_wp_hulk",
    category = "prof_weakpoint",
    name = ccb.content.text("Giant Humanoids"),
    description = ccb.content.text("You have some practice in fighting large, hulking humanoids.  You're better at reaching certain weak points."),
    can_learn = true,
    time_to_learn = "30 m",
    requires = { "prof_gross_anatomy" },
    weakpoint_bonus = 4,
    weakpoint_penalty = -2,
}

ccb.content.define_proficiency {
    id = "prof_wp_netherium_abomination",
    category = "prof_weakpoint",
    name = ccb.content.text("Netherium Abominations"),
    description = ccb.content.text("You have extensive experience with netherium abominations which provides you with a vague sense of where more vulnerable spots might be."),
    can_learn = true,
    time_to_learn = "30 m",
    weakpoint_bonus = 1,
    weakpoint_penalty = -2,
}

ccb.content.define_proficiency {
    id = "prof_wp_mi-go_basic",
    category = "prof_weakpoint",
    name = ccb.content.text("Mi-go basic anatomy"),
    description = ccb.content.text("You have studied mi-go sufficiently to get a sense for where some sensitive points might be.  However, its biology remains too different from life originating on Earth to be understood to any extent."),
    can_learn = true,
    time_to_learn = "30 m",
    weakpoint_bonus = 1,
    weakpoint_penalty = -2,
}

ccb.content.define_proficiency {
    id = "prof_wp_mi-go_advanced",
    category = "prof_weakpoint",
    name = ccb.content.text("Mi-go detailed anatomy"),
    description = ccb.content.text("Your understanding of the mi-go body is advanced enough to have a decent idea of where it is more sensitive to harm.  This does not mean you have any significant understanding of how it works internally; if anything, your dissections have just left you more confused."),
    can_learn = true,
    time_to_learn = "1 h",
    requires = { "prof_wp_mi-go_basic" },
    weakpoint_bonus = 2,
    weakpoint_penalty = -2,
}

ccb.content.define_proficiency {
    id = "prof_wp_fungaloid_basic",
    category = "prof_weakpoint",
    name = ccb.content.text("Fungaloid basic anatomy"),
    description = ccb.content.text("You have studied fungaloids sufficiently to get an idea of which parts are the more sensitive ones.  While seeming to be a weird mixture of fungus and animal, it at least has a structure with commonalities between different types of fungaloids."),
    can_learn = true,
    requires = { "prof_gross_anatomy" },
    time_to_learn = "30 m",
    weakpoint_bonus = 1,
    weakpoint_penalty = -2,
}

ccb.content.define_proficiency {
    id = "prof_wp_fungaloid_advanced",
    category = "prof_weakpoint",
    name = ccb.content.text("Fungaloid detailed anatomy"),
    description = ccb.content.text("You have advanced your understanding of the fungaloid body sufficiently to have a pretty good idea of where you can harm it and where it's better protected.  You don't really understand it's biological functions, although it seems it would be possible for someone with much more time than you have to glean some insight into it, but you've gotten an understanding of how to hurt it, and that's what's important here."),
    can_learn = true,
    time_to_learn = "1 h",
    requires = { "prof_wp_fungaloid_basic" },
    weakpoint_bonus = 2,
    weakpoint_penalty = -2,
}

ccb.content.define_proficiency {
    id = "prof_wp_power_leech_basic",
    category = "prof_weakpoint",
    name = ccb.content.text("Power leech basic anatomy"),
    description = ccb.content.text("Your observations of the power leech anatomy is starting to pay off.  You now have a basic idea of where their more sensitive structures are located.  These creatures exhibit traits that seem to be a mix between animal and plant ones."),
    can_learn = true,
    requires = { "prof_intro_biology" },
    time_to_learn = "30 m",
    weakpoint_bonus = 1,
    weakpoint_penalty = -2,
}

ccb.content.define_proficiency {
    id = "prof_wp_power_leech_advanced",
    category = "prof_weakpoint",
    name = ccb.content.text("Power leech detailed anatomy"),
    description = ccb.content.text("The extensive experience with power leeches have given you a good understanding of their weaknesses and strengths.  A rather different set of skills would be needed to actually understand their biology, though, and you probably don't have the time to study that anyway."),
    can_learn = true,
    time_to_learn = "1 h",
    requires = { "prof_wp_power_leech_basic" },
    weakpoint_bonus = 2,
    weakpoint_penalty = -2,
}

ccb.content.define_proficiency {
    id = "prof_wp_triffid_basic",
    category = "prof_weakpoint",
    name = ccb.content.text("Triffid basic anatomy"),
    description = ccb.content.text("Study of triffids has given you insights into their anatomy that allows you to aim for some weak spots."),
    can_learn = true,
    requires = { "prof_intro_biology" },
    time_to_learn = "30 m",
    weakpoint_bonus = 1,
    weakpoint_penalty = -2,
}

ccb.content.define_proficiency {
    id = "prof_wp_triffid_advanced",
    category = "prof_weakpoint",
    name = ccb.content.text("Triffid detailed anatomy"),
    description = ccb.content.text("Extensive study of triffids has provided you with a good understanding of their strengths and weaknesses when it comes to combat.  A scientific study of them might yield further biological insights, but you don't have the time to spend years cooped up in a lab."),
    can_learn = true,
    time_to_learn = "1 h",
    requires = { "prof_wp_triffid_basic" },
    weakpoint_bonus = 2,
    weakpoint_penalty = -2,
}
