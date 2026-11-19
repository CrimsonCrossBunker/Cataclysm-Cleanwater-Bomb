local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Robofac",
    line = ccb.content.text("Well, we had an odd group come by maybe two days after the power grid went off.  Two armed guards wearing brown uniforms, and what looked like a government doctor, had a hazmat suit on.  Everyone had masks they never took off.  They looked organized… maybe a military remnant from somewhere close by."),
    replies = {
        {
            text = ccb.content.text("What were they here for?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Robofac1",
        },
        {
            text = ccb.content.text("That's fine for now."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Robofac1",
    line = ccb.content.text("The doctor paid us in advance to get some old FEMA info from our computers here, and told us to deliver the data to an isolated building afterwards.  We still haven't done that.  I'm half worried it might have been some kind of trap, or trick."),
    replies = {
        {
            text = ccb.content.text("Where's that building at, exactly?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Robofac2",
        },
        {
            text = ccb.content.text("You seem right to be suspicious."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}
