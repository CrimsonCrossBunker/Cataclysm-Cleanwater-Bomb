local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRE_HEIGHTENED_SENSES",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Predator's Senses"),
    description = ccb.content.text("Your senses are heightened, allowing you to see more clearly, hear even tiny sounds, and smell nearby fresh human blood."),
    spells_learned = { vampire_smell_nearby_blood_spell = 1 },
    enchantments = {
        "ench_vampire_heightened_senses_hearing", "ench_vampire_heightened_senses_perception",
        "INLINE_ENCH_VAMPIRE_HEIGHTENED_SENSES_2",
    },
}

ccb.content.define_mutation {
    id = "VAMPIRE_HEALTH_BONUS",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Blush of Health"),
    description = ccb.content.text("The power of stolen blood keeps you feel amazing.  As long as you are not suffering from the Withering, you gain a bonus to your health."),
    enchantments = { "INLINE_ENCH_VAMPIRE_HEALTH_BONUS_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_SILENT_MOVE",
    points = 1,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Silent as Death"),
    description = ccb.content.text("Your movements don't make nearby as much noise as they used to."),
    enchantments = { "INLINE_ENCH_VAMPIRE_SILENT_MOVE_0" },
}

ccb.content.define_mutation {
    id = "STAMINAFORBLOOD",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Unholy Endurance"),
    description = ccb.content.text("Your exhaust some of the blood in your veins to boost and recover some of your spent stamina."),
    spells_learned = { vampire_stamina_for_blood_spell = 1 },
}

ccb.content.define_mutation {
    id = "COMMUNE_NIGHT",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Learn from the Children of the Night"),
    description = ccb.content.text("You call out to the creatures that inhabit the night.  Wolves, bats, rats and more.  They tell you about what terrain surrounds you."),
    spells_learned = { vampire_commune_with_night_spell = 1 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_SENSE_CHILDREN_OF_THE_NIGHT",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Sense the Children of the Night"),
    description = ccb.content.text("You can sense the presence of nearby predatory night creatures."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You open your senses to the children of the night."),
    enchantments = { "INLINE_ENCH_VAMPIRE_SENSE_CHILDREN_OF_THE_NIGHT_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE2",
    name = ccb.content.text("Walking the shadowed path of blood"),
    points = 0,
    description = ccb.content.text("You have new fangs to go along with your thirst for blood."),
    starting_trait = false,
    purifiable = false,
    types = { "TEETH" },
    valid = false,
    vitamin_intervals = { human_blood_vitamin = 720, mutagen = 300, mutagenic_slurry = 1 },
    flags = { "CANNIBAL", "HEMOVORE" },
    enchantments = { "INLINE_ENCH_VAMPIRE2_0" },
    spells_learned = { vampire_drink_blood_with_fangs_spell = 1 },
}
