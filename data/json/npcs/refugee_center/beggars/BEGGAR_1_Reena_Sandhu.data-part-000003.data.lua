local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates



ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_LEAVE",
    line = ccb.content.text("Where else?  I can't fight those things out there.  I'm in terrible physical condition, don't have any useful skills, and I'm terrified of <zombies> and violence.  How am I supposed to find a safe place?"),
    replies = {
        {
            text = ccb.content.text("Why don't you scavenge your own food?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_SCAVENGE",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_EXPERTISE",
        },
        {
            text = ccb.content.text("Come with me.  Maybe you're not the greatest adventurer, but it's better than living here."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_JOIN",
            when = predicates.handler("dlg_p_dda_19ac42f5fa83"),
        },
        {
            text = ccb.content.text("I have a camp of my own, away from here.  You could come there.  There aren't many people left, we could use anyone regardless of skills."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_RECRUIT1",
            when = predicates.handler("dlg_p_dda_ee51db677ef6"),
        },
        {
            text = ccb.content.text("I might have some food for you.  Let me check."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
        },
        {
            text = ccb.content.text("I'm sorry, I can't help you."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_SCAVENGE",
    line = ccb.content.text("Out there?  That's suicide!  People that go out there don't come back, people who can hold their own… unlike me.  I'd rather take my chances begging for scraps and waiting for someone in the center to die and make room for me, thanks."),
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_LEAVE",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_EXPERTISE",
        },
        {
            text = ccb.content.text("Come with me.  Maybe you're not the greatest adventurer, but it's better than living here."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_JOIN",
            when = predicates.handler("dlg_p_dda_19ac42f5fa83"),
        },
        {
            text = ccb.content.text("I have a camp of my own, away from here.  Maybe you can't scavenge, but we can use any warm bodies that can lift a tool.  You'd be safer and better fed there."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_RECRUIT1",
            when = predicates.handler("dlg_p_dda_ee51db677ef6"),
        },
        {
            text = ccb.content.text("I might have some food for you.  Let me check."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
        },
        {
            text = ccb.content.text("I'm sorry, I can't help you."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_EXPERTISE",
    line = ccb.content.text("I was a high school math teacher.  It was a good job, I loved it.  Funny enough, it's not super applicable after the end of the world.  I mean, at some point people are going to need a teacher again, but right now they just want food, shelter, and clothing."),
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_LEAVE",
        },
        {
            text = ccb.content.text("Why don't you scavenge your own food?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_SCAVENGE",
        },
        {
            text = ccb.content.text("Come with me.  Maybe you're not the greatest adventurer, but it's better than living here."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_JOIN",
            when = predicates.handler("dlg_p_dda_19ac42f5fa83"),
        },
        {
            text = ccb.content.text("I have a camp of my own, away from here.  Maybe they can't use your skills here, but I could."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_RECRUIT1",
            when = predicates.handler("dlg_p_dda_ee51db677ef6"),
        },
        {
            text = ccb.content.text("I might have some food for you.  Let me check."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
        },
        {
            text = ccb.content.text("I'm sorry, I can't help you."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_GAVE_FOOD",
    line = ccb.content.text("This is wonderful of you, I really appreciate it."),
    on_enter = {
        { actions = { "u_bulk_donate" } },
        { actions = { actions.handler("w16b_a_dda_ee5ac56a72a9") } },
    },
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_INTRO",
        },
        {
            text = ccb.content.text("No problem.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
