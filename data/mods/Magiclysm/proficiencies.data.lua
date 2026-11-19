local ccb = require("ccb")

ccb.content.define_proficiency_category {
    id = "prof_alchemy",
    name = ccb.content.text("Alchemy"),
    description = ccb.content.text("Proficiencies for working with the elements and transforming substances."),
}

ccb.content.define_proficiency_category {
    id = "prof_magic_casting",
    name = ccb.content.text("Spellcraft"),
    description = ccb.content.text("Proficiencies that help with casting of magical spells."),
}

ccb.content.define_proficiency {
    id = "prof_alchemy",
    category = "prof_alchemy",
    name = ccb.content.text("Alchemy"),
    description = ccb.content.text("You know the basics of manipulating the mana of objects through application of chemical laws."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.3,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_almetallurgy",
    category = "prof_alchemy",
    name = ccb.content.text("Almetallurgy"),
    description = ccb.content.text("The forging of magical alloys is a complex process requiring an understanding of both mundane metals and alchemy."),
    can_learn = true,
    time_to_learn = "4 h",
    time_multiplier = 2,
    skill_penalty = 0.2,
    requires = { "prof_alchemy", "prof_metalworking" },
}

ccb.content.define_proficiency {
    id = "prof_leatherworking_dragon",
    category = "prof_tailoring",
    name = ccb.content.text("Dragon leather working"),
    description = ccb.content.text("Working with dragon leather requires a specific set of skills and tools… a set you are familiar with."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 1,
    time_to_learn = "6 h",
    requires = { "prof_leatherworking" },
}

ccb.content.define_proficiency {
    id = "prof_scaleworking_dragon",
    category = "prof_tailoring",
    name = ccb.content.text("Dragon scale working"),
    description = ccb.content.text("Working with dragon scales requires a specific set of skills and tools… a set you are familiar with."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 2,
    time_to_learn = "12 h",
    requires = { "prof_leatherworking_dragon" },
}

ccb.content.define_proficiency {
    id = "prof_golemancy_basic",
    category = "prof_alchemy",
    name = ccb.content.text("Basic Golemancy"),
    description = ccb.content.text("Infusing shaped material with your will and the ability to move is hard but you're starting to get it."),
    can_learn = true,
    time_to_learn = "4 h",
    time_multiplier = 1.5,
    skill_penalty = 1,
}

ccb.content.define_proficiency {
    id = "prof_weapon_enchanting",
    category = "prof_alchemy",
    name = ccb.content.text("Enchanting"),
    description = ccb.content.text("You are an experienced enchanter."),
    can_learn = true,
    time_to_learn = "12 h",
    time_multiplier = 2,
    skill_penalty = 0,
}

ccb.content.define_proficiency {
    id = "prof_botanical_enchantment",
    category = "prof_alchemy",
    name = ccb.content.text("Mystic Horticulture"),
    description = ccb.content.text("The art of instilling mystical energy into fruit."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.2,
    time_to_learn = "10 h",
}

-- This doesn't just have to be damage-dealing spells, it can include anything that involves quickly casting something.
ccb.content.define_proficiency {
    id = "prof_magic_evocation_beginner",
    category = "prof_magic_casting",
    name = ccb.content.text("Novice Evocation"),
    description = ccb.content.text("You're familiar with how to channel magic and quickly release it with destructive potential."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_magic_evocation_apprentice",
    category = "prof_magic_casting",
    name = ccb.content.text("Apprentice Evocation"),
    description = ccb.content.text("You're proficient in quickly pooling magical energy for forceful casting."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "16 h",
    requires = { "prof_magic_evocation_beginner" },
}

ccb.content.define_proficiency {
    id = "prof_magic_evocation_master",
    category = "prof_magic_casting",
    name = ccb.content.text("Master Evocation"),
    description = ccb.content.text("You've mastered the art of casting evocative magic, able to pool large amounts of your mana for quick, powerful spells."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
    requires = { "prof_magic_evocation_apprentice" },
}

-- This covers anything that involves channeling mana for a prolonged amount of time.
ccb.content.define_proficiency {
    id = "prof_magic_channel_beginner",
    category = "prof_magic_casting",
    name = ccb.content.text("Novice Channeling"),
    description = ccb.content.text("You're familiar with the methods used to efficiently channel mana in prolonged casting."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_magic_channel_apprentice",
    category = "prof_magic_casting",
    name = ccb.content.text("Apprentice Channeling"),
    description = ccb.content.text("You're proficient in keeping a steady hand when channeling magic for long amounts of time."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "16 h",
    requires = { "prof_magic_channel_beginner" },
}

ccb.content.define_proficiency {
    id = "prof_magic_channel_master",
    category = "prof_magic_casting",
    name = ccb.content.text("Master Channeling"),
    description = ccb.content.text("You've mastered the art of letting magic flow through you in long stretches."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
    requires = { "prof_magic_channel_apprentice" },
}

-- This covers anything that involves summoning something with magic, like zombies.
ccb.content.define_proficiency {
    id = "prof_magic_summon_beginner",
    category = "prof_magic_casting",
    name = ccb.content.text("Novice Conjuration"),
    description = ccb.content.text("You're familiar with the ideal ways of conjuring something with the power of magic."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_magic_summon_apprentice",
    category = "prof_magic_casting",
    name = ccb.content.text("Apprentice Conjuration"),
    description = ccb.content.text("You're proficient with the methods used in conjuring magical things."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "16 h",
    requires = { "prof_magic_summon_beginner" },
}

ccb.content.define_proficiency {
    id = "prof_magic_summon_master",
    category = "prof_magic_casting",
    name = ccb.content.text("Master Conjuration"),
    description = ccb.content.text("You've mastered the art of conjuring things with the power of magic."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
    requires = { "prof_magic_summon_apprentice" },
}

-- This covers anything that improves a target, such as making oneself more intelligent or strong.
ccb.content.define_proficiency {
    id = "prof_magic_enhancement_beginner",
    category = "prof_magic_casting",
    name = ccb.content.text("Novice Enhancement"),
    description = ccb.content.text("You're familiar with improving a creature by way of magical enhancement."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_magic_enhancement_apprentice",
    category = "prof_magic_casting",
    name = ccb.content.text("Apprentice Enhancement"),
    description = ccb.content.text("You're proficient in boosting the capabilities of your subject with magic."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "16 h",
    requires = { "prof_magic_enhancement_beginner" },
}

ccb.content.define_proficiency {
    id = "prof_magic_enhancement_master",
    category = "prof_magic_casting",
    name = ccb.content.text("Master Enhancement"),
    description = ccb.content.text("You've mastered the art of improving yourself and others with the power of magical incantations."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
    requires = { "prof_magic_enhancement_apprentice" },
}

-- This covers anything that debilitates a target, such as slowing them, silencing them, reducing their regeneration, and so on.
ccb.content.define_proficiency {
    id = "prof_magic_enervation_beginner",
    category = "prof_magic_casting",
    name = ccb.content.text("Novice Enervation"),
    description = ccb.content.text("You're familiar with debilitating your enemies through magic."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_magic_enervation_apprentice",
    category = "prof_magic_casting",
    name = ccb.content.text("Apprentice Enervation"),
    description = ccb.content.text("You're proficient in debilitating your enemies through magic."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "16 h",
    requires = { "prof_magic_enhancement_beginner" },
}

ccb.content.define_proficiency {
    id = "prof_magic_enervation_master",
    category = "prof_magic_casting",
    name = ccb.content.text("Master Enervation"),
    description = ccb.content.text("You've mastered the art of debilitating your enemies with the power of magical incantations."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
    requires = { "prof_magic_enhancement_apprentice" },
}

-- This covers anything that moves a target to and from some place, like teleportation.
ccb.content.define_proficiency {
    id = "prof_magic_conveyance_beginner",
    category = "prof_magic_casting",
    name = ccb.content.text("Novice Conveyance"),
    description = ccb.content.text("You're familiar with how to safely move something from place to place with magic."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_magic_conveyance_apprentice",
    category = "prof_magic_casting",
    name = ccb.content.text("Apprentice Conveyance"),
    description = ccb.content.text("You're proficient in moving your subjects with magic across long distances."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "16 h",
    requires = { "prof_magic_conveyance_beginner" },
}

ccb.content.define_proficiency {
    id = "prof_magic_conveyance_master",
    category = "prof_magic_casting",
    name = ccb.content.text("Master Conveyance"),
    description = ccb.content.text("You've mastered the art of moving things from place to place by magical means."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
    requires = { "prof_magic_conveyance_apprentice" },
}

-- This covers anything that restores the base physical, spiritual, or mental capabilities of the target, like healing spells.
ccb.content.define_proficiency {
    id = "prof_magic_restoration_beginner",
    category = "prof_magic_casting",
    name = ccb.content.text("Novice Restoration"),
    description = ccb.content.text("You're familiar with how to return a target to its normal condition."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_magic_restoration_apprentice",
    category = "prof_magic_casting",
    name = ccb.content.text("Apprentice Restoration"),
    description = ccb.content.text("You're proficient in returning a target to its base condition, curing any ills it might suffer."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "16 h",
    requires = { "prof_magic_conveyance_beginner" },
}

ccb.content.define_proficiency {
    id = "prof_magic_restoration_master",
    category = "prof_magic_casting",
    name = ccb.content.text("Master Restoration"),
    description = ccb.content.text("You've mastered the art of restoring a target to its normal condition."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
    requires = { "prof_magic_conveyance_apprentice" },
}

-- This covers anything that turns one thing into another, like leaves into gold or a human into a bear.  It also covers magical mutation.
ccb.content.define_proficiency {
    id = "prof_magic_transformation_beginner",
    category = "prof_magic_casting",
    name = ccb.content.text("Novice Transformation"),
    description = ccb.content.text("You're familiar with how to turn things into other things using magic."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_magic_transformation_apprentice",
    category = "prof_magic_casting",
    name = ccb.content.text("Apprentice Transformation"),
    description = ccb.content.text("You're proficient in turning things into other things using magic."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "16 h",
    requires = { "prof_magic_conveyance_beginner" },
}

ccb.content.define_proficiency {
    id = "prof_magic_transformation_master",
    category = "prof_magic_casting",
    name = ccb.content.text("Master Transformation"),
    description = ccb.content.text("You've mastered the art of transforming the physical form of creatures and objects."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
    requires = { "prof_magic_conveyance_apprentice" },
}

ccb.content.define_proficiency_category {
    id = "prof_druidic_shifting",
    name = ccb.content.text("Shapeshifting"),
    description = ccb.content.text("Proficiencies for involving druidic transformation into the forms of animals."),
}

ccb.content.define_proficiency {
    id = "prof_druid_basis_of_transformation",
    category = "prof_druidic_shifting",
    name = ccb.content.text("Basis of Druidic Transformation"),
    description = ccb.content.text("As a druid, you have the innate potential to transform yourself into different animals.  You just need to study and master the techniques."),
    time_to_learn = "1 h",
    can_learn = true,
}

ccb.content.define_proficiency {
    id = "prof_druid_transformation_bear",
    category = "prof_druidic_shifting",
    name = ccb.content.text("Form Mastery (Forest King)"),
    description = ccb.content.text("You've mastered the art of transforming yourself into a bear."),
    can_learn = true,
    time_to_learn = "16 h",
    time_multiplier = 1,
    skill_penalty = 0.1,
    requires = { "prof_druid_basis_of_transformation" },
}

ccb.content.define_proficiency {
    id = "prof_druid_transformation_cougar",
    category = "prof_druidic_shifting",
    name = ccb.content.text("Form Mastery (Stalking Hunter)"),
    description = ccb.content.text("You've mastered the art of transforming yourself into a cougar."),
    can_learn = true,
    time_to_learn = "16 h",
    time_multiplier = 1,
    skill_penalty = 0.1,
    requires = { "prof_druid_basis_of_transformation" },
}

ccb.content.define_proficiency {
    id = "prof_druid_transformation_deer",
    category = "prof_druidic_shifting",
    name = ccb.content.text("Form Mastery (Swift Runner)"),
    description = ccb.content.text("You've mastered the art of transforming yourself into a deer."),
    can_learn = true,
    time_to_learn = "16 h",
    time_multiplier = 1,
    skill_penalty = 0.1,
    requires = { "prof_druid_basis_of_transformation" },
}

ccb.content.define_proficiency {
    id = "prof_druid_transformation_raven",
    category = "prof_druidic_shifting",
    name = ccb.content.text("Form Mastery (Soaring Wings)"),
    description = ccb.content.text("You've mastered the art of transforming yourself into a raven."),
    can_learn = true,
    time_to_learn = "16 h",
    time_multiplier = 1,
    skill_penalty = 0.1,
    requires = { "prof_druid_basis_of_transformation" },
}
