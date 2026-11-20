local ccb = require("ccb")

ccb.content.define_scenario {
    name = "Challenge - Unliving History",
    description = "New England is dotted with old forts from the Revolutionary War, and many of them are still standing.  When things started getting really bad, it seemed like a natural place to hole up for a while, and it turns out that many, many other people had the same idea.  The peace didn't last long.  Now everyone else is undead, and you're trapped inside the walls with them.  The single entrance being a tight choke point is looking a lot less useful now…",
    id = "BastionFortStart",
    points = -2,
    start_name = "Bastion Fort",
    locations = { "sloc_fort" },
    requirement = "achievement_reach_bastion_fort",
    flags = { "CHALLENGE", "LONE_START" },
}
