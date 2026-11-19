local ccb = require("ccb")

-- Table of contents for repeated conversation options when asking Jenny about the other refugees
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_JENNY_Refugees1", "TALK_REFUGEE_JENNY_FreeMerchants",
        "TALK_REFUGEE_JENNY_Refugees2_Fatima", "TALK_REFUGEE_JENNY_Refugees2_Friends",
        "TALK_REFUGEE_JENNY_Refugees2_Borichenko", "TALK_REFUGEE_JENNY_Refugees2_Singh",
        "TALK_REFUGEE_JENNY_Refugees2_Others",
    },
    replies = {
        {
            text = ccb.content.text("Can you tell me about the Free Merchants?"),
            next_topic = "TALK_REFUGEE_JENNY_FreeMerchants",
        },
        {
            text = ccb.content.text("Can you tell me about Fatima?"),
            next_topic = "TALK_REFUGEE_JENNY_Refugees2_Fatima",
        },
        {
            text = ccb.content.text("What has made you friends with Dana, Draco, and Aleesha?"),
            next_topic = "TALK_REFUGEE_JENNY_Refugees2_Friends",
        },
        {
            text = ccb.content.text("Can you tell me about the Borichenkos?"),
            next_topic = "TALK_REFUGEE_JENNY_Refugees2_Borichenko",
        },
        {
            text = ccb.content.text("Can you tell me about the Singhs?"),
            next_topic = "TALK_REFUGEE_JENNY_Refugees2_Singh",
        },
        {
            text = ccb.content.text("Can you tell me about the others?"),
            next_topic = "TALK_REFUGEE_JENNY_Refugees2_Others",
        },
    },
}
