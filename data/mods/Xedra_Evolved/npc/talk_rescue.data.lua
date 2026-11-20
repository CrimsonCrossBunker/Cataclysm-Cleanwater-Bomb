local ccb = require("ccb")

ccb.content.define_mission {
    id = "BRING_INFESTED_ANTIPARASITICS",
    name = ccb.content.text("Bring 10 antiparasitic pills to %s"),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 240,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("If you think those things put something inside of me we need to get me medicine asap!"),
        offer = ccb.content.text("Please bring me some antiparasitic drugs, I don't want anything hatching out of ME!"),
        accepted = ccb.content.text("Thank you!"),
        rejected = ccb.content.text("Hopefully nothing is wrong with me"),
        advice = ccb.content.text("You've managed to terrify me."),
        inquire = ccb.content.text("Every itch leaves me with a panic attack now"),
        success = ccb.content.text("Thank you so very much I hope this works!"),
        success_lie = ccb.content.text("You're telling me you brought it but you aren't giving them to me."),
        failure = ccb.content.text("Please try harder and get me some medicine, I don't know how long I've got!"),
    },
    finish = { handler = "mark_mission_completed_antiparasitic" },
}
