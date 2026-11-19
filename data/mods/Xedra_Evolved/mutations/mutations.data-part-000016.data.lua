local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRE_BEAST_CLAWS_active",
    name = ccb.content.text_without_extraction("Claws of the Beast Extended"),
    points = 0,
    visibility = 3,
    ugliness = 2,
    description = ccb.content.text_without_extraction("Your fingers are transformed into sharp claws.  You can use them to attack, but performing mundane tasks will be harder."),
    types = { "CLAWS" },
    cost = 0,
    player_display = false,
    valid = false,
    integrated_armor = { "integrated_claws_rat" },
    enchantments = { "INLINE_ENCH_VAMPIRE_BEAST_CLAWS_active_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_SEE_HEAT",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Crimson Vision"),
    description = ccb.content.text("Your vision has improved and now you can see flowing blood in the vein, like bright trails in the dark."),
    enchantments = { "THERMAL_VISION_GOOD_PASSIVE" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_BLOOD_TEMPORARY_BOOST",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Carmine Vitality"),
    description = ccb.content.text("Blood fills you with a surge of power.  You gain a bonus to your strength and dexterity for one hour after drinking blood."),
}

ccb.content.define_mutation {
    id = "VAMPIRE3",
    name = ccb.content.text("Mortal hungers are replaced with immortal hungers"),
    points = 0,
    description = ccb.content.text("You replace some of your regular caloric intake with blood and begin to see some of the more esoteric abilities inherent to vampirism, though the sun now burns exposed flesh."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    vitamin_absorption = { all = { human_blood_vitamin = 1.25 } },
    vitamin_intervals = { human_blood_vitamin = 720, mutagen = 300 },
    flags = { "CANNIBAL", "DAYFEAR", "HEMOVORE" },
    enchantments = { "INLINE_ENCH_VAMPIRE3_0", "INLINE_ENCH_VAMPIRE3_1", "INLINE_ENCH_VAMPIRE3_2" },
}

ccb.content.define_mutation {
    id = "HYPNOTIC_GAZE",
    points = 4,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Hypnotic Gaze"),
    description = ccb.content.text("You can mesmerize your prey, gazing into their eyes and freezing them in their tracks."),
    spells_learned = { spell_hypnotic_gaze = 1 },
}
