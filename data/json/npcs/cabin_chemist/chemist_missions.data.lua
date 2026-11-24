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

-- Gasoline is absurdly valuable post-apocalypse and they're asking for a lot of gasoline.
ccb.content.define_mission {
    id = "MISSION_CABIN_CHEMIST_GET_500_GAS",
    name = ccb.content.text("Find Some Gasoline"),
    description = ccb.content.text("Obtain 100 liters of gasoline for the chemist."),
    goal = "MGOAL_FIND_ITEM",
    item = "gasoline",
    item_count = 100000,
    difficulty = 10,
    value = 70000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE",
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need 100 liters of gas."),
        offer = ccb.content.text("I'm in a bit of a spot.  I keep a generator around here to power all my scientific equipment.  It has a bit of gas in it, but I've burned through that and I can't use most of my tools without power.  This may seem like a lot, but if you could get me 100 liters of gas, I'll pay you back any way I can."),
        advice = ccb.content.text("I bet the best place to find that much gas is still a gas station.  Bringing it all here is another problem.  You might want one of those big steel drums we used to use to haul off hazardous waste before <the_cataclysm>."),
        accepted = ccb.content.text("I'll be here when you get back.  Good luck!"),
        rejected = ccb.content.text("Well, someone's got to do it."),
        inquire = ccb.content.text("Do you have it?"),
        success = ccb.content.text("Wonderful!  Thank you so much!  This will keep me running for a long, long time."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("That's unfortunate.  I guess I'll have to find it myself."),
    },
}

ccb.content.define_mission {
    id = "MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE",
    name = ccb.content.text("Establish A Trade Route"),
    description = ccb.content.text("Establish trade relations between the chemist and a refugee center, and bring back a writ of the agreement."),
    goal = "MGOAL_FIND_ITEM",
    item = "trade_writ",
    item_count = 1,
    difficulty = 30,
    value = 20000,
    origins = { "ORIGIN_SECONDARY" },
    start = { target = { terrain = "evac_center_18", special = "evac_center", reveal_radius = 0 } },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("Go negotiate a trade agreement."),
        offer = ccb.content.text("I was out scavenging recently, and I found one of those old evac shelters.  Turns out the computer was still on and it had an address for a refugee center.  I think my skills might be useful to them, for helping maintain medical supplies and whatnot, so I want you to head over there and see if they're interested.  I'd do it myself, but I need to look after this place."),
        advice = ccb.content.text("It should be pretty simple making the deal, but I'd recommend taking a car over there myself."),
        accepted = ccb.content.text("I'll be here when you get back.  Good luck!"),
        rejected = ccb.content.text("Please?  This is really important to me."),
        inquire = ccb.content.text("What did they say about it?"),
        success = ccb.content.text("Thank you!"),
        success_lie = ccb.content.text("How does this help me?"),
        failure = ccb.content.text("That's unfortunate.  I guess I'll have to find other customers."),
    },
}
