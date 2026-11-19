local ccb = require("ccb")

ccb.content.define_mutation {
    id = "PSI_TORRENTIAL_CHANNELING_active",
    name = ccb.content.text_without_extraction("Torrential Channeling Active"),
    points = 0,
    description = ccb.content.text_without_extraction("The active trait for Torrential Channeling.  It's a bug if you can see it."),
    valid = false,
    player_display = false,
}

ccb.content.define_mutation {
    id = "FIFTH_SUN_CBM_INTERFACE",
    name = ccb.content.text("Tonallichicahualizmeya"),
    points = 0,
    description = ccb.content.text("You have a matrix in your central nervous system that acts as a universal control and installation bus for compact bionic modules."),
    valid = false,
    purifiable = false,
    types = { "Cybernetic" },
    cancels = { "NO_CBM_INSTALLATION" },
}

ccb.content.define_mutation {
    id = "STRONG_LEGS_MOM",
    name = ccb.content.text("Strong Legs"),
    description = ccb.content.text("Your legs have gained muscle mass to propel you across any terrain."),
    types = { "LEGS" },
    points = 1,
    vitamin_cost = 60,
    visibility = 1,
    enchantments = { "INLINE_ENCH_STRONG_LEGS_MOM_0" },
}

ccb.content.define_mutation {
    id = "WEAK_MOM",
    name = ccb.content.text("Weak"),
    enchantments = { "INLINE_ENCH_WEAK_MOM_0" },
    points = -1,
    description = ccb.content.text("Your body is unnaturally weak.  -1 Strength."),
    types = { "STR" },
}

ccb.content.define_mutation {
    id = "WEAK_MOM_2",
    name = ccb.content.text("Very Weak"),
    enchantments = { "INLINE_ENCH_WEAK_MOM_2_0" },
    points = -1,
    description = ccb.content.text("Your body is unnaturally very weak.  -2 Strength."),
    types = { "STR" },
}

ccb.content.define_mutation {
    id = "CLUMSY_MOM",
    name = ccb.content.text("Fumbling"),
    enchantments = { "INLINE_ENCH_CLUMSY_MOM_0" },
    points = -1,
    description = ccb.content.text("Your movements are unnaturally awkward.  -1 Dexterity."),
    types = { "STR" },
}

ccb.content.define_mutation {
    id = "CLUMSY_MOM_2",
    name = ccb.content.text("Weak"),
    enchantments = { "INLINE_ENCH_CLUMSY_MOM_2_0" },
    points = -1,
    description = ccb.content.text("Your  movements are unnaturally very awkward.  -2 Dexterity."),
    types = { "STR" },
}
