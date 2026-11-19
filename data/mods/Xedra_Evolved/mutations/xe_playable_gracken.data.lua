local ccb = require("ccb")

-- This is the baseline Gracken hands mutation.
ccb.content.define_mutation {
    id = "SHADE_HANDS",
    name = ccb.content.text("Shade Hands"),
    description = ccb.content.text("Your hands are humanoid but appear to be made of swirling shadows."),
    types = { "HANDS" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 4,
    ugliness = 1,
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
}

-- This is the first stage unarmed melee hands mutation.
ccb.content.define_mutation {
    id = "SHADE_SHARP_NAILS",
    name = ccb.content.text("Shade Sharp Nails"),
    description = ccb.content.text("Your hands are humanoid but appear to be made of swirling shadows.  At the end of each finger you sport a razor sharp nail.  It increases your damage when unarmed."),
    types = { "HANDS" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 4,
    ugliness = 1,
    enchantments = { "INLINE_ENCH_SHADE_SHARP_NAILS_0" },
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
}

-- This is the first stage crafting hands mutation.
ccb.content.define_mutation {
    id = "SHADE_DEXTROUS_HANDS",
    name = ccb.content.text("Shade Dextrous Hands"),
    description = ccb.content.text("Your hands are humanoid but appear to be made of swirling shadows.  You sport an extra digit on each hand that improves your ability to get into tight situations."),
    types = { "HANDS" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 4,
    ugliness = 1,
    enchantments = { "INLINE_ENCH_SHADE_DEXTROUS_HANDS_0" },
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
}

-- This is the baseline Gracken skin mutation.
ccb.content.define_mutation {
    id = "SHADE_SKIN",
    name = ccb.content.text("Shade Skin"),
    description = ccb.content.text("Your skin is the color of shadows moving in the twilight."),
    types = { "SKIN" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
}

-- This is the baseline Gracken stomach mutation.
ccb.content.define_mutation {
    id = "SHADE_STOMACH",
    name = ccb.content.text("Shade Stomach"),
    description = ccb.content.text("Your dietary needs are so minimized that you could travel months or years without eating.  There are consequences to this.  One is an inability to process normal food.  Another is a pretty constant state of weariness, but this is the best way to handle interdimensional travel until you are able to develop an organ to consume local foods.  The ambient energies here are much weaker than what you normally encounter out in the Nether between universes, you need exposure to nuclear radiation to gain calories on this planet, for now."),
    types = { "DIET" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    enchantments = { "INLINE_ENCH_SHADE_STOMACH_0" },
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
}

-- This is one path of Gracken stomach mutations.
ccb.content.define_mutation {
    id = "SHADE_OMNIVORE",
    name = ccb.content.text("Omnivorous Stomach"),
    description = ccb.content.text("You eat a wide variety of foods native to this world that would be appropriate for the dominant species."),
    types = { "DIET" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
}

-- This is one path of Gracken stomach mutations.
ccb.content.define_mutation {
    id = "SHADE_CARNIVORE",
    name = ccb.content.text("Carnivorous Stomach"),
    description = ccb.content.text("You eat an exclusively meat-based diet as befits an apex predator of this planet."),
    types = { "DIET" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
    flags = { "CARNIVORE_DIET" },
    enchantments = { "INLINE_ENCH_SHADE_CARNIVORE_0" },
    vitamin_intervals = { vitC = -1200 },
}

-- This is one path of Gracken stomach mutations.
ccb.content.define_mutation {
    id = "SHADE_HERBIVORE",
    name = ccb.content.text("Herbivore Stomach"),
    description = ccb.content.text("You eat a herbivorous diet.  The benefit of this is you never have to kill for your food.  Unless the plants were trying to kill you first."),
    types = { "DIET" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    categories = { "GRACKEN" },
    flags = { "HERBIVORE_DIET" },
    enchantments = { "INLINE_ENCH_SHADE_HERBIVORE_0" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
}

ccb.content.define_mutation {
    id = "SHADE_EVOLUTION_GLAND",
    name = ccb.content.text("Evolution Gland"),
    points = 8,
    purifiable = false,
    description = ccb.content.text("You have a gland that grows a small amount of the material needed to make biological improvements to yourself.  You must gather dreamdross and components from monsters you wish to gain the abilities of and combine them with this shadowstuff into new organs and abilities."),
    cancels = { "ROBUST", "RESTRICTED" },
    valid = false,
    integrated_armor = { "item_gracken_shadowstuff_pocket" },
}

ccb.content.define_mutation {
    id = "RADIOTROPHIC",
    name = ccb.content.text("Radiotrophic"),
    points = 3,
    purifiable = false,
    vitamin_cost = 160,
    description = ccb.content.text("Your system has adapted to radiation.  While irradiated, you will convert the radiation into calories."),
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
}
