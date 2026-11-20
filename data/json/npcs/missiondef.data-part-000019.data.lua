local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_PROVE_YOU_ARE_A_SURVIVOR",
    name = ccb.content.text("Prove You're A Survivor"),
    description = ccb.content.text("Prove you're a survivor by surviving for 10 days after the Cataclysm, and then returning to the person who gave you this mission."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 0,
    origins = { "ORIGIN_OPENER_NPC" },
    finish = { native_actions = { "follow" } },
    dialogue = {
        describe = ccb.content.text("It's hard to tell who actually has the skills to survive these days…"),
        offer = ccb.content.text("It's hard surviving out here on our own, and we'd probably have a better chance working together.  Problem is, I don't really know you and what you're capable of.  You might have what it takes, or you might not.  Either way, I'm going to need some proof.  Come back in a few days and I'll gladly follow you.  It's basically a win-win for me: either you come back and I'll know you've got what it takes, or you don't and I'll know that I was right not to follow you."),
        accepted = ccb.content.text("I'll see you then… or I won't, and then I'll know I made the right decision."),
        rejected = ccb.content.text("Ya, it was a long shot I admit."),
        advice = ccb.content.text("Don't die.  If you're asking me for advice, that doesn't bode well for you."),
        inquire = ccb.content.text("Well, you're not dead… yet."),
        success = ccb.content.text("I'll be honest, I wasn't really expecting to see you again.  A promise is a promise, I'll follow you now!"),
        success_lie = ccb.content.text("I know time is relative and all that."),
        failure = ccb.content.text("I'm not quite sure how you failed to survive AND are talking to me."),
    },
    complete_when = "complete_mission_prove_you_are_a_survivor",
}
