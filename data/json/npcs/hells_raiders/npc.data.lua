local ccb = require("ccb")

-- Generic melee focused guard for the Hell's Raiders faction.
ccb.content.define_npc {
    id = "thug",
    suffix = ccb.content.text("Thug"),
    class = "NC_THUG",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_DONE",
    faction = "hells_raiders",
}

-- Generic pistol/rifle focused guard for the Hell's Raiders faction.
ccb.content.define_npc {
    id = "bandit",
    suffix = ccb.content.text("Bandit"),
    class = "NC_SCAVENGER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_DONE",
    faction = "hells_raiders",
}

-- EOC-specific, should not spawn outside of trigger events.
ccb.content.define_npc {
    id = "hells_raiders_assassin",
    suffix = ccb.content.text("assassin"),
    class = "NC_BOUNTY_HUNTER",
    attitude = 10,
    mission = "NULL",
    chat = "TALK_DONE",
    faction = "hells_raiders",
}

-- The boss of a local raider clan.
ccb.content.define_npc {
    id = "hells_raiders_boss",
    suffix = ccb.content.text("Bandit"),
    class = "NC_BANDIT_LEADER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_DONE",
    faction = "hells_raiders",
}

-- Generic trader for the Hell's Raiders.
ccb.content.define_npc {
    id = "bandit_trader",
    suffix = ccb.content.text("Bandit"),
    class = "NC_BANDIT_TRADER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_DONE",
    faction = "hells_raiders",
}

-- Generic quartermaster for the Hell's Raiders.
ccb.content.define_npc {
    id = "bandit_quartermaster",
    suffix = ccb.content.text("Quartermaster"),
    class = "NC_BANDIT_QUARTERMASTER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_DONE",
    faction = "hells_raiders",
}

-- Automotive specialist for the Hells Raiders.
ccb.content.define_npc {
    id = "bandit_mechanic",
    suffix = ccb.content.text("Mechanic"),
    class = "NC_SCAVENGER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_DONE",
    faction = "hells_raiders",
}
