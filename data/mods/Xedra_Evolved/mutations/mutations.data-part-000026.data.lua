local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRE_MIST_FORM_TRAITS",
    name = ccb.content.text_without_extraction("Mist form traits"),
    points = 1,
    description = ccb.content.text_without_extraction("This mutation carries the traits for mist form.  You shouldn't be able to see it in-game."),
    valid = false,
    player_display = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_MIST_FORM_TRAITS_0" },
    appearance = { id = "fd_extinguisher", tile_category = "field" },
}

ccb.content.define_mutation {
    id = "BLOOD_DRINKER",
    name = ccb.content.text("Fully fueled by the Blood"),
    points = 0,
    description = ccb.content.text("By reaching the final stage of vampirism, you have freed yourself from your mundane needs and feelings.  The only thing you need and care about now is blood."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    can_only_eat = { "blood", "hblood", "fae_blood", "vampire_blood" },
    flags = {
        "CANNIBAL",
        "DAYFEAR",
        "NO_THIRST",
        "NO_BODY_HEAT",
        "CANNOT_CONSUME_DRUGS",
        "CANNOT_GAIN_WEARINESS",
    },
    vitamin_intervals = { vitC = -500, iron = -500, calcium = -500 },
    enchantments = { "INLINE_ENCH_BLOOD_DRINKER_0", "INLINE_ENCH_BLOOD_DRINKER_1" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_MASTER_MORTAL_MIND",
    points = 10,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Master the Mortal Mind"),
    description = ccb.content.text("Your ability to influence others has amplified.  You can now spend blood while talking with someone else to make them like you more, with the costliest application of this power being able to turn them into your obsessed servants.  Not all can be influenced by this power, for anger, panic and strong ties to a group that isn't yours will disrupt the process.  Other vampires and the rare saint-blooded are also immune to it."),
}

ccb.content.define_mutation {
    id = "VAMPIRE_DISTILLATE_INNER_BLOOD",
    points = 8,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Distillate the Inner Blood"),
    description = ccb.content.text("Unlike lesser vampires who bloat as they gorge on blood, you concentrate the blood you consume, making it fit nicely in your veins.  This removes the penalties for containing too much blood, but doesn't expand your maximal capacity."),
    enchantments = { "ench_vampire_no_gorge_issues" },
}
