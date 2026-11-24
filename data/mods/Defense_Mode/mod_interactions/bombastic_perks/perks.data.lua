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

ccb.content.define_mutation {
    id = "perk_mysterious_stranger",
    name = ccb.content.text("Mysterious Stranger"),
    points = 0,
    description = ccb.content.text("Someone must be watching over you!  Whenever you're in combat, you can call for the help of a stranger for a short amount of time."),
    categories = { "perk" },
    active = true,
    on_activate = "mysterious_stranger_activate",
}

ccb.content.define_mutation {
    id = "perk_extra_life",
    name = ccb.content.text("Living on a Prayer"),
    points = 0,
    description = ccb.content.text("You're like a cat, and it always seemed to you like you've had nine lives.  When things get rough, by pure luck or divine intervention, you can get out of it."),
    categories = { "perk" },
    on_process = "extra_life_addup",
}

ccb.content.define_mutation {
    id = "perk_money_maker_merc",
    name = ccb.content.text("Money Makin' Mercenary"),
    points = 0,
    description = ccb.content.text("You've always had a knack for finding the value in life, whether it's $200 or $50 for a life.  You get more money from completing hordes."),
    categories = { "perk" },
    on_process = "money_maker_setup",
}
