local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_CABIN_CHEMIST_GET_analytical_set_basic",
    name = ccb.content.text("Find A Basic Analysis Kit"),
    description = ccb.content.text("Obtain a basic laboratory analysis kit for the chemist."),
    goal = "MGOAL_FIND_ITEM",
    item = "analytical_set_basic",
    item_count = 1,
    difficulty = 2,
    value = 3000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_CABIN_CHEMIST_GET_60_chem_muriatic_acid",
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need a basic laboratory analysis kit."),
        offer = ccb.content.text("I've checked the stock here at this house, and it turns out there's a few pieces of equipment I need.  Firstly, I need a reliable way to take measurements and verify results.  If you could get me a basic laboratory analysis kit just to get started, I'd be grateful.  That's the first step towards making everything I brought with me useful."),
        advice = ccb.content.text("One of those old labs might have one."),
        accepted = ccb.content.text("I'll be here when you get back.  Good luck!"),
        rejected = ccb.content.text("Well, someone's got to do it."),
        inquire = ccb.content.text("Do you have it?"),
        success = ccb.content.text("Thank you!  I can't wait to get started!"),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("That's unfortunate.  I guess I'll have to find it myself."),
    },
}
