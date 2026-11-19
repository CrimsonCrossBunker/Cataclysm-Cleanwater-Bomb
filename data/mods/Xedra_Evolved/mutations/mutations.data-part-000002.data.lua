local ccb = require("ccb")

ccb.content.define_mutation {
    id = "DHAMPIR_FANGS_ACTIVE",
    name = ccb.content.text_without_extraction("Dhampir Fangs on"),
    points = 0,
    visibility = 1,
    ugliness = 2,
    description = ccb.content.text_without_extraction("Fang on!"),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    spells_learned = { vampire_drink_blood_with_fangs_spell = 1 },
}

ccb.content.define_mutation {
    id = "DHAMPIR_REDUCED_COLD_TEMPS",
    name = ccb.content.text("Cold as the Grave"),
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your half-dead flesh is inured to winter's chill.  As long as you have empowered blood in your body, you suffer much less from colder temperatures."),
    enchantments = { "INLINE_ENCH_DHAMPIR_REDUCED_COLD_TEMPS_0" },
}

ccb.content.define_mutation {
    id = "DHAMPIR_RESIST_DISEASE_POISON_INFECTION",
    name = ccb.content.text("One Foot in the Grave"),
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text("The deathly energies that course through your veins are inimical to mundane poisons and diseases.  As long as you have empowered blood in your body, you are more resistant to disease, poison, and infection."),
    enchantments = { "INLINE_ENCH_DHAMPIR_RESIST_DISEASE_POISON_INFECTION_0" },
}

ccb.content.define_mutation {
    id = "DHAMPIR_SLOWFALL",
    name = ccb.content.text("Light as the Last Breath"),
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text("While unable to ignore gravity like a true vampire, it has less of a hold on you.  You can fall one story without ill effect and take greatly-reduced fall damage as long as you have empowered blood in your body."),
    enchantments = { "INLINE_ENCH_DHAMPIR_SLOWFALL_0" },
}

ccb.content.define_mutation {
    id = "DHAMPIR_REDUCED_PAIN",
    name = ccb.content.text("Half-Dead Flesh"),
    points = 4,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Being born closer to death, you feel the sensations of the living less strongly.  You suffer much less pain from your injuries than a human would, and the pain affects your capabilities less."),
    enchantments = { "INLINE_ENCH_DHAMPIR_REDUCED_PAIN_0" },
}

-- This should prevent permanent damage from wounds, once that's possible.
ccb.content.define_mutation {
    id = "DHAMPIR_MEND_WOUNDS_FASTER",
    name = ccb.content.text("A Thousand Years of Night"),
    points = 6,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You are only half-alive now, sustained as much by the energy in your blood as by biological processes.  You age far slower than a mortal, and when your limbs break, they heal more quickly in proportion to how much empowered blood you have."),
    enchantments = { "INLINE_ENCH_DHAMPIR_MEND_WOUNDS_FASTER_0" },
    flags = { "MEND_ALL" },
}
