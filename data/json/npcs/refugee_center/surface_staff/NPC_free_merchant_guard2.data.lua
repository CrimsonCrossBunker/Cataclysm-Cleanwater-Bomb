local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD2_NEW",
    line = ccb.content.text("Yes of course.  Just don't bring any trouble and it's all fine by me."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EVAC_GUARD2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD2_RULES",
    line = ccb.content.text("Well mostly no.  Just don't go around robbing others and starting fights and you will be all set.  Also, don't go into the basement.  Outsiders are not allowed in there."),
    replies = {
        { text = ccb.content.text("Ok, thanks."), next_topic = "TALK_EVAC_GUARD2" },
        {
            text = ccb.content.text("So uhhh, why not?"),
            next_topic = "TALK_EVAC_GUARD2_RULES_BASEMENT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD2_RULES_BASEMENT",
    line = ccb.content.text("In short, we had a problem when a sick refugee died and turned into a zombie.  We had to expel the refugees and most of our surviving group now stays to the basement to prevent it from happening again.  Unless you really prove your worth I don't foresee any exceptions to that rule."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EVAC_GUARD2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD2_WHO",
    line = ccb.content.text("Most are scavengers like you.  They now make a living by looting the cities in search for anything useful: food, weapons, tools, gasoline.  In exchange for their findings we offer them a temporary place to rest and the services of our shop.  I bet some of them would be willing to organize resource runs with you if you ask."),
    replies = { { text = ccb.content.text("Thanks for the heads-up."), next_topic = "TALK_EVAC_GUARD2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD2_TRADE",
    line = ccb.content.text("You are asking the wrong person, should look for our merchant by the main entrance.  Perhaps one of the scavengers is also interested."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EVAC_GUARD2" } },
}
