local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Former miner, poor fellow succumbed to spiral madness.
ccb.content.define_npc {
    id = "spiral_madman",
    suffix = ccb.content.text("miner"),
    class = "NC_SPIRAL_MADMAN",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_SPIRAL_MADMAN_FIRST_MEETING",
    faction = "no_faction",
}

ccb.content.define_npc_class {
    id = "NC_SPIRAL_MADMAN",
    name = ccb.content.text("Miner"),
    job_description = ccb.content.text("Spirals."),
    common = false,
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    strength = { rng = { 2, 4 } },
    dexterity = { rng = { 0, 2 } },
    worn = "NC_SPIRAL_MADMAN_worn",
    weapon = "NC_SPIRAL_MADMAN_wield",
}

ccb.content.define_dialogue_topic {
    id = "TALK_SPIRAL_MADMAN_FIRST_MEETING",
    line = ccb.content.text("Spirals?"),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_first_meeting_first_meeting", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Hello there!"),
            next_topic = "TALK_SPIRAL_MADMAN_GENERIC",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_first_meeting" } })),
        },
        {
            text = ccb.content.text("I'm outta here.  Bye."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_first_meeting" } })),
        },
        {
            text = ccb.content.text("Poor fellow - looks like you're out of your mind.  Can't help you, sorry.  I'm outta here.  Bye."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_first_meeting" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SPIRAL_MADMAN_GENERIC",
    line = ccb.content.text_without_extraction("<spirals>"),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_SPIRAL_MADMAN_SPIRALS",
        },
        { text = ccb.content.text("Sorry, what?"), next_topic = "TALK_SPIRAL_MADMAN_SPIRALS" },
        { text = ccb.content.text("I'm outta here.  Bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SPIRAL_MADMAN_SPIRALS",
    line = ccb.content.text_without_extraction("<spirals>"),
    replies = {
        {
            text = ccb.content.text("Why are you repeating 'spirals' over and over again?"),
            next_topic = "TALK_SPIRAL_MADMAN_R_U_NUTS",
        },
        { text = ccb.content.text("Sorry, what?"), next_topic = "TALK_SPIRAL_MADMAN_R_U_NUTS" },
        { text = ccb.content.text("I'm outta here.  Bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SPIRAL_MADMAN_R_U_NUTS",
    line = ccb.content.text_without_extraction("<spirals>"),
    replies = {
        {
            text = ccb.content.text("Are you nuts?"),
            next_topic = "TALK_SPIRAL_MADMAN_THIS_IS_MADNESS",
        },
        {
            text = ccb.content.text("Sorry, what?"),
            next_topic = "TALK_SPIRAL_MADMAN_THIS_IS_MADNESS",
        },
        { text = ccb.content.text("I'm outta here.  Bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SPIRAL_MADMAN_THIS_IS_MADNESS",
    line = ccb.content.text_without_extraction("<spirals>"),
    replies = {
        {
            text = ccb.content.text("Poor fellow - looks like you're out of your mind.  Can't help you, sorry.  I'm outta here.  Bye."),
            next_topic = "TALK_DONE",
        },
    },
}
