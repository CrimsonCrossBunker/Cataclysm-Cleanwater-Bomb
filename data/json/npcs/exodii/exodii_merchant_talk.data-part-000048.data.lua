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
