local ccb = require("ccb")
local actions = ccb.content.dialogue_actions



ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_You_Buy_Riot_Gear_On_Credit",
    line = ccb.content.text("If'n you survive, we can give you a fortnight and six odd days to pay us'n back."),
    replies = {
        {
            text = ccb.content.text("Thanks Rubik, I'll be back with your payment soon."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
            actions = { actions.handler("dlg_a_dda_93f3ca32d409"), actions.assign_mission("MISSION_EXODII_PAY_BACK_RIOT_GEAR"), actions.set_actor_value("interlocutor", "npc_dialogue_exodii_npc_bought_riot_gear", "yes") },
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Found_Hub01_CBM_interface",
    line = ccb.content.text("&Rubik pulls out a glowing, green terminal while a surgical robot rolls in to do standard pre-surgical checks.  \"Rightly then, let us'n see what can do 'ye for.\"  Then the surgical robot starts to beep loudly and blurts out words you don't understand in a mechanical voice.  Rubik stares at it a moment, then stares at you.  \"Well now.  Seems to this'n ye've had yer interface swapped.  I'll hear no excuses.  We've had some tech an' stompers gone missin', an' word aroun' says a certain bunker offerin' stolen steelies.  Ye've two minutes to traipse out o'here.  Ken it.\""),
    replies = {
        {
            text = ccb.content.text("Two minutes?  Ah, shit."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_26a76d0c6d1d") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_You_Buy_Riot_Gear",
    line = ccb.content.text("Mayhaps this gear will do you better than it did the scuffers wot trained with it. [$400]"),
    replies = {
        {
            text = ccb.content.text("I'll buy it."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
            actions = { actions.handler("w16b_a_dda_3bad465bd877") },
        },
        {
            text = ccb.content.text("Any chance I can buy gear this on layaway?"),
            next_topic = "TALK_EXODII_MERCHANT_You_Buy_Riot_Gear_On_Credit",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_You_Buy_Riot_Gear_Payback",
    line = ccb.content.text("Right and done, don't let whatever you are going after turn you into a pork loin well done.  I's expectin' you back."),
    replies = {
        {
            text = ccb.content.text("Here's the money to pay off that debt."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
            actions = { actions.handler("w16b_a_dda_3bad465bd877") },
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Hates_Hub_Cyborgs",
    line = ccb.content.text("Shinies an' stompers missin', an' escoltin' a bunker offerin' stolen steelies.  Thine steelies.  Ne.  Ye ain't tassed from around here.  Ye've two minutes to traipse out o'here.  Ken it."),
    replies = {
        {
            text = ccb.content.text("Two minutes to get out of here?  Ah, shit."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_26a76d0c6d1d") },
        },
    },
}
