local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe",
    line = {
        when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        yes = ccb.content.text("What are you doing here, go away!  I don't want to talk to you…"),
        no = {
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
            yes = {
                choices = {
                    ccb.content.text("Aw hey, it's you again, <u_name>.  How have you been?"),
                    ccb.content.text("Aw hey, it's you again, <name_g>.  How have you been?"),
                },
            },
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_chloe" } }),
                yes = {
                    choices = {
                        ccb.content.text("Hey <u_name>, what's up?"),
                        ccb.content.text("Hey <name_g>, what's up?"),
                    },
                },
                no = ccb.content.text("Oh… hi.  I don't know you.  My name's Chloe."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Chloe.  What's up?"),
            next_topic = "TALK_GODCO_chloe_2",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_chloe" } })),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_chloe", "yes") },
        },
        {
            text = ccb.content.text("Hi.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_8213427bad25"),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_chloe", "yes") },
        },
        {
            text = ccb.content.text("Do you wanna shoot the breeze?"),
            next_topic = "TALK_GODCO_chloe_idle_chat",
            when = predicates.handler("dlg_p_dda_948fd1983114"),
        },
        {
            text = ccb.content.text("Do you need any help?"),
            next_topic = "TALK_GODCO_chloe_help",
            when = predicates.handler("dlg_p_dda_948fd1983114"),
        },
        {
            text = ccb.content.text("Do you wanna shoot the breeze?"),
            next_topic = "TALK_GODCO_chloe_angry",
            when = predicates.handler("dlg_p_dda_65e116ddf480"),
        },
        {
            text = ccb.content.text("Do you need any help?"),
            next_topic = "TALK_GODCO_chloe_angry",
            when = predicates.handler("dlg_p_dda_65e116ddf480"),
        },
        {
            text = ccb.content.text("Just saying hello.  Keep safe."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_948fd1983114"),
        },
        {
            text = ccb.content.text("Okay <name_b>, I'll leave."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_65e116ddf480"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_idle_chat",
    line = ccb.content.text("Shoot."),
    replies = {
        {
            text = ccb.content.text("Really, what's your story?"),
            when = predicates.handler("dlg_p_dda_bcd6b4e1bd5b"),
            trial = { kind = "persuade", difficulty = 30 },
            success = { next_topic = "TALK_GODCO_chloe_past_2" },
            failure = { next_topic = "TALK_GODCO_chloe_nochat" },
        },
        {
            text = ccb.content.text("How'd you and Sonia come to meet?"),
            next_topic = "TALK_GODCO_chloe_sonia",
            when = predicates.handler("dlg_p_dda_737f2e47701d"),
        },
        {
            text = ccb.content.text("How'd you and Sonia come to meet again?"),
            next_topic = "TALK_GODCO_chloe_sonia",
            when = predicates.handler("dlg_p_dda_386abab4facf"),
        },
        {
            text = ccb.content.text("Aren't you a bit young to be carrying a knife?"),
            next_topic = "TALK_GODCO_chloe_knife",
        },
        {
            text = ccb.content.text("On second though, let's talk about something else."),
            next_topic = "TALK_GODCO_chloe",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_2",
    line = ccb.content.text("Things suck right now, but you know that anyway.  I don't even know why you bother asking these stupid questions."),
    replies = {
        { text = ccb.content.text("What's your story?"), next_topic = "TALK_GODCO_chloe_past" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_help",
    line = ccb.content.text("I'm not a baby you know, I don't need a babysitter.  Sonia looks out for me though.  She's not so weird, I guess.  She promised to give me guitar lessons and she even signed me an autograph.  I know she's only nice to me because I saved her, but that's okay; we're equal now."),
    replies = {
        {
            text = ccb.content.text("How'd you and Sonia come to meet?"),
            next_topic = "TALK_GODCO_chloe_sonia",
        },
        { text = ccb.content.text("Yeah, that's enough for me."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_past",
    line = ccb.content.gendered_line("You're creepy.  I'm sorry for your lack of friends but, like, I'm literally a kid.  Everyone on Earth turned into a zombie, we're running out of toilet paper and everything, and my parents are gone.  I know they're still alive and they're looking for me.  I miss them.  Is that enough personal stuff for you?", { "speaker" }),
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "told_backstory_second_attempt", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm sorry for your loss.  <done_conversation_section>"),
            next_topic = "TALK_GODCO_chloe",
        },
        { text = ccb.content.text("Yeah, that's enough for me."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_past_2",
    line = ccb.content.text("Well, I grew up in the city.  My parents were always out of town on some business meeting or another, so I had plenty of time to myself.  They're great people; mom's a wonderful cook, she makes an amazing fish casserole.  Dad's a hot shot for military contracts, he handled business deals for DARPA and whatnot.  He's an ex-marine, and taught me how to defend myself with a knife."),
    replies = {
        {
            text = ccb.content.text("Where do you think your parents are now?"),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_told_backstory", "yes") },
            next_topic = "TALK_GODCO_chloe_parents_where",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_sonia",
    line = ccb.content.text("I was home alone during the ongoing riots.  My parents chose the worst possible time to reconnect, which sucks, but I'm also kinda happy for them.  Anyway, they were part of the NECC people, so they knew about this place and their plans and all.  Thing is, it was, like, really far away.  I kinda didn't want to go alone but I also didn't want the rioters to eat me, so I asked Sonia - my neighbor - to evacuate with me, I guess.  So that was fun; escaping my hometown, walking down the country road, waiting for a horror to ambush us.  Spoiler alert: we were attacked.  So this zombie shambles in front of us and Sonia whacks it real hard with her guitar!  Its brain splatters all over the pavement, I threw up 'cause it was so disgusting.  We got here soon after that.  My parents weren't here, obviously.  Oh man, they must worry about me so much…"),
    replies = {
        {
            text = ccb.content.text("Aren't you a bit young to be carrying a knife?"),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_told_about_sonia", "yes") },
            next_topic = "TALK_GODCO_chloe_knife",
        },
        {
            text = ccb.content.text("Thanks for the info.  Let's chat about something else."),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_told_about_sonia", "yes") },
            next_topic = "TALK_GODCO_chloe_idle_chat",
        },
        {
            text = ccb.content.text("Thanks for the info."),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_told_about_sonia", "yes") },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_parents_where",
    line = ccb.content.text("I don't know.  They were going to a contract deal before the riots broke out, at one of military bases I think.  I don't know what happened to them from there."),
    replies = {
        {
            text = ccb.content.text("I'll let you know if anything turns up."),
            next_topic = "TALK_GODCO_chloe_idle_chat",
        },
        {
            text = ccb.content.text("I'll let you know if anything turns up.  See you around."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_knife",
    line = ccb.content.text("Aren't you a bit too old not to realize how dangerous the world is for a kid like me?  I know how to handle one without hurting myself!  My dad taught me everything, he's a real pro."),
    replies = { { text = ccb.content.text("That makes sense."), next_topic = "TALK_GODCO_chloe_idle_chat" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_loss",
    line = ccb.content.text("They're not dead."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_nochat",
    line = ccb.content.text("I don't wanna talk about it right now."),
    replies = {
        {
            text = ccb.content.text("Alright, let's change the subject."),
            next_topic = "TALK_GODCO_chloe_idle_chat",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_angry",
    line = ccb.content.text("I said to get lost, <name_b>!  I can't believe you really think everything's alright, after all the shit you've done."),
    replies = { { text = ccb.content.text("Alright <name_b>, I'll leave."), next_topic = "TALK_DONE" } },
}
