local ccb = require("ccb")

-- Former prisoner with a melee or ranged weapon and prison clothing. Sometimes they also have prison guards' gear.
ccb.content.define_npc {
    id = "prisoner_generic",
    suffix = ccb.content.text("prisoner"),
    class = "NC_THUG_PRISONER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_PRISONER_GENERIC",
    faction = "prisoners",
}

-- Former prisoner with a melee or ranged weapon and prison clothing. Sometimes they also have prison guards' gear.
ccb.content.define_npc {
    id = "prisoner_greeter",
    suffix = ccb.content.text("gatekeeper"),
    class = "NC_THUG_PRISONER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_PRISONER_GREET",
    faction = "prisoners",
}

-- Former prisoner with a melee or ranged weapon and prison clothing. Sometimes they also have prison guards' gear.
ccb.content.define_npc {
    id = "prisoner_leader",
    suffix = ccb.content.text("leader of prisoners"),
    class = "NC_THUG_PRISONER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_PRISONER_LEADER_GREET",
    faction = "prisoners",
    missions_offered = "MISSION_PRISONER_LEADER_GET_ID_CARD",
}

ccb.content.define_npc_class {
    id = "NC_THUG_PRISONER",
    name = ccb.content.text("Prisoner"),
    job_description = ccb.content.text("I'm here to kick ass."),
    common = false,
    traits = {
        { group = "BG_survival_story_CRIMINAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
    },
    strength = { rng = { 2, 4 } },
    dexterity = { rng = { 0, 2 } },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -4 } } } },
        { skill = "dodge", bonus = { rng = { 1, 3 } } },
        { skill = "melee", bonus = { rng = { 2, 4 } } },
        { skill = "unarmed", bonus = { rng = { 1, 3 } } },
        { skill = "bashing", bonus = { rng = { 1, 5 } } },
        { skill = "stabbing", bonus = { rng = { 1, 5 } } },
        { skill = "cutting", bonus = { rng = { 1, 5 } } },
    },
    worn = "NC_THUG_PRISONER_worn",
    weapon = "NC_THUG_PRISONER_wield",
}
