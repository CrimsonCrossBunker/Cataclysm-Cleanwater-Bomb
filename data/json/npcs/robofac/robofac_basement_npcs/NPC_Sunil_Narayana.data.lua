local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "HUB01_SNarayana",
    unique_name = ccb.content.text("Sunil Narayana"),
    gender = "male",
    suffix = ccb.content.text("server maintenance"),
    class = "NC_HUB01_SNarayana",
    attitude = 0,
    mission = "GUARD",
    chat = "HUB01_SNarayana_Intro",
    faction = "robofac",
}

-- HVAC maintenance.  Resident dungeon master.
ccb.content.define_npc_class {
    id = "NC_HUB01_SNarayana",
    name = ccb.content.text("Hub 01 Server Maintenance"),
    job_description = ccb.content.text("I'm part of Hub 01's maintenance crew."),
    common = false,
    strength = { rng = { -2, 2 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { 0, 2 } },
    perception = { rng = { -1, 1 } },
    worn = "HUB01_SNarayana_worn",
    carry = "HUB01_SNarayana_carried",
    weapon = "HUB01_SNarayana_wield",
    traits = { { trait = "PROF_DICEMASTER" }, { group = "Appearance_demographics" } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "speech", bonus = { rng = { 0, 1 } } },
        { skill = "electronics", bonus = { rng = { 4, 5 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "HUB01_SNarayana_Intro",
    line = {
        when = predicates.has_trait("speaker", "PROF_HUB01_ANCILLIARY"),
        yes = ccb.content.text("Oooh, the NEW person.  So, you're not just some rumor they cooked up as a team building exercise.  I'm Sunil, welcome to the underground."),
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
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_SNarayana", "yes") },
            when = predicates.has_trait("speaker", "PROF_HUB01_ANCILLIARY"),
        },
    },
}
