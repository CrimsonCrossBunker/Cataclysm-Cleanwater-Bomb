local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.text("Could you be on your way, please?  We don't take kindly to sinners like you."),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("Could you be on your way, please?  I'm rather busy."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_chef" } }),
                yes = {
                    choices = {
                        ccb.content.text("Welcome back."),
                        ccb.content.text("Hello again.  What do you need?"),
                        ccb.content.text("*waves you over.  \"Hey <u_name>.  How's it going for you?\""),
                    },
                },
                no = ccb.content.gendered_line("Hello stranger, I don't think we've met before.  Its nice to meet you, name's Simon.", { "speaker" }),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Who are you?  Where am I right now?"),
            next_topic = "TALK_GODCO_chef_intro",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_chef" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_chef", "yes") },
        },
        {
            text = ccb.content.text("Just passing through, don't mind me."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_chef" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_chef", "yes") },
        },
        {
            text = ccb.content.text("I wanted to talk."),
            next_topic = "TALK_GODCO_chef_idle_chat",
            when = predicates.handler("dlg_p_dda_9aeef99033a0"),
        },
        {
            text = ccb.content.text("Could I have some food?"),
            next_topic = "TALK_GODCO_chef_get_food",
            when = predicates.handler("dlg_p_dda_b9e1e88d4a2b"),
        },
        {
            text = ccb.content.text("I heard the joinees could get some food here."),
            next_topic = "TALK_GODCO_chef_get_food_joinee",
            when = predicates.handler("dlg_p_dda_0a0c74d1dca5"),
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.handler("dlg_p_dda_4cb2c3f2db3c"),
        },
        {
            text = ccb.content.text("Just saying hello.  Keep safe."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_chef" } }),
        },
        {
            text = ccb.content.text("Okay, man.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_idle_chat",
    line = {
        choices = {
            ccb.content.text("Okay, shoot."),
            ccb.content.text("Sure, what's up?"),
            ccb.content.text("Alright, let's chat."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_chef_past",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are you holding up?"),
            next_topic = "TALK_GODCO_chef_mood",
        },
        {
            text = ccb.content.text("Is there any way I could join the community?"),
            next_topic = "TALK_GODCO_chef_join",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Could you tell me about Katherine?"),
            next_topic = "TALK_GODCO_chef_katherine",
            when = predicates.handler("dlg_p_dda_1e018699ec48"),
        },
        {
            text = ccb.content.text("Could you tell me about Jeremiah?"),
            next_topic = "TALK_GODCO_chef_jeremiah",
            when = predicates.handler("dlg_p_dda_1e018699ec48"),
        },
        {
            text = ccb.content.text("I've changed my mind, forget about it."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See ya, <name_g>."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_intro",
    line = ccb.content.text("This is the New England Community Church, I should say it's one of their old retreats.  I'm Simon, the head chef around here."),
    replies = {
        { text = ccb.content.text("What's your story?"), next_topic = "TALK_GODCO_chef_past" },
        { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_past",
    line = ccb.content.text("I used to volunteer as a cook in a homeless shelter.  I met the church through that job; their missionaries would come by every so often and hand out essentials to people living there, then give a sermon in one of the back rooms.  Katherine and I wound up going to one of their sermons, and we've stayed connected since.  Working in that shelter taught me to cook on a shoestring budget; that's really useful these days, ya know."),
    replies = {
        {
            text = ccb.content.text("Where's your family now?"),
            next_topic = "TALK_GODCO_chef_family",
        },
        { text = ccb.content.text("Thanks, <name_g>.  See you around."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_family",
    line = ccb.content.text("Katherine's probably in the bunks right now, and Jeremiah's next door.  Feel free to say hello sometime."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "general_meeting_u_know_about_family", "yes"),
            },
        },
    },
    replies = {
        { text = ccb.content.text("Who's Katherine?"), next_topic = "TALK_GODCO_chef_katherine" },
        { text = ccb.content.text("Who's Jeremiah?"), next_topic = "TALK_GODCO_chef_jeremiah" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_chef",
        },
        { text = ccb.content.text("I'll do that."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_get_food",
    line = ccb.content.text("It's been a while since anyone gave out meals.  We're low on supplies around here, I can't spare any.  I'm sorry."),
    replies = {
        {
            text = ccb.content.text("Would you accept any money for it?"),
            next_topic = "TALK_GODCO_chef_get_food_bribe",
        },
        {
            text = ccb.content.text("Please?  I need it for my family."),
            next_topic = "TALK_GODCO_chef_get_food_family",
        },
        { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_get_food_joinee",
    line = ccb.content.text("They can, but we're limited on the portions for now.  Hope you enjoy it, and come back tomorrow for another."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_d450420170b3"), actions.add_effect("interlocutor", "u_got_meal", { turns = 43200 }) } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_get_food_bribe",
    line = ccb.content.text("No, I wouldn't.  Like I said, we don't have any to spare."),
    replies = {
        {
            text = ccb.content.text("Is there any way I could join the community?"),
            next_topic = "TALK_GODCO_chef_join",
        },
        { text = ccb.content.text("It was worth a shot, I guess."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_katherine",
    line = ccb.content.text("She's my wife, worked for the Church before <the_cataclysm>.  She used to organize charities for the needy, now we're the ones in need of charity.  She has a bit of a high horse these days, but a nice lady once you get to know her.  We've been married for 28 years, and I couldn't ask for a better wife."),
    replies = {
        { text = ccb.content.text("Who's Jeremiah?"), next_topic = "TALK_GODCO_chef_jeremiah" },
        {
            text = ccb.content.text("That's good to hear.  <done_conversation_section>"),
            next_topic = "TALK_GODCO_chef_idle_chat",
        },
        {
            text = ccb.content.text("That's good to hear, but I gotta go."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_jeremiah",
    line = ccb.content.text("Jeremiah is my son, he's a sweet boy and all grown up now.  We taught him everything he knows, and we all had high hopes for how he could make it in the world, before <the_cataclysm> took it away.  He doesn't like his mother, Katherine, very much, and I've tried to help the two, but they can't seem to properly get along."),
    replies = {
        { text = ccb.content.text("Who's Katherine?"), next_topic = "TALK_GODCO_chef_katherine" },
        {
            text = ccb.content.text("Why would they have an issue with each other?"),
            next_topic = "TALK_GODCO_chef_k&j_conflict",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_chef_idle_chat",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_k&j_conflict",
    line = ccb.content.text("Katherine is a bit overprotective of him, and ever since <the_cataclysm>, she's become extremely worried for his safety.  He wants more independence, seein' as how he's grown now, but she won't leave him be.  She tells me that someone needs to keep an eye on him, so she took it upon herself to do so.  I think she has the best intentions at heart, I know she loves him dearly, but the boy needs to figure out some things on his own."),
    replies = {
        {
            text = ccb.content.text("Could you tell me more about Katherine?"),
            next_topic = "TALK_GODCO_chef_katherine",
        },
        {
            text = ccb.content.text("Could you tell me more about Jeremiah?"),
            next_topic = "TALK_GODCO_chef_jeremiah",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_chef_idle_chat",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_get_food_family",
    line = ccb.content.text("Look, I have a family too.  I know how hard it is for you, but I've already told you, rules are rules."),
    replies = { { text = ccb.content.text("I guess I'll starve."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_mood",
    line = ccb.content.text("Could be better, could be worse, but I'm not complaining.  I have everything I need here; my family, a nice job, and roof over my head.  I only wish God was as forgiving to others as to me."),
    replies = { { text = ccb.content.text("Good to hear that."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_join",
    line = ccb.content.text("You'd have to talk to Gemma or Julian about that.  I'm sure there's a way, though."),
    replies = { { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" } },
}
