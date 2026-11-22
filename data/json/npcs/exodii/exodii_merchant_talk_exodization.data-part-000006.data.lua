local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Cyberframe_trust_yes",
    line = ccb.content.text("Hm.  A mighty ask on a mighty ask.  Ye certainly got the disposition, but you sure you wanna be cut inta' this crowded space?\"  Rubik taps their metal torso.  \"You sure ya' lump is screwed on tight?  This isn't like the bright'n'steelies on offer.  No goin' back.  And ye best be happy with the amount'a power you can generate.  This'ere needs contant power.  Without power, yer good as dead.  The power storage units?  Fer a case this'n kind, one'a the power storage units buys you a little-less'an an hour of walkin'.  Less for scrappin' and scramblin'.  Nothin's easy about it.\""),
    replies = {
        {
            text = ccb.content.text("[Integrate your body into an Exodii Cyberframe] A robotic body I'll need to keep constantly powered?  Why not?  I'm ready."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe",
            actions = { actions.adjust_faction_trust(5), actions.handler("dlg_a_dda_dd8915c46668") },
            opinion = { trust = 7, value = 5 },
        },
        {
            text = ccb.content.text("I changed my mind.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I changed my mind.  <end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
