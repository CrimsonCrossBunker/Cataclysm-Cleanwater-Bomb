local ccb = require("ccb")

ccb.content.define_mutation {
    id = "MAGICFORBLOOD",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Blood-Fueled Magic"),
    description = ccb.content.text("Blood has power, and you can draw on that power to fuel magick."),
    spells_learned = { vampire_magic_for_blood_spell = 1 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_COMMAND_BEAST",
    points = 4,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Cowing the Beast"),
    description = ccb.content.text("You are a supreme predator, and other predators bow at your feet."),
    spells_learned = { vampire_command_beast_spell = 1 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_EARTH_SLUMBER",
    points = 4,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Earthen Slumber"),
    description = ccb.content.text("You can sleep within the earth itself, avoiding the hateful light of the sun."),
    spells_learned = { vampire_earth_slumber_spell = 1 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_CARDIO_BONUS",
    name = ccb.content.text("Incarnadine Energy"),
    points = 2,
    description = ccb.content.text("The stolen blood within your body provides you with a fountain of energy.  You gain a bonus to your Cardio rating."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_CARDIO_BONUS_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_MOTION_ALARM",
    name = ccb.content.text("Wakeful Slumber"),
    points = 2,
    description = ccb.content.text("Your senses are so fine they can alert you to danger even while you slumber.  Activate to cause yourself to wake up if danger approaches while you sleep."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    enchantments = { "INLINE_ENCH_VAMPIRE_MOTION_ALARM_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_BONUS_HP",
    name = ccb.content.text("Fortitude of the Damned"),
    points = 2,
    description = ccb.content.text("Your flesh is more resilient and you can suffer much more damage than a mortal before expiring.  Your hit points are increased."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_BONUS_HP_0", "INLINE_ENCH_VAMPIRE_BONUS_HP_1" },
}
