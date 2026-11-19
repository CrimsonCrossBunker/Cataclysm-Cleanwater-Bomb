local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RIFLE_ADAPTERS",
    line = ccb.content.text("Adapters are standalone conversion kits, and can be swapped in the field without any tools, though it will take a minute or so.  The factory standard includes adapters for the following calibers… 5.56 NATO, 7.62 NATO, 9mm Parabellum, and 12-gauge shotshell.  Two loaded magazines are also provided for each of these calibers, and additional empty magazines can be purchased through trade.  A maintenance kit with the necessary tools to service the Platform is also provided."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RIFLE_TIMEGATE",
    line = ccb.content.text("As before, each Platform is made to order.  This is a slow process for several reasons.  First, the parts must be printed to spec; this takes a great degree of precision, and so the process is lengthy.  The remainder of the week is spent running reliability tests as each conversion kit finishes production.  I understand that it isn't an ideal option, but I believe the quality of the product is worth that investment."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RIFLE_BENEFITS",
    line = ccb.content.text("I believe the answer to that question to be twofold.  First, a maintenance kit is included with each new Platform that includes the tools required to service it, including a diagram of the weapon's construction.  Second, even if you would prefer to use the weapon only for a specific purpose, we are able to manufacture and provide high-capacity drum magazines far exceeding the capacity of widely-available analogues.  We expect this to be a significant boon to your ability to use the Platform in a variety of environments and situations, as high-capacity magazines can be difficult or dangerous to find in the new world."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RIFLE_STARTED",
    line = ccb.content.text("Excellent.  Report back in seven days' time, and your Platform will be ready."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ARMOR_STARTED",
    line = ccb.content.text("Excellent.  We will begin work shortly.  Report back in 24 hours for pickup."),
}
