local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Fatima_1",
    name = ccb.content.text("Find a copy of the Quran"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 0,
    item = "holybook_quran",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I could use a bit of help to find a copy of the Quran."),
        offer = ccb.content.text("I feel silly asking this, but here goes.  I've never been really into reading holy books and stuff like that.  I usually went to the mosque on Friday, and I try to pray five times a day but I hardly ever manage it.  I guess I'm not a very good Muslim, but with all that's happened I would really love to have a copy of the Quran to read.  This seems like a time to get back in touch with God, you know?"),
        accepted = ccb.content.text("Thank you.  I'll see if I can save up a little reward for you."),
        rejected = ccb.content.text("That's okay.  Thanks for offering."),
        advice = ccb.content.text("It's not as common as the bible, but you should be able to find copies in most libraries and bookstores, or in religious buildings.  Make sure you get the translated version, I can't read Arabic!"),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thank you so much.  Just having a copy to keep at hand does actually feel pretty comforting.  I did a few extra rounds of chores and saved the proceeds for if you managed this, here you go.  It's not much but I hope it helps."),
        success_lie = ccb.content.text("What good does this do me?"),
        failure = ccb.content.text("It's okay.  I don't know how much comfort I'd have found in an old book anyway."),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 5 } },
        handler = {
            "mark_mission_flag_Fatima_Mission1",
            "advance_counter_refugee_center_refugee_happiness_by_1",
        },
    },
}
