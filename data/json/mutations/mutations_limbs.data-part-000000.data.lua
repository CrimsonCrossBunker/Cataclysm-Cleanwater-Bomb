local ccb = require("ccb")

ccb.content.define_mutation {
    id = "HEADBUMPS",
    name = ccb.content.text("Head Bumps"),
    description = ccb.content.text("You have a pair of bumps on your skull."),
    categories = { "CATTLE", "CHIMERA", "INSECT", "BEAST" },
    types = { "HORNS" },
    replacements = { "HORNS", "ANTENNAE" },
    points = 0,
    vitamin_cost = 60,
    visibility = 3,
    ugliness = 3,
}

ccb.content.define_mutation {
    id = "HORNS",
    name = ccb.content.text("Horns"),
    description = ccb.content.text("You have a pair of small horns on your head.  They allow you to make a weak piercing headbutt attack, but prevent the use of most rigid headwear."),
    categories = { "CATTLE", "CHIMERA", "BEAST" },
    types = { "HORNS" },
    prerequisites = { "HEADBUMPS" },
    replacements = { "HORNS_CURLED", "HORNS_POINTED", "ANTLERS" },
    points = 1,
    vitamin_cost = 60,
    visibility = 3,
    ugliness = 1,
    allow_soft_gear = true,
    restricts_gear = { "head_crown" },
    integrated_armor = { "integrated_horns_small" },
}

ccb.content.define_mutation {
    id = "HORNS_CURLED",
    name = ccb.content.text("Curled Horns"),
    description = ccb.content.text("You have a pair of large curled horns, like those of a ram.  They allow you to make a strong bashing headbutt attack, but prevent wearing any headwear."),
    categories = { "CHIMERA", "BEAST" },
    types = { "HORNS" },
    prerequisites = { "HORNS" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 90,
    visibility = 8,
    ugliness = 2,
    restricts_gear = { "head_crown" },
    integrated_armor = { "integrated_horns_curled" },
}

ccb.content.define_mutation {
    id = "HORNS_POINTED",
    name = ccb.content.text("Pointed Horns"),
    description = ccb.content.text("You have a pair of long, pointed horns, like those of an antelope.  They allow you to make a strong piercing headbutt attack, but prevent wearing headwear that is not made of fabric."),
    types = { "HORNS" },
    prerequisites = { "HORNS" },
    points = 1,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 2,
    allow_soft_gear = true,
    restricts_gear = { "head_crown" },
    integrated_armor = { "integrated_horns_pointed" },
}

ccb.content.define_mutation {
    id = "ANTLERS",
    name = ccb.content.text("Antlers"),
    description = ccb.content.text("You have a huge rack of antlers, like those of a moose.  They allow you to make a weak headbutt attack, but prevent wearing headwear that is not made of fabric."),
    types = { "HORNS" },
    prerequisites = { "HORNS" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = 3,
    allow_soft_gear = true,
    restricts_gear = { "head_crown" },
    integrated_armor = { "integrated_antlers" },
}

ccb.content.define_mutation {
    id = "SHORTER_FINGERS",
    name = ccb.content.text("Stubby Fingers"),
    description = ccb.content.text("Your fingers have shrunk a bit relative to the rest of your hand.  It's not too bad, but it does make manipulating objects a bit more difficult."),
    categories = { "LUPINE", "FELINE", "BEAST", "URSINE" },
    types = { "HANDS" },
    replacements = { "PAWS" },
    points = -1,
    vitamin_cost = 90,
    visibility = 1,
    ugliness = 0,
    enchantments = { "INLINE_ENCH_SHORTER_FINGERS_0" },
}

ccb.content.define_mutation {
    id = "LONGER_FINGERS",
    name = ccb.content.text("Extended Fingers"),
    description = ccb.content.text("Your fingers have grown relative to the rest of your hand.  This has no in-game effect."),
    categories = { "RABBIT", "CEPHALOPOD", "RAT" },
    replacements = { "PAWS_LITTLE", "PAWS_RAT", "ARM_TENTACLES" },
    types = { "HANDS" },
    points = 0,
    vitamin_cost = 90,
    visibility = 1,
    ugliness = 0,
}
