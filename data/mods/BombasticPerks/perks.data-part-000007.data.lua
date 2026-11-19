local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_bedtime_reader",
    name = ccb.content.text("Bedtime Stories"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've always loved reading, especially before you fall asleep, and have gotten very good at tearing through books as a way to wind down.  You read books 50% faster, but only when you read them between 8 p.m. and 1 a.m."),
    enchantments = { "INLINE_ENCH_perk_bedtime_reader_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_tingly",
    name = ccb.content.text("Tingly"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Ever since the apocalypse you get a funny feeling during storms and have trouble trusting small appliances.  You usually have a pretty good idea where they are though."),
    enchantments = { "INLINE_ENCH_perk_tingly_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_static_stockpile",
    name = ccb.content.text("Static Stockpile"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You can't touch a door without zapping yourself.  Whenever there is a shocker or a robot within 15 squares, or you are outside during a storm, you gain 500J of bionic power per second and your melee attacks will do a small amount of extra electrical damage."),
    enchantments = { "INLINE_ENCH_perk_static_stockpile_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_jumpy",
    name = ccb.content.text("Jumpy"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've not been the same since the apocalypse, almost everything makes you jump.  You are just a bit quicker to act though."),
    enchantments = { "INLINE_ENCH_perk_jumpy_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_quick_recovery",
    name = ccb.content.text("Quick Recovery"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You get knocked down, but you get up again.  There is a 75% chance when you are downed that you will stand up again immediately."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_sleepy",
    name = ccb.content.text("Easy Sleeper"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've always been able to fall asleep within a few minutes of closing your eyes, no matter what else is going on around you.  You have a much easier time falling asleep."),
    enchantments = { "INLINE_ENCH_perk_sleepy_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_running_in_heels",
    name = ccb.content.text("Running in Heels"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have mastered the ways of the 90s action heroine.  Heels only encumber you as much as normal shoes."),
    enchantments = { "INLINE_ENCH_perk_running_in_heels_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_early_to_rise",
    name = ccb.content.text("Early to Rise"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("That health, wealth, and wisdom is coming any day now.  When you wake up between 4 and 7 a.m., you gain a mood boost for that morning."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_duck_and_weave",
    name = ccb.content.text("Duck and Weave"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Run without rhythm.  After a short wind-up period, you gain 5 effective dodge and +1 bonus dodge attempt as long as you keep running."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_hobbyist",
    name = ccb.content.text("Hobbyist"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("No work, no social obligations, lots of time to focus on your hobbies.  You feel like you've been picking up skills faster recently."),
    enchantments = { "INLINE_ENCH_perk_hobbyist_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_non_combatant",
    name = ccb.content.text("Non-Combatant"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Hey, that's against the Geneva Convention!  When completely unarmed, you take -25% reduced damage."),
    enchantments = { "INLINE_ENCH_perk_non_combatant_0" },
    flags = { "PERK" },
}
