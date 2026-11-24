local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "HUB01_ADzvonko",
    unique_name = ccb.content.text("Andrea Dzvonko"),
    gender = "female",
    suffix = ccb.content.text("software engineer"),
    class = "NC_HUB01_ADzvonko",
    attitude = 0,
    mission = "GUARD",
    chat = "HUB01_ADzvonko_Intro",
    faction = "robofac",
}

-- Andrea Dzvonko is a software engineer with a limited understanding of how melchior actually functions.
ccb.content.define_npc_class {
    id = "NC_HUB01_ADzvonko",
    name = ccb.content.text("Hub 01 Software Engineer"),
    job_description = ccb.content.text("I work for Hub 01 as a software engineer."),
    common = false,
    strength = { rng = { -2, 2 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { 0, 4 } },
    perception = { rng = { -2, 2 } },
    worn = "HUB01_ADzvonko_worn",
    carry = "HUB01_ADzvonko_carried",
    weapon = "HUB01_ADzvonko_wield",
    traits = { { trait = "FASTLEARNER" }, { group = "Appearance_Caucasian" } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "computer", bonus = { rng = { 4, 6 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "HUB01_ADzvonko_Intro",
    line = {
        when = predicates.has_trait("speaker", "PROF_HUB01_ANCILLIARY"),
        yes = ccb.content.text("Woah, you must be that new person they told us about.  I can't really believe you're here.  I'm Andrea.  Dr. Dzvonko in the old days, but that seems silly now."),
        no = ccb.content.text("Who the fuck are you?  How did you get down here?  Security!"),
    },
    replies = {
        {
            text = ccb.content.text("Hold on, hold on.  I'm not here to hurt anyone, and there aren't enough of us left to just start fighting."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_trait("speaker", "PROF_HUB01_ANCILLIARY")),
            actions = { "flee" },
        },
        {
            text = ccb.content.text("Nice to meet you too."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_ADzvonko", "yes") },
            when = predicates.has_trait("speaker", "PROF_HUB01_ANCILLIARY"),
        },
    },
}
