local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Jobs",
    line = ccb.content.text("*pulls out a sheaf of mismatched papers, and leafs through the pages for a second.  Their broad metallic fingers look surprisingly deft and delicate, and incongruous on the otherwise unremarkable looseleaf.  \"Aye, an' there's room for a pop-an-work roun' here.  Rubik's got tassed a lissy, right and clean."),
    replies = {
        {
            text = ccb.content.text("[Pop-an-Work: Escoltin' sommat of curiosity]"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro",
            when = predicates.handler("dlg_p_dda_814187ad8ba4"),
        },
        {
            text = ccb.content.text("[Pop-an-Work: A pop-an-squeak]"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_intro",
            when = predicates.handler("dlg_p_dda_589f4090ddc0"),
        },
        {
            text = ccb.content.text("[Pop-an-Work: Escolt, held fast]"),
            next_topic = "TALK_EXODII_MERCHANT_mission_3_intro",
            when = predicates.handler("dlg_p_dda_ba181616e62b"),
        },
        {
            text = ccb.content.text("[Pop-an-Work: Free Merchants]"),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_intro",
            when = predicates.handler("dlg_p_dda_2e2b48a542d0"),
        },
        {
            text = ccb.content.text("I'm not interested in anything right now.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
