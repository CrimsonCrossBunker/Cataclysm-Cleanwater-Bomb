local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_JAY_QUEST",
    line = {
        choices = {
            ccb.content.text("If you're offering.  Before everything went to hell, Jay was talking about going to some gun show.  There was a guy there who had managed to sneak some Russian gun into the US.  It was a massive deal for Jay, it was all he could talk about.  I know it's a long shot, but maybe that guy was already at the gun show?  If you find the gun you can keep it, but it would mean a lot to Jay if he could take a look.  All he wanted was to pull it apart and put it back together."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I'll bring you back a souvenir."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
            actions = { actions.offer_mission("MISSION_BLACKSMITH_1"), actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_accepted_quest", "yes") },
        },
        {
            text = ccb.content.text("Not really interested."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'll think about it."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_DEAL_NEGOTIATE",
    line = {
        choices = {
            ccb.content.text("Sure, honey!  I'm always in need of more material!  What's the price, though?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Well, how about 100 merch for every 70 pounds of metal…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_01edabb98966") },
        },
    },
}
