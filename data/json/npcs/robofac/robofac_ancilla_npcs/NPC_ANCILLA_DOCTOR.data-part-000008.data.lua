local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_1",
    line = ccb.content.text("You're fuckin' right it's a proper setup, but damn, I could say the same about you!  Look at ya'!\"  The Doc walks over to the spider-like surgical robot, and pats the soft, cushioned examination table.  He wipes his brow with his sleeve and gulps.  \"Right.  Hop up here, and let's plug into your interface there, and see what we're working with.  I suspect we'll have to swap it out.\"  The Doc then starts to unclasp a set of wrist and ankle ties attached to the exam table.\n\n\"Hope this is alright.  We'll tie down your limbs.  Never worked on… well… someone like you, before.  Guess I haven't worked on that many people in any case.  No worries.  I can do it.  Just don't want you, uh, bugging out and hurting yourself, got it?"),
    replies = {
        {
            text = ccb.content.text("[Hop up on the exam table] No problem."),
            next_topic = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_2",
        },
        { text = ccb.content.text("Actually… maybe some other time."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_2",
    line = ccb.content.text("&You lay down on the exam table and lean back.  The spider-like surgical robot that, at first, appeared familiar to you, now feels alien, jerking in its movement, greedily grasping at your ports, plates, and wires.  You hear a bone saw start to loudly whirr, as the Doc goes through various tests.\n\n<color_light_red>You have a bad feeling about this.</color>"),
    replies = {
        {
            text = ccb.content.text("<color_red>[Against your better judgment, let Doc Stevens restrain you on the the Hub 01 automated surgical suite]</color>"),
            next_topic = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_3",
        },
        {
            text = ccb.content.text("[Hop off the exam table] Actually… maybe some other time.  I have some things to do."),
            next_topic = "TALK_DONE",
        },
    },
}
