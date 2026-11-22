local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "OFFWORLD_ACQUISITIONS_RAW_MATERIALS_COMPUTER_ID",
    line = ccb.content.text("&You swipe the id and are rewarded with a fresh login screen and a picture of someone that you're pretty sure you had to put down to get here.  There's no hint about the password, though."),
    replies = {
        {
            text = ccb.content.text("Try hacking the computer"),
            trial = { kind = "skill_check", difficulty = 6, skill = "computer" },
            success = { next_topic = "OFFWORLD_ACQUISITIONS_RAW_MATERIALS_COMPUTER_HACK_SUCCESS", actions = { actions.handler("dlg_a_xedra_evolved_1d46c01e34bb") } },
            failure = { next_topic = "OFFWORLD_ACQUISITIONS_RAW_MATERIALS_COMPUTER_HACK_FAILURE", actions = { actions.handler("dlg_a_xedra_evolved_e63bbbe08795") } },
        },
        {
            text = ccb.content.text("Maybe later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "OFFWORLD_ACQUISITIONS_RAW_MATERIALS_COMPUTER_HACK_SUCCESS",
    line = ccb.content.text("&With a satisfying flash of the screen, you manage to log in."),
    replies = {
        {
            text = ccb.content.text("Unlock raw materials storage doors."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_xedra_evolved_8bc82cf501b4") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "OFFWORLD_ACQUISITIONS_RAW_MATERIALS_COMPUTER_HACK_FAILURE",
    line = ccb.content.text("&After one too many failed attempts, you're greeted with a message informing you that you're locked out and need to see your systems administrator to regain access.  Also, and perhaps more importantly, an alarm goes off."),
    replies = {
        {
            text = ccb.content.text("Uh oh."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_xedra_evolved_5ada8748883b") },
        },
    },
}
