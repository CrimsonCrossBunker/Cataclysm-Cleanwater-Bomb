local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- A rural holdout survivor that gave up on life
ccb.content.define_npc {
    id = "RURAL_HOLDOUT_NIHILIST",
    class = "NC_COWBOY",
    attitude = 0,
    suffix = ccb.content.text("Survivor cowboy"),
    mission = "GUARD",
    chat = "TALK_COWBOYN_MAIN",
    faction = "no_faction",
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_MAIN",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyn" } }),
        yes = ccb.content.text("Yeah?"),
        no = ccb.content.text("Oh.  Hey there."),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_first_meeting_talked_to_cowboyn", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Thought I heard someone.  What are you doing here?"),
            next_topic = "TALK_COWBOYN_INTRODUCTION1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyn" } })),
        },
        {
            text = ccb.content.text("How did you get here?"),
            next_topic = "TALK_COWBOYN_BACKGROUND",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyn" } }), predicates.negate(predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmota" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmots" } }) })) }),
        },
        {
            text = ccb.content.text("Would you like to come with me?"),
            next_topic = "TALK_COWBOYN_FOLLOW",
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmota" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmots" } }) }),
        },
        {
            text = ccb.content.text("See you around."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyn" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_BACKGROUND",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmota" } }),
        yes = ccb.content.gendered_line("I already told you.  Don't want to go through it again.", { "interlocutor" }),
        no = ccb.content.gendered_line("Lived in a nearby town.  Normal life.  9 to 5 job.  When it all happened, we ran away to find some safety.  But there's no safety anymore, is there?", { "interlocutor" }),
    },
    replies = {
        {
            text = ccb.content.text("Wait, 'we'?"),
            next_topic = "TALK_COWBOYN_PARTNER",
            when = predicates.any({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cowboynmota" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cowboynmots" } })) }),
        },
        {
            text = ccb.content.text("Right.  Okay."),
            next_topic = "TALK_COWBOYN_MAIN",
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cowboynmota" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cowboynmots" } }) }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_PARTNER",
    line = ccb.content.gendered_line("I didn't leave the town alone.  I arrived here alone.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("I'm sorry for your loss.  But you still can't give up.  You have a lot to live for!"),
            next_topic = "TALK_COWBOYN_MOTIVATEF",
        },
        {
            text = ccb.content.text("We all lost someone.  No reason to sit down and die."),
            next_topic = "TALK_COWBOYN_MOTIVATEF",
        },
        {
            text = ccb.content.text("You can't let yourself be consumed by grief.  It will get better."),
            next_topic = "TALK_COWBOYN_MOTIVATEF",
        },
        {
            text = ccb.content.text("No one gets out alive.  Always been that way.  So we keep going."),
            next_topic = "TALK_COWBOYN_MOTIVATES",
        },
        {
            text = ccb.content.text("I'm sure your loved one would want you to live on for them."),
            next_topic = "TALK_COWBOYN_MOTIVATEF",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_MOTIVATES",
    line = ccb.content.text("I… I mean… huh.  I guess."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "dialogue_cowboyn_cowboynmots", "yes") } } },
    replies = {
        { text = ccb.content.text("Good.  Take care."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("That's a start."), next_topic = "TALK_COWBOYN_MAIN" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_MOTIVATEF",
    line = ccb.content.text("Just leave me alone."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "dialogue_cowboyn_cowboynmota", "yes") } } },
    replies = {
        { text = ccb.content.text("Alright.  Take care."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Fine."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_INTRODUCTION1",
    line = ccb.content.text("I dunno.  Waiting.  Seeing if something happens I guess."),
    replies = {
        {
            text = ccb.content.text("You do realize there is an apocalypse going on, right?"),
            next_topic = "TALK_COWBOYN_INTRODUCTION2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_INTRODUCTION2",
    line = ccb.content.text("Yeah.  I do."),
    replies = {
        {
            text = ccb.content.text("So shouldn't you be more concerned?  Trying to survive?"),
            next_topic = "TALK_COWBOYN_NIHILIST",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_NIHILIST",
    line = ccb.content.text("For how long?  You've seen what's out there.  If we survive today, we'll die the day after.  Or the day after that.  And if we live beyond that, we'll just see everyone we care about die.  All of them.  Might as well get it over with."),
    replies = {
        { text = ccb.content.text("What happened to you?"), next_topic = "TALK_COWBOYN_BACKGROUND" },
        {
            text = ccb.content.text("So you're just going to give up?"),
            next_topic = "TALK_COWBOYN_NIHILIST2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_NIHILIST2",
    line = ccb.content.text("Yeah.  I think I will."),
    replies = {
        { text = ccb.content.text("What happened to you?"), next_topic = "TALK_COWBOYN_BACKGROUND" },
        { text = ccb.content.text("Fair enough."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_FOLLOW",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmots" } }),
        yes = ccb.content.text("I dunno.  Maybe.  Might give me something to do while I think about all this."),
        no = ccb.content.gendered_line("I told you to just leave me alone.", { "interlocutor" }),
    },
    replies = {
        {
            text = ccb.content.text("It will.  <lets_go>"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmots" } }),
            native_actions = { "follow" },
        },
        {
            text = ccb.content.text("On a second thought, wait here a while."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmots" } }),
        },
        {
            text = ccb.content.text("Alright.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmots" } })),
        },
    },
}
