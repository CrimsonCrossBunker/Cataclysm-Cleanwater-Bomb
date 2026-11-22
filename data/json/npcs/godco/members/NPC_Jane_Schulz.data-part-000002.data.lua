local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jane_Heal_You",
    line = ccb.content.text("Sure, I've got some supplies on hand, just give me a minute and you'll be right as rain.  It'll cost three icons."),
    replies = {
        {
            text = ccb.content.text("I can pay for quality work.  Here it is."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "icon", 3),
            actions = { actions.transfer_items("icon", 3), "give_aid" },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Jane_2",
        },
    },
}
