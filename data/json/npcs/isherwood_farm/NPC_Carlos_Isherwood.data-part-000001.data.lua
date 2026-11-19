local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CARLOS_SawMarshal",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("* glares at you, his hand moving again to his gun.  \"I see that badge, I think you need to keep on walking, straight off this property.\""),
        no = ccb.content.text("*rolls his eyes.  \"I'm not an idiot.  You think if you don't wear your badge, I won't know who you're working for?  Get out of here.\""),
    },
    replies = {
        {
            text = ccb.content.text("Look, I took it off to show I'm not here as a marshal.  I'm just here as a traveler, someone who can maybe help you out.  I know you've got problems bigger than you can handle right now."),
            next_topic = "TALK_ISHERWOOD_CARLOS_MarshalSaveBarry",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_barry_missing" } }), predicates.negate(predicates.wears("speaker", "badge_marshal")) }),
        },
        { text = ccb.content.text("…[Leave.]"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CARLOS_ConvincedMarshal",
    line = {
        joined = {
            ccb.content.text("*looks up warily as you approach"),
            {
                when = predicates.wears("speaker", "badge_marshal"),
                yes = ccb.content.gendered_line(", looking at your marshal badge immediately.  \"You said you'd keep that goddamn piece of tin out of my sight.\"", { "speaker" }),
                no = ccb.content.text(".  \"Yeah?\""),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Oh, right… [Leave.]"),
            next_topic = "TALK_DONE",
            opinion = { trust = -10, value = -10 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
    },
}
