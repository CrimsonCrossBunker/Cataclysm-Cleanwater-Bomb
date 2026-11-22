local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates



ccb.content.define_dialogue_topic {
    id = "TALK_NPC_SCRAP_TRADER_STORY",
    line = {
        when = predicates.has_trait("interlocutor", "BGSS_No_Past_2"),
        yes = ccb.content.text("I know I worked in salvage, but I don't remember much else about it.  I just remember finding this place and deciding to stay here."),
        no = {
            when = predicates.has_trait("interlocutor", "BGSS_No_Past_3"),
            yes = ccb.content.text("I know I worked in salvage, but I don't remember much else about it.  I just remember finding this place and deciding to stay here."),
            no = ccb.content.text("Well, I held a modest job here as a scrap yard worker.  Business was fair most days, but when <the_cataclysm> hit, I decided to head out here.  With all the craziness going on in the cities and whatnot, I decided to just stay here for while.  I figure someone might find a use for the leftover metal lying around, so I started selling it to anyone who passed by."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Why stay here of all places?"),
            next_topic = "TALK_NPC_SCRAP_TRADER_FORT",
        },
        { text = ccb.content.text("Hmm."), next_topic = "TALK_NONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_SCRAP_TRADER_FORT",
    line = {
        when = predicates.has_trait("interlocutor", "BGSS_No_Past_2"),
        yes = ccb.content.text("Well, this place had some barbed wire, metalworking tools, and plenty of supplies.  I made the walls myself.  I didn't know of anywhere else to go either."),
        no = {
            when = predicates.has_trait("interlocutor", "BGSS_No_Past_3"),
            yes = ccb.content.text("Well, this place had some barbed wire, metalworking tools, and plenty of supplies.  I made the walls myself.  I didn't know of anywhere else to go either."),
            no = ccb.content.text("Like I said, I came out here when the dead got pissed off.  This place had some barbed wire, metalworking tools, and plenty of stuff to make weapons out of.  Even the walls are my own making."),
        },
    },
    replies = {
        { text = ccb.content.text("Interesting."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text("Think I could stay here?"),
            next_topic = "TALK_NPC_SCRAP_TRADER_HOME_STAY",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_SCRAP_TRADER_INTRO",
    line = ccb.content.text("Do you need something?"),
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_NPC_SCRAP_TRADER_STORY",
        },
        {
            text = ccb.content.text("Why stay here of all places?"),
            next_topic = "TALK_NPC_SCRAP_TRADER_FORT",
        },
        {
            text = ccb.content.text("I'm looking for a specific, strange building.  I wonder if you've come across it in your travels?"),
            next_topic = "TALK_NPC_SCRAP_TRADER_EXODII_MISSION_WAREHOUSE",
            when = predicates.all({ predicates.has_mission("EXODII_MISSION_WAREHOUSE"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "asked_about_exodii_warehouse_mission" } })) }),
            actions = { actions.handler("w16b_a_dda_9812bef589e2") },
        },
        {
            text = ccb.content.text("Nah, see ya."),
            next_topic = "TALK_DONE",
        },
    },
}
