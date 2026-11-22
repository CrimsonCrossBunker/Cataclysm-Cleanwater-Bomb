local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_SCIENCE_REP_CBM",
    line = ccb.content.text("You've got one of those interfaces?  Sure.  Let me fire up the robot."),
    replies = {
        {
            text = ccb.content.text("Would you be able to help me install a bionic implant?"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_9aa5249d2b43"),
            actions = { "bionic_install" },
        },
        {
            text = ccb.content.text("Would you be able to take out one of my bionic implants?"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_9aa5249d2b43"),
            actions = { "bionic_remove" },
        },
        {
            text = ccb.content.text("Never mind…"),
            next_topic = "TALK_SCIENCE_REP",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_SCIENCE_REP_1",
    name = ccb.content.text("Procure a centrifuge"),
    description = ccb.content.text("You need to bring me a <color_light_blue>centrifuge</color>, equipment like this can most commonly be found at <color_light_blue>hospitals</color>, but you can also try to search for it at <color_light_blue>medical labs</color> then bring it back to the <color_light_blue>Doctor</color>."),
    goal = "MGOAL_CONDITION",
    difficulty = 5,
    value = 50000,
    start = { target = { terrain = "hospital_2", reveal_radius = 3 } },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_SCIENCE_REP_2",
    dialogue = {
        describe = ccb.content.text("It could be very useful to be able to perform an analysis of zombie blood…"),
        offer = ccb.content.text("We don't have the equipment for real analysis here so I'll need you to bring me one.  I've been authorized to reward the completion of this job with 30 merch, a sizeable sum of the local currency."),
        accepted = ccb.content.text("Excellent.  Here, I'll note the location of a hospital nearby, with some luck you should be able to find a centrifuge in working condition there."),
        rejected = ccb.content.text("Are you sure?  The data we could extract with that equipment could be priceless…"),
        advice = ccb.content.text("Centrifuges can be a bit heavy; you might want to locate a smaller one if you can, it will be way easier to transport."),
        inquire = ccb.content.text("Well, do you have the centrifuge yet?"),
        success = ccb.content.text("Excellent!  This may be the key to removing the infection."),
        success_lie = ccb.content.text("Wait, you couldn't possibly have the centrifuge!  Liar!"),
        failure = ccb.content.text("What a shame, that equipment could have proved invaluable…"),
    },
    finish = {
        before_rewards = "deliver_doctor_centrifuge",
        item_rewards = { { item = "FMCNote", count = 30 } },
        handler = "mark_proven_worth_to_old_guard_representative",
    },
    complete_when = "complete_mission_science_rep_1",
}
