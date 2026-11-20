local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_MERC_1_RADIO",
    name = ccb.content.text("Active Noise Control"),
    description = ccb.content.text("Investigate Hub 01's radio tower, discover the source of the interference, and fix the problem."),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 5,
    value = 0,
    start = {
        target = { terrain = "radio_tower_top", special = "hub_01", reveal_radius = 1 },
        map_updates = {
            { layout = { monster_placements = { { id = "mon_leech_radio", x = 11, y = 4, target = true } } } },
            { layout = { nested = { { x = 0, y = 0, z = -6, id = "robofac_radio_leech" } } } },
        },
        actions = {
            "follow_only",
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "general_robofac_merc_1_temporal_follower", "yes"),
        },
    },
    finish = {
        actions = { ccb.content.dialogue_actions.offer_mission("MISSION_ROBOFAC_MERC_1_RETURN_TO_HUB") },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("Well… a little while ago, I set up a radio transmitter in the radio tower not far from here, but it stopped transmitting.  I went over there and encountered some crazy stuff you wouldn't believe if you didn't see it yourself:  Some 'plants' moving around, replicating, and attacking me with lightning bolts.  Luckily, the environmental suit I've got from our employers protected me from damage, but fried my electronics.  If you're willing to back me up to eradicate them, I'll owe you a favor.  However, I suggest you turn the mission down and come back when you think you've got sufficient gear."),
        accepted = ccb.content.text("Alright, let's be off, if you think you've got sufficient gear.  You don't mind taking point, right?"),
        rejected = ccb.content.text("Well, thanks for offering.  I hope you'll be able to come back when you've gotten hold of protective gear."),
        advice = ccb.content.text("Get hold of an environmental suit of your own, unless you've got some other protection against electric shocks.  Bring a good weapon and some ammo as well; no idea what insanity <the_cataclysm> has brought us this time, beyond what I saw during my brief encounter."),
        inquire = ccb.content.text("You think we fixed the problem?"),
        success = ccb.content.text("Sure seems like it.  What even was that…?  Eh, doesn't matter.  Let's go back to the Hub; hopefully the tower's working now."),
        success_lie = ccb.content.text("*frowns at you.  \"I've been with you this whole time, dude.  C'mon."),
        failure = ccb.content.text("…"),
    },
}
