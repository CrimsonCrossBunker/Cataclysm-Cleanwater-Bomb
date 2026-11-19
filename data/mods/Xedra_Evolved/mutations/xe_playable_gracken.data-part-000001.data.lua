local ccb = require("ccb")

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
