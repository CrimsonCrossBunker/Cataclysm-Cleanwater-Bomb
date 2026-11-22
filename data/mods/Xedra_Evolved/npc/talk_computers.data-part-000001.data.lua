local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "OFFWORLD_ACQUISITIONS_ASSETS_COMPUTER_ID",
    line = ccb.content.text("&You swipe the id and are rewarded with a fresh login screen and a picture of someone that you're pretty sure you had to put down to get here.  There's no hint about the password, though."),
    replies = {
        {
            text = ccb.content.text("Try hacking the computer"),
            trial = { kind = "skill_check", difficulty = 5, skill = "computer" },
            success = { next_topic = "OFFWORLD_ACQUISITIONS_ASSETS_COMPUTER_HACK_SUCCESS", actions = { actions.handler("dlg_a_xedra_evolved_24bc083f4a9b") } },
            failure = { next_topic = "OFFWORLD_ACQUISITIONS_ASSETS_COMPUTER_HACK_FAILURE", actions = { actions.handler("dlg_a_xedra_evolved_b157d4282aea") } },
        },
        {
            text = ccb.content.text("Maybe later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "OFFWORLD_ACQUISITIONS_ASSETS_COMPUTER_HACK_SUCCESS",
    line = ccb.content.text("&With a satisfying flash of the screen, you manage to log in."),
    replies = {
        {
            text = ccb.content.text("Unlock assets storage doors."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_xedra_evolved_8bc82cf501b4") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "OFFWORLD_ACQUISITIONS_ASSETS_COMPUTER_HACK_FAILURE",
    line = ccb.content.text("&After one too many failed attempts, you're greeted with a message informing you that you're locked out and need to see your systems administrator to regain access, and a loud clang from the other side of the door.  You certainly haven't made it any easier to get inside."),
    replies = {
        {
            text = ccb.content.text("Hmm."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_xedra_evolved_24a3c6481a26") },
        },
    },
}
