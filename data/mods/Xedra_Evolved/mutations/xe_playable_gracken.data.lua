local ccb = require("ccb")

ccb.content.define_profession {
    subtype = "hobby",
    id = "hobby_species_gracken",
    name = "XE843 'Gracken' (Species)",
    description = "Species XE843 is how the Xedra scientists identified your people before they learned your people could speak to them after enough time around them to develop a way to communicate.  They had little idea that communication is your people's survival trait, coming from a much harsher environment than the humans are…were blessed with, you can make allies with almost any thinking being.  You informed the Xedra people of your race's name 'Gracken' but you didn't tell them that most of your people they found were larval forms and lacking access to the shadow materials needed would never grow up into an adult form.  Now the humans' world is as deadly or moreso than your home and the way back is mostly closed.  Time to try and find a route home that wouldn't be a death sentence, or see what this world has to offer.",
    points = 4,
    proficiencies = { "prof_traps" },
    recipes = {
        "gracken_shade_arms",
        "gracken_strong_arms",
        "gracken_long_arms",
        "gracken_shade_hands",
        "gracken_sharp_nails",
        "gracken_dextrous_hands",
        "gracken_carnivorous_stomach",
        "gracken_herbivorous_stomach",
        "gracken_omnivorous_stomach",
        "gracken_shade_legs",
        "gracken_short_legs",
        "gracken_long_legs",
    },
    traits = {
        "THRESH_SPECIES_GRACKEN",
        "GRACKEN_BUILD",
        "NIGHTVISION",
        "SHADE_SKIN",
        "SHADE_LEGS",
        "SHADE_ARMS",
        "SHADE_EYES",
        "SHADE_HANDS",
        "SHADE_FEET",
        "SHADE_STOMACH",
        "SHADE_EVOLUTION_GLAND",
        "RADIOTROPHIC",
        "GRACKEN",
    },
}

-- Gracken are creatures from the shadow dimension.  They create their own cbm like enhancements that each take up specific trait slots so each build can be unique.
ccb.content.define_mutation {
    id = "GRACKEN",
    name = ccb.content.text("Gracken"),
    mixed_effect = true,
    valid = false,
    starting_trait = false,
    purifiable = false,
    points = 2,
    description = ccb.content.text("A traveler from another dimension.  A dimension of shadows with few bright lights.  Once your species matures, they gain the ability to create new alterations to their body from ingredients harvested from their kills, shadowstuff and magickal essence."),
    types = { "HERITAGE" },
    allowed_categories = { "GRACKEN" },
    cancels = { "DREAMER", "DREAMSMITH", "EATER", "INVENTOR", "CHAOTIC", "CHAOTIC_BAD" },
    empathize_with = { "GRACKEN" },
    no_empathize_with = { "HUMAN" },
    flags = { "HERITAGE", "NO_CBM_INSTALLATION" },
    enchantments = { "INLINE_ENCH_GRACKEN_0" },
}

ccb.content.define_mutation {
    id = "THRESH_SPECIES_GRACKEN",
    name = ccb.content.text("Gracken, Mature"),
    points = 1,
    description = ccb.content.text("You have become a fully mature Gracken and have gained the ability to reform your body in ways previously blocked to you in your immature state."),
    valid = false,
    purifiable = false,
    threshold = true,
}

-- This is the baseline Gracken eyes mutation. TODO: Jsonify nightvision so you can ditch the NIGHTVISION trait.
ccb.content.define_mutation {
    id = "SHADE_EYES",
    name = ccb.content.text("Shade Eyes"),
    description = ccb.content.text("Bright yellow eyes shine out from the shadowy crevices of your face."),
    types = { "EYES" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 4,
    ugliness = 1,
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
    enchantments = { "INLINE_ENCH_SHADE_EYES_0" },
}

ccb.content.define_mutation { id = "NIGHTVISION", copy_from = "NIGHTVISION", add = { categories = { "GRACKEN" } } }

-- This is the baseline Gracken size mutation.
ccb.content.define_mutation {
    id = "GRACKEN_BUILD",
    name = ccb.content.text("Gracken Build"),
    types = { "SIZE" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 4,
    ugliness = 1,
    description = ccb.content.text("Gracken are about the same size as humans, though they look like shadow demons."),
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
}

-- This is the baseline Gracken leg mutation.
ccb.content.define_mutation {
    id = "SHADE_LEGS",
    name = ccb.content.text("Shade Legs"),
    description = ccb.content.text("Your legs are human sized but appear to be made of swirling shadows."),
    types = { "LEGS" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 4,
    ugliness = 1,
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
}

-- This is the first stage short legs mutation.
ccb.content.define_mutation {
    id = "SHADE_SHORT_LEGS",
    name = ccb.content.text("Short Legs"),
    description = ccb.content.text("Your legs have decreased in length providing you with a lower center of gravity and a slight improvement to agility."),
    types = { "LEGS" },
    enchantments = { "INLINE_ENCH_SHADE_SHORT_LEGS_0" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 1,
    ugliness = 1,
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
}

-- This is the first stage long legs mutation.
ccb.content.define_mutation {
    id = "SHADE_LONG_LEGS",
    name = ccb.content.text("Long Legs"),
    description = ccb.content.text("Your legs have lengthened.  You can cross flat terrain more easily."),
    types = { "LEGS" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 4,
    ugliness = 1,
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
    enchantments = { "INLINE_ENCH_SHADE_LONG_LEGS_0" },
}

-- This is the baseline Gracken leg mutation.
ccb.content.define_mutation {
    id = "SHADE_FEET",
    name = ccb.content.text("Shade Feet"),
    description = ccb.content.text("Your feet are humanoid but appear to be made of swirling shadows."),
    types = { "FEET" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 4,
    ugliness = 1,
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
    flags = { "TOUGH_FEET" },
}

-- This is the baseline Gracken arms mutation.
ccb.content.define_mutation {
    id = "SHADE_ARMS",
    name = ccb.content.text("Shade Arms"),
    description = ccb.content.text("Your arms are humanoid but appear to be made of swirling shadows."),
    types = { "ARMS" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 4,
    ugliness = 1,
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
}

-- This is the first stage strong arms mutation.
ccb.content.define_mutation {
    id = "SHADE_STRONG_ARMS",
    name = ccb.content.text("Strong Arms"),
    description = ccb.content.text("Your arms have begun bulking up and become stronger.  +1 Strength"),
    types = { "ARMS" },
    enchantments = { "INLINE_ENCH_SHADE_STRONG_ARMS_0" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 4,
    ugliness = 1,
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
}

-- This is the first stage long arms mutation.
ccb.content.define_mutation {
    id = "SHADE_LONG_ARMS",
    name = ccb.content.text("Long Arms"),
    description = ccb.content.text("Your arms have lengthened.  You can push a target away from you."),
    types = { "ARMS" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 4,
    ugliness = 1,
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
    activation_setup_only = false,
    active = true,
    on_activate = "gracken_arm_push1",
}

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
