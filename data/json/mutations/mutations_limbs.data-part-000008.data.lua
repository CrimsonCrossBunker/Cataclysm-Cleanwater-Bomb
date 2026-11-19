local ccb = require("ccb")

ccb.content.define_mutation {
    id = "RABBIT_FEET",
    name = ccb.content.text("Rabbit Feet"),
    description = ccb.content.text("Your feet have grown into strong and large rabbit feet.  This makes your kicks pack a little more oomph.  Emphasis on little.  It also offers some warmth and allows you to move quickly across snow, and the lucky part is but superstition.  The downside is you are unable to wear shoes."),
    categories = { "RABBIT" },
    types = { "FEET" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 2,
    ugliness = 2,
    flags = { "QUADRUPED_RUN", "TOUGH_FEET", "SNOWWALKING" },
    destroys_gear = true,
    restricts_gear = { "foot_l", "foot_r" },
    armor = { { parts = { "foot_l", "foot_r" }, resistances = { bash = 1 } } },
    enchantments = {
        "ench_quadruped_movement_full", "INLINE_ENCH_RABBIT_FEET_1", "INLINE_ENCH_RABBIT_FEET_2",
        "INLINE_ENCH_RABBIT_FEET_3",
    },
    wet_protection = { { part = "foot_l", neutral = 10 }, { part = "foot_r", neutral = 10 } },
}

ccb.content.define_mutation {
    id = "HOOKED_TOES",
    name = ccb.content.text("Hooked Toes"),
    description = ccb.content.text("Your feet have grown into strong, curved claws.  They won't fit into normal shoes and are not much help in combat, but they allow you to climb most vertical surfaces with ease.  You can even cling to walls you glide into!"),
    categories = { "CHIROPTERAN" },
    types = { "FEET" },
    prerequisites = { "LEGS_BAT" },
    threshold_requirements = { "THRESH_CHIROPTERAN" },
    strict_threshold_requirements = true,
    points = 2,
    vitamin_cost = 160,
    visibility = 2,
    ugliness = 2,
    flags = { "WALL_CLING" },
    destroys_gear = true,
    restricts_gear = { "foot_l", "foot_r" },
}

ccb.content.define_mutation {
    id = "WEBBED_FEET",
    name = ccb.content.text("Webbed Feet"),
    description = ccb.content.text("Your feet are heavily webbed, allowing you to swim faster if you aren't wearing footwear."),
    categories = { "LIZARD", "FISH", "BATRACHIAN" },
    types = { "FEET" },
    prerequisites = { "WEBBED" },
    points = 1,
    vitamin_cost = 60,
    flags = { "WEBBED_FEET" },
    wet_protection = { { part = "foot_l", good = 6 }, { part = "foot_r", good = 6 } },
}
