local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_JANE_PILLS",
    name = ccb.content.text("Retrieve Thorazine"),
    description = ccb.content.text("Get 75 anti-psychotics for Jane."),
    goal = "MGOAL_FIND_ITEM",
    item = "thorazine",
    item_count = 75,
    difficulty = 3,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +3, value +3).
    finish = {
        actions = {
            { item = "icon", count = 150 },
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "mission_meeting_jane_willing_to_follow", "yes"),
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +3).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get some antipsychotics."),
        offer = ccb.content.text("I'm running out of antipsychotics, and Arturo is starting to see things again.  I'd pay for seventy-five antipsychotic pills, and be eternally grateful."),
        accepted = ccb.content.text("Thank you.  Arturo will be happy to get these."),
        rejected = ccb.content.text("Would you please reconsider?  Arturo's had some bad hallucinations before, he'll go crazy without them."),
        advice = ccb.content.text("The storage room of a pharmacy should have them."),
        inquire = ccb.content.text("Have you found the antipsychotics?"),
        success = ccb.content.text("God bless you, <name_g>.  Arturo shouldn't have to worry about his hallucinations for a long time."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("How unfortunate…"),
    },
}
