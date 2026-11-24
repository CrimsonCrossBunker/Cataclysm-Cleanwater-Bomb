local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- All dialogue about this mission is handled through talk_topics, so we don't use any of these strings.
ccb.content.define_mission {
    id = "BEM_jabberwock_mission",
    name = ccb.content.text("\"God\"-Slayer"),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 5,
    value = 200000,
    urgent = true,
    description = ccb.content.text("A traumatized mercenary has claimed to have seen what you assume to be a powerful monster.  Maybe you should investigate this for the benefit of everyone."),
    start = {
        target = {
            terrain = "forest_thick",
            replace_terrain = "forest",
            reveal_radius = 1,
            random = true,
            search_range = 60,
            min_distance = 15,
            z = 0,
        },
        map_updates = {
            { layout = { monster_placements = { { id = "mon_jabberwock", x = 11, y = 11, target = true } } } },
        },
    },
    finish = { handler = "mark_dialogue_bem_completed_bem_jabberwock" },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_JABBERWOCK_1",
    line = {
        when = predicates.has_mission("BEM_jabberwock_mission"),
        yes = ccb.content.text("&You see one more traumatized face, all too many and too frequent for any help to be worthwhile."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_bem_completed_bem_jabberwock" } }),
            yes = ccb.content.text("&You see one more traumatized face, all too many and too frequent for any help to be worthwhile."),
            no = ccb.content.gendered_line("&The mercenary stares intently at a stain in the ceiling, firmly clutching a now cold cup of soup.  No one else seems to be very concerned about this.", { "interlocutor" }),
        },
    },
    replies = {
        {
            text = ccb.content.text("Attempt a friendly approach."),
            next_topic = "BEM_JABBERWOCK_2",
            when = predicates.negate(predicates.any({ predicates.has_mission("BEM_jabberwock_mission"), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_bem_completed_bem_jabberwock" } }) })),
        },
        { text = ccb.content.text("Leave the traveler to their trauma."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_JABBERWOCK_2",
    line = ccb.content.text("&<mypronoun> seems completely lost to the present, but you can't help but notice <mypossesivepronoun> gear is caked with mud and broken twigs.  It doesn't look like you'll be getting much conversation from this one."),
    replies = {
        {
            text = ccb.content.text("Press on in search of a reaction."),
            next_topic = "BEM_JABBERWOCK_3",
        },
        {
            text = ccb.content.text("Try to find someone more interested in conversation."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_JABBERWOCK_3",
    line = ccb.content.gendered_line("&Continued prodding manages to extract a baffling response from your interlocutor \"I- I've seen it, the god of our new world, a god of flesh and bone.\" <mypronoun> says with a maddened glare, as though this were some sort of shocking revelation.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Show your map to the mercenary, and have them mark where they saw this \"god\"."),
            next_topic = "BEM_JABBERWOCK_4",
        },
        {
            text = ccb.content.text("Yeah I'm sure I have seen that one too.  Try to stay safe."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_JABBERWOCK_4",
    line = ccb.content.text("&<mypronoun> silently points at your maps with a trembling hand."),
    on_enter = { { actions = { actions.assign_mission("BEM_jabberwock_mission") } } },
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_DONE",
            actions = { "end_conversation" },
        },
    },
}
