local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_slice&dice",
    name = ccb.content.text("Slice n' Dice"),
    points = 0,
    description = ccb.content.text("You've become very skilled with cutting weapons of all sorts, and know how to use them better."),
    enchantments = { "INLINE_ENCH_perk_slice&dice_0" },
    categories = { "perk" },
}

ccb.content.define_mutation {
    id = "perk_bash&mash",
    name = ccb.content.text("Bash n' Mash"),
    points = 0,
    description = ccb.content.text("You've become very skilled with blunt instruments of all sorts, and know how to use them better."),
    enchantments = { "INLINE_ENCH_perk_bash&mash_0" },
    categories = { "perk" },
}

ccb.content.define_mutation {
    id = "perk_knifey",
    name = ccb.content.text("Knifey"),
    points = 0,
    description = ccb.content.text("You're very in tune with the ways of stabbing somebody."),
    enchantments = { "INLINE_ENCH_perk_knifey_0" },
    categories = { "perk" },
}

ccb.content.define_mutation {
    id = "perk_melee_master",
    name = ccb.content.text("Melee Master"),
    points = 0,
    description = ccb.content.text("You've become a master of melee, and are skilled with melee weapons."),
    enchantments = { "INLINE_ENCH_perk_melee_master_0" },
    categories = { "perk" },
}

ccb.content.define_mutation {
    id = "perk_gymrat_king",
    name = ccb.content.text("Gym Rat King"),
    points = 0,
    description = ccb.content.text("Your time exercising has gotten you used to being winded, and has vastly expanded your stamina.  You can go for longer and harder now."),
    categories = { "perk" },
    enchantments = { "INLINE_ENCH_perk_gymrat_king_0" },
}
