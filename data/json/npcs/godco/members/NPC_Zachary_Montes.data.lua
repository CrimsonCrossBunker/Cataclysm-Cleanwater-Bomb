local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Zachary_Intro_2", "TALK_GODCO_Zachary_Story0", "TALK_GODCO_Zachary_Feeling", "TALK_GODCO_Zachary_Result_rewardIcon", "TALK_GODCO_Zachary_Result_rewardRation", "TALK_GODCO_Zachary_Godco", "TALK_GODCO_Zachary_Intro", "TALK_GODCO_Zachary_Background" },
    replies = {
        {
            text = ccb.content.text("How did you get here?"),
            next_topic = "TALK_GODCO_Zachary_Story0",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Why don't you blow this joint and come with me?"),
            next_topic = "TALK_GODCO_Zachary_Follow",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things around here?"),
            next_topic = "TALK_GODCO_Zachary_Feeling",
        },
        {
            text = ccb.content.text("Is everyone treating you fairly?"),
            next_topic = "TALK_GODCO_Zachary_Godco",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary",
    line = {
        when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        yes = ccb.content.text("You're back?  Shove off <name_b>!"),
        no = ccb.content.gendered_line("I got my rights to be here, chum.  Squatter's rights!", { "speaker" }),
    },
    replies = {
        {
            text = ccb.content.text("Don't worry, I'm not going to hurt you."),
            next_topic = "TALK_GODCO_Zachary_Intro",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_zachary" } })),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_zachary", "yes") },
        },
        {
            text = ccb.content.text("Hey, good to see you're still around."),
            next_topic = "TALK_GODCO_Zachary_Intro_2",
            when = predicates.handler("dlg_p_dda_e044ff8b2e0f"),
        },
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Intro",
    line = ccb.content.text("I got here first, therefore this place belongs to me.  Them's the rules in the <the_cataclysm>."),
    replies = {
        {
            text = ccb.content.text("Now that's an archaic belief.  I'll see you around."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Intro_2",
    line = {
        when = predicates.has_mission("MISSION_GODCO_ZACHARY_KILL_NIGHTMARE"),
        yes = ccb.content.text("I ain't leaving, <name_g>.  Not until you or someone else has checked out that nightmare for me."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_meeting_zachary_willing_to_follow" } }),
            yes = ccb.content.text("Thanks, <name_g>.  I sure owe you one."),
            no = ccb.content.text("I ain't leaving, <name_g>.  Not until that eldritch screeching nightmare is dead 'n buried."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What nightmare?"),
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_GODCO_ZACHARY_KILL_NIGHTMARE")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_meeting_zachary_willing_to_follow" } })) }),
            next_topic = "TALK_GODCO_Zachary_Nightmare",
        },
        { text = ccb.content.text("I'll see you around then."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Story0",
    line = ccb.content.gendered_line("That ain't the point here, chum.  Don'tcha get it?  This was MY territory, but they took it away from me.  Now they think of us as nothin' but a <freaking> nuisance.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_GODCO_Zachary_Background",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Background",
    line = ccb.content.text("Who I was is gone, dead… died when I put down the monsters wearing the face of my friends.  Ever since then, I've felt nothing but disgust for myself.  Let's not fuckin' reminisce."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Godco",
    line = ccb.content.text("They are nice people, lettin' us stay here 'n all.  I got friends here, and while we may not be members we belong here.  We'll fight together if they ever try to kick us out."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Feeling",
    line = ccb.content.text("It ain't so bad.  I got shelter, heat, and people to defend me if any <zombie> shuffles its way in here.  If I want to eat then I'll be doin' construction work all day."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Result_rewardRation",
    line = ccb.content.text("Food is just the thing a starving man needs.  Thanks for the help, <name_g>."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Result_rewardIcon",
    line = ccb.content.gendered_line("Ha ha ha!  Think before you speak, chum.  Eight icons for an honest day's work, I say the system's broken!", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Sorry to hear that.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("No rest for the weary…"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Nightmare",
    line = ccb.content.gendered_line("Ain't you heard it?  It's been screeching out in the forest during the night for a while now, keeps me up sometimes.  I'm too scared to go out and see what that thing is.  If you'd kill it, I'd be in your debt forever.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("I'll see what I can do."),
            next_topic = "TALK_NONE",
            actions = { actions.offer_mission("MISSION_GODCO_ZACHARY_KILL_NIGHTMARE") },
        },
        {
            text = ccb.content.text("I'm sorry to hear that <name_g>, but I don't feel like facing it either."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Follow",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_meeting_zachary_willing_to_follow" } }),
        yes = ccb.content.gendered_line("After what you did for me, I'll follow you to the ends of the Earth!  No one around here's stood up for me like that, I owe ya one.", { "speaker" }),
        no = ccb.content.text("No chance!  Its not you, its the world out there I'm worried about.  All those <freaking> monsters really give me the creeps, and as far as I know this church is the last bastion of humanity in the <the_cataclysm>."),
    },
    replies = {
        {
            text = ccb.content.text("That's understandable."),
            next_topic = "TALK_GODCO_Zachary_Intro_2",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_meeting_zachary_willing_to_follow" } })),
        },
        {
            text = ccb.content.text("<lets_go>"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_meeting_zachary_willing_to_follow" } }),
            actions = { "follow", actions.handler("dlg_a_dda_22a5bb9a10f5") },
        },
    },
}
