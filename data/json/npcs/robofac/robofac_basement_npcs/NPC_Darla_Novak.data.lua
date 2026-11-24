local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "HUB01_DNovak",
    unique_name = ccb.content.text("Darla Novak"),
    gender = "female",
    suffix = ccb.content.text("building maintenance"),
    class = "NC_HUB01_DNovak",
    attitude = 0,
    mission = "GUARD",
    chat = "HUB01_DNovak_Intro",
    faction = "robofac",
}

-- HVAC maintenance.  Keeps melchior from boiling to death and you from choking on stale bunker air.
ccb.content.define_npc_class {
    id = "NC_HUB01_DNovak",
    name = ccb.content.text("Hub 01 HVAC maintenance"),
    job_description = ccb.content.text("I'm part of Hub 01's maintenance crew."),
    common = false,
    strength = { rng = { -1, 2 } },
    dexterity = { rng = { -1, 2 } },
    intelligence = { rng = { -2, 2 } },
    perception = { rng = { -1, 2 } },
    worn = "HUB01_DNovak_worn",
    carry = "HUB01_DNovak_carried",
    weapon = "HUB01_DNovak_wield",
    traits = { { group = "Appearance_demographics" } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "fabrication", bonus = { rng = { 0, 3 } } },
        { skill = "mechanics", bonus = { rng = { 4, 5 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "HUB01_DNovak_Intro",
    line = {
        when = predicates.has_trait("speaker", "PROF_HUB01_ANCILLIARY"),
        yes = ccb.content.text("Oh, hey.  The rumors were true, there really is someone new around.  Nice to meet you, call me Darla."),
        no = ccb.content.text("Who the fuck are you?  How did you get down here?  Security!"),
    },
    replies = {
        {
            text = ccb.content.text("Hold on, hold on.  I'm not here to hurt anyone, and there aren't enough of us left to just start fighting."),
            when = predicates.negate(predicates.has_trait("speaker", "PROF_HUB01_ANCILLIARY")),
            next_topic = "TALK_DONE",
            actions = { "flee" },
        },
        {
            text = ccb.content.text("Nice to meet you too."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_DNovak", "yes") },
            when = predicates.has_trait("speaker", "PROF_HUB01_ANCILLIARY"),
        },
    },
}
