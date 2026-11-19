local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_smash_boost",
    name = ccb.content.text("Smashing for Wimps"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Strong you might not be, but you can still break things down by hitting them the right way.  You get a bonus to your smashing ability that increases the weaker you are."),
    enchantments = { "INLINE_ENCH_perk_smash_boost_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_speedballing",
    name = ccb.content.text("Speedballing"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You love the rush of taking different drugs at once, and now this rush is much more impactful than before.  You gain +3 speed for each recreational or combat-enhancing drug currently affecting you."),
    enchantments = { "INLINE_ENCH_perk_speedballing_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_flawless_memory",
    name = ccb.content.text("Flawless Memory"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You cannot forget anything at all, ever.  This grants you the ability to memorize books for you to read in your head later and makes you able to store mental images so detailled it's almost as if you were taking pictures with your mind."),
    integrated_armor = { "integrated_memory" },
    flags = { "PERK" },
}
