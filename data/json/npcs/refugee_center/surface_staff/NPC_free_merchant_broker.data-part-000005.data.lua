local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_SEALED2",
    line = ccb.content.text("Thank you for that.  We don't have any immediate plans for the area.  Once it's cleaned up I suppose we'll let the people living up here decide what to do with it."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_RANCH",
    line = ccb.content.gendered_line("I'm so glad we've got that up and running.  One of the people evacuated here had a connection to a functioning ranch, and we got him and a crew out there as quickly as we were able.  We're hoping they'll be able to supply us in enough foodstuffs to make this place self-sufficient and even to trade with other communities as they arise.", { "interlocutor" }),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_Boris_Mission_1",
    line = ccb.content.text("You'd be better off asking the shopkeeper up front, I'm the quartermaster."),
}
