local ccb = require("ccb")

ccb.content.define_scenario {
    id = "xe_xedra_chronomancer_scenario",
    name = "Challenge - Temporal Misadventure",
    points = -10,
    description = "During the Cataclysmic portal storms, you and several other people were lost trying to escape the monsters attacking you.  Eventually, something caught up, and as your fellows started turning into frozen statues you ran straight into what should have been open air.  The pain of that impact was nothing compared to the knife you suddenly found stabbed into your torso.  The most you saw of your attacker was a quick blur before everything suddenly changed.  Snow covers the ground, the sun has set, you are freezing cold, and the knife is still stuck in your torso.  However, you've gained a dramatic new sense of time, and what is definitely the beginning of the ability to manipulate it.  Even beyond the knife and the winter you never thought you'd have to prepare for, your new powers tell you that there is much more wrong with you than is immediately apparent.  Hopefully you can use your skills and powers to survive both your new condition and every other horror of the Cataclysm.",
    start_name = "Monochrome Meadow",
    locations = { "sloc_xedra_chronomancer" },
    start_of_cataclysm = { hour = 0, day = 61, season = "spring", year = 1 },
    start_of_game = { hour = 22, day = 10, season = "winter", year = 1 },
    professions = { "xedra_chronomancer_profession" },
    flags = { "LONE_START" },
}

ccb.content.define_scenario {
    copy_from = "Mine_bottom",
    extend = { professions = { "archaeologist" } },
    id = "Mine_bottom",
}

ccb.content.define_scenario {
    copy_from = "Mansion",
    extend = { professions = { "archaeologist" } },
    id = "Mansion",
}

ccb.content.define_scenario {
    id = "xe_bloodthorne_druid_scenario",
    name = "Blood on the Thorns",
    points = 0,
    description = "When you were younger, you were suddenly and violently inducted into the truth that the world had things in it more terrible than any human predator, immortal monsters who viewed humans as nothing but cattle.  But you survived, and soon afterwards you were approached by a representative of a group dedicated to fighting the blood-drinkers.  They called themselves the \"Bloodthorne Druids\", and used the power of nature to defend themselves and root out the vampires wherever they could be found.  You joined them and after a period of training, went through the initiation rites and fused your soul with the wilds.  Soon after, the world ended.\n\nThe Cataclysm has shattered the druidic order, but some of its members survived.  And now, when there are so few humans left, they need even more protection from the darkness.",
    start_name = "The wilds",
    locations = { "sloc_hermit_shack", "sloc_cabin", "sloc_forest", "sloc_field" },
    professions = { "xedra_bloodthorne_druid_profession" },
    flags = { "LONE_START" },
}
