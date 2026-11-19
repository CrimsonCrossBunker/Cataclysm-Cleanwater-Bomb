local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
-- Does not have the TEETH type to avoid oddness with vampire fangs
ccb.content.define_mutation {
    id = "VAMPIRE_RENDING_TEETH_active",
    name = ccb.content.text_without_extraction("Rending Jaws Extended"),
    points = 0,
    visibility = 3,
    ugliness = 2,
    description = ccb.content.text_without_extraction("Your jaws are extended and full of sharp teeth."),
    cost = 0,
    player_display = false,
    valid = false,
    integrated_armor = { "integrated_vampire_rending_jaws" },
}

ccb.content.define_mutation {
    id = "VAMPIRE4",
    name = ccb.content.text("Discarded their mortality"),
    points = 0,
    description = ccb.content.text("You have become a true vampire and are beginning to see some of the most potent abilities vampirism has to offer.  The sun burns you even if you cover yourself, your body is now too dead to passively produce mana and your healing will stop while you suffer from the Withering, but your new power more than compensates for that."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    flags = { "CANNIBAL", "DAYFEAR", "HEMOVORE", "MEND_ALL" },
    enchantments = {
        "INLINE_ENCH_VAMPIRE4_0", "INLINE_ENCH_VAMPIRE4_1", "INLINE_ENCH_VAMPIRE4_2",
        "INLINE_ENCH_VAMPIRE4_3", "INLINE_ENCH_VAMPIRE4_4", "INLINE_ENCH_VAMPIRE4_5",
        "INLINE_ENCH_VAMPIRE4_6",
    },
}

ccb.content.define_mutation {
    id = "TRUE_VAMPIRE_POWER",
    points = 6,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("True Vampire's Potence"),
    description = ccb.content.text("Your new status as a true vampire has empowered your other abilities."),
}

ccb.content.define_mutation {
    id = "VAMPIRE_TORPOR",
    points = 5,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Torpor"),
    cancels = { "NARCOLEPTIC", "INSOMNIA", "HEAVYSLEEPER", "HEAVYSLEEPER2" },
    enchantments = { "INLINE_ENCH_VAMPIRE_TORPOR_0" },
    description = ccb.content.text("You can enter a deathlike stake known as torpor, in which your wounds will close faster, your fatigue will fully recover and your blood thirst will be less intense.  Be careful, though, as nothing will be able to wake you up until eight hours have passed."),
    spells_learned = { vampire_torpor = 1 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_DOMINATE",
    points = 7,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Dominating Gaze"),
    description = ccb.content.text("You can focus your gaze and take control of your target.  Only works against targets that have a mind."),
    spells_learned = { vampire_dominate = 1 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_NO_BREATHE",
    points = 6,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Facultative Breathing"),
    description = ccb.content.text("You do not need to breathe air to live anymore.  It prevents you from being drowned or suffocated and allows you to ignore inhaled gases."),
    flags = { "GILLS", "SUFFOCATION_IMMUNE", "INHALED_TOXIN_IMMUNE" },
    cancels = { "ASTHMA" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_NO_ILLNESS",
    points = 6,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Corpse-like Flesh"),
    description = ccb.content.text("Your undead body is now much more dead than alive.  It prevents mundane illnesses and parasites from affecting you, while granting you a total immunity against radiation.  In addition, your scent is now something most mundane creatures cannot understand."),
    scent_type = "sc_vampire",
    flags = { "PARAIMMUNE", "NO_DISEASE", "NO_RADIATION", "INFECTION_IMMUNE" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_SUMMON_SHADOWS",
    name = ccb.content.text("The Shadows that Crawl"),
    points = 5,
    description = ccb.content.text("Your control over darkness has progressed to the point that you can animate patches of it as living shadows to attack your enemies."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    spells_learned = { vampire_summon_shadows = 1 },
}
