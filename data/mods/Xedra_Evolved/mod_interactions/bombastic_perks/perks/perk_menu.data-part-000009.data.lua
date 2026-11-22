local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_ALCHEMY5",
    line = ccb.content.text("<trait_name:perk_ALCHEMY5>: \"<trait_description:perk_ALCHEMY5>\""),
    replies = {
        {
            text = ccb.content.text("Select Perk."),
            next_topic = "TALK_PERK_MENU_MAIN",
            when = predicates.handler("dlg_p_xedra_evolved_6f9d73792bd9"),
            actions = { actions.replace_mutation("speaker", "perk_ALCHEMY5"), actions.handler("dlg_a_xedra_evolved_0379580f0feb") },
            failure_topic = "TALK_PERK_MENU_FAIL",
            failure_explanation = ccb.content.text("Requirements Not Met"),
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_PERK_MENU_MAIN",
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}
