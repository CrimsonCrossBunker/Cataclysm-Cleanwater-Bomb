local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_NURSE_AID",
    line = {
        when = predicates.has_effect("interlocutor", "currently_busy"),
        yes = ccb.content.text("Come back later, I need to take care of a few things first."),
        no = ccb.content.text("I can take a look at you or your companions if you have any small injuries.  Anything more than some bleeding and you'll need to get a doctor to take a look."),
    },
    replies = {
        {
            text = ccb.content.text("[40 merch, 15m] I need you to patch me up."),
            next_topic = "TALK_RANCH_NURSE_AID_DONE",
            when = predicates.has_inventory("speaker", "FMCNote", 40),
            actions = { actions.handler("dlg_a_dda_fa123fbbeb4e"), "lesser_give_aid" },
        },
        {
            text = ccb.content.text("[100 merch, 30m] I need you to patch my friends up."),
            next_topic = "TALK_RANCH_NURSE_AID_DONE",
            when = predicates.has_inventory("speaker", "FMCNote", 100),
            actions = { actions.handler("dlg_a_dda_3c7b9f950bdf"), "lesser_give_all_aid" },
        },
        {
            text = ccb.content.text("I should be fine."),
            next_topic = "TALK_RANCH_NURSE",
        },
    },
}
