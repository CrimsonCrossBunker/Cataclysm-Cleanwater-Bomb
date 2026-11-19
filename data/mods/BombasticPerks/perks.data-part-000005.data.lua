local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_surgical_strikes",
    name = ccb.content.text("Surgical Strikes"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Careful aim allows you to take down game with little tissue damage.  Enemies you kill tend to stay intact."),
    enchantments = { "INLINE_ENCH_perk_surgical_strikes_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_bloody_mess",
    name = ccb.content.text("Bloody Mess"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("For whatever reason you seem to always make a real mess of things.  Enemies you kill tend to explode into a mess of viscera."),
    enchantments = { "INLINE_ENCH_perk_bloody_mess_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_perfect_time",
    name = ccb.content.text("Perfect Timing"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You used to annoy your friends before the Cataclysm by always being *exactly* on time and you've maintained that characteristic to this day.  You always know what time it is and can set alarms even without a watch or a phone."),
    flags = { "PERK", "WATCH", "ALARMCLOCK" },
}

ccb.content.define_mutation {
    id = "perk_all_terrain",
    name = ccb.content.text("All Terrain"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have a persistent sense of how to move around in sharp and rough terrain.  You'll never accidently snag or cut yourself on protrusions from the ground."),
    flags = { "PERK", "ALL_TERRAIN_NAVIGATION" },
}

ccb.content.define_mutation {
    id = "perk_situational_uncanny_dodge",
    name = ccb.content.text("Evasion"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You're so good at dodging that almost nothing can touch you as long as you're on your game.  You have passive Uncanny Dodge until you take damage, after which it takes a few minutes for you to recover your poise."),
    enchantments = { "INLINE_ENCH_perk_situational_uncanny_dodge_0" },
    flags = { "PERK" },
}
