local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_3",
    line = ccb.content.text("&Doc Stevens ties down your limbs, and gives you a firm nod.  Then he wipes his brow, again.  And then again with the other sleeve.  The bone saw quickens until it is spinning with a deafening sound.  Its biting teeth cut the air with a harsh whistle.  \"Hoowee, it's hot today.  Alright, give me just a second to boot up the twilight juice, yeah?  Stay still!\".\n\n<color_red>You have a VERY bad feeling about this.</color>"),
    replies = {
        {
            text = ccb.content.text("<color_red>[Against your better judgment, give Doc Stevens permission to put you to sleep, here, strapped down beneath a spinning bone saw]</color>"),
            next_topic = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_4",
            actions = { actions.handler("dlg_a_dda_e77729ae12dd") },
        },
        {
            text = ccb.content.text("Actually, hold on, Doc.  Can you take these things off me?  I'm not ready."),
            next_topic = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_GOOD_CALL",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_4",
    line = ccb.content.text("&It all goes black."),
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "a_turncoat_to_the_end", { permanent = true }), "u_die" },
        },
    },
}
