local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_MYCUS3",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_recruit_luo_attempt_recruit" } }),
        yes = ccb.content.text("If you get me a sample, I'll join your crazy camp expedition.  Hell, if you bring me a sample maybe I'll help you set up a lab to study this stuff.  Almost anything could work, but if this stuff is as dangerous as you make it sound, maybe make sure it's not a sporulating body."),
        no = ccb.content.text("I dunno, scientific interest?  If you don't bring me anything, no worries.  I'm positively swimming in entertainment here, as you can see."),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "general_mission_luo_mycus_mission", "yes") },
        },
    },
    replies = {
        {
            when = predicates.all({ predicates.has_item("speaker", "veggy_tainted"), predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_recruit_luo_attempt_recruit" } }) }),
            text = ccb.content.text("It just so happens I have a chunk of fungal matter on me right now."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS4_RECRUIT",
        },
        {
            when = predicates.all({ predicates.has_item("speaker", "veggy_tainted"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_recruit_luo_attempt_recruit" } })) }),
            text = ccb.content.text("It just so happens I have a chunk of fungal matter on me right now."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS4_NOTREADY",
            actions = { actions.set_actor_value("interlocutor", "general_recruit_luo_owed", "yes") },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Sure, I'd better get going.  I'll see if I can find you something."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_MYCUS4_RECRUIT",
    line = ccb.content.text("Well.  Well, well, well.  This is really interesting.  Look, you can see reticulations here, it looks sort of like an enlarged piece of a stipe from a basidiocarp… but look at this, these fibers are clearly unlike anything I've seen before.  I wonder if they're motile?\n\nOkay, listen: you've got yourself a deal.  I'll come to your base, but you've gotta get me hooked up with a microscope as soon as you can.  This could be the beginning of something really cool.  Oh, and it should go without saying that I'm not coming unless you can find a place for my friends here in your base.  I'm sure you anticipated that.  Talk them into going and I'm in.  It should be easy, they're a bunch of sweet hearted saps."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "general_recruit_luo_recruited", "yes") } } },
    replies = {
        {
            text = ccb.content.text("Great!  I'll go see what I can do about that."),
            next_topic = "TALK_DONE",
        },
    },
}
