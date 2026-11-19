local ccb = require("ccb")

ccb.content.define_mutation {
    id = "PAWS_RAT",
    name = ccb.content.text("Dextrous Paws"),
    description = ccb.content.text("Your hands have elongated and look a bit more like paws.  Fortunately you still have your thumbs, though fine manipulation might be a bit more difficult and you'll have a harder time with firearms."),
    categories = { "RAT" },
    types = { "HANDS" },
    prerequisites = { "NAILS", "CLAWS", "CLAWS_RAT" },
    secondary_prerequisites = { "LONGER_FINGERS" },
    cancels = { "TALONS" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 3,
    ugliness = 2,
    craft_skill_bonuses = { electronics = -1, tailor = -1, mechanics = -1 },
    restricts_gear = { "hand_l", "hand_r" },
    enchantments = { "INLINE_ENCH_PAWS_RAT_0" },
}
