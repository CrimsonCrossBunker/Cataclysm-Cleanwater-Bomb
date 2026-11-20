local ccb = require("ccb")

-- Hydrochloric acid is used for basically everything the chemist sells, so trading with them is gated behind this quest.
ccb.content.define_mission {
    id = "MISSION_CABIN_CHEMIST_GET_60_chem_muriatic_acid",
    name = ccb.content.text("Find Some Hydrochloric Acid"),
    description = ccb.content.text("Obtain 15 liters of hydrochloric acid for the chemist."),
    goal = "MGOAL_FIND_ITEM",
    item = "chem_muriatic_acid",
    item_count = 60,
    difficulty = 7,
    value = 10000,
    origins = { "ORIGIN_SECONDARY" },
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "dialogue_trade_mass_chem_tradeable", "yes"),
        },
    },
    followup = "MISSION_CABIN_CHEMIST_GET_500_GAS",
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need 15 liters of hydrochloric acid."),
        offer = ccb.content.text("The last thing I really need to get going is hydrochloric acid.  It's one of those chemicals that's just perfect for so many things.  An acidifying reagent, and one of the best.  With a large supply of hydrochloric acid, you and I are only a few steps removed from a stable source of antiseptic, fungicide, and even some light explosives!  As the only apparent health authority left, I do have to warn you not to get it on your skin, though.  Find this for me and I'll sell you whatever I can make."),
        advice = ccb.content.text("You might find large quantities in a warehouse somewhere, but it often got sold as a household cleaner, did you know that?"),
        accepted = ccb.content.text("I'll be here when you get back.  Good luck!"),
        rejected = ccb.content.text("Well, someone's got to do it."),
        inquire = ccb.content.text("Do you have the hydrochloric acid?"),
        success = ccb.content.text("Wonderful!  I'm sure this will be quite helpful."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("That's unfortunate.  I guess I'll have to find it myself."),
    },
}
