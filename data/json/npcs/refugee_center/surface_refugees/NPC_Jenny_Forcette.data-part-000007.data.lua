local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Teach1",
    line = ccb.content.text("Huh.\"  She purses her lips and looks at you reluctantly.  \"I guess I can teach you a bit, but you'd have to be like, my on-the-job apprentice and help me get stuff done.  It'll cost you a bit depending on what you want to learn.  Do you know anything about electronics, computers, or mechanics already?"),
    replies = {
        {
            text = ccb.content.text("[Skill 2] I'm not a total noob."),
            next_topic = "TALK_REFUGEE_JENNY_Teach2",
            when = predicates.handler("dlg_p_dda_c0d07b73df17"),
        },
        {
            text = ccb.content.text("[Skill <2] No, that's why I want you to teach me."),
            next_topic = "TALK_REFUGEE_JENNY_Teach2_Sorry",
            when = predicates.handler("dlg_p_dda_54492866b5b0"),
        },
        {
            text = ccb.content.text("[INT 10] No, but I'm a fast learner."),
            when = predicates.handler("dlg_p_dda_7ae74f090fb2"),
            trial = { kind = "persuade", difficulty = 30 },
            success = { next_topic = "TALK_REFUGEE_JENNY_Teach2" },
            failure = { next_topic = "TALK_REFUGEE_JENNY_Teach2_Sorry" },
        },
        {
            text = ccb.content.text("Um, you know what?  Never mind.  What were you saying?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Teach2",
    line = ccb.content.text("All right, fine.\"  Jenny sets aside the computer and gets up.  \"Grab some tools and do as I tell you."),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "knowledge_flag_Jenny_teach", "yes"), actions.handler("dlg_a_dda_d8be20af72a2") } },
    },
    replies = {
        {
            text = ccb.content.text("Just say the word, teach."),
            next_topic = "TALK_TRAIN",
        },
        {
            text = ccb.content.text("<end_talking_leave>  Let's do this later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Teach2_Sorry",
    line = ccb.content.text("&\"I'm sorry, I don't have the time to teach someone who can't pull their weight, I just don't.\"  She gives you a look of genuine regret, then shrugs."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_d8be20af72a2") } },
    },
    replies = {
        {
            text = ccb.content.text("Fine.  What were you saying?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Project1",
    line = {
        when = predicates.any_equal({ "mission_complete", { scope = "speaker", key = "Jenny_pneumatics" } }),
        yes = ccb.content.text("Well, thanks to your help, I've been designing some turrets that would use a central air system to power pneumatic rifle turrets around the center.  It's a lot easier than trying to make gunpowder!\"  She shrugs quickly.  \"I'm probably getting ahead of myself here, I don't think we're due to run out of gunpowder for years, but I also think the design is quieter and more long-term extendable."),
        no = {
            when = predicates.handler("dlg_p_dda_14d6d86ed426"),
            yes = ccb.content.text("About a month ago, I got a mold for making high-caliber air rifle bullets.  I've been designing some turrets that would use a central air system to power pneumatic rifle turrets around the center.  It's a lot easier than trying to make gunpowder!\"  She shrugs quickly.  \"I'm probably getting ahead of myself here, I don't think we're due to run out of gunpowder for years, but I also think the design is quieter and more long-term extendable."),
            no = ccb.content.text("I recently came into possession of this mold for making high-caliber air rifle bullets.  I'm kinda working on a design that would use them to protect the base.  Got a long way to go, though.  If you happen to see anything in your travels about high-powered air rifles, it would help a lot."),
        },
    },
    replies = {
        {
            text = ccb.content.text("If I see anything, I'll let you know.  Can you tell me more about your project?"),
            next_topic = "TALK_REFUGEE_JENNY_Project2",
            when = predicates.handler("dlg_p_dda_ec4cf1c5815e"),
            actions = { actions.offer_mission("MISSION_REFUGEE_Jenny_GET_PNEUMATICS") },
        },
        {
            text = ccb.content.text("Tell me more about your project."),
            next_topic = "TALK_REFUGEE_JENNY_Project2",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
