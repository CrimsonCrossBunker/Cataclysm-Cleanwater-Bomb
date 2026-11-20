local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Draco_GET_GUITAR",
    name = ccb.content.text("Bring an acoustic guitar"),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "acoustic_guitar",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    finish = {
        handler = {
            "mark_general_mission_NC_REFUGEE_Draco_has_guitar",
            "advance_counter_refugee_center_refugee_happiness_by_2",
        },
    },
    dialogue = {
        describe = ccb.content.text("Yeah, sure, imagine how things would be if we had some live music around here?  I don't know how much I could thank you, though, if you're looking for payment.  You'd sure be improving the mood, though."),
        offer = ccb.content.text("I just want a functional acoustic guitar.  Preferably one that hasn't been used to cave in any zombie skulls."),
        accepted = ccb.content.text("Great!  We'll be makin' music in no time!"),
        rejected = ccb.content.text("Oh well.  I understand your reluctance… I guess."),
        advice = ccb.content.text("Well, I'll let you in on a little secret.  Guitars COULD be found at a music store.  Let that one sink in a bit."),
        inquire = ccb.content.text("How's my guitar comin', friend?"),
        success = ccb.content.text("Hell yeah, bud!  You just made a lot of people really happy!  In thanks, I'll have enough cash to offer you more recompense for our little dealings."),
        success_lie = ccb.content.text("Huh.  This… is something, isn't it."),
        failure = ccb.content.text("No worries.  They don't grow from trees, but we have time."),
    },
}
