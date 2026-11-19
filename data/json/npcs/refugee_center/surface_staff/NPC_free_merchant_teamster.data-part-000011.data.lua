local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Investigation_Mission",
    line = ccb.content.text("Tell you what, if you can find some sort of evidence that proves they're shafting customers and bring it to me, I'll send someone to look in to it."),
    replies = {
        {
            text = ccb.content.text("Alright, you have yourself a deal."),
            actions = { actions.assign_mission("MISSION_INVESTIGATE_TRADER") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("What sort of \"evidence\" did you have in mind?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Evidence_Type",
        },
        {
            text = ccb.content.text("Why do you want me to do it?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_DoItYourself",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_DoItYourself",
    line = ccb.content.text("Look, I have limited manpower these days, and not everyone can go off of a strangers word with no supporting evidence."),
    replies = {
        {
            text = ccb.content.text("Makes sense, I'll find you some evidence."),
            actions = { actions.assign_mission("MISSION_INVESTIGATE_TRADER") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("What sort of \"evidence\" did you have in mind?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Evidence_Type",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
        },
        {
            text = ccb.content.text("Forget it, since you're not interested in taking this seriously."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Evidence_Type",
    line = ccb.content.text("I guess sales records could work, or stock lists of inventory that give a discrepancy between what's sold and what money comes in."),
    replies = {
        {
            text = ccb.content.text("I'll get right to it, see you later."),
            actions = { actions.assign_mission("MISSION_INVESTIGATE_TRADER") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Who would have these sorts of things?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Evidence_Who",
        },
        {
            text = ccb.content.text("Why do you want me to do it?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_DoItYourself",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
        },
        {
            text = ccb.content.text("<end_talking_later>  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Evidence_Who",
    line = ccb.content.text("Well, there's somebody else who works there, handles all of the money management.  I'd look into them first, should be in the same spot the other guy is."),
    replies = {
        {
            text = ccb.content.text("Makes sense, I'll get right to it."),
            actions = { actions.assign_mission("MISSION_INVESTIGATE_TRADER") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Why do you want me to do it?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_DoItYourself",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
        },
        {
            text = ccb.content.text("I'm not doing any of this legwork for you, figure it out on your own."),
            next_topic = "TALK_DONE",
        },
    },
}
