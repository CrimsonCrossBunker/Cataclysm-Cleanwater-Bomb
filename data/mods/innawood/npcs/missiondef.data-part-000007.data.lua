local ccb = require("ccb")

-- NPC will ask player to burn tagged forest tile. Will follow player after accepting mission.
-- Change first topic to do proper checks. MGOAL_GO_TO to check if player stands on tagged tile.
-- At the end of the mission, will place fire on tagged tile and NPC will join player faction.
ccb.content.define_mission {
    id = "MISSION_PYROMANIAC",
    name = ccb.content.text("Angry pyromaniac"),
    goal = "MGOAL_GO_TO",
    difficulty = 0,
    value = 0,
    generic_rewards = false,
    start = {
        target = { terrain = "forest", match = "PREFIX", search_range = 75, random = true, z = 0 },
        actions = { "follow_only", ccb.content.dialogue_actions.set_first_topic("MISSION_PYROMANIAC") },
    },
    finish = {
        actions = {
            "follow",
            { handler = "deliver_tinder_1_items" },
            ccb.content.dialogue_actions.update_map("MISSION_PYROMANIAC_BURN_INNAWOOD"),
        },
    },
    origins = { "ORIGIN_OPENER_NPC" },
    dialogue = {
        describe = ccb.content.text("Oh man, I want to fucking burn it so bad…"),
        offer = ccb.content.text("I'm so fucking infuriated!  I've got a tree that ruined my life, and now I want to get revenge!  I don't care about <the_cataclysm>, I just want to burn that tree!  Would you help me, <name_g>?"),
        accepted = ccb.content.text("Good.  Let's go to the tree and goddamn burn it down!  Oh, bring some tinder so we can start the fire.  I can make the sparks."),
        rejected = ccb.content.text("Seriously?  It's such an easy job…"),
        advice = ccb.content.text("Maybe we can find a stick in the woods."),
        inquire = ccb.content.text("Are you ready, <name_g>?"),
        success = ccb.content.text("Sweet, sweet revenge!  Ah, smells so nice!  Feels like the smell of napalm in the morning!  It will all burn to ashes in a matter of minutes.  You helped me get my revenge, so I'll follow you to the end, <name_g>!"),
        success_lie = ccb.content.text("What?!  You liar!"),
        failure = ccb.content.text("Wow, you failed?  How…"),
    },
}
