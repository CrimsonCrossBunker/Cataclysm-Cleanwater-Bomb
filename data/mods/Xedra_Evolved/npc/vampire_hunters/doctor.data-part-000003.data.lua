local ccb = require("ccb")

-- When hidding currently unavailable items will be added, sharing the aspirin and rage drink recipes will add the resulting items to his stock.  For now he has them in stock but won't let you buy them.
ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_SHARE_ASPIRIN",
    line = {
        choices = {
            ccb.content.text("[Blaine copies the recipe on a paper sheet]  These painkillers will surely prove useful when someone will get injured.  Thanks."),
        },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_SHARE_RAGE_DRINK",
    line = {
        choices = {
            ccb.content.text("[Blaine copies the recipe on a paper sheet]  This concoction should result in cardiac arrest, but if it doesn't it will give a boost to our hunters when needed.  Thanks."),
        },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_SHARE_LSD",
    line = {
        choices = {
            ccb.content.text("[Blaine copies the recipe on a paper sheet]  What a complex ingredient list.  This would be hard to produce before <the_cataclysm>, but now it's beyond reasonable with the resources I got here.  Thanks anyway for sharing the recipe."),
        },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
