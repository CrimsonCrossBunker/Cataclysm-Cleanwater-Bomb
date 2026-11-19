local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_LUMBERMILL_LOGGER_TALK_TO_MANAGER",
    line = {
        choices = {
            ccb.content.text("You mean you're still looking for wood?  Crazy… but we had a suspicion folks might show up in an emergency.  Talk to the manager if you want to make an order."),
            ccb.content.text("Well, the machinery works just fine.  We were always self-sufficient and <the_cataclysm> only really made that more apparent.  So if you want to place an order and help keep the operation running, talk to the manager.  We'll trade you for our wood."),
        },
    },
    replies = { { text = ccb.content.text("Sounds good, thanks."), next_topic = "TALK_NONE" } },
}
