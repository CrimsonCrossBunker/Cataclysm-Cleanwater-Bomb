local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- A member of the Gray Moose Lodge, trying to safe in their isolated location
ccb.content.define_npc {
    id = "MILITIA_GUARD1",
    class = "MILITIA_GUARD1",
    attitude = 0,
    suffix = ccb.content.text("Militia Guard"),
    mission = "GUARD_PATROL",
    chat = "TALK_MILITIA_Guard1",
    faction = "GM_militia_faction",
}

ccb.content.define_npc_class {
    id = "MILITIA_GUARD1",
    name = ccb.content.text("Guard"),
    job_description = ccb.content.text("I'm a local guard."),
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "mechanics", bonus = { one_in = 2 } },
        { skill = "electronics", bonus = { rng = { 0, 2 } } },
        { skill = "speech", bonus = { rng = { 3, 5 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_Guard1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_LODGEMAIN" } }),
        yes = ccb.content.text("Hello again."),
        no = ccb.content.text("I'm busy on watch duty.  Talk to the Boss upstairs."),
    },
    replies = {
        {
            text = ccb.content.text("What are you doing?"),
            next_topic = "TALK_MILITIA_GUARD1_Introduction",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_MILITIA_GUARD1_BYE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_GUARD1_Introduction",
    line = ccb.content.text("I'm on watch duty.  Talk to the Boss.  He's upstairs."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_GUARD1_BYE",
    line = ccb.content.text("Stay safe out there.  Hate to have to kill you after you've already died."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
