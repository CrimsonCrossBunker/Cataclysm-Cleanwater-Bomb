local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Pablo_Bakery4",
    line = ccb.content.text("Not where you might think.\"  He sets aside his ledger and pulls out a page of bullet-point notes written in neat block letters.  \"Everyone is on board with the idea and the amount of actual building to get it online is small enough that the carpenters are willing to help out, so I don't need any assistance with design.  For the really short term I basically just need materials.  I've been collecting spare wood, but to get a good wood-fired oven I need to secure a source of firebrick.  In the longer run, Dana knows the principles of milling, but I need a resource book if I want to set up a functioning mill, first a muscle-powered one and then a windmill for long term.  I wish I'd thought of asking Jenny.  She's a mechanical engineer, but she would probably know how to get me started at least.  I'm also still looking into how to make a good vermin-proof cellar.  Longer term, I will need to work my way around our reliance on sugar, salt, and vinegar from before the Cataclysm, but our stocks of those will hold out for months while I sort things out."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "message_jenny_tacoma_mill", "known"),
                actions.set_actor_value("speaker", "firebricks_tacoma_bakery", "known"),
                actions.set_actor_value("speaker", "rootcellar_tacoma_bakery", "known"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
